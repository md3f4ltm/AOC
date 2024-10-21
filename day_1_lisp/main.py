def read_file(file_path):
    """Reads a file and returns its lines as a list."""
    try:
        with open(file_path, "r") as file:
            lines = file.readlines()  # Read all lines into a list
        return lines
    except FileNotFoundError:
        print(f"Error: The file '{file_path}' was not found.")
        return []
    except Exception as e:
        print(f"An error occurred: {e}")
        return []


def concatenate_first_last_number(lines):
    results = []

    for line in lines:
        first_digit = None
        last_digit = None

        # Find the first digit
        for char in line:
            if char.isdigit():
                first_digit = char
                print(first_digit)
                break

        # Find the last digit
        for char in reversed(line):
            if char.isdigit():
                last_digit = char
                print(last_digit)
                break

        if first_digit is not None and last_digit is not None:
            # Concatenate first and last digit with the line
            result = f"{first_digit}{last_digit}"
            results.append(result)

    return results


numbers = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]


def concatenate_part2(lines):
    total = 0
    for line in lines:
        digits = []
        for i, c in enumerate(line):
            if c.isdigit():
                digits.append(c)
            else:
                for si, num in enumerate(numbers):
                    if line[i:].startswith(num):
                        digits.append(str(si + 1))
        print(digits)

        if digits:
            total += int(digits[0] + digits[-1])
    print(total)


def sum_digits(results):
    total = 0
    for result in results:
        total += int(result)
    print(total)


def print_results(results):
    """Prints the concatenated results."""
    for result in results:
        print(result)


file_path = "1.txt"  # Specify your file path here
lines = read_file(file_path)  # Read the file
concatenate_part2(lines)  # Concatenate the first and last digits
