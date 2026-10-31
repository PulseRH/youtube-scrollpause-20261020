# ScrollPause custom patches for Morphe

Unofficial derivative of Morphe Patches. Current custom bundle: **2.0.1**, based on upstream **2.0.0**, targeting **YouTube 21.30.216** (Android 10+). Use **Morphe Manager 2.3.0** for this bundle; older 1.x Managers do not provide the new Patcher 2.x runtime.

## Install or update

In Morphe Manager, add this repository as a remote source:

`https://github.com/PulseRH/youtube-scrollpause-20261020`

If already added, refresh **ScrollPause custom patches**, select version **2.0.1**, and repatch an original supported **YouTube 21.30.216** APK. Updating the source alone does not change the installed YouTube app.

The source exposes only:

- **Pause on scroll or minimise**
- **Smooth pinch zoom**

Select either or both. Settings, gesture hooks, extensions, and GmsCore/playback support are automatic hidden dependencies. This focused bundle is intended for a normal non-root install using GmsCore. Other official features, including ad blocking and SponsorBlock, are not included. Combining it with the complete official bundle has not been validated and may duplicate shared hooks.

Download compiled bundles and complete source from [releases](https://github.com/PulseRH/youtube-scrollpause-20261020/releases/latest).

## Behaviour

Find the custom switches under **YouTube → Settings → Morphe → Video**.

- **Pause when scrolling** is on by default. A confirmed RecyclerView list drag can pause a regular video while the finger remains down, even if the video stays visible. Actual scrolling and movement beyond touch slop are required. Unconfirmed scroll sources retain the release-plus-250-ms fallback. Player transitions, interception, pinches, panning, and video changes cancel pending scroll pauses.
- **Pause when minimised** is on by default. Entering the mini-player, PiP, or background pauses a regular video. Rotation is excluded. Opening another fullscreen activity can also stop the main activity and pause it.
- **Resume when scrolling stops** is **off by default**. If enabled, it resumes only an acknowledged scroll-owned pause, after finger release and 0.8 seconds of inactivity. Manual controls, video/player changes, backgrounding, and switching the option off cancel ownership. It does not resume a manual or minimise pause.
- **Smooth pinch zoom** is on by default. Fullscreen pinches zoom continuously from 1× to 8×, without the native zoom-to-fill snap. A label such as **1.1× · 110%** hides about 0.9 seconds after movement stops. Drag cropped video with one finger to pan within the actual video bounds; the bottom control strip remains available for seeking. There is no kinetic pan fling.

Turn off YouTube's own **Zoom to fill** option for a fitted 1× starting image. Custom zoom takes priority over fullscreen stretch/fill and restore-pinch workarounds. **Disable pinch-to-zoom gesture** still disables zoom. Turning custom zoom off returns to native handlers; reopen the video after changing it. Zoom resets on a new video or leaving fullscreen. Shorts and inline feed previews are excluded from custom pause handling.

## Compatibility and verification

Pinned upstream: [6cb8e6b6ee425eda8a854e026507286359f38a32](https://github.com/MorpheApp/morphe-patches/commit/6cb8e6b6ee425eda8a854e026507286359f38a32), Morphe Patches **2.0.0**. That base declares stable support for **21.30.216** and contains the updated YouTube hooks. Custom event observers are adapted to its Consumer callbacks.

The [2.0.1 build](https://github.com/PulseRH/youtube-scrollpause-20261020/actions/runs/41216517148) passed all checks. The final bundle exposes two custom entries with 52 hidden dependency objects. The workflow runs 73 standalone policy/geometry checks, five bytecode-wrapper tests, a full Android build, and a compacted-archive loader check. The archive check requires exactly two selectable patches, resolves their hidden dependency graph without untrimmed main classes on the classpath, and checks stable 21.30.216 metadata throughout YouTube dependencies. Unused classes and Music/Reddit extension payloads are removed conservatively.

These checks do not patch a real YouTube APK or test Android touch behaviour. No original 21.30.216 APK or connected device was available here. Verify held feed/comment scrolling, swipe-to-maximise, pinch/percentage/pan, minimise/PiP/Home, manual pause, and default-off optional resume on your phone. Casting and other media apps also require device verification.

## Reproduce the build

Run the repository's **Build ScrollPause** GitHub Actions workflow. It fetches the pinned upstream commit, applies `scrollpause.patch`, runs the tests, verifies the trimmed bundle, and builds the importable `.mpp`. Package downloads use the job's built-in token with read-only package permissions; no personal token is stored in source.

For a local Windows build, run `Prepare-Source.ps1` to create a fresh `upstream` folder. Use Java 21, Python 3 available as `python3`, Android SDK, and credentials with access to Morphe's Maven registry. Then run `./gradlew.bat :patches:test --tests app.morphe.patches.youtube.layout.player.fullscreen.SmoothZoomCallbackTest :patches:buildAndroid` inside `upstream`. Keep credentials outside source control. Outputs are under `patches/build/libs`.

## Source and licence

`scrollpause.patch` includes the complete custom changes and tests against the pinned base. Original copyright, GPLv3 licence, and additional Section 7 terms are preserved in `LICENSE` and `NOTICE`. No YouTube APK, decompiled YouTube code, or credentials are included.
