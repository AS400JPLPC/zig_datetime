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

    const zenlib_date = b.dependency("libdate", .{});

    // Building the executable
    const Prog = b.addExecutable(.{
    .name = "Testdate",
    .root_source_file =  b.path( "./Testdate.zig" ),
    .target = target,
    .optimize = optimize,
    });

    Prog.root_module.addImport("datetime", zenlib_date.module("datetime"));
	Prog.root_module.addImport("timezones", zenlib_date.module("timezones"));

    b.installArtifact(Prog);




}
