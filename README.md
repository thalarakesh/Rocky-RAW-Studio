# Rocky RAW Selection Studio (Windows)

## Run software
1. Install Python 3.10+ (check **Add Python to PATH** in the installer).
2. Recommended: in PowerShell run `py -3 -m pip install Pillow rawpy` for JPEG and embedded RAW thumbnails. If rawpy does not support a format, it shows an extension tile.
3. Double-click **START_ROCKY_STUDIO.bat**. Your web browser opens the real local Windows application. Keep the launcher running while using it.
4. Choose original RAW folder; paste selected numbers OR choose client JPEG folder; press Find Matching RAW Files. Correct any ambiguous/missing selections. Choose destination and Copy.

## Build a standalone Windows EXE
Double-click **BUILD_WINDOWS_EXE.bat** on a Windows computer with Python/pip. It installs Pillow and PyInstaller and creates `dist/Rocky_RAW_Studio.exe`. To include embedded RAW previews, install `rawpy` before building and add `--collect-all rawpy` to the PyInstaller command. Building on Windows is necessary for a Windows EXE; this ZIP is source, not a compiled EXE.

## Matching rules
- JPEG `D007.JPG` matches original RAW `D007.ARW`, `D007.CR2`, etc. based on name without extension.
- Numeric `007` matches a single original RAW file with trailing 7 (e.g. `DSC_0007.NEF`). Ambiguous numbers are reported rather than copied silently.
- JPEG folder requires exact filename stem; this prevents accidental selection of similarly numbered, differently named photos.
- Subfolders are scanned and copied preserving relative structure.
- Existing destination files are not overwritten; a `_copy1` suffix is added to conflicting copies.
- RAW originals are never converted or modified.
- 4 counter cards: source RAW, client requests, selected, successfully copied.
- Automatic theme follows Windows/browser OS preference; Light/Dark overrides are saved in browser local storage.

## Limitations
- The visual gallery supports JPG sidecars or the client's matching JPEG; embedded RAW preview requires optional `rawpy` and appropriate codec support. All RAW formats are selectable/copyable even without thumbnails.
- The browser is just the graphical user interface; a local Python service provides real native folder dialogs and filesystem copying. The service listens only on 127.0.0.1.
- CSV report is generated on your computer. No cloud or internet upload is used.
- Do not close the launcher while copying.
