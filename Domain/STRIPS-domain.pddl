(define (domain trucks-project-1) 

    (:requirements :strips :typing :negative-preconditions)
    (:types
        agent
        square
        direction ;; TODO maybe model with object types
        ;block
    )
    (:predicates
        (at ?p - agent  ?square - square)
        ;(block-at ?o - block  ?square - square)
        (adj ?x ?y - square ?d - direction)
        (pit ?x - square)   
        (facing-north ?p - agent)   
        (facing-east ?p - agent)
        (facing-south ?p - agent)
        (facing-west ?p - agent)
        
        (is-north ?d - direction)
        (is-west ?d - direction)
        (is-east ?d - direction)
        (is-south ?d - direction)

)           
    ;; TURN LEFT
    ;; actions to turn left if car faces east
    (:action turn_left_from_east
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-north ?toDir) (facing-east ?p) (at ?p ?from) (not (pit ?to)))
        :effect (and (facing-north ?p) (not (facing-east ?p)) (not (at ?p ?from)) (at ?p ?to))
    )
    
    ;; actions to turn left if car faces south
    (:action turn_left_from_south
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-east ?toDir) (facing-south ?p) (at ?p ?from) (not (pit ?to)))
        :effect (and (facing-east ?p) (not (facing-south ?p)) (not (at ?p ?from)) (at ?p ?to))
    )
    
    ;; actions to turn left if car faces north
    (:action turn_left_from_north
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-west ?toDir) (facing-north ?p) (at ?p ?from) (not (pit ?to)))
        :effect (and (facing-west ?p) (not (facing-north ?p)) (not (at ?p ?from)) (at ?p ?to))
    )
    
    ;; actions to turn left if car faces west
    (:action turn_left_from_west
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-south ?toDir) (facing-west ?p) (at ?p ?from) (not (pit ?to)))
        :effect (and (facing-south ?p) (not (facing-west ?p)) (not (at ?p ?from)) (at ?p ?to))
    )
    
    ;; TURN RIGHT
    ;; actions to turn right if car faces east
    (:action turn_right_from_east
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-south ?toDir)  (facing-east ?p) (at ?p ?from) (not (pit ?to))) 
        :effect (and (facing-south ?p) (not (facing-east ?p)) (not (at ?p ?from)) (at ?p ?to))
    )
    
    ;; actions to turn right if car faces south
    (:action turn_right_from_south
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-west ?toDir) (facing-south ?p) (at ?p ?from) (not (pit ?to)))
        :effect (and (facing-west ?p) (not (facing-south ?p)) (not (at ?p ?from)) (at ?p ?to))
    )
    
    ;; actions to turn right if car faces north
    (:action turn_right_from_north
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-east ?toDir)  (facing-north ?p) (at ?p ?from) (not (pit ?to)))
        :effect (and (facing-east ?p) (not (facing-north ?p)) (not (at ?p ?from)) (at ?p ?to))
    )
    
    ;; actions to turn right if car faces west
    (:action turn_right_from_west
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-north ?toDir) (facing-west ?p) (at ?p ?from) (not (pit ?to)))
        :effect (and (facing-north ?p) (not (facing-west ?p)) (not (at ?p ?from)) (at ?p ?to))
    )
    

    ;; MOVE FORWARD 
    ;; actions to move forward if car faces west
    (:action move_forward_from_east
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-east ?toDir) (facing-east ?p) (at ?p ?from) (not (pit ?to)))
        :effect (and (not (at ?p ?from)) (at ?p ?to))
    )
    
    ;; actions to move forward if car faces south
    (:action move_forward_from_south
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-south ?toDir) (facing-south ?p) (at ?p ?from) (not (pit ?to)))
        :effect (and (not (at ?p ?from)) (at ?p ?to)) 
    )
    
    ;; actions to move forward if car faces north
    (:action move_forward_from_north
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-north ?toDir) (facing-north ?p) (at ?p ?from) (not (pit ?to)))
        :effect (and (not (at ?p ?from)) (at ?p ?to))
    )
    
    ;; actions to move forward if car faces west
    (:action move_forward_from_west
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-west ?toDir) (facing-west ?p) (at ?p ?from) (not (pit ?to)))
        :effect (and (not (at ?p ?from)) (at ?p ?to))
    )
    
    ;; STRAIGHT REVERSE  
    ;; actions to move back if car faces east
    (:action move_back_from_east
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-west ?toDir) (facing-east ?p) (at ?p ?from) (not (pit ?to)))
        :effect (and (not (at ?p ?from)) (at ?p ?to))
    )
    
    ;; actions to move back if car faces west
    (:action move_back_from_west
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-east ?toDir) (facing-west ?p) (at ?p ?from) (not (pit ?to)))
        :effect (and (not (at ?p ?from)) (at ?p ?to))
    )
    
    ;; actions to move back if car faces north
    (:action move_back_from_north
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-south ?toDir) (facing-north ?p) (at ?p ?from) (not (pit ?to)))
        :effect (and (not (at ?p ?from)) (at ?p ?to))
    )
    
    ;; actions to move back if car faces south
    (:action move_back_from_south
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-north ?toDir) (facing-south ?p) (at ?p ?from) (not (pit ?to)))
        :effect (and (not (at ?p ?from)) (at ?p ?to))
    )
    
    ;; LATERAL REVERSE from west 
    (:action right_back_from_west
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-north ?toDir) (facing-west ?p) (at ?p ?from) (not (pit ?to)))
        :effect (and (facing-south ?p) (not (facing-west ?p)) (not (at ?p ?from)) (at ?p ?to))
    )

    (:action left_back_from_west
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-south ?toDir) (facing-west ?p) (at ?p ?from) (not (pit ?to)))
        :effect (and (facing-north ?p) (not (facing-west ?p)) (not (at ?p ?from)) (at ?p ?to))
    )

    ;; LATERAL REVERSE from north
    (:action right_back_from_north
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-east ?toDir) (facing-north ?p) (at ?p ?from) (not (pit ?to)))
        :effect (and (facing-west ?p) (not (facing-north ?p)) (not (at ?p ?from)) (at ?p ?to))
    )
    
    (:action left_back_from_north
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-west ?toDir) (facing-north ?p) (at ?p ?from) (not (pit ?to)))
        :effect (and (facing-east ?p) (not (facing-north ?p)) (not (at ?p ?from)) (at ?p ?to))
    )
    
    ;; LATERAL REVERSE from south
    (:action right_back_from_south
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-east ?toDir) (facing-south ?p) (at ?p ?from) (not (pit ?to)))
        :effect (and (facing-west ?p) (not (facing-south ?p)) (not (at ?p ?from)) (at ?p ?to))
    )
    
    (:action left_back_from_south
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-west ?toDir) (facing-south ?p) (at ?p ?from) (not (pit ?to)))
        :effect (and (facing-east ?p) (not (facing-south ?p)) (not (at ?p ?from)) (at ?p ?to))
    )

    ;; LATERAL REVERSE from east
    (:action right_back_from_east
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-south ?toDir) (facing-east ?p) (at ?p ?from) (not (pit ?to)))
        :effect (and (facing-north ?p) (not (facing-east ?p)) (not (at ?p ?from)) (at ?p ?to))
    )

    (:action left_back_from_east
        :parameters (?p - agent ?from ?to - square ?toDir - direction)
        :precondition (and (adj ?from ?to ?toDir) (is-north ?toDir) (facing-east ?p) (at ?p ?from) (not (pit ?to)))
        :effect (and (facing-south ?p) (not (facing-east ?p)) (not (at ?p ?from)) (at ?p ?to))
    )
)
