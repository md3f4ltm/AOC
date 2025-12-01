const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const file = try std.fs.cwd().openFile("src/inputs/day01.txt", .{});
    defer file.close();

    const input = try file.readToEndAlloc(allocator, 1024 * 1024);
    defer allocator.free(input);

    var pos: i32 = 50;

    var password_count: i32 = 0;
    var password_count2: i32 = 0;

    var lines = std.mem.splitScalar(u8, input, '\n');

    while (lines.next()) |line| {
        const trimmed = std.mem.trim(u8, line, " \r\t");
        if (trimmed.len == 0) continue;
        const val = try std.fmt.parseInt(i32, trimmed[1..], 10);
        const direction = trimmed[0];
        const start = @mod(pos, 100);

        switch (direction) {
            'L' => pos -= val,
            'R' => pos += val,
            else => {},
        }

        pos = @mod(pos, 100);

        var hits: i32 = 0;
        if (direction == 'R') {
            var k0 = @mod(100 - start, 100);
            if (k0 == 0) k0 = 100;
            if (val >= k0) hits = 1 + @divTrunc(val - k0, 100);
        } else if (direction == 'L') {
            var k0 = @mod(start, 100);
            if (k0 == 0) k0 = 100;
            if (val >= k0) hits = 1 + @divTrunc(val - k0, 100);
        }
        password_count2 += hits;

        if (pos == 0) password_count += 1;
        std.debug.print("{}\n", .{pos});
    }

    std.debug.print("Pass:{any}\n", .{password_count});
    std.debug.print("Pass part2:{any}\n", .{password_count2});
}
