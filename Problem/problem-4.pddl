(define (problem truck_1)
    (:domain trucks-project-8)
    (:objects   
            sq-1-1 sq-1-2 sq-1-3 sq-1-4 sq-1-5 
            sq-2-1 sq-2-2 sq-2-3 sq-2-4 sq-2-5 
            sq-3-1 sq-3-2 sq-3-3 sq-3-4 sq-3-5 
            sq-4-1 sq-4-2 sq-4-3 sq-4-4 sq-4-5 
            sq-5-1 sq-5-2 sq-5-3 sq-5-4 sq-5-5  - square
            driver - agent
            b1 b2 - block
            N S W E - direction
            f1 - footbridge
    )

    (:init

        (opposite N S)
        (opposite S N)
        (opposite W E)
        (opposite E W)

        (adj sq-1-1 sq-2-1 N)
        (adj sq-1-1 sq-1-2 E)
        (adj sq-1-2 sq-2-2 N)
        (adj sq-1-2 sq-1-1 W)
        (adj sq-1-2 sq-1-3 E)
        (adj sq-1-3 sq-2-3 N)
        (adj sq-1-3 sq-1-2 W)
        (adj sq-1-3 sq-1-4 E)
        (adj sq-1-4 sq-2-4 N)
        (adj sq-1-4 sq-1-3 W)
        (adj sq-1-4 sq-1-5 E)
        (adj sq-1-5 sq-2-5 N)
        (adj sq-1-5 sq-1-4 W)
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
        (adj sq-2-3 sq-2-4 E)
        (adj sq-2-4 sq-1-4 S)
        (adj sq-2-4 sq-3-4 N)
        (adj sq-2-4 sq-2-3 W)
        (adj sq-2-4 sq-2-5 E)
        (adj sq-2-5 sq-1-5 S)
        (adj sq-2-5 sq-3-5 N)
        (adj sq-2-5 sq-2-4 W)
        (adj sq-3-1 sq-2-1 S)
        (adj sq-3-1 sq-4-1 N)
        (adj sq-3-1 sq-3-2 E)
        (adj sq-3-2 sq-2-2 S)
        (adj sq-3-2 sq-4-2 N)
        (adj sq-3-2 sq-3-1 W)
        (adj sq-3-2 sq-3-3 E)
        (adj sq-3-3 sq-2-3 S)
        (adj sq-3-3 sq-4-3 N)
        (adj sq-3-3 sq-3-2 W)
        (adj sq-3-3 sq-3-4 E)
        (adj sq-3-4 sq-2-4 S)
        (adj sq-3-4 sq-4-4 N)
        (adj sq-3-4 sq-3-3 W)
        (adj sq-3-4 sq-3-5 E)
        (adj sq-3-5 sq-2-5 S)
        (adj sq-3-5 sq-4-5 N)
        (adj sq-3-5 sq-3-4 W)
        (adj sq-4-1 sq-3-1 S)
        (adj sq-4-1 sq-5-1 N)
        (adj sq-4-1 sq-4-2 E)
        (adj sq-4-2 sq-3-2 S)
        (adj sq-4-2 sq-5-2 N)
        (adj sq-4-2 sq-4-1 W)
        (adj sq-4-2 sq-4-3 E)
        (adj sq-4-3 sq-3-3 S)
        (adj sq-4-3 sq-5-3 N)
        (adj sq-4-3 sq-4-2 W)
        (adj sq-4-3 sq-4-4 E)
        (adj sq-4-4 sq-3-4 S)
        (adj sq-4-4 sq-5-4 N)
        (adj sq-4-4 sq-4-3 W)
        (adj sq-4-4 sq-4-5 E)
        (adj sq-4-5 sq-3-5 S)
        (adj sq-4-5 sq-5-5 N)
        (adj sq-4-5 sq-4-4 W)
        (adj sq-5-1 sq-4-1 S)
        (adj sq-5-1 sq-5-2 E)
        (adj sq-5-2 sq-4-2 S)
        (adj sq-5-2 sq-5-1 W)
        (adj sq-5-2 sq-5-3 E)
        (adj sq-5-3 sq-4-3 S)
        (adj sq-5-3 sq-5-2 W)
        (adj sq-5-3 sq-5-4 E)
        (adj sq-5-4 sq-4-4 S)
        (adj sq-5-4 sq-5-3 W)
        (adj sq-5-4 sq-5-5 E)
        (adj sq-5-5 sq-4-5 S)
        (adj sq-5-5 sq-5-4 W)
        
    
        (pit sq-2-3)
        (pit sq-3-4)
        (pit sq-3-5)
        (pit sq-4-2)
        (pit sq-4-4)
        (pit sq-4-5)
        (pit sq-5-2)
        (pit sq-5-3)
        (pit sq-5-4)
        (pit sq-5-5)

        (at driver sq-1-1)
        (facing driver N)
        
        (block-at b1 sq-1-4)
        (block-at b2 sq-2-4)
        
    
        (foot-bridge-at f1 sq-5-1)
        
        (is-clear b1)
        (is-clear b2)
        
        
        (zero-turn driver)
        (is-free driver)
        (on-ground driver)
        
        (= (total-cost) 0)

    )

    ;(:goal (and (at driver sq-3-3) (jammed driver)))
    ;(:goal  (and (block-at b1 sq-3-3) (block-at b2 sq-3-3)))
    ;(:goal  (and (block-at b1 sq-3-3) (block-at b2 sq-3-3) (on-top b2 b1) (at driver sq-1-1)) )
    
    ;(:goal (and  (block-at b1 sq-1-2) (at driver sq-1-2) (facing-west driver)))
    ;(:goal (and  (bridge-top-level-built sq-1-2 sq-3-2)))
    ;(:goal (and  (bridge-top-level-built sq-1-2 sq-3-2)))
    
    ;(:goal (and (at driver sq-2-3)))
    

    (:goal (and
        ; (adj-bridge b1 b2)
        ; (adj-bridge b2 b3)
        ; (adj-bridge b3 b4)
        ; (block-at b1 sq-1-3)
        ; (block-at b2 sq-2-3)
        ; (block-at b3 sq-3-3)
        ; (block-at b4 sq-4-3)
        ; (block-at b3 sq-2-2)
        ; (at driver sq-1-1)

        ;(not (on-ground driver)) (facing-north driver) (adj sq-1-1 sq-1-2 E) (agent-on-top driver b1)
        ;(agent-on-top driver b2)
        (at driver sq-4-4)
        
        
        
    ))
    

    (:metric minimize (total-cost))
)