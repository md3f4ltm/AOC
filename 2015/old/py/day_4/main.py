import hashlib

# Read the secret key from input.txt
with open('input.txt', 'r') as file:
    secret_key = file.read().strip()

# Function to find the smallest number with the required leading zeros in MD5 hash
def find_smallest_number(secret_key, required_zeros):
    number = 1
    while True:
        # Create the input string by concatenating the secret key and the current number
        input_str = secret_key + str(number)
        # Compute MD5 hash of the input string encoded as UTF-8 bytes
        md5_hash = hashlib.md5(input_str.encode('utf-8')).hexdigest()
        # Check if the hash starts with the required number of zeros
        if md5_hash.startswith('0' * required_zeros):
            return number
        number += 1

# For part one, we need five leading zeros
result_part_one = find_smallest_number(secret_key, 5)
print(f"Part One Result: {result_part_one}")

# For part two, we need six leading zeros
result_part_two = find_smallest_number(secret_key, 6)
print(f"Part Two Result: {result_part_two}")
