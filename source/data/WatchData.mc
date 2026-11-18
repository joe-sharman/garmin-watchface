import Toybox.Activity;
import Toybox.ActivityMonitor;
import Toybox.Lang;
import Toybox.System;
import Toybox.Time;
import Toybox.Time.Gregorian;
import Toybox.Weather;

//! Reads live values from the device. Kept thin so the domain layer stays pure.
module WatchData {

    function heartRate() as Number? {
        var info = Activity.getActivityInfo();
        return info.currentHeartRate as Number?;
    }

    function steps() as Number? {
        var info = ActivityMonitor.getInfo();
        return info.steps as Number?;
    }

    function dailyForecast() as Weather.DailyForecast? {
        var forecasts = Weather.getDailyForecast();
        if (forecasts == null || forecasts.size() == 0) {
            return null;
        }
        return forecasts[0];
    }

    function upcomingUvIndexes(hours as Number) as Array<Float?> {
        var uvIndexes = [] as Array<Float?>;
        var forecasts = Weather.getHourlyForecast();
        if (forecasts == null) {
            return uvIndexes;
        }
        for (var i = 0; i < forecasts.size() && i < hours; i++) {
            uvIndexes.add(forecasts[i].uvIndex);
        }
        return uvIndexes;
    }

    function usesFahrenheit() as Boolean {
        return System.getDeviceSettings().temperatureUnits == System.UNIT_STATUTE;
    }

    function batteryPercent() as Float {
        return System.getSystemStats().battery;
    }

    function today() as Gregorian.Info {
        return Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
    }
}
