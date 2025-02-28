const std = @import("std");

pub fn build(b: *std.Build) void {
	// Standard release options allow the person running `zig build` to select
	// between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
	const target   = b.standardTargetOptions(.{});
	const optimize = b.standardOptimizeOption(.{});
 
    // zig-src            source projet
    // zig-src/deps       curs/ form / outils ....
    // src_c              source c/c++



    // Definition of dependencies

    // Building the executable
    const Prog = b.addExecutable(.{
    .name = "create_timezones",
    .root_source_file =  b.path("./create_timezones.zig" ),
    .target = target,
    .optimize = optimize,
    });

    b.installArtifact(Prog);

	const run_exe = b.addRunArtifact(Prog);

    const run_step = b.step("run", "Run the application");
    run_step.dependOn(&run_exe.step);

}

