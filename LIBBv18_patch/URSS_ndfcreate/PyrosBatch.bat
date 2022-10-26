@echo off
ECHO Wargame - Apply Patch Workflow

REM Edit the settings between the equal signs only
REM Individual mod files are listed in order and should be in same folder as batch file
REM First mod file is mandatory, the remainder may be left blank
REM WGStartFile and WGFinalFile can be in the same folder or a different one as the batch file
REM If WGStartFile and WGFinalFile are in same folder as batch file, set WGTargetFolder=current
REM (setting it to null gives errors that I simply cannot be bothered to work out)
REM Config file for WGPatcher should be in same folder as batch file
REM Lastly set ModPatcherFolder to the folder containing the WGPatcher.exe file,
REM or ModPatcherFolder=current if it is in the same folder as the batch file.
REM====================================================================
SET ModFile001=URSS_TTurretTwoAxisDescriptor_1.xml
SET ModFile002=
SET ModFile003=
SET ModFile004=
SET ModFile005=
SET ModFile006=
SET ModFile007=
SET ModFile008=
SET ModFile009=
SET ModFile010=
SET ModFile011=
SET ModFile012=
SET ModFile013=
SET ModFile014=
SET ModFile015=
SET ModFile016=
SET ModFile017=
SET ModFile018=
SET ModFile019=
SET ModFile020=
SET WGTargetFolder=current
SET WGStartFile=NDF_Win
SET WGFinalFile=NDF_Win-patched
SET ModPatcherFolder=current
REM====================================================================

IF NOT "%WGTargetFolder%"=="current" (
   SET DataFinal=%WGTargetFolder%\%WGFinalFile%.dat
   SET DataOutput=%WGTargetFolder%\%WGFinalFile%_patched.dat
   SET DataStart=%WGTargetFolder%\%WGStartFile%.dat
) ELSE (
   SET DataFinal=%WGFinalFile%.dat
   SET DataOutput=%WGFinalFile%_patched.dat
   SET DataStart=%WGStartFile%.dat
)
IF NOT "%ModPatcherFolder%"=="current" (
   SET ModPatcher=%ModPatcherFolder%\WGPatcher.exe
) ELSE (
   SET ModPatcher=WGPatcher.exe
)
SET ModList=%ModFile001%
IF NOT "%ModFile002%"=="" SET ModList=%ModList%" "%ModFile002%
IF NOT "%ModFile003%"=="" SET ModList=%ModList%" "%ModFile003%
IF NOT "%ModFile004%"=="" SET ModList=%ModList%" "%ModFile004%
IF NOT "%ModFile005%"=="" SET ModList=%ModList%" "%ModFile005%
IF NOT "%ModFile006%"=="" SET ModList=%ModList%" "%ModFile006%
IF NOT "%ModFile007%"=="" SET ModList=%ModList%" "%ModFile007%
IF NOT "%ModFile008%"=="" SET ModList=%ModList%" "%ModFile008%
IF NOT "%ModFile009%"=="" SET ModList=%ModList%" "%ModFile009%
IF NOT "%ModFile010%"=="" SET ModList=%ModList%" "%ModFile010%
IF NOT "%ModFile011%"=="" SET ModList=%ModList%" "%ModFile011%
IF NOT "%ModFile012%"=="" SET ModList=%ModList%" "%ModFile012%
IF NOT "%ModFile013%"=="" SET ModList=%ModList%" "%ModFile013%
IF NOT "%ModFile014%"=="" SET ModList=%ModList%" "%ModFile014%
IF NOT "%ModFile015%"=="" SET ModList=%ModList%" "%ModFile015%
IF NOT "%ModFile016%"=="" SET ModList=%ModList%" "%ModFile016%
IF NOT "%ModFile017%"=="" SET ModList=%ModList%" "%ModFile017%
IF NOT "%ModFile018%"=="" SET ModList=%ModList%" "%ModFile018%
IF NOT "%ModFile019%"=="" SET ModList=%ModList%" "%ModFile019%
IF NOT "%ModFile020%"=="" SET ModList=%ModList%" "%ModFile020%

ECHO.
ECHO.

ECHO Patcher Configuration
ECHO StartFile: "%DataStart%"
ECHO FinalFile: "%DataFinal%"
ECHO ModList: "%ModList%"
ECHO ModPatcher: "%ModPatcher%"

ECHO.
ECHO.
ECHO.

IF NOT EXIST "%ModPatcher%" (
   ECHO Cannot find "%ModPatcher%"
   PAUSE
   EXIT /b
)
IF NOT EXIST "%DataStart%" (
   ECHO Cannot find "%DataStart%"
   PAUSE
   EXIT /b
)
IF NOT EXIST "%ModFile001%" (
   ECHO Cannot find "%ModFile001%%"
   PAUSE
   EXIT /b
)

ECHO Preparing to overwrite %WGFinalFile%.dat file with %WGStartFile%.dat file.
ECHO All previous changes will be lost. (or exit now)
ECHO.
PAUSE
ECHO f | xcopy /f /y "%DataStart%" "%DataFinal%"

ECHO.
ECHO.
ECHO.

ECHO Preparing to execute the WARGAME patcher. Please wait until completion. (or exit now)
ECHO.
PAUSE
@echo on
CALL "%ModPatcher%" "apply" "%DataFinal%" "%ModList%"
@echo off

ECHO.
ECHO.
ECHO.

ECHO Updating data file from data output.
ECHO.
MOVE /y "%DataOutput%" "%DataFinal%"

ECHO.
ECHO.
ECHO.

ECHO The WARGAME patcher is complete. "%DataFinal%"
PAUSE