# PDDL Modeling and heuristic search with Fast-Downward planner
## Overview
Truck can move like a car: turn left, turn
right, reverse and one step forward. If the machine makes two consecutive turns, it jams, but
it can be repaired and resume movement, altough with a very high repair cost.
Trucks can carry blocks but they have also the ability to climb on them in order to construct
buildings. My idea is to model the world with a NxN grid, in some cells there are blocks that
trucks can use, in other cells there may be pits and the truck can build a bridge on top of
them using its climbing ability.
Due to the ruined floor the truck consumes more energy moving on the ground than when
walking on bridges.
The goal is to reach an exit cell, of course the truck needs to navigate through the grid,
potentially building bridges to traverse pits efficiently.

![Problem2](https://github.com/GabrieleLerani/Planning-Fast-Downward-Trucks-domain/assets/92364167/48971ea4-8ba5-4fc6-ba36-97f11f76c323)

# Goal
The goal of the project is to model a truck domain in PDDL and evaluates the quality of the domain with different search heuristics:
- hadd
- hff
- hmax
- blind

# Results
Using STRIPS modeling I improved the search time of 20% with respect to using ADL specifications. <br>
Blind heuristics outperforms all the other for small problem instances, but heuristics based on delete relaxation (hadd, hff, hmax) scales better for bigger problems.

![Screenshot from 2024-01-27 18-47-37](https://github.com/GabrieleLerani/Planning-Fast-Downward-Trucks-domain/assets/92364167/e2d69193-0768-4ca6-a4d1-42a9c1f9aadb)

 
