const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const file = try std.fs.cwd().openFile("src/inputs/day01.txt", .{});
    defer file.close();
    const input = try file.readToEndAlloc(allocator, 1024 * 1024);
    defer allocator.free(input);

    std.debug.print("{d}\n", .{input.len});

    var current_floor: i32 = 0;
    var pos_basement: ?usize = null;

    for (input, 0..) |c, i| {
        switch (c) {
            '(' => current_floor += 1,
            ')' => current_floor -= 1,
            else => {},
        }
        if (current_floor == -1 and pos_basement == null) {
            pos_basement = i + 1;
        }
    }
    std.debug.print("Current floor {d}\n", .{current_floor});
    std.debug.print("Position {any}\n", .{pos_basement});
}
