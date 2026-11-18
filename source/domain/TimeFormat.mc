import Toybox.Lang;

//! Pure formatting of clock values into display strings.
module TimeFormat {

    //! Format an hour and minute as "H:MM" (12-hour) or "HH:MM" (24-hour).
    function formatTime(hour as Number, minute as Number, is24Hour as Boolean) as String {
        return formatHour(hour, is24Hour) + ":" + minute.format("%02d");
    }

    function formatHour(hour as Number, is24Hour as Boolean) as String {
        if (is24Hour) {
            return hour.format("%02d");
        }
        return toTwelveHour(hour).toString();
    }

    function toTwelveHour(hour as Number) as Number {
        var twelveHour = hour % 12;
        return twelveHour == 0 ? 12 : twelveHour;
    }
}
