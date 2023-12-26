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

n = 5  
m = 5  

# Get neighbors for all elements in the matrix
for i in range(1,n+1):
    for j in range(1,m+1):
        neighbors = get_neighbors(n,m,i,j)
        print_neighbors(i,j,neighbors)

# print all squares
for i in range(1,n+1):
    for j in range(1,m+1):
        print(f"sq-{i}-{j}", end = " ")
    print("\n")    

