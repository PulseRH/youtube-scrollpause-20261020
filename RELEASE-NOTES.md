ScrollPause is an unofficial custom bundle based on Morphe Patches 1.47.0.

Adds **Pause on scroll or minimise** for regular YouTube videos:
- Pause after drag-scrolling, even while the video remains visible.
- Pause on entering the mini-player, picture-in-picture, or the background.
- Both settings default to enabled. Resume playback manually.

Import this repository through Morphe Manager → Sources → + → Remote. Use **ScrollPause custom patches** as the YouTube source and select **Pause on scroll or minimise**. This bundle contains upstream patches too.

Supported non-experimental target: YouTube **21.20.405**. YouTube 21.04.223 is not supported by the pinned upstream source. Requires Morphe patcher 1.14.0 or newer.

The full Android build and all 11 standalone policy checks passed. This bundle has not been tested against a YouTube APK or on an Android device. Shorts and feed previews are excluded. Opening a separate full-screen activity may also pause playback. Mouse/trackpad wheel input is not hooked.

Source changes, pinned upstream revision, reproducible build workflow, licence and notices are in this repository and the attached source archive. No YouTube APK is included.