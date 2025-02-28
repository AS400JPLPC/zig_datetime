const std = @import("std");



pub const Dte = @import("datetime").DATE;
pub const Dtm = @import("datetime").DTIME;
pub const Tmz = @import("timezones");
pub const Idm = @import("datetime").DATE.Idiom;
const allocator = std.heap.page_allocator;

const stdout = std.io.getStdOut().writer();
const stdin = std.io.getStdIn().reader();

pub fn main () ! void {
stdout.writeAll("\x1b[2J") catch {};
stdout.writeAll("\x1b[3J") catch {};



// const datesys = Dte.nowDate(Tmz.Europe.Paris);
// std.debug.print("SystemISO: {s}\n",.{datesys.string(allocator)});



const c = Dtm.nowUTC() ;
std.debug.print("chronolog: {d} {d} {d} {d} {d} {d} {d}\n",
     .{c.year,c.month,c.day,c.hour,c.minute,c.second,c.nanosecond});
std.debug.print("chrono UTC : {s}\n",.{c.stringTime(allocator)});
std.debug.print("Chrono NUM : {d}\n",.{c.numTime(allocator)});

var d = Dtm.nowTime(Tmz.Europe.Paris) ;
std.debug.print("chronolog: {d} {d} {d} {d} {d} {d} {d}\n",
     .{d.year,d.month,d.day,d.hour,d.minute,d.second,d.nanosecond});
std.debug.print("Chrono Europe.Paris : {s}\n",.{d.stringTime(allocator)});
std.debug.print("Chrono NUM Europe.Paris : {d}\n",.{d.numTime(allocator)});

std.debug.print("timestamp timezone included of datetime {d}\n",.{d.Timestamp()});


d = Dtm.nowTime(Tmz.Europe.Paris) ;
std.debug.print("Chrono Europe.Paris : {s}\n",.{d.stringTime(allocator)});

// pub const Detroit = create("America/Detroit", -300);
d = Dtm.nowTime(Tmz.America.Detroit) ;
std.debug.print("Chrono America.Detroit : {s}\n",.{d.stringTime(allocator)});

// pub const Los_Angeles = create("America/Los_Angeles", -480);
d = Dtm.nowTime(Tmz.America.Los_Angeles) ;
std.debug.print("Chrono America.Los_Angeles : {s}\n",.{d.stringTime(allocator)});

// pub const Seoul = create("Asia/Seoul", 540);
d = Dtm.nowTime(Tmz.Asia.Seoul) ;
std.debug.print("Chrono Asia.Seoul : {s}\n",.{d.stringTime(allocator)});


// pub const Tel_Aviv = create("Asia/Tel_Aviv", 120);
d = Dtm.nowTime(Tmz.Asia.Tel_Aviv) ;
std.debug.print("Chrono Asia.Tel_Aviv : {s}\n",.{d.stringTime(allocator)});

// pub const Melbourne = create("Australia/Melbourne", 600);
d = Dtm.nowTime(Tmz.Australia.Melbourne) ;
std.debug.print("Chrono Australia.Melbourne : {s}\n",.{d.stringTime(allocator)});

// pub const Atlantic = create("Canada/Atlantic", -240);
d = Dtm.nowTime(Tmz.Canada.Atlantic) ;
std.debug.print("Chrono Canada.Atlantic : {s}\n",.{d.stringTime(allocator)});

// pub const Sofia = create("Europe/Sofia", 120);
d = Dtm.nowTime(Tmz.Europe.Sofia) ;
std.debug.print("Chrono Europe.Sofia : {s}\n",.{d.stringTime(allocator)});


// pub const Japan = create("Japan", 540);
d = Dtm.nowTime(Tmz.Japan) ;
std.debug.print("Chrono Japan : {s}\n",.{d.stringTime(allocator)});

// pub const Apia = create("Pacific/Apia", 780);
d = Dtm.nowTime(Tmz.Pacific.Apia) ;
std.debug.print("Chrono Pacific.Apia : {s}\n",.{d.stringTime(allocator)});


// pub const Pacific = create("US/Pacific", -480);
d = Dtm.nowTime(Tmz.US.Pacific) ;
std.debug.print("Chrono US.Pacific : {s}\n",.{d.stringTime(allocator)});

// date timezone
var ed = Dte.nowDate(Tmz.Europe.Paris) ;
std.debug.print("date Europe.Paris : {s}\n",.{ed.string(allocator)});

ed = Dte.nowDate(Tmz.US.Pacific) ;
std.debug.print("date US.Pacific : {s}\n",.{ed.string(allocator)});

pause("stop");

}
fn pause(text : [] const u8) void {
    std.debug.print("{s}\n",.{text});
   	var buf : [3]u8  =	[_]u8{0} ** 3;
	_= stdin.readUntilDelimiterOrEof(buf[0..], '\n') catch unreachable;

}

