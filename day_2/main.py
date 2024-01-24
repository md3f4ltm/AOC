import re

def read_file():
    file_name = 'input.txt'

    try:
        # Open the file and read the content line by line
        with open(file_name, 'r') as file:
            data = file.readlines()

    except FileNotFoundError:
        print(f"File '{file_name}' not found.")
        return None  # Return None if the file is not found

    return data  # Return the data if the file is successfully read

def check_data(line):
    # Initialize dictionaries to store counts for each color
    counts = {'blue': 0, 'green': 0, 'red': 0}

    # Find all color-count pairs in the game line
    color_counts = re.findall(r'(\d+) (\w+)', line)

    # Update the counts dictionary based on color-count pairs
    for num, color in color_counts:
            counts[color] += int(num)

    return counts

def main():
    max_counts = {'blue': 14, 'green': 13, 'red': 12}  # Maximum counts for each color
    min_counts = {'blue': 14, 'green': 13, 'red': 12}  # Min counts for each color
    data = read_file()
    sum_games = 0 #True if game possible for part 1
    sum_power = 0
    for line in data:
        possible = True
        power = 1
        substrings = line.split(";") #split the sets
        result_not_needed = check_data(line)
        game_id_matches = re.findall(r'Game (\d+):',line)
        min_counts = result_not_needed
        print("***************************")
        print(line)
        print(result_not_needed)
        for substring in substrings:
            result = check_data(substring)
            print("-------------------")
            for color in result:
                #Verify if any set surpasses max_counts
                if result[color] > max_counts[color]:
                   possible = False
                #Give min_counts the min values of the sets
                if min_counts[color] < result[color]:
                    if result[color] > 0:
                        min_counts[color] = result[color]

        if possible:
            game_id = int(game_id_matches[0])
            sum_games  += game_id

        for color in min_counts:
            power *= min_counts[color]
        sum_power += power
        print("MIN COUTS-->",min_counts)
        print(power)
        print(sum_power)

    print("Part 1 resultado:", sum_games)
    print("Part 2 resultado",sum_power)

main()
