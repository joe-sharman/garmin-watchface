import Toybox.Graphics;
import Toybox.Lang;

//! Vector icons drawn with primitives, so they stay sharp at any size.
//! Each takes the centre point and the icon's overall size in pixels.
module Icons {

    const LOW_BATTERY_PERCENT = 20;

    function drawHeart(dc as Graphics.Dc, cx as Number, cy as Number, size as Number) as Void {
        var r = size / 4;
        dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(cx - r, cy - r / 2, r);
        dc.fillCircle(cx + r, cy - r / 2, r);
        dc.fillPolygon([[cx - 2 * r, cy - r / 2], [cx + 2 * r, cy - r / 2], [cx, cy + 2 * r]]);
    }

    function drawFootsteps(dc as Graphics.Dc, cx as Number, cy as Number, size as Number) as Void {
        var u = size / 8;
        dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
        drawFoot(dc, cx - 2 * u, cy, u);
        drawFoot(dc, cx + 2 * u, cy - 2 * u, u);
    }

    function drawBattery(dc as Graphics.Dc, cx as Number, cy as Number, size as Number, percent as Float) as Void {
        var level = clampPercent((percent + 0.5).toNumber());
        var height = size / 2;
        var left = cx - size / 2;
        var top = cy - height / 2;

        dc.setColor(batteryColour(level), Graphics.COLOR_TRANSPARENT);
        dc.drawRoundedRectangle(left, top, size, height, 2);
        dc.fillRectangle(left + size, cy - height / 4, 2, height / 2);
        dc.fillRectangle(left + 2, top + 2, (size - 4) * level / 100, height - 4);
    }

    function drawFoot(dc as Graphics.Dc, cx as Number, cy as Number, u as Number) as Void {
        dc.fillEllipse(cx, cy, u, 2 * u);
        dc.fillEllipse(cx, cy + 3 * u, u - 1, u - 1);
    }

    function clampPercent(percent as Number) as Number {
        return percent < 0 ? 0 : (percent > 100 ? 100 : percent);
    }

    function batteryColour(level as Number) as Graphics.ColorType {
        return level <= LOW_BATTERY_PERCENT ? Graphics.COLOR_RED : Graphics.COLOR_GREEN;
    }
}
