import Toybox.Lang;

//! Pure formatting of calendar values into display strings.
module DateFormat {

    //! Format a day of the week name and day of the month as "TUE 18".
    function formatDate(dayOfWeek as String, day as Number) as String {
        return dayOfWeek.toUpper() + " " + day.toString();
    }
}
