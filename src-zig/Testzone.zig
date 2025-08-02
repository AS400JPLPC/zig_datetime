const std = @import("std");



pub const Dte = @import("datetime").DATE;
pub const Dtm = @import("datetime").DTIME;
pub const Tmz = @import("timezones");
pub const Idm = @import("datetime").DATE.Idiom;


//============================================================================================
var stdin = std.fs.File.stdin();
var stdout = std.fs.File.stdout().writerStreaming(&.{});


inline fn Print( comptime format: []const u8, args: anytype) void {
    stdout.interface.print(format, args) catch  {} ;
}
inline fn WriteAll( args: anytype) void {
    stdout.interface.writeAll(args) catch {} ;
}

fn Pause(msg : [] const u8 ) void{

    Print("\nPause  {s}\r\n",.{msg});
    var buf: [16]u8 = undefined;
    var c  : usize = 0;
    while (c == 0) {
        c = stdin.read(&buf) catch unreachable;
    }
}
//============================================================================================


pub fn main () ! void {
WriteAll("\x1b[2J");
WriteAll("\x1b[3J");



// const datesys = Dte.nowDate(Tmz.Europe.Paris);
// std.debug.print("SystemISO: {s}\n",.{datesys.string()});



const c = Dtm.nowUTC() ;
Print("chronolog: {d} {d} {d} {d} {d} {d} {d}\n",
     .{c.year,c.month,c.day,c.hour,c.minute,c.second,c.nanosecond});
Print("chrono UTC : {s}\n",.{c.stringTime()});
Print("Chrono NUM : {d}\n",.{c.numTime()});

var d = Dtm.nowTime(Tmz.Europe.Paris) ;
Print("chronolog: {d} {d} {d} {d} {d} {d} {d}\n",
     .{d.year,d.month,d.day,d.hour,d.minute,d.second,d.nanosecond});
Print("Chrono Europe.Paris : {s}\n",.{d.stringTime()});
Print("Chrono NUM Europe.Paris : {d}\n",.{d.numTime()});

Print("timestamp timezone included of datetime {d}\n",.{d.Timestamp()});


d = Dtm.nowTime(Tmz.Europe.Paris) ;
Print("Chrono Europe.Paris : {s}\n",.{d.stringTime()});

// pub const Detroit = create("America/Detroit", -300);
d = Dtm.nowTime(Tmz.America.Detroit) ;
Print("Chrono America.Detroit : {s}\n",.{d.stringTime()});

// pub const Los_Angeles = create("America/Los_Angeles", -480);
d = Dtm.nowTime(Tmz.America.Los_Angeles) ;
Print("Chrono America.Los_Angeles : {s}\n",.{d.stringTime()});

// pub const Seoul = create("Asia/Seoul", 540);
d = Dtm.nowTime(Tmz.Asia.Seoul) ;
Print("Chrono Asia.Seoul : {s}\n",.{d.stringTime()});


// pub const Tel_Aviv = create("Asia/Tel_Aviv", 120);
d = Dtm.nowTime(Tmz.Asia.Tel_Aviv) ;
Print("Chrono Asia.Tel_Aviv : {s}\n",.{d.stringTime()});

// pub const Melbourne = create("Australia/Melbourne", 600);
d = Dtm.nowTime(Tmz.Australia.Melbourne) ;
Print("Chrono Australia.Melbourne : {s}\n",.{d.stringTime()});

// pub const Atlantic = create("Canada/Atlantic", -240);
d = Dtm.nowTime(Tmz.Canada.Atlantic) ;
Print("Chrono Canada.Atlantic : {s}\n",.{d.stringTime()});

// pub const Sofia = create("Europe/Sofia", 120);
d = Dtm.nowTime(Tmz.Europe.Sofia) ;
Print("Chrono Europe.Sofia : {s}\n",.{d.stringTime()});


// pub const Japan = create("Japan", 540);
d = Dtm.nowTime(Tmz.Japan) ;
Print("Chrono Japan : {s}\n",.{d.stringTime()});

// pub const Apia = create("Pacific/Apia", 780);
d = Dtm.nowTime(Tmz.Pacific.Apia) ;
Print("Chrono Pacific.Apia : {s}\n",.{d.stringTime()});


// pub const Pacific = create("US/Pacific", -480);
d = Dtm.nowTime(Tmz.US.Pacific) ;
Print("Chrono US.Pacific : {s}\n",.{d.stringTime()});

// date timezone
var ed = Dte.nowDate(Tmz.Europe.Paris) ;
Print("date Europe.Paris : {s}\n",.{ed.string()});

ed = Dte.nowDate(Tmz.US.Pacific) ;
Print("date US.Pacific : {s}\n",.{ed.string()});

Dtm.deinitAlloc();
Dte.deinitAlloc();
Pause("stop");


}

