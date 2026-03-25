@echo off
echo Building Endless Beloved APK...

REM Create build directory
if not exist "build" mkdir build

REM Try to build with current setup
echo Attempting to build APK...
.\build_tools\Godot_v4.2.2-stable_win64_console.exe --headless --export-release "Android" "build/EndlessBeloved.apk"

if %ERRORLEVEL% EQU 0 (
    echo APK built successfully!
    echo Location: build/EndlessBeloved.apk
) else (
    echo Build failed. Please install:
    echo 1. Android SDK
    echo 2. Java JDK
    echo 3. Godot export templates
    echo.
    echo Or use Godot Editor GUI: File ^> Export ^> Android
)

pause
