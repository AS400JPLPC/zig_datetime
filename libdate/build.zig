    ///-----------------------
    /// build (library)
    ///-----------------------

const std = @import("std");

pub fn build(b: *std.Build) void {

    const timezones_mod = b.addModule("timezones", .{
        .root_source_file = b.path( "./datetime/timezones.zig" ),
    });
    const datetime_mod = b.addModule("datetime", .{
        .root_source_file = b.path( "./datetime/datetime.zig" ),
        .imports= &.{
        .{ .name = "timezones", .module = timezones_mod},
        },
    });


    const libdate_mod = b.addModule("library", .{
        .root_source_file = b.path( "library.zig" ),
        .imports = &.{
        .{ .name = "datetime",    .module = datetime_mod },
        .{ .name = "timezones", .module = timezones_mod },
        },
    });


    _=libdate_mod;

}
