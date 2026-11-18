import Toybox.Lang;
import Toybox.Test;

(:test)
function heartRateShowsPlaceholderWhenMissing(logger as Test.Logger) as Boolean {
    return StatFormat.formatHeartRate(null).equals("--");
}

(:test)
function heartRateShowsPlaceholderWhenZero(logger as Test.Logger) as Boolean {
    return StatFormat.formatHeartRate(0).equals("--");
}

(:test)
function heartRateShowsBeatsPerMinute(logger as Test.Logger) as Boolean {
    return StatFormat.formatHeartRate(62).equals("62");
}

(:test)
function stepsShowsPlaceholderWhenMissing(logger as Test.Logger) as Boolean {
    return StatFormat.formatSteps(null).equals("--");
}

(:test)
function stepsBelowOneThousandHasNoSeparator(logger as Test.Logger) as Boolean {
    return StatFormat.formatSteps(999).equals("999");
}

(:test)
function stepsGroupsThousands(logger as Test.Logger) as Boolean {
    return StatFormat.formatSteps(8432).equals("8,432");
}

(:test)
function stepsZeroPadsTheLastGroup(logger as Test.Logger) as Boolean {
    return StatFormat.formatSteps(10005).equals("10,005");
}

(:test)
function batteryRoundsToNearestPercent(logger as Test.Logger) as Boolean {
    return StatFormat.formatBattery(86.6).equals("87%") && StatFormat.formatBattery(86.4).equals("86%");
}
