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

pub const Dte = @import("datetime").Date;i  // work date Y M D

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

## Outils

|Function               | Description                              | Pub |
|-----------------------|------------------------------------------|-----|
|isLeapYear             | is Leap Year                             |  .  |
|dayInYear              | Number of days in the year               |  .  |
|daysInMonth            | Number of days in the month              |  .  |
|daysBeforeYear         | Number of days before Jan 1st of year    |  .  |
|daysBeforeMonth        | Number of days   of the month precedent  |  .  |
|ldaysBeforeFirstMonday | Calculate the number of days of the first|  .  |
|                       | Monday for week 1 ISO calendar           |     |
|                       | for the given year since 01-Jan-0001     |     |
|ymd2ord                | Number of days since 01-Jan-0001         |     |


## DateTime


|Function               | Description                              | Pub |
|-----------------------|------------------------------------------|-----|
|HardTime               | Change of field attribute                |  .  |
|nowUTC                 | Timestamp date in UTC ONLY               |  x  |
|nowTime                | Timestamp date into Time-zone            |  x  |
|Timestamp              | Date time reverse  timestamp             |  x  |
|Timestamp              | Timestamp date into time-zone            |  x  |
|stringTime             | Date-time format string                  |  x  |


## Date

|Function    | Description                                          | Pub |
|------------|------------------------------------------------------|-----|
|create      | Create and validate the date                         |  x  |
|copy        | Return a copy of the date                            |  x  |
|fromOrdinal | Create a Date since 01-Jan-0001                      |  .  |
|toOrdinal   | Return proleptic Gregorian ordinal                   |  .  |
|HardDate    | Change of field attribute                            |  .  |
|nowDate     | Returns today's date into time-zone                  |  x  |
|isoCalendar | Convert to an ISO Calendar date YWS                  |  x  |
|eql         | comparaison                                          |  x  |
|comp        | comparaison                                          |  x  |
|gt          | comparaison                                          |  x  |
|gte         | comparaison                                          |  x  |
|lt          | comparaison                                          |  x  |
|lte         | comparaison                                          |  x  |
|parseIso    | Parse date in format YYYY-MM-DD                      |  x  |
|parseFR     | Parse date in format YYYY-MM-DD                      |  x  |
|parseUS     | Parse date in format YYYY-MM-DD                      |  x  |
|formatIso   | Return date in ISO format YYYY-MM-DD                 |  x  |
|formatFR    | Return date in ISO format DD-MM-YYYY                 |  x  |
|formatUS    | Return date in ISO format MM-DD-YYYY                 |  x  |
|dayOfYear   | Return day of year starting with 1                   |  x  |
|dayOfWeek   | Day of week starting with Monday =1 and Sunday =7    |  x  |
|weekday     | Day of week starting with Monday =1 and Sunday =6    |  x  |
|dayNum      | Day of week starting with Monday =1 and Sunday =7    |  x  |
|getYear     | get year                                             |  x  |
|getMonth    | get Month                                            |  x  |
|getWeek     | get Week                                             |  x  |
|shiftDays   | Copy of the date shifted by the given number of days |  x  |
|shiftYears  | Copy of the date shifted by the given number of Year |  x  |
|switchMonths| Copy of the date switch by the given  number of Month|  x  |

## Timezone

|Function    | Description                                          | Pub |
|------------|------------------------------------------------------|-----|
|abbrevDay   | Return the abbreviation name of the day              |  x  |
|nameDay     | Return the of the day                                |  x  |
|abbrevMonth | Return the abbreviation name of the Month            |  x  |
|abbrevDay   | Return the abbreviation name of the day              |  x  |

## Avancement

-2025-01-16 06:30 start projet date-time </br></br>
-2025-01-16 15:01 add function switchMonths </br></br>

