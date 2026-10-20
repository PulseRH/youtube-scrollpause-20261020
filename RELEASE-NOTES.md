Adds **Smooth pinch zoom**, alongside **Pause on scroll or minimise**.

Smooth pinch zoom replaces YouTube's native fullscreen pinch callbacks. Zoom increases continuously from 1× through 1.1×, 1.2× and higher, up to 8×, without a fit/fill snap during the gesture or on release. Zoom is centered and resets on fullscreen exit or changing videos. Native zoom HUD and drag-to-pan are not implemented.

## Install

Update the ScrollPause source in Morphe Manager, then repatch an original **YouTube 21.20.405** APK. Select **Smooth pinch zoom**. In YouTube → Settings → Morphe → Video, the new setting defaults to on.

Turn off YouTube's built-in **Zoom to fill** setting and reopen the video for a fitted 1× starting image. Keep **Disable pinch-to-zoom gesture** off. While smooth zoom is enabled it overrides Morphe's fullscreen stretch/fill and restore-pinch workaround. Reopen the video after changing the setting.

The prior pause patch is retained. This bundle includes upstream patches, so use ScrollPause as your YouTube source. Requires patcher 1.14.0 or newer. YouTube 21.04.223 is not supported by the pinned upstream source.

## Validation

Full Android build passed. All 25 standalone checks passed (14 smooth zoom, 11 pause policy). The custom patch and extension classes were verified in the compiled bundle. APK patching and actual Android device behaviour remain unverified; treat this as an experimental custom feature until tested on your phone.

Source changes, pinned upstream revision, reproducible build workflow, GPLv3 licence and Section 7 notices are included. This is an unofficial derivative of Morphe Patches 1.47.0. No YouTube APK is included.