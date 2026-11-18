import Toybox.Lang;

//! Turns the day's forecast into the few things worth acting on in the morning.
module DayAdvice {

    const RAIN_JACKET_CHANCE_PERCENT = 40;

    //! The WHO recommends sun protection from a UV index of 3.
    const SUNSCREEN_UV_INDEX = 3.0;

    function needsRainJacket(precipitationChance as Number?) as Boolean {
        return precipitationChance != null && precipitationChance >= RAIN_JACKET_CHANCE_PERCENT;
    }

    function needsSunscreen(peakUvIndex as Float?) as Boolean {
        return peakUvIndex != null && peakUvIndex >= SUNSCREEN_UV_INDEX;
    }

    function peakUvIndex(uvIndexes as Array<Float?>) as Float? {
        var peak = null as Float?;
        for (var i = 0; i < uvIndexes.size(); i++) {
            var uv = uvIndexes[i];
            if (uv != null && (peak == null || uv > peak)) {
                peak = uv;
            }
        }
        return peak;
    }
}
