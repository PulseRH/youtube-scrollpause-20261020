Fixes **Pause on scroll or minimise** pausing the video during an upward swipe to expand the mini-player or enter fullscreen.

Scroll-to-pause now waits until the finger is released, then allows 250 ms for player-size changes to be reported. A player-type change cancels the queued scroll pause and blocks the remainder of that gesture. Pinches and cancelled touches are excluded. Actual minimising/backgrounding still uses its separate pause path.

Ordinary list scrolling still pauses playback shortly after release. Smooth pinch zoom and the existing pause settings remain included.

## Update

In Morphe Manager → Sources, update **ScrollPause custom patches** to **1.47.2**, then repatch your original **YouTube 21.20.405** APK using that source. Updating the source alone does not change the installed YouTube APK.

Keep **Pause on scroll or minimise** selected and keep **Smooth pinch zoom** selected if wanted. Existing settings can remain as they are.

## Validation

All 36 standalone checks passed: 11 pause-policy, 14 smooth-zoom, and 11 new scroll/player-resize regression checks. The Android build passed. The fix still needs confirmation on the user's phone; the reported device interaction was reproduced as gesture-policy event sequences, not on an Android device here.

This is an unofficial custom derivative of Morphe Patches 1.47.0. Source changes, pinned upstream revision, reproducible build workflow, GPLv3 licence and Section 7 notices are included. No YouTube APK is included.