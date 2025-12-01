# Read the input from the file
with open('input.txt', 'r') as f:
    directions = f.readline().strip()

# Part 1: Only Santa delivers
visited_santa = set()
s_pos = (0, 0)
visited_santa.add(s_pos)

for i in range(len(directions)):
    d = directions[i]
    dx, dy = 0, 0
    if d == '>':
        dx = 1
    elif d == '<':
        dx = -1
    elif d == '^':
        dy = 1
    elif d == 'v':
        dy = -1

    s_pos = (s_pos[0] + dx, s_pos[1] + dy)
    visited_santa.add(s_pos)

print("Part 1:", len(visited_santa))

# Part 2: Santa and Robo-Santa take turns
visited_both = set()
s_pos = (0, 0)
r_pos = (0, 0)
visited_both.add((0, 0))  # Starting point is visited by both initially

for i in range(len(directions)):
    d = directions[i]
    dx, dy = 0, 0
    if d == '>':
        dx = 1
    elif d == '<':
        dx = -1
    elif d == '^':
        dy = 1
    elif d == 'v':
        dy = -1

    if i % 2 == 0:
        # Santa's turn
        s_pos = (s_pos[0] + dx, s_pos[1] + dy)
        visited_both.add(s_pos)
    else:
        # Robo-Santa's turn
        r_pos = (r_pos[0] + dx, r_pos[1] + dy)
        visited_both.add(r_pos)

print("Part 2:", len(visited_both))
