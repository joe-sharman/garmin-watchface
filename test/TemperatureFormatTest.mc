import Toybox.Lang;
import Toybox.Test;

(:test)
function rangeShowsLowThenHighInCelsius(logger as Test.Logger) as Boolean {
    return TemperatureFormat.formatRange(8, 15.4, false).equals("8/15°");
}

(:test)
function rangeConvertsToFahrenheit(logger as Test.Logger) as Boolean {
    return TemperatureFormat.formatRange(0, 10, true).equals("32/50°");
}

(:test)
function rangeKeepsNegativeLows(logger as Test.Logger) as Boolean {
    return TemperatureFormat.formatRange(-3, 4, false).equals("-3/4°");
}

(:test)
function rangeIsEmptyWhenEitherEndIsUnknown(logger as Test.Logger) as Boolean {
    return TemperatureFormat.formatRange(null, 10, false).equals("")
        && TemperatureFormat.formatRange(5, null, false).equals("");
}
