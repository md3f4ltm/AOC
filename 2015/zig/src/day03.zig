const std = @import("std");

const Point = struct {
    x: i32,
    y: i32,
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const file = try std.fs.cwd().openFile("src/inputs/day03.txt", .{});
    defer file.close();

    const input = try file.readToEndAlloc(allocator, 1024 * 1024);
    defer allocator.free(input);

    var x: i32 = 0;
    var y: i32 = 0;

    var visited = std.AutoHashMap(Point, void).init(allocator);
    try visited.put(.{ .x = x, .y = y }, {});
    defer visited.deinit();

    for (input) |char| {
        switch (char) {
            '>' => x += 1,
            '<' => x -= 1,
            'v' => y -= 1,
            '^' => y += 1,
            else => continue, // Ignore garbage
        }
        try visited.put(.{ .x = x, .y = y }, {});
    }

    std.debug.print("Houses Visited: {d}\n", .{visited.count()});

    // --------Part 2 -------------------//
    var santaRobot = [2]Point{ .{ .x = 0, .y = 0 }, .{ .x = 0, .y = 0 } };

    var visited2 = std.AutoHashMap(Point, void).init(allocator);
    try visited2.put(santaRobot[0], {});
    defer visited2.deinit();

    for (input, 0..) |char, i| {
        const turn = i % 2;

        const current_pos = &santaRobot[turn];

        switch (char) {
            '>' => current_pos.x += 1,
            '<' => current_pos.x -= 1,
            'v' => current_pos.y -= 1,
            '^' => current_pos.y += 1,
            else => continue, // Ignore garbage
        }
        try visited2.put(current_pos.*, {});
    }

    std.debug.print("Houses visited: {d}", .{visited2.count()});
}
