#!/usr/bin/env python3

import re
from collections import defaultdict


def sum_colors(input_string):
    color_sums = defaultdict(int)  # Dictionary to hold color counts

    # Extract the relevant part of the string after "Game 1:"
    normalized = input_string.split(":", 1)[1]  # Get everything after the first colon

    # Split the normalized string by semicolons
    segments = normalized.split(";")
    for segment in segments:
        # Split by commas to get color-count pairs
        color_pairs = segment.split(",")
        for color_pair in color_pairs:
            # Trim whitespace
            color_pair = color_pair.strip()
            # Use regex to find numbers and colors
            matches = re.findall(r"(\d+)\s+(\w+)", color_pair)
            for count, color in matches:
                count = int(count)  # Convert count to an integer
                color_sums[color] += count  # Sum counts for each color

    # Convert the results into a formatted string
    result = ", ".join(f"{count} {color}" for color, count in color_sums.items())
    return result


# Example usage
game_string = "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"
total_colors = sum_colors(game_string)
print(f"Total colors: {total_colors}")
