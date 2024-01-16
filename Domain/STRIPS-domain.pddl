(define (domain trucks_domain) 

    (:requirements :strips :typing :negative-preconditions :action-costs :equality)
    (:types
        agent square direction block footbridge - objects
    )
    (:predicates
        ; agent is at square s
        (at ?p - agent  ?square - square) 
        
        ; block b is on square s
        (block-at ?b - block  ?square - square) 
        
        ; block on top of the agent 
        (on ?o - block ?p - agent) 

        ; agent on top of block b    
        (agent-on-top ?p - agent ?b - block) 
        
        ; block b is part of a bridge and it cannot be loaded
        (block-used-for-bridge ?b - block) 

        ; square x is adjacent to square y in direction d (i.e. sq-1-1 sq-1-2 WEST because 1-2 is on the right)
        (adj ?x ?y - square ?d - direction)
        
        ; there is a bridge made up of block b1 and b2
        (adj-bridge ?b1 ?b2 - block) 
        
        ; square x is a pit
        (pit ?x - square) 
        
        ; there is a foot bridge at square x
        (foot-bridge-at ?f - footbridge ?s - square) 
        
        ; agent has footbridge
        (has-footbridge ?p - agent ?f - footbridge) 
        
        ; footbridge f is used for bridge and cannot be used
        (used-for-bridge ?f - footbridge)
        
        ; agent is facing direction d (i.e. facing driver North)
        (facing ?p - agent ?d - direction) 
        
        ; two direction are opposite (i.e. N is opposite to S). Useful for moving some turn actions
        (opposite ?d1 ?d2 - direction)

        ; agent can do one more turn move
        (zero-turn ?p - agent)
        
        ; if agent makes another turn it gets stucked
        (first-turn ?p - agent)
        
        ; driver is stucked
        (jammed ?p - agent)
        
        ; agent is free and can load blocks
        (is-free ?p - agent) 

        ; agent is on ground a not on top of some bridge
        (on-ground ?p - agent) 
        
    )   
    
    (:functions
        (total-cost)
    )


    ;; General action for turning
    (:action turn_zero
        :parameters (?p - agent ?from ?to - square ?fromDir ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (facing ?p ?fromDir) (not (opposite ?fromDir ?toDir)) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (facing ?p ?toDir) (not (facing ?p ?fromDir)) (not (at ?p ?from)) (at ?p ?to) (first-turn ?p) (not (zero-turn ?p)) (increase (total-cost) 20))
    )

    (:action turn_one
        :parameters (?p - agent ?from ?to - square ?fromDir ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (facing ?p ?fromDir) (not (opposite ?fromDir ?toDir)) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (first-turn ?p) (not (jammed ?p)))
        :effect (and (facing ?p ?toDir) (not (facing ?p ?fromDir)) (not (at ?p ?from)) (at ?p ?to) (jammed ?p) (not (first-turn ?p)) (increase (total-cost) 20))
    )

    ;; General action for moving forward
    (:action move_forward_zero
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (facing ?p ?toDir) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (not (at ?p ?from)) (at ?p ?to) (increase (total-cost) 20))
    )

    (:action move_forward_one
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (facing ?p ?toDir) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (first-turn ?p) (not (jammed ?p)))
        :effect (and (not (at ?p ?from)) (zero-turn ?p) (not (first-turn ?p)) (at ?p ?to) (increase (total-cost) 20))
    )

    
    ;; General action for lateral reverse
    (:action lateral_reverse
        :parameters (?p - agent ?from ?to - square ?fromDir ?toDir ?newDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (facing ?p ?fromDir) (not (= ?fromDir ?toDir)) (not (opposite ?fromDir ?toDir)) (opposite ?newDir ?toDir) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (not (jammed ?p)))
        :effect (and (facing ?p ?newDir) (not (facing ?p ?fromDir)) (not (at ?p ?from)) (at ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 50))
    )

    ;; General action for moving backward
    (:action move_backward
        :parameters (?p - agent ?from ?to - square ?fromDir ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (facing ?p ?fromDir) (opposite ?fromDir ?toDir) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (not (jammed ?p)))
        :effect (and (not (at ?p ?from)) (at ?p ?to) (increase (total-cost) 40))
    )



    ;------------------------------------------------------------------------------- MOVE ON BRIDGE -------------------------------------------------------------------------
    
    
    ;; TURN on bridge when turn count is zero
    (:action turn_zero_bridge
        :parameters (?p - agent ?from ?to - block ?s1 ?s2 - square ?fromDir ?toDir - direction)
        :precondition (and (adj-bridge ?from ?to) (facing ?p ?fromDir) (not (opposite ?fromDir ?toDir)) (adj ?s1 ?s2 ?toDir) (block-at ?from ?s1) (block-at ?to ?s2) (agent-on-top ?p ?from) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (facing ?p ?toDir) (not (facing ?p ?fromDir)) (not (agent-on-top ?p ?from)) (at ?p ?s2) (not (at ?p ?s1)) (agent-on-top ?p ?to) (first-turn ?p) (not (zero-turn ?p)) (increase (total-cost) 1))
    )
    
    ;; TURN coming from one turn move
    (:action turn_one_bridge
        :parameters (?p - agent ?from ?to - block ?s1 ?s2 - square ?fromDir ?toDir - direction)
        :precondition (and  (adj-bridge ?from ?to) (facing ?p ?fromDir) (not (opposite ?fromDir ?toDir)) (adj ?s1 ?s2 ?toDir) (block-at ?from ?s1) (block-at ?to ?s2) (agent-on-top ?p ?from) (first-turn ?p) (not (jammed ?p)))
        :effect (and (facing ?p ?toDir) (not (facing ?p ?fromDir)) (not (agent-on-top ?p ?from)) (at ?p ?s2) (not (at ?p ?s1)) (agent-on-top ?p ?to) (jammed ?p) (not (first-turn ?p)) (increase (total-cost) 1))
    )
    

    ;; MOVE FORWARD 
    (:action move_forward_zero_bridge
        :parameters (?p - agent ?from ?to - block ?s1 ?s2 - square ?toDir - direction)
        :precondition (and  (adj-bridge ?from ?to) (facing ?p ?toDir) (adj ?s1 ?s2 ?toDir) (block-at ?from ?s1) (block-at ?to ?s2) (agent-on-top ?p ?from) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (not (agent-on-top ?p ?from)) (at ?p ?s2) (not (at ?p ?s1)) (agent-on-top ?p ?to) (increase (total-cost) 1))
    )
    
    (:action move_forward_one_bridge
        :parameters (?p - agent ?from ?to - block ?s1 ?s2 - square ?toDir - direction)
        :precondition (and  (adj-bridge ?from ?to) (facing ?p ?toDir) (adj ?s1 ?s2 ?toDir) (block-at ?from ?s1) (block-at ?to ?s2) (agent-on-top ?p ?from) (first-turn ?p) (not (jammed ?p)))
        :effect (and (not (agent-on-top ?p ?from)) (at ?p ?s2) (not (at ?p ?s1)) (agent-on-top ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 1)) ;; Used to reset the count when you come from a turn but you move forward
    )

    ;; STRAIGHT REVERSE  
    (:action move_back_bridge
        :parameters (?p - agent ?from ?to - block ?s1 ?s2 - square ?fromDir ?toDir - direction)
        :precondition (and  (adj-bridge ?from ?to) (facing ?p ?fromDir) (opposite ?fromDir ?toDir) (adj ?s1 ?s2 ?toDir) (block-at ?from ?s1) (block-at ?to ?s2) (agent-on-top ?p ?from) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (not (agent-on-top ?p ?from)) (at ?p ?s2) (not (at ?p ?s1)) (agent-on-top ?p ?to) (increase (total-cost) 2))
    )
       
    ;; LATERAL REVERSE 
    (:action lateral_reverse_bridge
        :parameters (?p - agent ?from ?to - block ?s1 ?s2 - square ?fromDir ?toDir ?newDir - direction)
        :precondition (and  (adj-bridge ?from ?to) (facing ?p ?fromDir)  (not (= ?fromDir ?toDir)) (not (opposite ?fromDir ?toDir)) (opposite ?newDir ?toDir) (adj ?s1 ?s2 ?toDir) (block-at ?from ?s1) (block-at ?to ?s2) (agent-on-top ?p ?from) (not (jammed ?p)))
        :effect (and (facing ?p ?newDir) (not (facing ?p ?fromDir)) (not (agent-on-top ?p ?from)) (at ?p ?s2) (not (at ?p ?s1)) (agent-on-top ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 2))
    )


    ;; REPAIR action
    (:action repair
        :parameters (?p - agent)
        :precondition (jammed ?p)
        :effect (and (zero-turn ?p) (not (jammed ?p)) (increase (total-cost) 25)) 
    )
    
    ;; LOAD package on truck
    (:action load_block
        :parameters (?b - block ?p - agent ?s - square) 
        :precondition (and (at ?p ?s) (block-at ?b ?s) (on-ground ?p) (is-free ?p) (not (block-used-for-bridge ?b)))
        :effect (and (not (block-at ?b ?s)) (on ?b ?p) (not (is-free ?p)) (increase (total-cost) 2))
    )

    
    ;; LOAD footbridge
    (:action load_footbridge
        :parameters (?p - agent ?s - square ?f - footbridge) 
        :precondition (and (at ?p ?s) (foot-bridge-at ?f ?s) (not (used-for-bridge ?f)) (not (has-footbridge ?p ?f)) (on-ground ?p))
        :effect (and (not (foot-bridge-at ?f ?s)) (has-footbridge ?p ?f) (increase (total-cost) 2))
    )    

    
    ;; UNLOAD package on floor
    (:action unload
        :parameters (?b - block ?p - agent ?s - square)
        :precondition (and (at ?p ?s) (on ?b ?p)) 
        :effect (and (not (on ?b ?p)) (block-at ?b ?s) (is-free ?p) (increase (total-cost) 1))
    )
    
    
    ;; GET OFF a block when truck is on top of it
    (:action get_off_block
        :parameters (?p - agent ?b - block ?s - square)
        :precondition (and (agent-on-top ?p ?b)  (block-at ?b ?s) (not (pit ?s)))
        :effect  (and (not (agent-on-top ?p ?b)) (at ?p ?s) (on-ground ?p) (increase (total-cost) 1))
    )

    
    ;; THROW block
    (:action throw_block
        :parameters (?p - agent ?from ?to - square ?d - direction ?b1 ?b2 - block)
        :precondition (and  (adj ?from ?to ?d) (block-at ?b1 ?from) (agent-on-top ?p ?b1) (on ?b2 ?p))
        :effect (and (not (on ?b2 ?p)) (block-at ?b2 ?to) (is-free ?p) (block-used-for-bridge ?b1) (block-used-for-bridge ?b2) (increase (total-cost) 1))
    )

    ;; BUILD bridge
    (:action build_bridge
        :parameters (?p - agent ?b1 ?b2 - block ?f - footbridge)
        :precondition (and (not (adj-bridge ?b1 ?b2)) (agent-on-top ?p ?b1) (has-footbridge ?p ?f) (block-used-for-bridge ?b1) (block-used-for-bridge ?b2))
        :effect (and (not (has-footbridge ?p ?f)) (used-for-bridge ?f) (adj-bridge ?b1 ?b2) (adj-bridge ?b2 ?b1) (increase (total-cost) 1))
    )


    ;; CLIMB on block
    (:action climb_on_block
        :parameters (?p - agent ?s - square ?b - block)
        :precondition (and (block-at ?b ?s) (at ?p ?s) (not (agent-on-top ?p ?b)) (on-ground ?p))
        :effect (and (not (on-ground ?p)) (agent-on-top ?p ?b) (not (at ?p ?s)) (increase (total-cost) 1))
    )
    
)