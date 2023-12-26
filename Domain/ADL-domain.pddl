(define (domain trucks-project-2) 

  (:requirements :strips :typing :adl :negative-preconditions)
  (:types
    agent
    square
    direction
  )
  (:predicates
    (at ?p - agent  ?square - square)
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

  ;; Actions for turning left
  (:action turn-left
    :parameters (?p - agent ?from ?to - square ?toDir - direction)
    :precondition (and (adj ?from ?to ?toDir) (at ?p ?from) (not (pit ?to)))
    :effect (and
              (when (is-north ?toDir) (facing-west ?p))
              (when (is-east ?toDir) (facing-north ?p))
              (when (is-south ?toDir) (facing-east ?p))
              (when (is-west ?toDir) (facing-south ?p))
              (not (at ?p ?from)) (at ?p ?to)
            )
  )

  ;; Actions for turning right
  (:action turn-right
    :parameters (?p - agent ?from ?to - square ?toDir - direction)
    :precondition (and (adj ?from ?to ?toDir) (at ?p ?from) (not (pit ?to)))
    :effect (and
              (when (is-north ?toDir) (facing-east ?p))
              (when (is-east ?toDir) (facing-south ?p))
              (when (is-south ?toDir) (facing-west ?p))
              (when (is-west ?toDir) (facing-north ?p))
              (not (at ?p ?from)) (at ?p ?to)
            )
  )

  ;; Actions for moving forward
  (:action move-forward
    :parameters (?p - agent ?from ?to - square ?toDir - direction)
    :precondition (and (adj ?from ?to ?toDir) (at ?p ?from) (not (pit ?to)))
    :effect (and
              (when (and (facing-east ?p) (is-east ?toDir)) (facing-east ?p))
              (when (and (facing-south ?p) (is-south ?toDir)) (facing-south ?p))
              (when (and (facing-north ?p) (is-west ?toDir)) (facing-west ?p))
              (when (is-north ?toDir) (facing-north ?p))
              (not (at ?p ?from)) (at ?p ?to)
            )
  )
  
  ;; ACTUALLY it doesn't work this ADL modification
  ;; TODO: Implement actions for reversing

)
