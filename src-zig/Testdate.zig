const std = @import("std");



pub const Dte = @import("datetime").DATE;
pub const Dtm = @import("datetime").DTIME;
pub const Tmz = @import("timezones");
pub const Idm = @import("datetime").DATE.Idiom;

const stdout = std.io.getStdOut().writer();
const stdin = std.io.getStdIn().reader();

pub fn main () ! void {
stdout.writeAll("\x1b[2J") catch {};
stdout.writeAll("\x1b[3J") catch {};

const datx = try Dte.create(1951, 10, 12);

const mois = Idm.nameMonth(datx.month,Idm.fr); 

std.debug.print("{s}\n",.{mois});


const moisx = Idm.abbrevMonth(datx.month,Idm.fr); 

std.debug.print("{s}\n",.{moisx});


const jour = Idm.nameDay(datx.weekday,Idm.fr); 

std.debug.print("{s}\n",.{jour});

const jourx = Idm.abbrevDay(datx.weekday,Idm.fr); 

std.debug.print("{s}\n",.{jourx});

std.debug.print("EXT fr {s}\n",.{datx.dateExt(Idm.fr)});
std.debug.print("EXT es {s}\n",.{datx.dateExt(Idm.es)});
std.debug.print("EXT cn {s}\n",.{datx.dateExt(Idm.cn)});
std.debug.print("EXT en {s}\n",.{datx.dateExt(Idm.en)});


std.debug.print("ABR fr {s}\n",.{datx.dateAbr(Idm.fr)});
std.debug.print("ABR es {s}\n",.{datx.dateAbr(Idm.es)});
std.debug.print("ABR cn {s}\n",.{datx.dateAbr(Idm.cn)});
std.debug.print("ABR en {s}\n",.{datx.dateAbr(Idm.en)});


pause("look date");

std.debug.print("{d}\n",.{datx.getWeekDay()});
std.debug.print("formatISO: {s}\n",.{datx.string()});
var daty = try Dte.copy(datx); 

_=Dte.yearsMore(&daty, 74);
std.debug.print("shiftYears  74 year: {s}\n",.{daty.string()});


var datn = try Dte.copy(datx);
_=Dte.daysLess(&datn, 500);
std.debug.print("shiftDays -500 day : {s}\n",.{datn.string()});



std.debug.print("{s}\n",.{daty.stringFR()});


std.debug.print("isWeekend: {}\n",.{daty.isWeekend()});

std.debug.print("dayOfYear: {d}\n",.{daty.quantieme()});

std.debug.print("getWeek: {d}\n",.{daty.getWeek()});


std.debug.print("formatISO: {s}\n",.{datx.string()});
std.debug.print("formatFR : {s}\n",.{datx.stringFR()});
std.debug.print("formatUS : {s}\n",.{datx.stringUS() });

var datez = try Dte.create(2025, 1, 10);
datez = try Dte.parseISO(datx.string());
std.debug.print("ISO {d} {d} {d}\n",.{datez.getYear(),datez.getMonth(),datez.getDay()});

datez = try Dte.parseFR(datx.stringFR());
std.debug.print("FR  {d} {d} {d}\n",.{datez.getDay(),datez.getMonth(),datez.getYear()});

datez = try Dte.parseUS(datx.stringUS());
std.debug.print("US  {d} {d} {d}\n",.{datez.getMonth(),datez.getDay(),datez.getYear()});


datez = try Dte.create(2025, 1, 10);
std.debug.print("eql:{s} {s} = {}\n",.{
    datx.string()  ,datez.string() ,Dte.eql(datx,datez)});
std.debug.print("gt :{s} {s} = {}\n",.{
    datx.string()  ,datez.string() ,Dte.gt(datx,datez)});
std.debug.print("gte:{s} {s} = {}\n",.{
    datx.string()  ,datez.string() ,Dte.gte(datx,datez)});
std.debug.print("lt :{s} {s} = {}\n",.{
    datx.string() ,datez.string() ,Dte.lt(datx,datez)});
std.debug.print("lte:{s} {s} = {}\n",.{
    datx.string() ,datez.string(), Dte.lte(datx,datez)});

std.debug.print("cmp:{s} {s} = {}\n",.{
    datx.string() ,datez.string(), Dte.cmp(datx,datez)});


std.debug.print("isoCalendar:{d} {d} {d}\n",.{
    datez.year, datez.week , datez.weekday , });




const c = Dtm.nowUTC() ;
std.debug.print("chronolog: {d} {d} {d} {d} {d} {d} {d}\n",
     .{c.year,c.month,c.day,c.hour,c.minute,c.second,c.nanosecond});
std.debug.print("chrono UTC : {s}\n",.{c.stringTime()});
std.debug.print("Chrono NUM : {d}\n",.{c.numTime()});


const dateh = try Dte.create(1515, 6, 10);
std.debug.print("ISO {d} {d} {d}\n",.{dateh.getYear(),dateh.getMonth(),dateh.getDay()});

var datxm = try Dte.create(1951, 10, 12);

Dte.dateOff(&datxm);

if (!datxm.status) std.debug.print("{}\n",.{null});

std.debug.print("datm null {d} {d}  {d} \n",.{datxm.year, datxm.month, datxm.day});
std.debug.print("===============================\n",.{});


// test fou  Idiot test
var datm = try Dte.create(1951, 10, 12);
std.debug.print("create(1951, 10, 12) : {s}\n",.{datm.string()});
 _= Dte.daysLess(&datm, 30);
std.debug.print("fewerDays(&datm, 30) day : {s}\n",.{datm.string()});

datm = try Dte.create(1951, 2, 1);
std.debug.print("create(1951, 2, 1) : {s}\n",.{datm.string()});
 _= Dte.daysMore(&datm, 20);
std.debug.print("moreDays(&datm, 20) : {s}\n",.{datm.string()});
 _= Dte.daysLess(&datm, 20);
std.debug.print("fewerDays(&datm, 20) : {s}\n",.{datm.string()});


datm = try Dte.create(1951, 5, 12);
std.debug.print("create(1951, 5, 12) : {s}\n",.{datm.string()});
std.debug.print("Quantieme: {d}\n",.{datm.quantieme()});
std.debug.print("restOfdays: {d}\n",.{datm.restOfdays()});


datm = try Dte.create(1951, 10, 12);
std.debug.print("create(1951, 10, 12) : {s}\n",.{datm.string()});
_= Dte.yearsMore(&datm, 10);
std.debug.print("moreYear(&datm, 10): {s}\n",.{datm.string()});
_= Dte.yearsLess(&datm, 10);
std.debug.print("fewverYear(&datm, 10): {s}\n",.{datm.string()});

datm = try Dte.create(2017, 1, 1);
std.debug.print("create(2017, 1, 1) : {s}\n",.{datm.string()});
std.debug.print("Quantieme : {d}\n",.{datm.quantieme()});
std.debug.print("weekNumber : {d}\n",.{datm.getWeek()});


datm = try Dte.create(2025, 1, 4);
std.debug.print("create(2025, 1, 1) : {s}\n",.{datm.string()});
std.debug.print("Quantieme : {d}\n",.{datm.quantieme()});
std.debug.print("weekNumber : {d}\n",.{datm.getWeek()});

// test semaine 53
datm = try Dte.create(2020, 12, 31);
pause("test semaine 53");
std.debug.print("create(2020, 12, 31) : {s}\n",.{datm.string()});
std.debug.print("Quantieme : {d}\n",.{datm.quantieme()});
std.debug.print("weekNumber : {d}\n",.{datm.getWeek()});
std.debug.print("restOfdays: {d}\n",.{datm.restOfdays()});







_= Dte.daysMore(&datm,20);
std.debug.print("shiftDays ad 20 day : {s}\n",.{datm.string()});
_= Dte.yearsMore(&datm,20);
std.debug.print("shiftYears ad 20 Year : {s}\n",.{datm.string()});


datm = try Dte.create(2025, 3, 1);
std.debug.print("create(2025, 3, 1) : {s}\n",.{datm.string()});
std.debug.print("isWeekend: {}\n",.{datm.isWeekend()});
std.debug.print("dayOfYear: {d}\n",.{datm.quantieme()});
std.debug.print("getWeek: {d}\n",.{datm.getWeek()});
std.debug.print("dayNum : {d}\n",.{datm.getWeekDay()});


std.debug.print("isoCalendar:{d} {d} {d}\n",.{
    datm.year, datm.week , datm.weekday });
Dte.deinitAlloc();
datm= try Dte.parseISO(datm.string());
std.debug.print("ISO {d} {d} {d}\n",.{datm.getYear(),datm.getMonth(),datm.getDay()});


// Dte.dateOff(&datm); //test error
// std.debug.print("dayOfYear: {d}\n",.{datm.quantieme()});
}



fn pause(text : [] const u8) void {
    std.debug.print("{s}\n",.{text});
   	var buf : [3]u8  =	[_]u8{0} ** 3;
	_= stdin.readUntilDelimiterOrEof(buf[0..], '\n') catch unreachable;

}

