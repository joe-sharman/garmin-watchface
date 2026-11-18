import Toybox.Lang;

//! Pure formatting of the daily stats into display strings.
module StatFormat {

    const PLACEHOLDER = "--";

    //! The sensor reports no value (null or 0) until it has a reading.
    function formatHeartRate(bpm as Number?) as String {
        if (bpm == null || bpm <= 0) {
            return PLACEHOLDER;
        }
        return bpm.toString();
    }

    function formatSteps(steps as Number?) as String {
        if (steps == null) {
            return PLACEHOLDER;
        }
        return groupThousands(steps);
    }

    function formatBattery(percent as Float) as String {
        return (percent + 0.5).toNumber().toString() + "%";
    }

    function groupThousands(value as Number) as String {
        if (value < 1000) {
            return value.toString();
        }
        return groupThousands(value / 1000) + "," + (value % 1000).format("%03d");
    }
}
