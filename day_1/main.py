def extract_calibration_values(calibration_document):
    calibration_values = []
    str_to_digit = {'zero': 0,
                          'one':1,
                          'two':2,
                          'three':3,
                          'four':4,
                          'five':5,
                          'six':6,
                          'seven':7
                          ,'eight':8
                          ,'nine':9}

    for line in calibration_document:
        nums = []
        for i in range(len(line)):
            if line[i].isdigit():
                nums.append(line[i])
            else:
                for str_num in str_to_digit:
                    if line[i:].startswith(str_num):
                        nums.append(str_to_digit[str_num])


        calibration_values.append(int(str(nums[0]) + str(nums[-1])))


    sum_calibration = sum(calibration_values)
    return sum_calibration

def main():
    # Replace 'input.txt' with the actual name of your text file
    file_name = 'input.txt'

    try:
        # Open the file and read the content
        with open(file_name, 'r') as file:
            calibration_document = [line.strip() for line in file]

        # Calculate the sum of calibration values
        result = extract_calibration_values(calibration_document)

        # Print the result
        print("Sum of calibration values:", result)

    except FileNotFoundError:
        print(f"File '{file_name}' not found.")

if __name__ == "__main__":
    main()

