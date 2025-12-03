const std = @import("std");
const input = @embedFile("inputs/day02.txt");

pub fn main() !void {
    var total_sum: u64 = 0;
    var total_sum_two: u64 = 0;

    var range = std.mem.tokenizeScalar(u8, input, ',');

    while (range.next()) |range_token| {
        var bounds_iter = std.mem.tokenizeScalar(u8, range_token, '-');
        const start_str = std.mem.trim(u8, bounds_iter.next().?, &std.ascii.whitespace);
        const end_str = std.mem.trim(u8, bounds_iter.next().?, &std.ascii.whitespace);
        const start = try std.fmt.parseInt(u64, start_str, 10);
        const end = try std.fmt.parseInt(u64, end_str, 10);
        var current: u64 = start;

        while (current <= end) : (current += 1) {
            if (try hasRepeatedPattern(current)) total_sum += current;
            if (try hasRepeatedPatternTwo(current)) total_sum_two += current;
        }
    }
    std.debug.print("Part 1: {}\n", .{total_sum});
    std.debug.print("Part 2: {}\n", .{total_sum_two});
}

pub fn hasRepeatedPattern(id: u64) !bool {
    var buf: [32]u8 = undefined;
    const s = try std.fmt.bufPrint(&buf, "{}", .{id});

    if (s.len % 2 != 0) return false;

    const mid: usize = s.len / 2;
    const first = s[0..mid];
    const second = s[mid..];

    return std.mem.eql(u8, first, second);
}

pub fn hasRepeatedPatternTwo(id: u64) !bool {
    var buf: [32]u8 = undefined;
    const s = try std.fmt.bufPrint(&buf, "{}", .{id});
    const s_len = s.len;

    if (s_len <= 1) return false;

    for (1..(s_len / 2) + 1) |k| {
        if (s_len % k == 0) {
            var is_repeated = true;
            for (k..s_len) |i| {
                if (s[i] != s[i - k]) {
                    is_repeated = false;
                    break;
                }
            }
            if (is_repeated) return true;
        }
    }

    return false;
}
