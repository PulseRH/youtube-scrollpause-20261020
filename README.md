# ScrollPause custom patch source for Morphe

Custom source changes prepared 20 October 2026. This is an unofficial modification of Morphe Patches. This folder contains the reproducible source; the separately supplied `ScrollPause-1.47.0.mpp` is the compiled importable bundle.

## Behaviour

Select **Pause on scroll or minimise** when patching. In YouTube → Settings → Morphe → Video:

- **Pause when scrolling**: enabled by default. Drag-scrolling the main YouTube screen pauses an open regular video, even if it stays visible. A gesture must exceed Android's touch slop; automatic scrolling without a drag is ignored. This observes normal Android view scrolling. Controls implemented wholly outside Android view scrolling need device verification.
- **Pause when minimised**: enabled by default. Entering YouTube's mini-player, picture-in-picture, or stopping the main activity pauses an open regular video. Rotation is excluded. Opening a separate full-screen activity can also stop the main activity and pause it.
- Resuming playback is manual. Paused videos remain paused. Shorts and inline feed previews are excluded.
- A brief pending request handles buffering during the trigger. Requests expire after 1.5 seconds. Pause events are rate limited during a fling.
- Pause uses the activity's media controller when available, otherwise the same Android pause-only media-key mechanism as upstream's screen-lock pause feature. Casting and interactions with other media apps require device verification.

## Compatibility

Pinned upstream: https://github.com/MorpheApp/morphe-patches/commit/e5464395441e916b643af4e2175c4e253e6df487 (1.47.0).

The patch inherits that source's supported versions. For this build, **21.20.405** is the first non-experimental target in the upstream compatibility list. Your **21.04.223** is not listed. Use a supported original YouTube APK and repatch with this custom bundle; compatibility has not been tested against any APK here.

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
