# ScrollPause custom patch source for Morphe

Custom source changes prepared 20 October 2026. This is an unofficial modification of Morphe Patches. This folder contains the reproducible source; the separately supplied `ScrollPause-1.47.3.mpp` is the compiled importable bundle.

## Remote import

In Morphe Manager, choose **Sources → + → Remote** and paste:

`https://github.com/PulseRH/youtube-scrollpause-20261020`

Or open https://morphe.software/add-source?github=PulseRH/youtube-scrollpause-20261020&name=ScrollPause .

Use **ScrollPause custom patches** as the YouTube source, select **Pause on scroll or minimise**, and patch a supported original YouTube APK. This bundle already includes upstream patches. The current bundle targets YouTube **21.20.405** as its first non-experimental version. Source imports can fetch future releases; this does not automatically rebuild this project when upstream changes.

Compiled bundle and source downloads are available from https://github.com/PulseRH/youtube-scrollpause-20261020/releases/latest .

## Behaviour

Select **Pause on scroll or minimise** when patching. In YouTube → Settings → Morphe → Video:

- **Pause when scrolling**: enabled by default. Drag-scrolling the main YouTube screen pauses an open regular video, even if it stays visible. A gesture must exceed Android's touch slop; automatic scrolling without a drag is ignored. This observes normal Android view scrolling. Controls implemented wholly outside Android view scrolling need device verification.
- **Pause when minimised**: enabled by default. Entering YouTube's mini-player, picture-in-picture, or stopping the main activity pauses an open regular video. Rotation is excluded. Opening a separate full-screen activity can also stop the main activity and pause it.
- Resuming playback is manual by default. The optional Resume when scrolling stops switch is off by default. Videos that were already paused remain paused. Shorts and inline feed previews are excluded.
- A brief pending request handles buffering during the trigger. Requests expire after 1.5 seconds. Pause events are rate limited during a fling.
- Pause uses the activity's media controller when available, otherwise the same Android pause-only media-key mechanism as upstream's screen-lock pause feature. Casting and interactions with other media apps require device verification.

### Register fix and optional scroll resume (1.47.3)

Fixes the pinch patch's `Could not find a free register` failure by wrapping callbacks in a separate method with its own scratch register. No spare register is required in the native callback.

**Settings → Morphe → Video → Resume when scrolling stops** is **off by default**. If enabled, it can resume a video paused by scrolling after 0.8 seconds without scrolling. A manually paused video or a minimise pause does not arm automatic resume. Manual control taps, video/player changes, backgrounding, and disabling the switch cancel it. Pause acknowledgement is required.

All 47 standalone policy checks, 3 pinch-callback bytecode regression tests, and the full Android build passed: https://github.com/PulseRH/youtube-scrollpause-20261020/actions/runs/39414035400 . The new setting and extension were checked inside the compiled bundle. Real APK patching and device behaviour still require verification.

### Player resize gesture fix (1.47.2)

Scroll-to-pause now waits for finger release and a 250 ms transition window. Player-type changes cancel the queued pause and exclude the rest of that gesture, preventing resize/fullscreen swipes from being treated as scrolling. Pinches and cancelled touches are excluded too. The separate pause-on-minimise path remains unchanged.

Ordinary list scrolling pauses shortly after release. Update the source and **repatch YouTube** to install the fix. All 36 standalone checks and the full Android build passed: https://github.com/PulseRH/youtube-scrollpause-20261020/actions/runs/39413062114 . Device confirmation remains outstanding.

### Smooth pinch zoom (1.47.1)

Select **Smooth pinch zoom** when patching. **YouTube → Settings → Morphe → Video → Smooth pinch zoom** defaults to on. This replaces the native fullscreen pinch callbacks with continuous centered zoom from 1× through 1.1×, 1.2× and up to 8×. Releasing a pinch keeps its scale. Zoom resets when leaving fullscreen or opening a different video. It does not implement drag-to-pan or the native zoom HUD.

Turn off YouTube's own **Zoom to fill** option for a fitted 1× starting image, then reopen the video. While enabled, this takes priority over Morphe's **Fullscreen video scale** stretch/fill modes and its **Restore pinch to zoom** workaround. **Disable pinch-to-zoom gesture** still takes priority and disables zoom. Turning this custom setting off returns to the upstream handlers; reopen the video after changing it.

The earlier **Pause on scroll or minimise** patch remains in the bundle. Pinch gestures alone do not trigger its scroll observer; an Android view must actually report scrolling.

The new scale model passed 14 standalone checks and the 11 pause checks still pass. Full Android build passed: https://github.com/PulseRH/youtube-scrollpause-20261020/actions/runs/39412163566 . Both custom features were verified inside the compiled bundle. APK/device verification remains outstanding.

## Compatibility

Pinned upstream: https://github.com/MorpheApp/morphe-patches/commit/e5464395441e916b643af4e2175c4e253e6df487 (1.47.0).

The patch inherits that source's supported versions. For this build, **21.20.405** is the first non-experimental target in the upstream compatibility list. **21.04.223** is not listed. Use a supported original YouTube APK and repatch with this custom bundle; compatibility has not been tested against any APK here.

## Build

### GitHub Actions

Place this folder's contents, including `.github/workflows/build-scrollpause.yml`, in your own repository. From Actions, run **Build ScrollPause**. The workflow fetches the exact upstream commit, applies the patch, runs the policy checks, and uses upstream's Android build task. Download **ScrollPause-patch-bundle** from a successful run; the importable bundle will be among its build outputs.

The job requests read-only repository and package permissions. It uses GitHub's built-in job token, and does not require putting a personal token into the repository. Registry policy may still restrict access; a successful build is required before treating this as usable.

### Local Windows build

Run `./Prepare-Source.ps1` from PowerShell to create a patched `upstream` folder. Java 21, the Android SDK required by upstream, and a GitHub credential with read access to Morphe's Maven packages are required. Upstream accepts `GITHUB_ACTOR` and `GITHUB_TOKEN` environment variables or the `gpr.user` and `gpr.key` Gradle properties. Keep credentials outside this source folder.

Inside `upstream`, run `./gradlew.bat :patches:buildAndroid`. Build outputs are written to `patches/build/libs`.

## Validation performed

- All 11 standalone pause-policy checks passed with Java 17.
- Modified Android string XML parsed successfully.
- `git diff --check` passed.
- The patch was checked and applied against a fresh worktree at the pinned upstream revision.
- Full Android build passed on GitHub Actions: https://github.com/PulseRH/youtube-scrollpause-20261020/actions/runs/39409318926 . Local builds still need a credential with package read access. The compiled bundle contains the custom patch class and both custom extension classes. No YouTube APK compatibility check or Android device test has been completed.

Before daily use, verify scrolling comments and suggestions, a paused video, manual resume, entering/re-entering the mini-player, PiP, Home/app switch, rotation, buffering, Shorts, both settings disabled, and playback with another media app present. These remain required device checks.

## Source and licence

`scrollpause.patch` contains every custom source change, including the standalone policy test. It also labels the patch bundle **ScrollPause custom patches** to distinguish it from upstream. Original notices and authorship are preserved. See `LICENSE` and `NOTICE` for upstream GPLv3 and additional Section 7 terms. No YouTube application files are included.
