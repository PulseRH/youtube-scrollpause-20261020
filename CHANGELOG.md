# [1.47.5](https://github.com/PulseRH/youtube-scrollpause-20261020/releases/tag/v1.47.5-scrollpause.1) (2026-10-20)

Improves **Pause on scroll or minimise** so confirmed list scrolling can pause a video while the finger is still down, without removing the player-resize protections.

The patch now observes touches delivered to YouTube's RecyclerView lists. When a single-finger list drag produces a real scroll notification, it uses the immediate pause path rather than waiting for release. Player transitions, parent touch interception, pinches, cropped-video panning, and video changes cancel list confirmation and pending scroll pauses.

Unknown scroll sources retain the conservative release-plus-250-ms fallback. This is intended to improve feed/comment list drags while retaining the swipe-to-maximise fix; phone confirmation is still required.

Smooth zoom, the brief percentage label, bounded panning, pause-on-minimise, and the default-off **Resume when scrolling stops** option remain included. If resume is enabled, it still waits for finger release and scroll inactivity before resuming a scroll-owned pause.

## Update

Update the ScrollPause source to **1.47.5**, confirm that version is selected, and repatch your original **YouTube 21.20.405** APK using the ScrollPause source. Keep **Pause on scroll or minimise** selected, plus **Smooth pinch zoom** if wanted. Updating the source alone does not alter the installed YouTube APK.

## Validation

Full Android build passed, along with 73 standalone policy/geometry checks and 5 bytecode wrapper tests. The 21 scroll/resize checks include immediate pause before release for a confirmed list, cancellation on resize/interception, and preservation of the conservative path for unconfirmed gestures. The source uses a framework onTouchEvent override with no added scratch-register requirement.

These checks do not establish real YouTube APK or Android touch behaviour. Please verify holding-and-scrolling in the feed/comments, swiping up to maximise, pinch/pan, minimising, and optional resume on your phone.

Unofficial derivative of Morphe Patches 1.47.0. Source changes, pinned upstream revision, reproducible build/test workflow, GPLv3 licence and Section 7 notices are included. No YouTube APK is included.

# [1.47.4](https://github.com/PulseRH/youtube-scrollpause-20261020/releases/tag/v1.47.4-scrollpause.1) (2026-10-20)

Enhances **Smooth pinch zoom** with a brief zoom label and bounded drag-to-pan, while retaining continuous 1×–8× zoom without the native snap to fill.

- Shows a label such as **1.1× · 110%** during zoom and pan, then hides it after about 0.9 seconds without movement.
- Drag with one finger to pan when video content is cropped. Movement is clamped to the actual video edges; axes that are not cropped stay centred. The bottom control strip remains available for seekbar interaction.
- Taps and multi-touch gestures continue to the player. A real pan cancels the prior view touch stream and is excluded from scroll-to-pause/resume. Two-finger pinch can resume after a pan.
- Leaving fullscreen, changing videos, zooming back to 1×, or disabling the feature restores the view transform and clears panning offsets. The label clears on fullscreen exit/video change.

The register-safe callback fix, swipe-to-expand pause fix, and **Resume when scrolling stops** option remain included. Automatic scroll resume still defaults to **off**.

## Install

Update your ScrollPause source to **1.47.4**, confirm that version is selected, and repatch an original **YouTube 21.20.405** APK. Select **Smooth pinch zoom** and the pause patch if wanted. Updating the source alone does not change the installed YouTube APK.

Keep YouTube's **Zoom to fill** and Morphe's **Disable pinch-to-zoom gesture** off. Reopen the video after changing zoom settings. The percentage is relative to the fitted starting image. Pan follows the finger; kinetic fling panning is not implemented.

## Validation

Full Android build and all 63 standalone policy/geometry checks plus 5 bytecode wrapper regression tests passed. The published bundle was checked for the panning extension and its checksum verified. These tests do not establish real APK or Android device behaviour; please confirm zoom, the transient label, panning, seekbar access, and pinch-after-pan on your phone.

This is an unofficial derivative of Morphe Patches 1.47.0. Source changes, pinned upstream revision, reproducible build/test workflow, GPLv3 licence and Section 7 notices are provided. No YouTube APK is included.

# [1.47.3](https://github.com/PulseRH/youtube-scrollpause-20261020/releases/tag/v1.47.3-scrollpause.1) (2026-10-20)

Fixes the **Smooth pinch zoom** patching failure reported on YouTube 21.20.405: `Could not find a free register from startIndex: 0 excluding: [0, 1]`.

Pinch callbacks now use separate wrapper methods with an explicit scratch register. The native callback is preserved under a separate name and called when smooth zoom is disabled. Three bytecode regression fixtures cover the two-register void callback and both boolean callbacks.

Adds **Resume when scrolling stops** under YouTube → Settings → Morphe → Video. It defaults to **off**. When enabled, videos paused by scroll-to-pause can resume after 0.8 seconds without scrolling. It waits for a pause acknowledgement. Existing manual pauses and minimise pauses do not arm resume; video/player changes, a manual control tap, playback state changes, backgrounding, and switching the option off cancel resume. The prior swipe-to-expand fix and smooth zoom remain included.

## Install

Update your ScrollPause source to **1.47.3**, then repatch an original **YouTube 21.20.405** APK with **Pause on scroll or minimise** and **Smooth pinch zoom** selected. Updating a source alone does not alter the installed YouTube APK. Keep YouTube's Zoom to fill and Morphe's Disable pinch-to-zoom gesture off for smooth zoom. Reopen the video after changing zoom settings.

Automatic resume is optional: leave the new switch off for manual resuming.

## Validation

Full Android build passed. All 47 standalone policy checks and 3 bytecode callback regression tests passed. The new resume extension and setting were verified in the compiled bundle. The exact register-exhaustion case was tested synthetically; this build has not been applied to a YouTube APK or tested on an Android device here. Please verify pinch behaviour and automatic resume on your phone.

This is an unofficial custom derivative of Morphe Patches 1.47.0. The source archive and repository include the changes, pinned upstream revision, reproducible build/test workflow, GPLv3 licence, and Section 7 notices. No YouTube APK is included.

# [1.47.2](https://github.com/PulseRH/youtube-scrollpause-20261020/releases/tag/v1.47.2-scrollpause.1) (2026-10-20)

Fixes **Pause on scroll or minimise** pausing the video during an upward swipe to expand the mini-player or enter fullscreen.

Scroll-to-pause now waits until the finger is released, then allows 250 ms for player-size changes to be reported. A player-type change cancels the queued scroll pause and blocks the remainder of that gesture. Pinches and cancelled touches are excluded. Actual minimising/backgrounding still uses its separate pause path.

Ordinary list scrolling still pauses playback shortly after release. Smooth pinch zoom and the existing pause settings remain included.

## Update

In Morphe Manager → Sources, update **ScrollPause custom patches** to **1.47.2**, then repatch your original **YouTube 21.20.405** APK using that source. Updating the source alone does not change the installed YouTube APK.

Keep **Pause on scroll or minimise** selected and keep **Smooth pinch zoom** selected if wanted. Existing settings can remain as they are.

## Validation

All 36 standalone checks passed: 11 pause-policy, 14 smooth-zoom, and 11 new scroll/player-resize regression checks. The Android build passed. The fix still needs confirmation on the user's phone; the reported device interaction was reproduced as gesture-policy event sequences, not on an Android device here.

This is an unofficial custom derivative of Morphe Patches 1.47.0. Source changes, pinned upstream revision, reproducible build workflow, GPLv3 licence and Section 7 notices are included. No YouTube APK is included.

# [1.47.1](https://github.com/PulseRH/youtube-scrollpause-20261020/releases/tag/v1.47.1-scrollpause.1) (2026-10-20)

Adds **Smooth pinch zoom**, alongside **Pause on scroll or minimise**.

Smooth pinch zoom replaces YouTube's native fullscreen pinch callbacks. Zoom increases continuously from 1× through 1.1×, 1.2× and higher, up to 8×, without a fit/fill snap during the gesture or on release. Zoom is centered and resets on fullscreen exit or changing videos. Native zoom HUD and drag-to-pan are not implemented.

## Install

Update the ScrollPause source in Morphe Manager, then repatch an original **YouTube 21.20.405** APK. Select **Smooth pinch zoom**. In YouTube → Settings → Morphe → Video, the new setting defaults to on.

Turn off YouTube's built-in **Zoom to fill** setting and reopen the video for a fitted 1× starting image. Keep **Disable pinch-to-zoom gesture** off. While smooth zoom is enabled it overrides Morphe's fullscreen stretch/fill and restore-pinch workaround. Reopen the video after changing the setting.

The prior pause patch is retained. This bundle includes upstream patches, so use ScrollPause as your YouTube source. Requires patcher 1.14.0 or newer. YouTube 21.04.223 is not supported by the pinned upstream source.

## Validation

Full Android build passed. All 25 standalone checks passed (14 smooth zoom, 11 pause policy). The custom patch and extension classes were verified in the compiled bundle. APK patching and actual Android device behaviour remain unverified; treat this as an experimental custom feature until tested on your phone.

Source changes, pinned upstream revision, reproducible build workflow, GPLv3 licence and Section 7 notices are included. This is an unofficial derivative of Morphe Patches 1.47.0. No YouTube APK is included.

# 1.47.0 (2026-10-20)

Initial custom pause-on-scroll and minimise patch.
