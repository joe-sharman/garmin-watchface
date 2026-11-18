import Toybox.Lang;
import Toybox.Test;

(:test)
function twelveHourShowsMidnightAsTwelve(logger as Test.Logger) as Boolean {
    return TimeFormat.formatTime(0, 0, false).equals("12:00");
}

(:test)
function twelveHourShowsNoonAsTwelve(logger as Test.Logger) as Boolean {
    return TimeFormat.formatTime(12, 30, false).equals("12:30");
}

(:test)
function twelveHourConvertsAfternoonHours(logger as Test.Logger) as Boolean {
    return TimeFormat.formatTime(13, 7, false).equals("1:07");
}

(:test)
function twentyFourHourZeroPadsHours(logger as Test.Logger) as Boolean {
    return TimeFormat.formatTime(7, 5, true).equals("07:05");
}

(:test)
function twentyFourHourKeepsLateHours(logger as Test.Logger) as Boolean {
    return TimeFormat.formatTime(23, 59, true).equals("23:59");
}
