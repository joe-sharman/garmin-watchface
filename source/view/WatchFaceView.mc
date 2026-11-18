import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class WatchFaceView extends WatchUi.WatchFace {

    private var _isLowPower as Boolean = false;

    function initialize() {
        WatchFace.initialize();
    }

    function onUpdate(dc as Graphics.Dc) as Void {
        var clockTime = System.getClockTime();
        var timeText = TimeFormat.formatTime(clockTime.hour, clockTime.min, System.getDeviceSettings().is24Hour);

        clearScreen(dc);
        if (_isLowPower) {
            drawLowPowerTime(dc, timeText, clockTime.min);
        } else {
            drawActiveTime(dc, timeText);
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

    private function clearScreen(dc as Graphics.Dc) as Void {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
    }

    private function drawActiveTime(dc as Graphics.Dc, timeText as String) as Void {
        drawCentredText(dc, timeText, Graphics.FONT_NUMBER_THAI_HOT, Graphics.COLOR_WHITE, 0, 0);
    }

    private function drawLowPowerTime(dc as Graphics.Dc, timeText as String, minute as Number) as Void {
        var offset = BurnIn.offsetForMinute(minute);
        drawCentredText(dc, timeText, Graphics.FONT_NUMBER_MEDIUM, Graphics.COLOR_DK_GRAY, offset[0], offset[1]);
    }

    private function drawCentredText(
        dc as Graphics.Dc,
        text as String,
        font as Graphics.FontType,
        colour as Graphics.ColorType,
        dx as Number,
        dy as Number
    ) as Void {
        dc.setColor(colour, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            dc.getWidth() / 2 + dx,
            dc.getHeight() / 2 + dy,
            font,
            text,
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
        );
    }
}
