import Toybox.Lang;
import Toybox.Test;

(:test)
function dateUppercasesDayOfWeek(logger as Test.Logger) as Boolean {
    return DateFormat.formatDate("Tue", 18).equals("TUE 18");
}

(:test)
function dateDoesNotPadSingleDigitDays(logger as Test.Logger) as Boolean {
    return DateFormat.formatDate("Sun", 3).equals("SUN 3");
}
