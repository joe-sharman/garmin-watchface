import Toybox.Lang;
import Toybox.Test;

(:test)
function burnInOffsetStaysWithinMaxShift(logger as Test.Logger) as Boolean {
    for (var minute = 0; minute < 60; minute++) {
        var offset = BurnIn.offsetForMinute(minute);
        if (offset[0].abs() > BurnIn.MAX_SHIFT_PX || offset[1].abs() > BurnIn.MAX_SHIFT_PX) {
            logger.error("minute " + minute + " shifted outside bounds: " + offset);
            return false;
        }
    }
    return true;
}

(:test)
function burnInOffsetMovesEveryMinute(logger as Test.Logger) as Boolean {
    for (var minute = 0; minute < 59; minute++) {
        var current = BurnIn.offsetForMinute(minute);
        var next = BurnIn.offsetForMinute(minute + 1);
        if (current[0] == next[0] && current[1] == next[1]) {
            logger.error("minute " + minute + " and " + (minute + 1) + " share offset " + current);
            return false;
        }
    }
    return true;
}
