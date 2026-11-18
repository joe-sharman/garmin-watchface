import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.Time.Gregorian;
import Toybox.WatchUi;

class WatchFaceView extends WatchUi.WatchFace {

    private const DATE_Y = 0.22;
    private const TIME_Y = 0.46;
    private const STAT_ICON_Y = 0.68;
    private const STAT_VALUE_Y = 0.78;
    private const STAT_XS = [0.28, 0.5, 0.72];
    private const LOW_POWER_DATE_DROP_PX = 50;

    private var _isLowPower as Boolean = false;

    function initialize() {
        WatchFace.initialize();
    }

    function onUpdate(dc as Graphics.Dc) as Void {
        var clockTime = System.getClockTime();
        var timeText = TimeFormat.formatTime(clockTime.hour, clockTime.min, System.getDeviceSettings().is24Hour);
        var dateText = currentDateText();

        enableAntiAlias(dc);
        clearScreen(dc);
        if (_isLowPower) {
            drawLowPower(dc, timeText, dateText, clockTime.min);
        } else {
            drawActive(dc, timeText, dateText);
        }
    }

    function onEnterSleep() as Void {
        _isLowPower = true;
        WatchUi.requestUpdate();
    }

    function onExitSleep() as Void {
        _isLowPower = false;
        WatchUi.requestUpdate();
    }

    private function currentDateText() as String {
        var today = WatchData.today();
        return DateFormat.formatDate(today.day_of_week as String, today.day as Number);
    }

    //! Not every device supports it, and it smooths the edges of the drawn icons.
    private function enableAntiAlias(dc as Graphics.Dc) as Void {
        if (dc has :setAntiAlias) {
            dc.setAntiAlias(true);
        }
    }

    private function clearScreen(dc as Graphics.Dc) as Void {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
    }

    private function drawActive(dc as Graphics.Dc, timeText as String, dateText as String) as Void {
        drawText(dc, dateText, Graphics.FONT_TINY, Graphics.COLOR_LT_GRAY, 0.5, DATE_Y, 0, 0);
        drawText(dc, timeText, Graphics.FONT_NUMBER_THAI_HOT, Graphics.COLOR_WHITE, 0.5, TIME_Y, 0, 0);
        drawStats(dc);
    }

    private function drawStats(dc as Graphics.Dc) as Void {
        var iconSize = dc.getWidth() / 16;
        var iconY = (dc.getHeight() * STAT_ICON_Y).toNumber();
        var battery = WatchData.batteryPercent();

        Icons.drawHeart(dc, columnX(dc, 0), iconY, iconSize);
        Icons.drawFootsteps(dc, columnX(dc, 1), iconY, iconSize);
        Icons.drawBattery(dc, columnX(dc, 2), iconY, iconSize, battery);

        drawStatValue(dc, StatFormat.formatHeartRate(WatchData.heartRate()), STAT_XS[0]);
        drawStatValue(dc, StatFormat.formatSteps(WatchData.steps()), STAT_XS[1]);
        drawStatValue(dc, StatFormat.formatBattery(battery), STAT_XS[2]);
    }

    private function columnX(dc as Graphics.Dc, column as Number) as Number {
        return (dc.getWidth() * STAT_XS[column]).toNumber();
    }

    private function drawLowPower(dc as Graphics.Dc, timeText as String, dateText as String, minute as Number) as Void {
        var offset = BurnIn.offsetForMinute(minute);
        drawText(dc, timeText, Graphics.FONT_NUMBER_MEDIUM, Graphics.COLOR_DK_GRAY, 0.5, 0.5, offset[0], offset[1]);
        drawText(dc, dateText, Graphics.FONT_XTINY, Graphics.COLOR_DK_GRAY, 0.5, 0.5, offset[0], offset[1] + LOW_POWER_DATE_DROP_PX);
    }

    private function drawStatValue(dc as Graphics.Dc, value as String, xFraction as Float) as Void {
        drawText(dc, value, Graphics.FONT_SMALL, Graphics.COLOR_WHITE, xFraction, STAT_VALUE_Y, 0, 0);
    }

    private function drawText(
        dc as Graphics.Dc,
        text as String,
        font as Graphics.FontType,
        colour as Graphics.ColorType,
        xFraction as Float,
        yFraction as Float,
        dx as Number,
        dy as Number
    ) as Void {
        dc.setColor(colour, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            (dc.getWidth() * xFraction).toNumber() + dx,
            (dc.getHeight() * yFraction).toNumber() + dy,
            font,
            text,
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
        );
    }
}
