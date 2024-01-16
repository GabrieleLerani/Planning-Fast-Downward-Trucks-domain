import random

def get_neighbors(n,m,i,j):
    neighbors = []
    rows, cols = n, m

    # Define the relative positions of neighbors
    directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]

    for di, dj in directions:
        ni, nj = i + di, j + dj
        # Check if the neighbor is within the matrix boundaries
        if 1 <= ni <= rows and 1 <= nj <= cols:
            neighbors.append((ni, nj))

    return neighbors


def print_neighbors(i, j, neighbors):

    for elem in neighbors:
        if i+1 == elem[0]:
            print(f'(adj sq-{i}-{j} sq-{elem[0]}-{elem[1]} N)')
        if j+1 == elem[1]:
            print(f'(adj sq-{i}-{j} sq-{elem[0]}-{elem[1]} E)')
        if i-1 == elem[0]:
            print(f'(adj sq-{i}-{j} sq-{elem[0]}-{elem[1]} S)')
        if j-1 == elem[1]:
            print(f'(adj sq-{i}-{j} sq-{elem[0]}-{elem[1]} W)')

  
def get_square(n,m):
    
    squares = []
    # Get neighbors for all elements in the matrix
    for i in range(1,n+1):
        for j in range(1,m+1):
            squares.append((i,j))
            neighbors = get_neighbors(n,m,i,j)
            print_neighbors(i,j,neighbors)

    # print all squares
    for i in range(1,n+1):
        for j in range(1,m+1):
            print(f"sq-{i}-{j}", end = " ")
        print("\n")    
    
    return squares

def get_pit(k, squares):

    if k > len(squares):
        print("More pits than squares!")
        return None

    pits = random.sample(squares, k)

    for p in pits:
        print(f'(pit sq-{p[0]}-{p[1]})')
    return pits

def get_block(b):
    # get block for problem definition
    for i in range(1,b+1):
        print(f'b{i}', end=' ')
    print("")


    # get blocks for problem definition
    for i in range(1,b+1):        
        print(f'(block-at b{i} sq-1-1)')


squares = get_square(4,3)
# pits = get_pit(20,squares)
# get_block(1000)


# TODO insert random generation of pit in the grid
