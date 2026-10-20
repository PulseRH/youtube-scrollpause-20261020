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