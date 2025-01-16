const std = @import("std");


pub const Dtc = @import("datetime").ISOCalendar;

pub const Dte = @import("datetime").Date;

pub const Dtm = @import("datetime").DTime;

pub const tmz = @import("timezones");

const allocator = std.heap.page_allocator;

const stdout = std.io.getStdOut().writer();
const stdin = std.io.getStdIn().reader();

pub fn main () ! void {
stdout.writeAll("\x1b[2J") catch {};
stdout.writeAll("\x1b[3J") catch {};

const datx = try Dte.create(1951, 10, 12);

const mois = datx.nameMonth(Dte.Idiom.fr); 

std.debug.print("{s}\n",.{mois});


const moisx = datx.abbrevMonth(Dte.Idiom.fr); 

std.debug.print("{s}\n",.{moisx});


const jour = datx.nameDay(Dte.Idiom.fr); 

std.debug.print("{s}\n",.{jour});

const jourx = datx.abbrevDay(Dte.Idiom.fr); 

std.debug.print("{s}\n",.{jourx});

std.debug.print("EXT fr {s}\n",.{try datx.dateExt(allocator,Dte.Idiom.fr)});
std.debug.print("EXT es {s}\n",.{try datx.dateExt(allocator,Dte.Idiom.es)});
std.debug.print("EXT cn {s}\n",.{try datx.dateExt(allocator,Dte.Idiom.cn)});
std.debug.print("EXT en {s}\n",.{try datx.dateExt(allocator,Dte.Idiom.en)});


std.debug.print("ABR fr {s}\n",.{try datx.dateAbr(allocator,Dte.Idiom.fr)});
std.debug.print("ABR es {s}\n",.{try datx.dateAbr(allocator,Dte.Idiom.es)});
std.debug.print("ABR cn {s}\n",.{try datx.dateAbr(allocator,Dte.Idiom.cn)});
std.debug.print("ABR en {s}\n",.{try datx.dateAbr(allocator,Dte.Idiom.en)});

std.debug.print("{d}\n",.{Dte.dayNum(datx)});

const daty = Dte.shiftYears(datx, 74);
std.debug.print("shiftYears add 74 year: {s}\n",.{daty.stringIso(allocator) catch "0" });



const datn = Dte.shiftDays(datx, 20);
std.debug.print("shiftDays ad 20 day : {s}\n",.{datn.stringIso(allocator) catch "0" });



std.debug.print("{s}\n",.{daty.stringFR(allocator) catch "0" });


std.debug.print("isWeekend: {}\n",.{daty.isWeekend()});

std.debug.print("dayOfYear: {d}\n",.{daty.dayOfYear()});

std.debug.print("getWeek: {d}\n",.{daty.getWeek()});


std.debug.print("formatIso: {s}\n",.{datx.stringIso(allocator) catch "0" });
std.debug.print("formatFR : {s}\n",.{datx.stringFR(allocator) catch "0" });
std.debug.print("formatUS : {s}\n",.{datx.stringUS(allocator) catch "0" });

var datez = try Dte.create(2025, 1, 10);
datez = try Dte.parseIso(datx.stringIso(allocator) catch "0" );
std.debug.print("ISO {d} {d} {d}\n",.{datez.getYear(),datez.getMonth(),datez.getDay()});

datez = try Dte.parseFR(datx.stringFR(allocator) catch "0" );
std.debug.print("FR  {d} {d} {d}\n",.{datez.getDay(),datez.getMonth(),datez.getYear()});

datez = try Dte.parseUS(datx.stringUS(allocator) catch "0" );
std.debug.print("US  {d} {d} {d}\n",.{datez.getMonth(),datez.getDay(),datez.getYear()});


datez = try Dte.create(2025, 1, 10);
std.debug.print("eql:{s} {s} = {}\n",.{
    datx.stringIso(allocator) catch "0",datez.stringIso(allocator) catch "0",Dte.eql(datx,datez)});
std.debug.print("gt :{s} {s} = {}\n",.{
    datx.stringIso(allocator) catch "0",datez.stringIso(allocator) catch "0",Dte.gt(datx,datez)});
std.debug.print("gte:{s} {s} = {}\n",.{
    datx.stringIso(allocator) catch "0",datez.stringIso(allocator) catch "0",Dte.gte(datx,datez)});
std.debug.print("lt :{s} {s} = {}\n",.{
    datx.stringIso(allocator) catch "0",datez.stringIso(allocator) catch "0",Dte.lt(datx,datez)});
std.debug.print("lte:{s} {s} = {}\n",.{
    datx.stringIso(allocator) catch "0",datez.stringIso(allocator) catch "0",Dte.lte(datx,datez)});

std.debug.print("cmp:{s} {s} = {}\n",.{
    datx.stringIso(allocator) catch "0",datez.stringIso(allocator) catch "0",Dte.cmp(datx,datez)});


const calendar :  Dtc  = datx.isoCalendar(); 
std.debug.print("isoCalendar:{d} {d} {d}\n",.{
    calendar.year, calendar.week , calendar.weekday , });


const datesys = try Dte.nowDate(tmz.Europe.Paris);
std.debug.print("SystemIso: {s}\n",.{datesys.stringIso(allocator) catch "0" });



const c = try Dtm.nowUTC() ;
std.debug.print("chronolog: {d} {d} {d} {d} {d} {d} {d}\n",
     .{c.year,c.month,c.day,c.hour,c.minute,c.second,c.nanosecond});
std.debug.print("chrono UTC : {s}\n",.{c.stringTime(allocator) catch "0" });
std.debug.print("Chrono NUM : {d}\n",.{c.numTime(allocator) catch 0 });

const d = try Dtm.nowTime(tmz.Europe.Paris) ;
std.debug.print("chronolog: {d} {d} {d} {d} {d} {d} {d}\n",
     .{d.year,d.month,d.day,d.hour,d.minute,d.second,d.nanosecond});
std.debug.print("Chrono UTC Europe.Paris : {s}\n",.{d.stringTime(allocator) catch "0" });
std.debug.print("Chrono NUM Europe.Paris : {d}\n",.{d.numTime(allocator) catch 0 });

std.debug.print("timestamp timezone included of datetime {d}\n",.{d.Timestamp()});

const dateh = try Dte.create(1515, 6, 10);
std.debug.print("ISO {d} {d} {d}\n",.{dateh.getYear(),dateh.getMonth(),dateh.getDay()})

;}

fn pause(text : [] const u8) void {
    std.debug.print("{s}\n",.{text});
   	var buf : [3]u8  =	[_]u8{0} ** 3;
	_= stdin.readUntilDelimiterOrEof(buf[0..], '\n') catch unreachable;

}

