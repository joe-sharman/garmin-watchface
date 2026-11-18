import Toybox.Activity;
import Toybox.ActivityMonitor;
import Toybox.Lang;
import Toybox.System;
import Toybox.Time;
import Toybox.Time.Gregorian;

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

    function batteryPercent() as Float {
        return System.getSystemStats().battery;
    }

    function today() as Gregorian.Info {
        return Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
    }
}
