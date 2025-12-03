const std = @import("std");
const input = @embedFile("inputs/day03.txt");

pub fn main() !void {
    var total_joltage: u32 = 0;
    var total_joltage_2: u64 = 0;

    var lines = std.mem.tokenizeAny(u8, input, "\n");

    while (lines.next()) |line| {
        var max_bank: u32 = 0;
        for (0..line.len) |i| {
            for (i + 1..line.len) |j| {
                if (!std.ascii.isDigit(line[i]) or !std.ascii.isDigit(line[i])) continue;
                const d1 = line[i] - '0';
                const d2 = line[j] - '0';

                const current_joltage = (d1 * 10) + d2;

                if (current_joltage > max_bank) {
                    max_bank = current_joltage;
                }
            }
        }
        total_joltage += max_bank;
        total_joltage_2 += try findMaxJoltage(line);
        std.debug.print("{any}\n", .{max_bank});
    }
    std.debug.print("{any}\n", .{total_joltage});
    std.debug.print("{any}\n", .{total_joltage_2});
}

pub fn findMaxJoltage(line: []const u8) !u64 {
    const target_len = 12;

    var result: [target_len]u8 = undefined;
    var current_start: usize = 0;

    for (0..target_len) |i| {
        const digits_left = (target_len - 1) - i;
        const search_limit = line.len - digits_left;

        var max_digit: u8 = 0;
        var max_digit_index: usize = 0;
        for (current_start..search_limit) |j| {
            const digit = line[j];
            if (digit > max_digit) {
                max_digit = digit;
                max_digit_index = j;
            }
            if (max_digit == '9') break;
        }
        result[i] = max_digit;
        current_start = max_digit_index + 1;
    }
    return std.fmt.parseInt(u64, &result, 10);
}
