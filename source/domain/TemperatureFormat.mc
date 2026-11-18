import Toybox.Lang;
import Toybox.Math;

//! Pure formatting of temperatures. The Weather API always reports Celsius.
module TemperatureFormat {

    //! Format the day's low and high as "8/15°", or an empty string if either is unknown.
    function formatRange(low as Numeric?, high as Numeric?, useFahrenheit as Boolean) as String {
        if (low == null || high == null) {
            return "";
        }
        return toDisplayDegrees(low, useFahrenheit).toString()
            + "/" + toDisplayDegrees(high, useFahrenheit).toString() + "°";
    }

    function toDisplayDegrees(celsius as Numeric, useFahrenheit as Boolean) as Number {
        var degrees = useFahrenheit ? celsius.toFloat() * 9 / 5 + 32 : celsius.toFloat();
        return Math.round(degrees).toNumber();
    }
}
