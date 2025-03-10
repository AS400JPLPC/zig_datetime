# Zig Datetime

thank

[![actions](frmdstryr/](https://github.com/frmdstryr/zig-datetime)



## Table of Contents

- [Usage](#usage)

    - [Outils](#outils)

    - [DateTime](#datetime)

    - [Date](#date)

    - [Timezone](#timezone)

    - [Notes](#notes)

    - [Avancement](#avancement)


## Usage

```zig

pub const Dte = @import("datetime").Date;  // work date Y M D

pub const Dtm = @import("datetime").DTime;  // UTC chronolog

pub const tmz = @import("timezones");       // Time zones


const allocator = std.heap.page_allocator;
const date = try Dte.create(2019, 12, 25);
const next_year = date.shiftDays(7);
assert(next_year.year == 2020);
assert(next_year.month == 1);
assert(next_year.day == 1);
const datuday= try. now(tmz.Europe.Paris);  // get milliTimestanp add timezones = YMD of day
  
// In UTC  milliTimestamp
const now = Dtm.now(tmz.Europe.Paris);
std.debug.print("formaChrono UTC : {s}\n",.{c.ChronoTime(allocator) catch "0" });
// formaChrono UTC : 2025-01-14T:11:25:37N:0491Z:000
std.debug.print("formaChrono NUM : {d}\n",.{c.ChronoNum(allocator) catch 0 });
// formaChrono NUM : 202501141125370491000

```
</br>

## Notes

This is a standard date processing library, plus a feature for SQL that supports a NULL zone.</br>
See examples in the zig_sql project.</br>
</br>
In SQL, there are two ways of handling dates:</br>
“NULL”, e.g. invoicing not processed.</br>
</br>
“0000-00-00” is not a valid date, it's just an indication, you shouldn't use it in your SQL.</br>
</br>
The date becomes invalid, for example when a record is “deinit”. </br>
Dte.DATE.dateOff(&dfacture), becomes “0000-00-00” its status changes to false.</br>
</br>
</br>
Normally, if you don't fiddle with the date apart from retrieving twisted text,</br>
there'll be no error, catch unreachable instead of try</br>
</br>

To regenerate the timezone.zig file, run gensrc.sh from the create_timezones folder.</br>
this file is generated from timedatectl </br>
</br>

To be dynamic, an LMDB file is generated at each reboot only if the readTimezone() function is used.</br>
Time-zone processing in source file ./liboffset/timeoffset.zig</br>
</br>
searchWeek” is a function that determines the number of weeks, the last week and the start of week 01.</br>
</br>

![](assets/20250116_012345_Testdate.png)


![](assets/20250116_012345_Testzone.png)

</br>

## Outils

|Function               | Description                              | Pub |
|-----------------------|------------------------------------------|-----|
|checkLeapYear          | is Leap Year                             |  .  |
|dayInYear              | Number of days in the year               |  .  |
|daysInMonth            | Number of days in the month              |  .  |
|daysBeforeYear         | Number of days before Jan 1st of year    |  .  |
|daysBeforeMonth        | Number of days   of the month precedent  |  .  |
|isFile                 | openfileAbsolute lmdb                    |  .  |


## DateTime


|Function               | Description                              | Pub |
|-----------------------|------------------------------------------|-----|
|HardTime               | Change of field attribute                |  .  |
|nowUTC                 | Timestamp date in UTC ONLY               |  x  |
|nowTime                | Timestamp date into Time-zone            |  x  |
|Timestamp              | Date time reverse  timestamp             |  x  |
|NumTime                | Timestamp date into time-zone            |  x  |
|stringTime             | Date-time format string                  |  x  |


## Date

|Function    | Description                                          | Pub |Panic|
|------------|------------------------------------------------------|-----|-----|
|create      | Create and validate the date                         |  x  |  ?  |
|dateOff     | Change status OFF for work SQL = null                |  x  |     |
[isBad       | Consistency test of the date                         |  .  [     |
|copy        | Return a copy of the date                            |  x  |  x  |
|HardDate    | Change of field attribute                            |  .  |     |
|nowDate     | Returns today's date into time-zone   readTimezone() |  x  |     |
|eql         | comparaison                                          |  x  |     |
|comp        | comparaison                                          |  x  |     |
|gt          | comparaison                                          |  x  |     |
|gte         | comparaison                                          |  x  |     |
|lt          | comparaison                                          |  x  |     |
|lte         | comparaison                                          |  x  |     |
|parseIso    | Parse date in format YYYY-MM-DD                      |  x  |  x  |
|parseFR     | Parse date in format YYYY-MM-DD                      |  x  |  x  |
|parseUS     | Parse date in format YYYY-MM-DD                      |  x  |  x  |
|formatIso   | Return date in ISO format YYYY-MM-DD                 |  .  |     |
|formatFR    | Return date in ISO format DD-MM-YYYY                 |  .  |     |
|formatUS    | Return date in ISO format MM-DD-YYYY                 |  .  |     |
|getYear     | get year                                             |  x  |     |
|getMonth    | get Month                                            |  x  |     |
|getDay      | get Day                                              |  x  |     |
|getWeek     | get Week                                             |  x  |     |
|getWeekDay  | get WeekDay                                          |  x  |     |
|restOfdays  | get restOfdays                                       |  x  |     |
|isWeekend   | Test Week end                                        |  x  |     |
|isLeapYear  | is Leap Year                                         |  x  |     |
|dayNum      | number of days                                       |  .  |     |
|daysMore    | Add days                                             |  x  |     |
|daysLess    | Sub days                                             |  x  |     |
|yearsMore   | Add years                                            |  x  |     |
|yearsLess   | Sub years                                            |  x  |     |
|quantieme   | Returns the day number in the year                   |  x  |     |
|dayZeller   | Calculation of day number with Sunday = 01...        |  .  |     |
|searchWeek  | Calculation week                                     |  .  |     |
|fromOrdinal | Create a Date since 01-Jan-0001                      |  .  |  x  |
|toOrdinal   | Return proleptic Gregorian ordinal                   |  .  |     |


## Timezone

|Function    | Description                                          | Pub |Panic|
|------------|------------------------------------------------------|-----|-----|
|abbrevDay   | Return the abbreviation name of the day              |  x  |     |
|nameDay     | Return the of the day                                |  x  |     |
|abbrevMonth | Return the abbreviation name of the Month            |  x  |     |
|abbrevDay   | Return the abbreviation name of the day              |  x  |     |

## Avancement

-2025-01-16 06:30 start projet date-time </br></br>

-2025-01-16 15:01 add function switchMonths </br></br>

-2025-01-30 04:47 Formatting @panic and modifying isBad() deleting assert() </br></br>

-2025-02-25 20:08 Complete overhaul of the DATE model </br></br>

-2025-02-25 20:08 Dynamic timezone set-up  </br></br>

-2025-02-25 20:08 Automatic creation of timezone.zig source code, via the module: Creat_timezones  </br></br>

-2025-02-25 20:08 LMDB database creation  </br></br>

-2025-02-25 20:08 module timeoffset  </br></br>

