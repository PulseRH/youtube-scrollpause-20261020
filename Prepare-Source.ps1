$ErrorActionPreference = 'Stop'
$target = Join-Path $PSScriptRoot 'upstream'
if (Test-Path -LiteralPath $target) { throw 'The upstream folder already exists. Use a fresh folder.' }
git init $target
if ($LASTEXITCODE) { throw 'git init failed' }
git -C $target remote add origin https://github.com/MorpheApp/morphe-patches.git
git -C $target fetch --depth 1 origin e5464395441e916b643af4e2175c4e253e6df487
if ($LASTEXITCODE) { throw 'Fetching pinned upstream failed' }
git -C $target checkout --detach FETCH_HEAD
if ($LASTEXITCODE) { throw 'Checking out pinned upstream failed' }
git -C $target apply --check (Join-Path $PSScriptRoot 'scrollpause.patch')
if ($LASTEXITCODE) { throw 'Patch check failed' }
git -C $target apply (Join-Path $PSScriptRoot 'scrollpause.patch')
if ($LASTEXITCODE) { throw 'Applying patch failed' }
Write-Output "Prepared source: $target"
Write-Output 'Build with Java 21, Python 3 (python3), Android SDK, and authenticated GitHub package access: .\gradlew.bat :patches:buildAndroid'
