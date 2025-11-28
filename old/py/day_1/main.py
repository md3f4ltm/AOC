# Advent of Code 2015- Day 1
from dis import Instruction

def open_file(filename):
    with open(filename) as file:
        return file.read()


def calc_floor(instructions):
    return sum(1 if char == '(' else -1 for char in instructions if char in '()')

def calc_basement(instructions):
    floor = 0
    for pos, char in enumerate(instructions):
        if char == '(':
            floor += 1
        elif char == ')':
            floor -= 1
        if floor < 0:
            return pos+1
    return -1





if __name__ == '__main__':
    instructions = open_file("input.txt")
    final_floor = calc_floor(instructions)
    print(f"Final floor:  {final_floor}")
    basement_pos = calc_basement(instructions)
    print(f"Basement position : {basement_pos}")
