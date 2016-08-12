@echo off
set DGUI_LIB=DGui.lib
set SAMPLES_DIR=dgui_samples\
set OUT_DIR=%SAMPLES_DIR%
set WIN_LIB=user32.lib  gdi32.lib ole32.lib oleAut32.lib comctl32.lib comdlg32.lib advapi32.lib uuid.lib ws2_32.lib

set samples=events, gradient_rect, gradient_triangle, grid, hello, menu, picture, rawbitmap, resources, splitter, toolbar_32_x_32
set resources=%SAMPLES_DIR%resource.res

if not exist %DGUI_LIB% echo %DGUI_LIB% not found. Build DGui first. && goto reportError

echo Building DGui samples...
setlocal EnableDelayedExpansion
for /d %%f in (%samples%) do (
	echo     %%f.d !%%f!
	dmd -m64 -release -de -w -of%OUT_DIR%%%f.exe -L-SUBSYSTEM:windows -L-ENTRY:mainCRTStartup %SAMPLES_DIR%%%f.d !%%f! %RES% %DGUI_LIB% %WIN_LIB%|| goto reportError
	del %OUT_DIR%%%f.obj
)


goto noError
:reportError
echo Building samples failed.
:noError
echo Done. Somples are here: %OUT_DIR%
