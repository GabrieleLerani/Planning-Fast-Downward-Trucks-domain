(define (problem problem_2)
    (:domain trucks_domain)
    (:objects   
            sq-1-1 sq-1-2 sq-1-3 sq-1-4 
            sq-2-1 sq-2-2 sq-2-3 sq-2-4 
            sq-3-1 sq-3-2 sq-3-3 sq-3-4 
            sq-4-1 sq-4-2 sq-4-3 sq-4-4 - square
            driver - agent
            b1 b2 b3 - block
            N S W E - direction
            f1 f2 - footbridge
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
        (adj sq-4-1 sq-3-1 S)
        (adj sq-4-1 sq-4-2 E)
        (adj sq-4-2 sq-3-2 S)
        (adj sq-4-2 sq-4-1 W)
        (adj sq-4-2 sq-4-3 E)
        (adj sq-4-3 sq-3-3 S)
        (adj sq-4-3 sq-4-2 W)
        (adj sq-4-3 sq-4-4 E)
        (adj sq-4-4 sq-3-4 S)
        (adj sq-4-4 sq-4-3 W)
        

        (pit sq-2-2)
        (pit sq-2-3)
        (pit sq-3-1)
        (pit sq-3-3)
        (pit sq-3-4)
        (pit sq-4-2)
        
        (at driver sq-1-3)
        (facing driver N)
        
        (block-at b1 sq-2-1)
        (block-at b2 sq-2-1)
        (block-at b3 sq-2-1)
        

        (foot-bridge-at f1 sq-2-1)
        (foot-bridge-at f2 sq-1-2)
        

    
        (zero-turn driver)
        (is-free driver)
        (on-ground driver)
        
        (= (total-cost) 0)

    )

 
    

    (:goal (and
      
      
        (at driver sq-4-3)  
        
    ))
    

    (:metric minimize (total-cost))
)