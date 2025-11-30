const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    var day: u32 = 1;
    while (day <= 25) : (day += 1) {
        const day_str = b.fmt("day{:0>2}", .{day});
        const zig_file = b.fmt("src/{s}.zig", .{day_str});

        // 1. Check if file exists (optional, prevents errors on empty days)
        // Note: In 0.15, checking file existence in build.zig is tricky without
        // triggering build errors. It is usually easier to just assume it exists
        // or ensure the files are created.

        // 2. Define the executable using the new Module system
        const exe = b.addExecutable(.{
            .name = day_str,
            .root_module = b.createModule(.{
                .root_source_file = b.path(zig_file),
                .target = target,
                .optimize = optimize,
            }),
        });

        // 3. Define the run step
        const run_cmd = b.addRunArtifact(exe);
        run_cmd.step.dependOn(b.getInstallStep());

        if (b.args) |args| {
            run_cmd.addArgs(args);
        }

        const run_step = b.step(day_str, b.fmt("Run day {}", .{day}));
        run_step.dependOn(&run_cmd.step);
    }
}
