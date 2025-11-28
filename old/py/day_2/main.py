# Advent of Code 2015- Day 2

def read_input(filename):
    with open(filename) as file:
        return file.readlines()

def parse_dim(line):
    return tuple(map(int,line.strip().split("x")))

def calc_paper(l,w,h):
    sides = [l*w, w*h, h*l]
    surface_area = 2 * sum(sides)
    extra = min(sides)
    return surface_area + extra
def calc_ribbon(l,w,h):
    dims = sorted([l,w,h])
    wrap = 2 * (dims[0] + dims[1])
    bow = l*w*h
    return wrap + bow



def main():
   total_paper = 0
   total_ribbon = 0
   for line in read_input("input.txt"):
       l, w, h = parse_dim(line)
       total_paper += calc_paper(l, w, h)
       total_ribbon += calc_ribbon(l, w, h)

   print(f"Total paper: {total_paper}")
   print(f"Total ribbon: {total_ribbon}")

if __name__ == '__main__':
    main()
