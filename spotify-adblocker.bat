@echo off

>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if %errorLevel% neq 0 (
    echo %~nx0 must be ran as administrator
    pause
    goto :EOF
)

set "HOSTS_FILE=%SystemRoot%\System32\drivers\etc\hosts"
set "SPOTIFY_PATH="

for %%I in (
    "%APPDATA%\Spotify\Spotify.exe"
    "%LOCALAPPDATA%\Spotify\Spotify.exe"
    "%PROGRAMFILES%\Spotify\Spotify.exe"
    "%PROGRAMFILES(x86)%\Spotify\Spotify.exe"
) do (
    if exist "%%~I" (
        set "SPOTIFY_PATH=%%~I"
        goto :LaunchSpotify
    )
)

echo Spotify.exe not found.
goto :EOF

:LaunchSpotify
echo 0.0.0.0 adclick.g.doubleclick.net >> %HOSTS_FILE%
echo 0.0.0.0 googleads.g.doubleclick.net >> %HOSTS_FILE%
echo 0.0.0.0 pubads.g.doubleclick.net >> %HOSTS_FILE%
echo 0.0.0.0 securepubads.g.doubleclick.net >> %HOSTS_FILE%
echo 0.0.0.0 pagead2.googlesyndication.com >> %HOSTS_FILE%
echo 0.0.0.0 spclient.wg.spotify.com >> %HOSTS_FILE%

start "" "%SPOTIFY_PATH%"
