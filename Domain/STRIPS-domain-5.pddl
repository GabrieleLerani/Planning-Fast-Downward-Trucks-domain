(define (domain trucks-project-5) 

    (:requirements :strips :typing :negative-preconditions :action-costs :equality)
    (:types
        agent
        square
        direction ; TODO maybe model with object types
        block
        footbridge
    )
    (:predicates
        (at ?p - agent  ?square - square) ; agent is at square s
        (block-at ?b - block  ?square - square) ; block b is on square s
        (on ?o - block ?p - agent) ; block on top of the agent TODO merge
        ;(on-footbridge ?f - footbridge ?p - agent); footbridge on top of the agent
        ;(on-top ?b1 ?b2 - block) ; block b1 on top of another block b2
        (agent-on-top ?p - agent ?b - block) ; agent on top of block b
        ;(agent-on-bridge ?p - agent) ; agent ?p on top of a bridge

        (is-clear ?b - block) ; block b has nothing on top of it 
        
        (bridge-base-built ?b1 ?b2 - block ?d - direction) ;; there is a bridge base between block b1 and b2
        ;(bridge-top-level-built ?from ?to - square)
        (block-used-for-bridge ?b - block) ; says whether a block is used for a bridge, in this case it cannot be loaded anymore

        (adj ?x ?y - square ?d - direction)
        (adj-bridge ?b1 ?b2 - block ?d - direction) ;; there is a bridge made up of block b1 and b2
        (pit ?x - square) 
        
        ;; TODO maybe you can merge this two
        
        ;(upper-floor ?s - square) ; square is on upper floor, A square is on upper floor when a bridge is built on top of it
        
        ;(footbridge-coverage ?from ?to - square ?f - footbridge) ;; footbridge covers square ?from and ?to
        (foot-bridge-at ?f - footbridge ?s - square) ;; footbridge at square
        (has-footbridge ?p - agent ?f) ;; agent has footbridge
        (used-for-bridge ?f - footbridge) ;; footbridge used for bridge

        (facing-north ?p - agent)   
        (facing-east ?p - agent)
        (facing-south ?p - agent)
        (facing-west ?p - agent)
        
        (is-north ?d - direction)
        (is-west ?d - direction)
        (is-east ?d - direction)
        (is-south ?d - direction)

        (zero-turn ?p - agent)
        (first-turn ?p - agent)
        (jammed ?p - agent)
        
        (is-free ?p - agent) ;; TODO agent is free but check if really necessary and you can remove it and leave only "on"

        (on-ground ?p - agent) ;; agent on ground floor
        
    )   
    
    (:functions
        (total-cost)
    )


    ;; TURN LEFT
    ;; actions to turn left if car faces east coming from zero turns
    (:action turn_left_east_zero
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-north ?toDir) (facing-east ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (facing-north ?p) (not (facing-east ?p)) (not (at ?p ?from)) (at ?p ?to) (first-turn ?p) (not (zero-turn ?p)) (increase (total-cost) 20)))
    

    ;; coming from one turn
    (:action turn_left_east_one
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-north ?toDir) (facing-east ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (first-turn ?p) (not (jammed ?p)))
        :effect (and (facing-north ?p) (not (facing-east ?p)) (not (at ?p ?from)) (at ?p ?to) (jammed ?p) (not (first-turn ?p)) (increase (total-cost) 20))
    )
    


    ;; actions to turn left if car faces south
    (:action turn_left_south_zero
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-east ?toDir) (facing-south ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (facing-east ?p) (not (facing-south ?p)) (not (at ?p ?from)) (at ?p ?to) (first-turn ?p) (not (zero-turn ?p)) (increase (total-cost) 20))
    )

    ;; coming from one turn
    (:action turn_left_south_one
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-east ?toDir) (facing-south ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (first-turn ?p) (not (jammed ?p)))
        :effect (and (facing-east ?p) (not (facing-south ?p)) (not (at ?p ?from)) (at ?p ?to) (jammed ?p) (not (first-turn ?p)) (increase (total-cost) 20))
    )
    
    
    ;; actions to turn left if car faces north
    (:action turn_left_north_zero
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-west ?toDir) (facing-north ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (facing-west ?p) (not (facing-north ?p)) (not (at ?p ?from)) (at ?p ?to) (first-turn ?p) (not (zero-turn ?p)) (increase (total-cost) 20))
    )
    

    (:action turn_left_north_one
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-west ?toDir) (facing-north ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (first-turn ?p) (not (jammed ?p)))
        :effect (and (facing-west ?p) (not (facing-north ?p)) (not (at ?p ?from)) (at ?p ?to) (jammed ?p) (not (first-turn ?p)) (increase (total-cost) 20))
    
    )
    ;; actions to turn left if car faces west
    (:action turn_left_west_zero
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-south ?toDir) (facing-west ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (facing-south ?p) (not (facing-west ?p)) (not (at ?p ?from)) (at ?p ?to) (first-turn ?p) (not (zero-turn ?p)) (increase (total-cost) 20))
    )
    
    (:action turn_left_west_one
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-south ?toDir) (facing-west ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (first-turn ?p) (not (jammed ?p)))
        :effect (and (facing-south ?p) (not (facing-west ?p)) (not (at ?p ?from)) (at ?p ?to) (jammed ?p) (not (first-turn ?p)) (increase (total-cost) 20))
    )

    ;; TURN RIGHT
    ;; actions to turn right if car faces east
    (:action turn_right_east_zero
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-south ?toDir)  (facing-east ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (zero-turn ?p) (not (jammed ?p))) 
        :effect (and (facing-south ?p) (not (facing-east ?p)) (not (at ?p ?from)) (at ?p ?to) (first-turn ?p) (not (zero-turn ?p)) (increase (total-cost) 20))
    )
    
    (:action turn_right_east_one
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-south ?toDir)  (facing-east ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (first-turn ?p) (not (jammed ?p))) 
        :effect (and (facing-south ?p) (not (facing-east ?p)) (not (at ?p ?from)) (at ?p ?to) (jammed ?p) (not (first-turn ?p)) (increase (total-cost) 20))
    )

    ;; actions to turn right if car faces south
    (:action turn_right_south_zero
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-west ?toDir) (facing-south ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (zero-turn ?p) (not (jammed ?p))) 
        :effect (and (facing-west ?p) (not (facing-south ?p)) (not (at ?p ?from)) (at ?p ?to) (first-turn ?p) (not (zero-turn ?p)) (increase (total-cost) 20))
    )

    (:action turn_right_south_one
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-west ?toDir) (facing-south ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (first-turn ?p) (not (jammed ?p)))
        :effect (and (facing-west ?p) (not (facing-south ?p)) (not (at ?p ?from)) (at ?p ?to) (jammed ?p) (not (first-turn ?p)) (increase (total-cost) 20))
    )
    
    ;; actions to turn right if car faces north
    (:action turn_right_north_zero
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-east ?toDir)  (facing-north ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (facing-east ?p) (not (facing-north ?p)) (not (at ?p ?from)) (at ?p ?to) (first-turn ?p) (not (zero-turn ?p)) (increase (total-cost) 20))
    )
    
    (:action turn_right_north_one
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-east ?toDir)  (facing-north ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (first-turn ?p) (not (jammed ?p)))
        :effect (and (facing-east ?p) (not (facing-north ?p)) (not (at ?p ?from)) (at ?p ?to) (jammed ?p) (not (first-turn ?p)) (increase (total-cost) 20))
    )

    ;; actions to turn right if car faces west
    (:action turn_right_west_zero
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-north ?toDir) (facing-west ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (facing-north ?p) (not (facing-west ?p)) (not (at ?p ?from)) (at ?p ?to) (first-turn ?p) (not (zero-turn ?p)) (increase (total-cost) 20))
    )
    
    (:action turn_right_west_one
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-north ?toDir) (facing-west ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (first-turn ?p) (not (jammed ?p)))
        :effect (and (facing-north ?p) (not (facing-west ?p)) (not (at ?p ?from)) (at ?p ?to) (jammed ?p) (not (first-turn ?p)) (increase (total-cost) 20))
    )

    ;; MOVE FORWARD 
    ;; actions to move forward if car faces west
    (:action move_forward_east_zero
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-east ?toDir) (facing-east ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (not (at ?p ?from)) (at ?p ?to) (increase (total-cost) 20))
    )
    
    (:action move_forward_east_one
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-east ?toDir) (facing-east ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (first-turn ?p) (not (jammed ?p)))
        :effect (and (not (at ?p ?from)) (at ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 20)) ;; Used to reset the count when you come from a turn but you move forward
    )

    ;; actions to move forward if car faces south
    (:action move_forward_south_zero
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-south ?toDir) (facing-south ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (not (at ?p ?from)) (at ?p ?to) (increase (total-cost) 20)) 
    )
    
    (:action move_forward_south_one
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-south ?toDir) (facing-south ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (first-turn ?p) (not (jammed ?p)))
        :effect (and (not (at ?p ?from)) (at ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 20)) 
    )

    ;; actions to move forward if car faces north
    (:action move_forward_north_zero
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-north ?toDir) (facing-north ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (not (at ?p ?from)) (at ?p ?to) (increase (total-cost) 20))
    )
    
    (:action move_forward_north_one
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-north ?toDir) (facing-north ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (first-turn ?p) (not (jammed ?p)))
        :effect (and (not (at ?p ?from)) (at ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 20))
    )

    ;; actions to move forward if car faces west
    (:action move_forward_west_zero
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-west ?toDir) (facing-west ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (not (at ?p ?from)) (at ?p ?to) (increase (total-cost) 20))
    )
    
    (:action move_forward_west_one
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-west ?toDir) (facing-west ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (first-turn ?p) (not (jammed ?p)))
        :effect (and (not (at ?p ?from)) (at ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 20))
    )

    ;; STRAIGHT REVERSE  
    ;; actions to move back if car faces east
    (:action move_back_east_zero
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-west ?toDir) (facing-east ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (not (at ?p ?from)) (at ?p ?to) (increase (total-cost) 30))
    )
    
    (:action move_back_east_one
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-west ?toDir) (facing-east ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (first-turn ?p) (not (jammed ?p)))
        :effect (and (not (at ?p ?from)) (at ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 30))
    )

    ;; actions to move back if car faces west
    (:action move_back_west_zero
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-east ?toDir) (facing-west ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (not (at ?p ?from)) (at ?p ?to) (increase (total-cost) 30))
    )
    
    (:action move_back_west_one
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-east ?toDir) (facing-west ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (first-turn ?p) (not (jammed ?p)))
        :effect (and (not (at ?p ?from)) (at ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 30))
    )

    ;; actions to move back if car faces north
    (:action move_back_north_zero
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-south ?toDir) (facing-north ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (not (at ?p ?from)) (at ?p ?to) (increase (total-cost) 30))
    )
    
    (:action move_back_north_one
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-south ?toDir) (facing-north ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (first-turn ?p) (not (jammed ?p)))
        :effect (and (not (at ?p ?from)) (at ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 30))
    )

    ;; actions to move back if car faces south
    (:action move_back_south_zero
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-north ?toDir) (facing-south ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (not (at ?p ?from)) (at ?p ?to) (increase (total-cost) 30))
    )
    
    (:action move_back_south_one
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-north ?toDir) (facing-south ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (first-turn ?p) (not (jammed ?p)))
        :effect (and (not (at ?p ?from)) (at ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 30))
    )

    ;; LATERAL REVERSE from west 
    (:action right_back_west
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-north ?toDir) (facing-west ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (not (jammed ?p)))
        :effect (and (facing-south ?p) (not (facing-west ?p)) (not (at ?p ?from)) (at ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 30))
    )

    (:action left_back_west
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-south ?toDir) (facing-west ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (not (jammed ?p)))
        :effect (and (facing-north ?p) (not (facing-west ?p)) (not (at ?p ?from)) (at ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 30))
    )

    ;; LATERAL REVERSE from north
    (:action right_back_north
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-east ?toDir) (facing-north ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (not (jammed ?p)))
        :effect (and (facing-west ?p) (not (facing-north ?p)) (not (at ?p ?from)) (at ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 30))
    )
    
    (:action left_back_north
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-west ?toDir) (facing-north ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (not (jammed ?p)))
        :effect (and (facing-east ?p) (not (facing-north ?p)) (not (at ?p ?from)) (at ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 30))
    )
    
    ;; LATERAL REVERSE from south
    (:action right_back_south
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-west ?toDir) (facing-south ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (not (jammed ?p)))
        :effect (and (facing-east ?p) (not (facing-south ?p)) (not (at ?p ?from)) (at ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 30))
    )
    
    (:action left_back_south
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-east ?toDir) (facing-south ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (not (jammed ?p)))
        :effect (and (facing-west ?p) (not (facing-south ?p)) (not (at ?p ?from)) (at ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 30))
    )

    ;; LATERAL REVERSE from east
    (:action right_back_east
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-south ?toDir) (facing-east ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (not (jammed ?p)))
        :effect (and (facing-north ?p) (not (facing-east ?p)) (not (at ?p ?from)) (at ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 30))
    )

    (:action left_back_east
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-north ?toDir) (facing-east ?p) (at ?p ?from)  (on-ground ?p) (not (pit ?to)) (not (jammed ?p)))
        :effect (and (facing-south ?p) (not (facing-east ?p)) (not (at ?p ?from)) (at ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 30))
    )

    ; MOVE ON BRIDGE ----------------------------------------------------------------------------------------------------------------------------------------
    
    ;; TURN LEFT
    ;; actions to turn left if car faces east coming from zero turns
    (:action turn_left_east_zero_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-north ?toDir) (facing-east ?p) (agent-on-top ?p ?from) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (facing-north ?p) (not (facing-east ?p)) (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (first-turn ?p) (not (zero-turn ?p)) (increase (total-cost) 1))
    )
    
    ;; coming from one turn
    (:action turn_left_east_one_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-north ?toDir) (facing-east ?p) (agent-on-top ?p ?from)  (first-turn ?p) (not (jammed ?p)))
        :effect (and (facing-north ?p) (not (facing-east ?p)) (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (jammed ?p) (not (first-turn ?p)) (increase (total-cost) 1))
    )
    


    ;; actions to turn left if car faces south
    (:action turn_left_south_zero_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-east ?toDir) (facing-south ?p) (agent-on-top ?p ?from) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (facing-east ?p) (not (facing-south ?p)) (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (first-turn ?p) (not (zero-turn ?p)) (increase (total-cost) 1))
    )

    ;; coming from one turn
    (:action turn_left_south_one_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-east ?toDir) (facing-south ?p) (agent-on-top ?p ?from) (first-turn ?p) (not (jammed ?p)))
        :effect (and (facing-east ?p) (not (facing-south ?p)) (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (jammed ?p) (not (first-turn ?p)) (increase (total-cost) 1))
    )
    
    
    ;; actions to turn left if car faces north
    (:action turn_left_north_zero_bridge
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-west ?toDir) (facing-north ?p) (agent-on-top ?p ?from) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (facing-west ?p) (not (facing-north ?p)) (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (first-turn ?p) (not (zero-turn ?p)) (increase (total-cost) 1))
    )
    

    (:action turn_left_north_one_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-west ?toDir) (facing-north ?p) (agent-on-top ?p ?from) (first-turn ?p) (not (jammed ?p)))
        :effect (and (facing-west ?p) (not (facing-north ?p)) (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (jammed ?p) (not (first-turn ?p)) (increase (total-cost) 1))
    
    )
    ;; actions to turn left if car faces west
    (:action turn_left_west_zero_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-south ?toDir) (facing-west ?p) (agent-on-top ?p ?from) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (facing-south ?p) (not (facing-west ?p)) (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (first-turn ?p) (not (zero-turn ?p)) (increase (total-cost) 1))
    )
    
    (:action turn_left_west_one_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-south ?toDir) (facing-west ?p) (agent-on-top ?p ?from) (first-turn ?p) (not (jammed ?p)))
        :effect (and (facing-south ?p) (not (facing-west ?p)) (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (jammed ?p) (not (first-turn ?p)) (increase (total-cost) 1))
    )

    ;; TURN RIGHT
    ;; actions to turn right if car faces east
    (:action turn_right_east_zero_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-south ?toDir)  (facing-east ?p) (agent-on-top ?p ?from) (zero-turn ?p) (not (jammed ?p))) 
        :effect (and (facing-south ?p) (not (facing-east ?p)) (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (first-turn ?p) (not (zero-turn ?p)) (increase (total-cost) 1))
    )
    
    (:action turn_right_east_one_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-south ?toDir)  (facing-east ?p) (agent-on-top ?p ?from)  (first-turn ?p) (not (jammed ?p))) 
        :effect (and (facing-south ?p) (not (facing-east ?p)) (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (jammed ?p) (not (first-turn ?p)) (increase (total-cost) 1))
    )

    ;; actions to turn right if car faces south
    (:action turn_right_south_zero_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-west ?toDir) (facing-south ?p) (agent-on-top ?p ?from)  (zero-turn ?p) (not (jammed ?p))) 
        :effect (and (facing-west ?p) (not (facing-south ?p)) (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (first-turn ?p) (not (zero-turn ?p)) (increase (total-cost) 1))
    )

    (:action turn_right_south_one_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-west ?toDir) (facing-south ?p) (agent-on-top ?p ?from) (first-turn ?p) (not (jammed ?p)))
        :effect (and (facing-west ?p) (not (facing-south ?p)) (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (jammed ?p) (not (first-turn ?p)) (increase (total-cost) 1))
    )
    
    ;; actions to turn right if car faces north
    (:action turn_right_north_zero_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-east ?toDir)  (facing-north ?p) (agent-on-top ?p ?from)  (zero-turn ?p) (not (jammed ?p)))
        :effect (and (facing-east ?p) (not (facing-north ?p)) (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (first-turn ?p) (not (zero-turn ?p)) (increase (total-cost) 1))
    )
    
    (:action turn_right_north_one_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-east ?toDir)  (facing-north ?p) (agent-on-top ?p ?from) (first-turn ?p) (not (jammed ?p)))
        :effect (and (facing-east ?p) (not (facing-north ?p)) (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (jammed ?p) (not (first-turn ?p)) (increase (total-cost) 1))
    )

    ;; actions to turn right if car faces west
    (:action turn_right_west_zero_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-north ?toDir) (facing-west ?p) (agent-on-top ?p ?from) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (facing-north ?p) (not (facing-west ?p)) (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (first-turn ?p) (not (zero-turn ?p)) (increase (total-cost) 1))
    )
    
    (:action turn_right_west_one_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-north ?toDir) (facing-west ?p) (agent-on-top ?p ?from) (first-turn ?p) (not (jammed ?p)))
        :effect (and (facing-north ?p) (not (facing-west ?p)) (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (jammed ?p) (not (first-turn ?p)) (increase (total-cost) 1))
    )

    ;; MOVE FORWARD 
    ;; actions to move forward if car faces west
    (:action move_forward_east_zero_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-east ?toDir) (facing-east ?p) (agent-on-top ?p ?from) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (increase (total-cost) 1))
    )
    
    (:action move_forward_east_one_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-east ?toDir) (facing-east ?p) (agent-on-top ?p ?from) (first-turn ?p) (not (jammed ?p)))
        :effect (and (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 1)) ;; Used to reset the count when you come from a turn but you move forward
    )

    ;; actions to move forward if car faces south
    (:action move_forward_south_zero_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-south ?toDir) (facing-south ?p) (agent-on-top ?p ?from) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (increase (total-cost) 1)) 
    )
    
    (:action move_forward_south_one_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-south ?toDir) (facing-south ?p) (agent-on-top ?p ?from) (first-turn ?p) (not (jammed ?p)))
        :effect (and (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 1)) 
    )

    ;; actions to move forward if car faces north
    (:action move_forward_north_zero_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-north ?toDir) (facing-north ?p) (agent-on-top ?p ?from) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (increase (total-cost) 1))
    )
    
    (:action move_forward_north_one_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and  (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-north ?toDir) (facing-north ?p) (agent-on-top ?p ?from) (first-turn ?p) (not (jammed ?p)))
        :effect (and (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 1))
    )

    ;; actions to move forward if car faces west
    (:action move_forward_west_zero_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-west ?toDir) (facing-west ?p) (agent-on-top ?p ?from) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (increase (total-cost) 1))
    )
    
    (:action move_forward_west_one_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-west ?toDir) (facing-west ?p) (agent-on-top ?p ?from) (first-turn ?p) (not (jammed ?p)))
        :effect (and (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 1))
    )

    ;; STRAIGHT REVERSE  
    ;; actions to move back if car faces east
    (:action move_back_east_zero_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-west ?toDir) (facing-east ?p) (agent-on-top ?p ?from) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (increase (total-cost) 2))
    )
    
    (:action move_back_east_one_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-west ?toDir) (facing-east ?p) (agent-on-top ?p ?from) (first-turn ?p) (not (jammed ?p)))
        :effect (and (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 2))
    )

    ;; actions to move back if car faces west
    (:action move_back_west_zero_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-east ?toDir) (facing-west ?p) (agent-on-top ?p ?from) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (increase (total-cost) 2))
    )
    
    (:action move_back_west_one_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-east ?toDir) (facing-west ?p) (agent-on-top ?p ?from) (first-turn ?p) (not (jammed ?p)))
        :effect (and (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 2))
    )

    ;; actions to move back if car faces north
    (:action move_back_north_zero_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-south ?toDir) (facing-north ?p) (agent-on-top ?p ?from) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (increase (total-cost) 2))
    )
    
    (:action move_back_north_one_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-south ?toDir) (facing-north ?p) (agent-on-top ?p ?from) (first-turn ?p) (not (jammed ?p)))
        :effect (and (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 2))
    )

    ;; actions to move back if car faces south
    (:action move_back_south_zero_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-north ?toDir) (facing-south ?p) (agent-on-top ?p ?from)  (zero-turn ?p) (not (jammed ?p)))
        :effect (and (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (increase (total-cost) 2))
    )
    
    (:action move_back_south_one_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-north ?toDir) (facing-south ?p) (agent-on-top ?p ?from) (first-turn ?p) (not (jammed ?p)))
        :effect (and (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 2))
    )

    ;; LATERAL REVERSE from west 
    (:action right_back_west_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-north ?toDir) (facing-west ?p) (agent-on-top ?p ?from) (not (jammed ?p)))
        :effect (and (facing-south ?p) (not (facing-west ?p)) (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 2))
    )

    (:action left_back_west_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-south ?toDir) (facing-west ?p) (agent-on-top ?p ?from) (not (jammed ?p)))
        :effect (and (facing-north ?p) (not (facing-west ?p)) (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 2))
    )

    ;; LATERAL REVERSE from north
    (:action right_back_north_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-east ?toDir) (facing-north ?p) (agent-on-top ?p ?from) (not (jammed ?p)))
        :effect (and (facing-west ?p) (not (facing-north ?p)) (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 2))
    )
    
    (:action left_back_north_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-west ?toDir) (facing-north ?p) (agent-on-top ?p ?from)  (not (jammed ?p)))
        :effect (and (facing-east ?p) (not (facing-north ?p)) (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 2))
    )
    
    ;; LATERAL REVERSE from south
    (:action right_back_south_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-west ?toDir) (facing-south ?p) (agent-on-top ?p ?from)  (not (jammed ?p)))
        :effect (and (facing-east ?p) (not (facing-south ?p)) (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 2))
    )
    
    (:action left_back_south_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-east ?toDir) (facing-south ?p) (agent-on-top ?p ?from)  (not (jammed ?p)))
        :effect (and (facing-west ?p) (not (facing-south ?p)) (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 2))
    )

    ;; LATERAL REVERSE from east
    (:action right_back_east_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-south ?toDir) (facing-east ?p) (agent-on-top ?p ?from) (not (jammed ?p)))
        :effect (and (facing-north ?p) (not (facing-east ?p)) (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 2))
    )

    (:action left_back_east_bridge
        :parameters (?p - agent ?from ?to - block ?toDir - direction)
        :precondition (and (not (on-ground ?p)) (adj-bridge ?from ?to ?toDir) (is-north ?toDir) (facing-east ?p) (agent-on-top ?p ?from) (not (jammed ?p)))
        :effect (and (facing-south ?p) (not (facing-east ?p)) (not (agent-on-top ?p ?from)) (agent-on-top ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 2))
    )


    ;; REPAIR action
    (:action repair
        :parameters (?p - agent)
        :precondition (jammed ?p)
        :effect (and (zero-turn ?p) (not (jammed ?p)) (increase (total-cost) 40)) ;; TODO modify cost
    )
    
    ;; LOAD package on truck
    (:action load_block
        :parameters (?b - block ?p - agent ?s - square) ;; TODO notice that parameters are necessary without ADL, because you cannot use universal and existential quantifier
        :precondition (and (at ?p ?s) (block-at ?b ?s) (on-ground ?p) (not (pit ?s)) (is-free ?p) (not (block-used-for-bridge ?b))) ;; TODO for the moment the truck can carry just one block at a time
        :effect (and (not (block-at ?b ?s)) (on ?b ?p) (not (is-free ?p)) (increase (total-cost) 2))
    )
    
    ;; LOAD footbridge
    (:action load_footbridge
        :parameters (?p - agent ?s - square ?f - footbridge) 
        :precondition (and (at ?p ?s)  (foot-bridge-at ?f ?s) (not (used-for-bridge ?f)) (not (has-footbridge ?p ?f)) (on-ground ?p) (not (pit ?s)))
        :effect (and (not (foot-bridge-at ?f ?s)) (has-footbridge ?p ?f) (increase (total-cost) 2))
    )


    ;; UNLOAD package on floor
    (:action unload_ground
        :parameters (?b - block ?p - agent ?s - square)
        :precondition (and (at ?p ?s) (on ?b ?p) (not (pit ?s))) 
        :effect (and (not (on ?b ?p)) (block-at ?b ?s) (is-free ?p) (increase (total-cost) 1))
    )
    

    ;; GET OFF a block when truck is on top of it
    (:action get_off_block
        :parameters (?p - agent ?b - block ?s - square)
        :precondition (and (agent-on-top ?p ?b) (not (on-ground ?p)) (block-at ?b ?s))
        :effect  (and (not (agent-on-top ?p ?b)) (at ?p ?s) (on-ground ?p) (is-clear ?b) (increase (total-cost) 1))
    )
    
    ;; TODO check if bridge base built predicate can be removed
    (:action throw_block
        :parameters (?p - agent ?from ?to - square ?d - direction ?b1 ?b2 - block)
        :precondition (and (not (on-ground ?p)) (adj ?from ?to ?d) (block-at ?b1 ?from) (pit ?to) (agent-on-top ?p ?b1) (on ?b2 ?p) (not (bridge-base-built ?b1 ?b2 ?d)))
        :effect (and (not (on ?b2 ?p)) (block-at ?b2 ?to) (is-free ?p) (bridge-base-built ?b1 ?b2 ?d) (block-used-for-bridge ?b1) (block-used-for-bridge ?b2) (increase (total-cost) 1))
    )
    
    (:action build_bridge
        :parameters (?p - agent ?b1 ?b2 - block ?f - footbridge ?d - direction)
        :precondition (and (not (adj-bridge ?b1 ?b2 ?d)) (bridge-base-built ?b1 ?b2 ?d) (agent-on-top ?p ?b1) (has-footbridge ?p ?f) (block-used-for-bridge ?b1) (block-used-for-bridge ?b2))
        :effect (and (not (has-footbridge ?p ?f)) (used-for-bridge ?f) (adj-bridge ?b1 ?b2 ?d) (increase (total-cost) 1))
    )
    

    ;; CLIMB on block
    (:action climb_on_block
        :parameters (?p - agent ?s - square ?b - block)
        :precondition (and (block-at ?b ?s) (at ?p ?s) (not (agent-on-top ?p ?b)) (is-clear ?b) (on-ground ?p))
        :effect (and (agent-on-top ?p ?b) (not (at ?p  ?s)) (not (is-clear ?b)) (not (on-ground ?p)) (increase (total-cost) 1))
    )
    



)