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

const datx = try Dte.create(1951, 10, 12);

const mois = Idm.nameMonth(datx.month,Idm.fr); 

Print("{s}\n",.{mois});


const moisx = Idm.abbrevMonth(datx.month,Idm.fr); 

Print("{s}\n",.{moisx});


const jour = Idm.nameDay(datx.weekday,Idm.fr); 

Print("{s}\n",.{jour});

const jourx = Idm.abbrevDay(datx.weekday,Idm.fr); 

Print("{s}\n",.{jourx});

Print("EXT fr {s}\n",.{datx.dateExt(Idm.fr)});
Print("EXT es {s}\n",.{datx.dateExt(Idm.es)});
Print("EXT cn {s}\n",.{datx.dateExt(Idm.cn)});
Print("EXT en {s}\n",.{datx.dateExt(Idm.en)});


Print("ABR fr {s}\n",.{datx.dateAbr(Idm.fr)});
Print("ABR es {s}\n",.{datx.dateAbr(Idm.es)});
Print("ABR cn {s}\n",.{datx.dateAbr(Idm.cn)});
Print("ABR en {s}\n",.{datx.dateAbr(Idm.en)});


Pause("look date");

Print("{d}\n",.{datx.getWeekDay()});
Print("formatISO: {s}\n",.{datx.string()});
var daty = try Dte.copy(datx); 

_=Dte.yearsMore(&daty, 74);
Print("shiftYears  74 year: {s}\n",.{daty.string()});


var datn = try Dte.copy(datx);
_=Dte.daysLess(&datn, 500);
Print("shiftDays -500 day : {s}\n",.{datn.string()});



Print("{s}\n",.{daty.stringFR()});


Print("isWeekend: {}\n",.{daty.isWeekend()});

Print("dayOfYear: {d}\n",.{daty.quantieme()});

Print("getWeek: {d}\n",.{daty.getWeek()});


Print("formatISO: {s}\n",.{datx.string()});
Print("formatFR : {s}\n",.{datx.stringFR()});
Print("formatUS : {s}\n",.{datx.stringUS() });

var datez = try Dte.create(2025, 1, 10);
datez = try Dte.parseISO(datx.string());
Print("ISO {d} {d} {d}\n",.{datez.getYear(),datez.getMonth(),datez.getDay()});

datez = try Dte.parseFR(datx.stringFR());
Print("FR  {d} {d} {d}\n",.{datez.getDay(),datez.getMonth(),datez.getYear()});

datez = try Dte.parseUS(datx.stringUS());
Print("US  {d} {d} {d}\n",.{datez.getMonth(),datez.getDay(),datez.getYear()});


datez = try Dte.create(2025, 1, 10);
Print("eql:{s} {s} = {}\n",.{
    datx.string()  ,datez.string() ,Dte.eql(datx,datez)});

Print("gt :{s} {s} = {}\n",.{
    datx.string()  ,datez.string() ,Dte.gt(datx,datez)});

Print("gte:{s} {s} = {}\n",.{
    datx.string()  ,datez.string() ,Dte.gte(datx,datez)});

Print("lt :{s} {s} = {}\n",.{
    datx.string() ,datez.string() ,Dte.lt(datx,datez)});

Print("lte:{s} {s} = {}\n",.{
    datx.string() ,datez.string(), Dte.lte(datx,datez)});

Print("cmp:{s} {s} = {}\n",.{
    datx.string() ,datez.string(), Dte.cmp(datx,datez)});


Print("isoCalendar:{d} {d} {d}\n",.{
    datez.year, datez.week , datez.weekday , });




const c = Dtm.nowUTC() ;
Print("chronolog: {d} {d} {d} {d} {d} {d} {d}\n",
     .{c.year,c.month,c.day,c.hour,c.minute,c.second,c.nanosecond});

Print("chrono UTC : {s}\n",.{c.stringTime()});

Print("Chrono NUM : {d}\n",.{c.numTime()});


const dateh = try Dte.create(1515, 6, 10);
Print("ISO {d} {d} {d}\n",.{dateh.getYear(),dateh.getMonth(),dateh.getDay()});

var datxm = try Dte.create(1951, 10, 12);

Dte.dateOff(&datxm);

if (!datxm.status) std.debug.print("{}\n",.{null});

Print("datm null {d} {d}  {d} \n",.{datxm.year, datxm.month, datxm.day});
Print("===============================\n",.{});


// test fou  Idiot test
var datm = try Dte.create(1951, 10, 12);
Print("create(1951, 10, 12) : {s}\n",.{datm.string()});

 _= Dte.daysLess(&datm, 30);
Print("fewerDays(&datm, 30) day : {s}\n",.{datm.string()});

datm = try Dte.create(1951, 2, 1);
Print("create(1951, 2, 1) : {s}\n",.{datm.string()});

 _= Dte.daysMore(&datm, 20);
Print("moreDays(&datm, 20) : {s}\n",.{datm.string()});

 _= Dte.daysLess(&datm, 20);
Print("fewerDays(&datm, 20) : {s}\n",.{datm.string()});


datm = try Dte.create(1951, 5, 12);
Print("create(1951, 5, 12) : {s}\n",.{datm.string()});
Print("Quantieme: {d}\n",.{datm.quantieme()});
Print("restOfdays: {d}\n",.{datm.restOfdays()});


datm = try Dte.create(1951, 10, 12);
Print("create(1951, 10, 12) : {s}\n",.{datm.string()});

_= Dte.yearsMore(&datm, 10);
Print("moreYear(&datm, 10): {s}\n",.{datm.string()});

_= Dte.yearsLess(&datm, 10);
Print("fewverYear(&datm, 10): {s}\n",.{datm.string()});

datm = try Dte.create(2017, 1, 1);
Print("create(2017, 1, 1) : {s}\n",.{datm.string()});
Print("Quantieme : {d}\n",.{datm.quantieme()});
Print("weekNumber : {d}\n",.{datm.getWeek()});


datm = try Dte.create(2025, 1, 4);
Print("create(2025, 1, 1) : {s}\n",.{datm.string()});
Print("Quantieme : {d}\n",.{datm.quantieme()});
Print("weekNumber : {d}\n",.{datm.getWeek()});

// test semaine 53
datm = try Dte.create(2020, 12, 31);
Pause("test semaine 53");
Print("create(2020, 12, 31) : {s}\n",.{datm.string()});
Print("Quantieme : {d}\n",.{datm.quantieme()});
Print("weekNumber : {d}\n",.{datm.getWeek()});
Print("restOfdays: {d}\n",.{datm.restOfdays()});







_= Dte.daysMore(&datm,20);
Print("shiftDays ad 20 day : {s}\n",.{datm.string()});
_= Dte.yearsMore(&datm,20);
Print("shiftYears ad 20 Year : {s}\n",.{datm.string()});


datm = try Dte.create(2025, 3, 1);
Print("create(2025, 3, 1) : {s}\n",.{datm.string()});
Print("isWeekend: {}\n",.{datm.isWeekend()});
Print("dayOfYear: {d}\n",.{datm.quantieme()});
Print("getWeek: {d}\n",.{datm.getWeek()});
Print("dayNum : {d}\n",.{datm.getWeekDay()});


Print("isoCalendar:{d} {d} {d}\n",.{
    datm.year, datm.week , datm.weekday });
Dte.deinitAlloc();
datm= try Dte.parseISO(datm.string());
Print("ISO {d} {d} {d}\n",.{datm.getYear(),datm.getMonth(),datm.getDay()});


// Dte.dateOff(&datm); //test error
// std.debug.print("dayOfYear: {d}\n",.{datm.quantieme()});
}

