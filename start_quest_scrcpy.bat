@echo off
set DEVICE_IP=192.168.0.191
set PORT=5555

echo 🔌 Waiting for Oculus Quest to be connected via USB...
adb wait-for-device

echo ✅ Device detected via USB.
echo ⚙️ Enabling ADB over TCP/IP...
adb tcpip %PORT%

echo.
echo 🔌 Disconnect USB now, then press any key to continue...
REM pause >nul

echo 🌐 Connecting to %DEVICE_IP% over Wi-Fi...
adb connect %DEVICE_IP%:%PORT%

adb devices | find "%DEVICE_IP%" >nul
if %errorlevel%==0 (
    echo ✅ Successfully connected to %DEVICE_IP% over Wi-Fi.
    echo 🚀 Launching scrcpy...
    scrcpy --tcpip=%DEVICE_IP% -m 800 -b5M --max-fps 30 --crop 1600:900:2017:510
) else (
    echo ❌ Failed to connect. Make sure the device is on the same Wi-Fi and IP is correct.
)
