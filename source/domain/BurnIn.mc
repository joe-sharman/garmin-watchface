import Toybox.Lang;

//! Pixel-shift positions for always-on mode.
//!
//! The FR165 is AMOLED: Garmin blanks a watch face in low power mode if the
//! same pixels stay lit for too long, so the always-on render must move.
module BurnIn {

    const STEP_PX = 6;
    const GRID_SIZE = 5;
    const MAX_SHIFT_PX = STEP_PX * (GRID_SIZE / 2);

    //! Offset [dx, dy] in pixels for a given minute, cycling through a 5x5 grid.
    function offsetForMinute(minute as Number) as [Number, Number] {
        return [
            gridOffset(minute % GRID_SIZE),
            gridOffset((minute / GRID_SIZE) % GRID_SIZE)
        ];
    }

    function gridOffset(cell as Number) as Number {
        return (cell - GRID_SIZE / 2) * STEP_PX;
    }
}
