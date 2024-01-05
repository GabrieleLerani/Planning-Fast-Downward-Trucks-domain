(define (problem truck_1)
    (:domain trucks-project-2)
    (:objects   
            sq-1-1 sq-1-2 sq-1-3 
            sq-2-1 sq-2-2 sq-2-3 
            sq-3-1 sq-3-2 sq-3-3 - square
            driver - agent
            b1 b2 b3 b4 b5 - block
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
        
        (pit sq-2-2)

        (at driver sq-1-1)
        (facing-north driver)
        
        (block-at b1 sq-2-1)
        (block-at b2 sq-2-1)
        (block-at b3 sq-2-1)
        (block-at b4 sq-2-1)
        (block-at b5 sq-2-1)

        ; (block-used-for-bridge b1)
        ; (block-used-for-bridge b2)


        (is-clear b1)
        (is-clear b2)
        (is-clear b3)
        (is-clear b4)
        (is-clear b5)

        (zero-turn driver)
        (is-free driver)
        (on-ground driver)
        
        (= (total-cost) 0)

    )

    ;(:goal (and (at driver sq-3-3) (jammed driver)))
    ;(:goal  (and (block-at b1 sq-3-3) (block-at b2 sq-3-3)))
    ;(:goal  (and (block-at b1 sq-3-3) (block-at b2 sq-3-3) (on-top b2 b1) (at driver sq-1-1)) )
    
    
    (:goal (and  (bridge-base-built sq-1-2 sq-3-2)))

    (:metric minimize (total-cost))
)