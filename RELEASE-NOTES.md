Fixes the **Smooth pinch zoom** patching failure reported on YouTube 21.20.405: `Could not find a free register from startIndex: 0 excluding: [0, 1]`.

Pinch callbacks now use separate wrapper methods with an explicit scratch register. The native callback is preserved under a separate name and called when smooth zoom is disabled. Three bytecode regression fixtures cover the two-register void callback and both boolean callbacks.

Adds **Resume when scrolling stops** under YouTube → Settings → Morphe → Video. It defaults to **off**. When enabled, videos paused by scroll-to-pause can resume after 0.8 seconds without scrolling. It waits for a pause acknowledgement. Existing manual pauses and minimise pauses do not arm resume; video/player changes, a manual control tap, playback state changes, backgrounding, and switching the option off cancel resume. The prior swipe-to-expand fix and smooth zoom remain included.

## Install

Update your ScrollPause source to **1.47.3**, then repatch an original **YouTube 21.20.405** APK with **Pause on scroll or minimise** and **Smooth pinch zoom** selected. Updating a source alone does not alter the installed YouTube APK. Keep YouTube's Zoom to fill and Morphe's Disable pinch-to-zoom gesture off for smooth zoom. Reopen the video after changing zoom settings.

Automatic resume is optional: leave the new switch off for manual resuming.

## Validation

Full Android build passed. All 47 standalone policy checks and 3 bytecode callback regression tests passed. The new resume extension and setting were verified in the compiled bundle. The exact register-exhaustion case was tested synthetically; this build has not been applied to a YouTube APK or tested on an Android device here. Please verify pinch behaviour and automatic resume on your phone.

This is an unofficial custom derivative of Morphe Patches 1.47.0. The source archive and repository include the changes, pinned upstream revision, reproducible build/test workflow, GPLv3 licence, and Section 7 notices. No YouTube APK is included.