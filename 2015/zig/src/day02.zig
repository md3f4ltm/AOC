const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const file = try std.fs.cwd().openFile("src/inputs/day02.txt", .{});
    defer file.close();

    // Read entire file
    const input = try file.readToEndAlloc(allocator, 1024 * 1024);
    defer allocator.free(input);

    // Split by newline
    var total: i32 = 0;
    var total_ribbon: i32 = 0;

    var it = std.mem.splitScalar(u8, input, '\n');

    while (it.next()) |line| {
        if (line.len == 0) continue;
        var parts = std.mem.splitScalar(u8, line, 'x');
        const l = try std.fmt.parseInt(i32, parts.next().?, 10);
        const w = try std.fmt.parseInt(i32, parts.next().?, 10);
        const h = try std.fmt.parseInt(i32, parts.next().?, 10);

        // Calc sides
        const side1 = l * w;
        const side2 = w * h;
        const side3 = h * l;

        const smallside = @min(side1, side2, side3);

        const smallperimeter = @min(2 * (l + w), 2 * (w + h), 2 * (h + l));
        const bow = l * w * h;

        total_ribbon += smallperimeter + bow;
        total += 2 * side1 + 2 * side2 + 2 * side3 + smallside;
        std.debug.print("l: {}, w: {}, h: {}\n", .{ l, w, h });
    }
    std.debug.print("Result: {}\n", .{total});
    std.debug.print("Ribbon: {}\n", .{total_ribbon});
}
