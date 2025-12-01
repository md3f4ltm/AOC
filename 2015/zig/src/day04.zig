const std = @import("std");

const input = @embedFile("inputs/day04.txt");

pub fn main() !void {
    var lines = std.mem.splitScalar(u8, input, '\n');
    var nice_count: i32 = 0;
    var nice_count2: i32 = 0;

    while (lines.next()) |line| {
        const trimmed = std.mem.trim(u8, line, " \r\t");
        if (isNice(trimmed) == true) nice_count += 1;
        if (isNiceTwo(trimmed) == true) nice_count2 += 1;
    }
    std.debug.print("There is {} nice strings\n", .{nice_count});
    std.debug.print("Part2: There is {} nice strings\n", .{nice_count2});
}

pub fn isNice(line: []const u8) bool {
    if (std.mem.indexOf(u8, line, "ab") != null) return false;
    if (std.mem.indexOf(u8, line, "cd") != null) return false;
    if (std.mem.indexOf(u8, line, "pq") != null) return false;
    if (std.mem.indexOf(u8, line, "xy") != null) return false;

    var vowel_count: i32 = 0;
    var has_double = false;

    for (line, 0..) |c, i| {
        switch (c) {
            'a', 'e', 'i', 'o', 'u' => vowel_count += 1,
            else => {},
        }
        if (i > 0) {
            if (c == line[i - 1]) has_double = true;
        }
    }
    if (vowel_count >= 3 and has_double) return true else return false;
}

pub fn isNiceTwo(line: []const u8) bool {
    if (repetingLetter(line) == true and asRepetingPair(line) == true) return true;
    return false;
}

pub fn asRepetingPair(line: []const u8) bool {
    if (line.len < 4) return false;

    for (0..line.len - 3) |i| {
        const pair1 = line[i .. i + 2];
        for (i + 2..line.len - 1) |j| {
            const pair2 = line[j .. j + 2];
            if (std.mem.eql(u8, pair1, pair2)) return true;
        }
    }
    return false;
}

pub fn repetingLetter(line: []const u8) bool {
    if (line.len < 3) return false;

    for (0..line.len - 2) |i| {
        if (line[i] == line[i + 2]) return true;
    }
    return false;
}
