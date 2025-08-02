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

    // const zenlib_dep  = b.dependency("library", .{});
    // const zenlib_sql  = b.dependency("libsql", .{});
    const zenlib_date = b.dependency("libdate", .{});



    // Building the executable
    const Prog = b.addExecutable(.{
    .name = "TimezoneCRT",
    .root_module = b.createModule(.{
	    .root_source_file =  b.path( "./TimezoneCRT.zig" ),
	    .target = target,
	    .optimize = optimize,
    }),
    });
    
    Prog.root_module.addImport("datetime", zenlib_date.module("datetime"));
    b.installArtifact(Prog);

}

