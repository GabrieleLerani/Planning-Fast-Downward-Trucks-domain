(define (domain trucks-project-2) 

    (:requirements :strips :typing :negative-preconditions :action-costs)
    (:types
        agent
        square
        direction ;; TODO maybe model with object types
        block
    )
    (:predicates
        (at ?p - agent  ?square - square)
        (block-at ?o - block  ?square - square) 
        (on ?o - block ?p - agent) ;; block on top of the agent
        (on-top ?b1 ?b2 - block) ;; block b1 on top of another block b2
        (agent-on-top ?p - agent ?b - block) ;; agent on top of block b
        
        (is-clear ?b - block) ;; block b has nothing on top of it 
        
        (bridge-base-built ?from ?to - square)
        (bridge-top-level-built ?from ?to - square)
        (block-used-for-bridge ?b - block) ;; says whether a block is used for a bridge, in this case it cannot be loaded anymore

        (adj ?x ?y - square ?d - direction)
        (pit ?x - square) 
        (stack ?s - square) ;; indicates whether in square s there is a stack made up of two blocks 

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
        
        (is-free ?p - agent)

        (on-ground ?p - agent) ;; agent on ground floor
)   
    
    (:functions
        (total-cost)
    )


    ;; TURN LEFT
    ;; actions to turn left if car faces east coming from zero turns
    (:action turn_left_from_east_zero
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-north ?toDir) (facing-east ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (facing-north ?p) (not (facing-east ?p)) (not (at ?p ?from)) (at ?p ?to) (first-turn ?p) (not (zero-turn ?p)) (increase (total-cost) 1)))
    

    ;; coming from one turn
    (:action turn_left_from_east_one
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-north ?toDir) (facing-east ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (first-turn ?p) (not (jammed ?p)))
        :effect (and (facing-north ?p) (not (facing-east ?p)) (not (at ?p ?from)) (at ?p ?to) (jammed ?p) (not (first-turn ?p)) (increase (total-cost) 1))
    )
    


    ;; actions to turn left if car faces south
    (:action turn_left_from_south_zero
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-east ?toDir) (facing-south ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (facing-east ?p) (not (facing-south ?p)) (not (at ?p ?from)) (at ?p ?to) (first-turn ?p) (not (zero-turn ?p)) (increase (total-cost) 1))
    )

    ;; coming from one turn
    (:action turn_left_from_south_one
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-east ?toDir) (facing-south ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (first-turn ?p) (not (jammed ?p)))
        :effect (and (facing-east ?p) (not (facing-south ?p)) (not (at ?p ?from)) (at ?p ?to) (jammed ?p) (not (first-turn ?p)) (increase (total-cost) 1))
    )
    
    
    ;; actions to turn left if car faces north
    (:action turn_left_from_north_zero
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-west ?toDir) (facing-north ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (facing-west ?p) (not (facing-north ?p)) (not (at ?p ?from)) (at ?p ?to) (first-turn ?p) (not (zero-turn ?p)) (increase (total-cost) 1))
    )
    

    (:action turn_left_from_north_one
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-west ?toDir) (facing-north ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (first-turn ?p) (not (jammed ?p)))
        :effect (and (facing-west ?p) (not (facing-north ?p)) (not (at ?p ?from)) (at ?p ?to) (jammed ?p) (not (first-turn ?p)) (increase (total-cost) 1))
    
    )
    ;; actions to turn left if car faces west
    (:action turn_left_from_west_zero
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-south ?toDir) (facing-west ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (facing-south ?p) (not (facing-west ?p)) (not (at ?p ?from)) (at ?p ?to) (first-turn ?p) (not (zero-turn ?p)) (increase (total-cost) 1))
    )
    
    (:action turn_left_from_west_one
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-south ?toDir) (facing-west ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (first-turn ?p) (not (jammed ?p)))
        :effect (and (facing-south ?p) (not (facing-west ?p)) (not (at ?p ?from)) (at ?p ?to) (jammed ?p) (not (first-turn ?p)) (increase (total-cost) 1))
    )

    ;; TURN RIGHT
    ;; actions to turn right if car faces east
    (:action turn_right_from_east_zero
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-south ?toDir)  (facing-east ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (zero-turn ?p) (not (jammed ?p))) 
        :effect (and (facing-south ?p) (not (facing-east ?p)) (not (at ?p ?from)) (at ?p ?to) (first-turn ?p) (not (zero-turn ?p)) (increase (total-cost) 1))
    )
    
    (:action turn_right_from_east_one
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-south ?toDir)  (facing-east ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (first-turn ?p) (not (jammed ?p))) 
        :effect (and (facing-south ?p) (not (facing-east ?p)) (not (at ?p ?from)) (at ?p ?to) (jammed ?p) (not (first-turn ?p)) (increase (total-cost) 1))
    )

    ;; actions to turn right if car faces south
    (:action turn_right_from_south_zero
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-west ?toDir) (facing-south ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (zero-turn ?p) (not (jammed ?p))) 
        :effect (and (facing-west ?p) (not (facing-south ?p)) (not (at ?p ?from)) (at ?p ?to) (first-turn ?p) (not (zero-turn ?p)) (increase (total-cost) 1))
    )

    (:action turn_right_from_south_one
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-west ?toDir) (facing-south ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (first-turn ?p) (not (jammed ?p)))
        :effect (and (facing-west ?p) (not (facing-south ?p)) (not (at ?p ?from)) (at ?p ?to) (jammed ?p) (not (first-turn ?p)) (increase (total-cost) 1))
    )
    
    ;; actions to turn right if car faces north
    (:action turn_right_from_north_zero
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-east ?toDir)  (facing-north ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (facing-east ?p) (not (facing-north ?p)) (not (at ?p ?from)) (at ?p ?to) (first-turn ?p) (not (zero-turn ?p)) (increase (total-cost) 1))
    )
    
    (:action turn_right_from_north_one
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-east ?toDir)  (facing-north ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (first-turn ?p) (not (jammed ?p)))
        :effect (and (facing-east ?p) (not (facing-north ?p)) (not (at ?p ?from)) (at ?p ?to) (jammed ?p) (not (first-turn ?p)) (increase (total-cost) 1))
    )

    ;; actions to turn right if car faces west
    (:action turn_right_from_west_zero
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-north ?toDir) (facing-west ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (facing-north ?p) (not (facing-west ?p)) (not (at ?p ?from)) (at ?p ?to) (first-turn ?p) (not (zero-turn ?p)) (increase (total-cost) 1))
    )
    
    (:action turn_right_from_west_one
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-north ?toDir) (facing-west ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (first-turn ?p) (not (jammed ?p)))
        :effect (and (facing-north ?p) (not (facing-west ?p)) (not (at ?p ?from)) (at ?p ?to) (jammed ?p) (not (first-turn ?p)) (increase (total-cost) 1))
    )

    ;; MOVE FORWARD 
    ;; actions to move forward if car faces west
    (:action move_forward_from_east_zero
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-east ?toDir) (facing-east ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (not (at ?p ?from)) (at ?p ?to) (increase (total-cost) 1))
    )
    
    (:action move_forward_from_east_one
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-east ?toDir) (facing-east ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (first-turn ?p) (not (jammed ?p)))
        :effect (and (not (at ?p ?from)) (at ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 1)) ;; Used to reset the count when you come from a turn but you move forward
    )

    ;; actions to move forward if car faces south
    (:action move_forward_from_south_zero
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-south ?toDir) (facing-south ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (not (at ?p ?from)) (at ?p ?to) (increase (total-cost) 1)) 
    )
    
    (:action move_forward_from_south_one
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-south ?toDir) (facing-south ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (first-turn ?p) (not (jammed ?p)))
        :effect (and (not (at ?p ?from)) (at ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 1)) 
    )

    ;; actions to move forward if car faces north
    (:action move_forward_from_north_zero
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-north ?toDir) (facing-north ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (not (at ?p ?from)) (at ?p ?to) (increase (total-cost) 1))
    )
    
    (:action move_forward_from_north_one
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-north ?toDir) (facing-north ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (first-turn ?p) (not (jammed ?p)))
        :effect (and (not (at ?p ?from)) (at ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 1))
    )

    ;; actions to move forward if car faces west
    (:action move_forward_from_west_zero
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-west ?toDir) (facing-west ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (not (at ?p ?from)) (at ?p ?to) (increase (total-cost) 1))
    )
    
    (:action move_forward_from_west_one
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-west ?toDir) (facing-west ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (first-turn ?p) (not (jammed ?p)))
        :effect (and (not (at ?p ?from)) (at ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 1))
    )

    ;; STRAIGHT REVERSE  
    ;; actions to move back if car faces east
    (:action move_back_from_east_zero
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-west ?toDir) (facing-east ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (not (at ?p ?from)) (at ?p ?to) (increase (total-cost) 5))
    )
    
    (:action move_back_from_east_one
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-west ?toDir) (facing-east ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (first-turn ?p) (not (jammed ?p)))
        :effect (and (not (at ?p ?from)) (at ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 5))
    )

    ;; actions to move back if car faces west
    (:action move_back_from_west_zero
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-east ?toDir) (facing-west ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (not (at ?p ?from)) (at ?p ?to) (increase (total-cost) 5))
    )
    
    (:action move_back_from_west_one
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-east ?toDir) (facing-west ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (first-turn ?p) (not (jammed ?p)))
        :effect (and (not (at ?p ?from)) (at ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 5))
    )

    ;; actions to move back if car faces north
    (:action move_back_from_north_zero
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-south ?toDir) (facing-north ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (not (at ?p ?from)) (at ?p ?to) (increase (total-cost) 5))
    )
    
    (:action move_back_from_north_one
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-south ?toDir) (facing-north ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (first-turn ?p) (not (jammed ?p)))
        :effect (and (not (at ?p ?from)) (at ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 5))
    )

    ;; actions to move back if car faces south
    (:action move_back_from_south_zero
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-north ?toDir) (facing-south ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (zero-turn ?p) (not (jammed ?p)))
        :effect (and (not (at ?p ?from)) (at ?p ?to) (increase (total-cost) 5))
    )
    
    (:action move_back_from_south_one
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-north ?toDir) (facing-south ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (first-turn ?p) (not (jammed ?p)))
        :effect (and (not (at ?p ?from)) (at ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 5))
    )

    ;; LATERAL REVERSE from west 
    (:action right_back_from_west
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-north ?toDir) (facing-west ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (not (jammed ?p)))
        :effect (and (facing-south ?p) (not (facing-west ?p)) (not (at ?p ?from)) (at ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 5))
    )

    (:action left_back_from_west
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-south ?toDir) (facing-west ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (not (jammed ?p)))
        :effect (and (facing-north ?p) (not (facing-west ?p)) (not (at ?p ?from)) (at ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 5))
    )

    ;; LATERAL REVERSE from north
    (:action right_back_from_north
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-east ?toDir) (facing-north ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (not (jammed ?p)))
        :effect (and (facing-west ?p) (not (facing-north ?p)) (not (at ?p ?from)) (at ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 5))
    )
    
    (:action left_back_from_north
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-west ?toDir) (facing-north ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (not (jammed ?p)))
        :effect (and (facing-east ?p) (not (facing-north ?p)) (not (at ?p ?from)) (at ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 5))
    )
    
    ;; LATERAL REVERSE from south
    (:action right_back_from_south
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-west ?toDir) (facing-south ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (not (jammed ?p)))
        :effect (and (facing-east ?p) (not (facing-south ?p)) (not (at ?p ?from)) (at ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 5))
    )
    
    (:action left_back_from_south
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-east ?toDir) (facing-south ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (not (jammed ?p)))
        :effect (and (facing-west ?p) (not (facing-south ?p)) (not (at ?p ?from)) (at ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 5))
    )

    ;; LATERAL REVERSE from east
    (:action right_back_from_east
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-south ?toDir) (facing-east ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (not (jammed ?p)))
        :effect (and (facing-north ?p) (not (facing-east ?p)) (not (at ?p ?from)) (at ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 5))
    )

    (:action left_back_from_east
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-north ?toDir) (facing-east ?p) (at ?p ?from) (on-ground ?p) (not (pit ?to)) (not (jammed ?p)))
        :effect (and (facing-south ?p) (not (facing-east ?p)) (not (at ?p ?from)) (at ?p ?to) (zero-turn ?p) (not (first-turn ?p)) (increase (total-cost) 5))
    )

    ;; REPAIR action
    (:action repair
        :parameters (?p - agent)
        :precondition (jammed ?p)
        :effect (and (zero-turn ?p) (not (jammed ?p)) (increase (total-cost) 50)) ;; TODO modify cost
    )
    
    ;; LOAD package on truck
    (:action load
        :parameters (?b - block ?p - agent ?s - square) ;; TODO notice that parameters are necessary without ADL, because you cannot use universal and existential quantifier
        :precondition (and (at ?p ?s) (block-at ?b ?s) (not (pit ?s)) (is-free ?p) (not (block-used-for-bridge ?b))) ;; TODO for the moment the truck can carry just one block at a time
        :effect (and (not (block-at ?b ?s)) (on ?b ?p) (not (is-free ?p)) (increase (total-cost) 2))
    )
    
    ;; UNLOAD package on floor
    (:action unload_ground
        :parameters (?b - block ?p - agent ?s - square)
        :precondition (and (at ?p ?s) (on ?b ?p) (not (pit ?s))) 
        :effect (and (not (on ?b ?p)) (block-at ?b ?s) (is-free ?p) (increase (total-cost) 1))
    )
    
    ;; UNLOAD package on block
    (:action unload_on_block
        :parameters (?p - agent ?b1 ?b2 - block ?s - square)
        :precondition (and (on ?b2 ?p) (agent-on-top ?p ?b1) (block-at ?b1 ?s)) 
        :effect (and 
                    (not (on ?b2 ?p)) 
                    (on-top ?b2 ?b1) 
                    (not (is-clear ?b1)) 
                    (block-at ?b2 ?s) 
                    (not (agent-on-top ?p ?b1)) 
                    (agent-on-top ?p ?b2)
                    (stack ?s) 
                    (block-used-for-bridge ?b1) 
                    (block-used-for-bridge ?b2) 
                    (increase (total-cost) 1))
    )
    
    ;; GET OFF a block when truck is on top of it
    (:action get_off_a_block
        :parameters (?p - agent ?b - block)
        :precondition (and (agent-on-top ?p ?b) (not (on-ground ?p)))
        :effect  (and (not (agent-on-top ?p ?b)) (on-ground ?p) (increase (total-cost) 1))
    )
    
    ;; BUILD BRIDGE BASE composed by 2 blocks TODO check if you can remove it
    (:action build_bridge_base
        :parameters (?p - agent ?b1 ?b2 - block ?from ?middle ?to - square ?d1 ?d2 - direction)
        :precondition (and (adj ?from ?middle ?d1) (adj ?middle ?to ?d2) (pit ?middle) (not (bridge-base-built ?from ?to)) (block-at ?b1 ?from) (block-at ?b2 ?to)) ;; TODO implement the fact that "from" "to" must NOT be the same square
        :effect (and (bridge-base-built ?from ?to) (increase (total-cost) 1))
    )
    
    ; (:action build_bridge_base
    ;     :parameters (?p - agent ?from ?middle ?to - square ?d1 ?d2 - direction)
    ;     :precondition (and (adj ?from ?middle ?d1) (adj ?middle ?to ?d2) (pit ?middle) (not (bridge-base-built ?from ?to)) (stack ?from) (stack ?to)) ;; TODO implement the fact that "from" "to" must NOT be the same square
    ;     :effect (and (bridge-base-built ?from ?to) (increase (total-cost) 1))
    ; )
    

    ;; BUILD bridge top level with 3 blocks 
    ; (:action build_bridge_top_level
    ;     :parameters (?p - agent ?from ?middle ?to - square ?d1 ?d2 - direction ?b1 ?b2 ?b3 ?b4 ?b5 - block)
    ;     :precondition (and (adj ?from ?middle ?d1) (adj ?middle ?to ?d2) (pit ?middle) (not (bridge-top-level-built ?from ?to)) (bridge-base-built ?from ?to) (at ?p ?from) (on-top ?b3 ?b1) (on-top ?b4 ?b2) (agent-on-top ?p ?b3) (on ?b5 ?p) )
    ;     :effect (and (bridge-top-level-built ?from ?to) (not (on ?b5 ?p)) (block-used-for-bridge ?b3) (block-used-for-bridge ?b4) (block-used-for-bridge ?b5))
    ; )

    ;; TODO try to simplify the action 
    ; (:action build_bridge_top_level
    ;     :parameters (?p - agent ?from ?to - direction ?b1 ?b2 ?b3 - block)
    ;     :precondition (and (not (bridge-top-level-built ?from ?to)) (bridge-base-built ?from ?to) (at ?p ?from) (agent-on-top ?p ?b3) (stack ?from) (stack ?to) (on ?b3 ?p))
    ;     :effect (and (bridge-top-level-built ?from ?to) (not (on ?b3 ?p)))
    ; )


    ;; CLIMB on block
    (:action climb_on_block
        :parameters (?p - agent ?s - square ?b - block)
        :precondition (and (block-at ?b ?s) (at ?p ?s) (not (agent-on-top ?p ?b)) (is-clear ?b) (on-ground ?p))
        :effect (and (agent-on-top ?p ?b) (not (on-ground ?p)) (increase (total-cost) 1))
    )


    
    
    
)