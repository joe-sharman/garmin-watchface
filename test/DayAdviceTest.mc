import Toybox.Lang;
import Toybox.Test;

(:test)
function rainJacketNeededAtThreshold(logger as Test.Logger) as Boolean {
    return DayAdvice.needsRainJacket(40) && !DayAdvice.needsRainJacket(39);
}

(:test)
function rainJacketNotNeededWithoutForecast(logger as Test.Logger) as Boolean {
    return !DayAdvice.needsRainJacket(null);
}

(:test)
function sunscreenNeededAtThreshold(logger as Test.Logger) as Boolean {
    return DayAdvice.needsSunscreen(3.0) && !DayAdvice.needsSunscreen(2.9);
}

(:test)
function sunscreenNotNeededWithoutForecast(logger as Test.Logger) as Boolean {
    return !DayAdvice.needsSunscreen(null);
}

(:test)
function peakUvIgnoresMissingHours(logger as Test.Logger) as Boolean {
    return DayAdvice.peakUvIndex([null, 1.5, null, 4.0, 2.0] as Array<Float?>) == 4.0;
}

(:test)
function peakUvIsNullWhenNoHoursHaveData(logger as Test.Logger) as Boolean {
    return DayAdvice.peakUvIndex([null, null] as Array<Float?>) == null
        && DayAdvice.peakUvIndex([] as Array<Float?>) == null;
}
