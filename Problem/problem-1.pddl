(define (problem truck_1)
    (:domain trucks-project-2)
    (:objects sq-1-1 sq-1-2 sq-1-3 sq-1-4 sq-1-5 
            sq-2-1 sq-2-2 sq-2-3 sq-2-4 sq-2-5 
            sq-3-1 sq-3-2 sq-3-3 sq-3-4 sq-3-5 
            sq-4-1 sq-4-2 sq-4-3 sq-4-4 sq-4-5 
            sq-5-1 sq-5-2 sq-5-3 sq-5-4 sq-5-5 - square
            driver - agent
            N S W E - direction
    )

    (:init

        (is-north N)
        (is-south S)
        (is-west W)
        (is-east E)

        (adj sq-1-1 sq-2-1 N)
        (adj sq-1-1 sq-1-2 E)
        (adj sq-1-2 sq-2-2 N)
        (adj sq-1-2 sq-1-1 W)
        (adj sq-1-2 sq-1-3 E)
        (adj sq-1-3 sq-2-3 N)
        (adj sq-1-3 sq-1-2 W)
        (adj sq-2-1 sq-1-1 S)
        (adj sq-2-1 sq-3-1 N)
        (adj sq-2-1 sq-2-2 E)
        (adj sq-2-2 sq-1-2 S)
        (adj sq-2-2 sq-3-2 N)
        (adj sq-2-2 sq-2-1 W)
        (adj sq-2-2 sq-2-3 E)
        (adj sq-2-3 sq-1-3 S)
        (adj sq-2-3 sq-3-3 N)
        (adj sq-2-3 sq-2-2 W)
        (adj sq-3-1 sq-2-1 S)
        (adj sq-3-1 sq-3-2 E)
        (adj sq-3-2 sq-2-2 S)
        (adj sq-3-2 sq-3-1 W)
        (adj sq-3-2 sq-3-3 E)
        (adj sq-3-3 sq-2-3 S)
        (adj sq-3-3 sq-3-2 W)

           
        (at driver sq-1-1)
        (facing-north driver)
       
        (pit sq-2-1)
        (pit sq-3-1)
        (pit sq-3-2)
        (pit sq-1-3)
        (zero-turn driver)

    )

    (:goal (and (at driver sq-3-3) (facing-north driver)))
    ;;(:goal (stucked driver))
)