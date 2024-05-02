::THIS IS EXPERIMENTAL!!

:: Created by YoshiiShell, creater of Yet Another Windows Toolbox and NyneDZN, Owner of NeptuneOS


@echo off
:: Get current directory and set it as a variable
set "fullPath=%~dp0"
set "pathOnly=%fullPath:~0,-1%"
echo DEBUG: Script is located at %pathOnly%
:: Check required files
if not exist %pathOnly%\NSudoLG.exe (
    echo "ISOMaker requires NSudo to run certain commands. Download as ZIP and retry"
    timeout 10 > nul
    exit
)
echo WARNING: This will not work on custom ISOs
:: Yeah I took a tiny bit of InstallWindowsWithoutUSB.
echo Select the ISO file:
for /f "delims=" %%A in ('powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; $f = New-Object Windows.Forms.OpenFileDialog; $f.InitialDirectory = [Environment]::GetFolderPath('Desktop'); $f.Filter = 'Image Files (*.iso)|*.iso|All Files (*.*)|*.*'; $f.Multiselect = $false; [void]$f.ShowDialog(); Write-Output $f.FileName"') do set "filepath=%%A"
echo ISO: %filepath%
:: break..
cd C:/Users/%USERNAME%
md ISO
cd ISO
powershell.exe -Command "Mount-DiskImage -ImagePath '%filepath%'"
for %%D in (A B D E F G H) do (
    if exist %%D:\Sources (
        echo copying files...
        xcopy /s /i %%D:\ C:\Users\%USERNAME%\ISO
        pause
        cd C:/Users/%USERNAME%/ISO
        goto :premenu
    )
)
echo No drive with Windows found. Restart the program and try again


:premenu
cls
echo What version of Windows do you want?
echo Type 1 for Windows Home
echo Type 2 for Windows Pro
echo Type 3 for Windows Pro For Workstations
echo Type 4 for Windows Home N
echo Type 5 for Windows Pro N
set /p message1=
md mount
if %message1% == 1 dism /Mount-Image /ImageFile:sources\install.wim /Index:1 /MountDir:mount
if %message1% == 2 dism /Mount-Image /ImageFile:sources\install.wim /Index:6 /MountDir:mount
if %message1% == 3 dism /Mount-Image /ImageFile:sources\install.wim /Index:10 /MountDir:mount
if %message1% == 4 dism /Mount-Image /ImageFile:sources\install.wim /Index:2 /MountDir:mount
if %message1% == 5 dism /Mount-Image /ImageFile:sources\install.wim /Index:7 /MountDir:mount
pause

:menu
cd C:/Users/%USERNAME%/ISO
cls
echo Any of these will take you to a menu for more options
echo .
echo .
echo Type 1 - preinstalled programs
echo Type 2 - System
echo Type 3 - privacy/tracking
echo Type 4 - hardware support/drivers
echo Type 5 for a menu to remove more things
echo Type 6 to save the image to an ISO
set /p message2=
if %message2% == 1 goto :Appx
if %message2% == 2 goto :System
if %message2% == 3 goto :Loggers
if %message2% == 4 goto :Drivers
if %message2% == 5 goto :menu2
if %message2% == 6 goto :end
:: dism /Image:mount /Get-ProvisionedAppxPackages

:system
echo Type 1 to remove Windows Update
echo Type 1 to remove Windows Defender
set /p message4=
if %message4% == 1 goto :Update
if %message4% == 2 goto :Defender

:Drivers
echo Type 1 to remove battery support
echo Type 2 to remove Bluetooth support
echo Type 3 to remove Indeo Codec support
set /p Drivers=
if %Drivers% == 1 goto :battery
if %Drivers% == 2 goto :Bluetooth
if %Drivers% == 3 goto :Indeo

:battery
cd C:/Users/%USERNAME%/ISO/mount/Windows/System32
del batmeter.dll
cd drivers
del battc
goto :menu

:Bluetooth
cd C:/Users/%USERNAME%/ISO/mount/Windows/System32
del bthudtask.exe
del BTAGService.dll
del BthAvctpSvc.dll
del BthAvrcp.dll
del BthAvrcpAppSvc.dll
del bthci.dll
del BthMtpContextHandler.dll
del BthpanContextHandler.dll
del BthRadioMedia.dll
del bthserv.dll
del BthTelemetry.dll
del btpanui.dll
goto :menu

:Indeo
echo Bros I'm tired
timeout 5 > nul
goto :menu

:Appx
cls
echo Type 1 to remove Clipchamp
echo Type 2 to remove Cortana
echo Type 3 to remove Camera
:: Yeah.. for some reason both Calendar and Mail are included in one package. microsoft.windowscommunicationsapps...
echo Type 4 to remove Calendar/Mail
echo Type 5 to remove Calculator
echo Type 6 to remove News and Intrests
echo Type 7 to remove Weather
echo Type 8 to remove Xbox
echo Type 9 to remove Xbox Game Bar
echo Type 10 to remove Xbox TCUI
echo Type 11 to remove Alarms
echo Type 12 to remove Photos (Modern)
echo Type 13 to remove Get Help
echo Type 14 to remove Get Started
echo Type 15 to remove Solitare
echo Type 16 to remove Sticky Notes
echo Type 17 to remove HEIF Video Extentions
echo Type 18 to remove HEVC Video Extentions
echo Type 19 to remove Office Hub
echo Type 20 to remove Paint (Modern)
echo Type 21 to remove People
echo Type 22 to remove Power Automate Desktop
echo Type 23 to remove Raw Image Extentions
echo Type 24 to remove Snip and Sketch
echo Type 25 to remove the Microsoft Store
echo Type 26 to remove Todos
echo Type 27 to remove Feedback Hub
echo Type 28 to remove Windows Maps
:: Modern Notepad sucks
echo Type 29 to remove Notepad (Modern)
echo Type 30 to remove Sound Recorder
echo Type 31 to remove Windows Terminal
echo Type 32 to remove Your Phone
echo Type 33 to remove Groove Music
echo Type 34 to remove Videos
echo Type 35 to remove Quick Assist
echo Type 36 to remove Web Media Extentions
echo Type 37 to remove WebP Media Extentions
echo Type 38 to remove Xbox Text to Speech
echo Type 39 to remove Xbox Identity Provider
echo Type 40 to go back to the main menu
set /p message3=
if %message3% == 1 (
    dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Clipchamp.Clipchamp_2.5.15.0_neutral_~_yxz26nhyzhsrt
    goto :appx
)

if %message3% == 2 (
    dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.549981C3F5F10_3.2204.14815.0_neutral_~_8wekyb3d8bbwe
    goto :appx
)

if %message3% == 3 (
    dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.WindowsCamera_2022.2201.4.0_neutral_~_8wekyb3d8bbwe
    goto :appx
)

if %message3% == 4 (
    dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:microsoft.windowscommunicationsapps_16005.14326.20544.0_neutral_~_8wekyb3d8bbwe
    goto :appx
)

if %message3% == 5 (
    dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.WindowsCalculator_2020.2103.8.0_neutral_~_8wekyb3d8bbwe
    goto :appx
)

if %message3% == 6 (
    dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.BingNews_4.2.27001.0_neutral_~_8wekyb3d8bbwe
    goto :appx
)

if %message3% == 7 (
    dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.BingWeather_4.53.33420.0_neutral_~_8wekyb3d8bbwe
    goto :appx
)

if %message3% == 8 (
    dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.GamingApp_2021.427.138.0_neutral_~_8wekyb3d8bbwe
    goto :appx
)

if %message3% == 9 goto :GameBar

if %message3% == 10 (
    dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.Xbox.TCUI_1.23.28004.0_neutral_~_8wekyb3d8bbwe
    goto :appx
)

if %message3% == 11 (
    dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.WindowsAlarms_2022.2202.24.0_neutral_~_8wekyb3d8bbwe
    goto :appx
)

if %message3% == 12 (
    dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.Windows.Photos_21.21030.25003.0_neutral_~_8wekyb3d8bbwe
    goto :appx
)

if %message3% == 13 (
    dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.GetHelp_10.2201.421.0_neutral_~_8wekyb3d8bbwe
    goto :appx
)

if %message3% == 14 (
    dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.Getstarted_2021.2204.1.0_neutral_~_8wekyb3d8bbwe
    goto :appx
)

if %message3% == 15 (
    dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.MicrosoftSolitaireCollection_4.12.3171.0_neutral_~_8wekyb3d8bbwe
    goto :appx
)

if %message3% == 16 (
    dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.MicrosoftStickyNotes_4.2.2.0_neutral_~_8wekyb3d8bbwe
    goto :appx
)

if %message3% == 17 (
    dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.HEIFImageExtension_1.0.43012.0_x64__8wekyb3d8bbwe
    goto :appx
)

if %message3% == 18 (
    dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.HEVCVideoExtension_1.0.50361.0_x64__8wekyb3d8bbwe
    goto :appx
)

if %message3% == 19 (
    dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.MicrosoftOfficeHub_18.2204.1141.0_neutral_~_8wekyb3d8bbwe
    goto :appx
)

if %message3% == 20 (
    dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.Paint_11.2201.22.0_neutral_~_8wekyb3d8bbwe
    goto :appx
)

if %message3% == 21 (
    dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.People_2020.901.1724.0_neutral_~_8wekyb3d8bbwe
    goto :appx
)

if %message3% == 22 (
    dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.PowerAutomateDesktop_10.0.3735.0_neutral_~_8wekyb3d8bbwe
    goto :appx
)

if %message3% == 23 (
    dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.RawImageExtension_2.1.30391.0_neutral_~_8wekyb3d8bbwe
    goto :appx
)

if %message3% == 24 (
    dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.ScreenSketch_2022.2201.12.0_neutral_~_8wekyb3d8bbwe
    goto :appx
)

if %message3% == 25 goto :Store

if %message3% == 26 (
    dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.Todos_2.54.42772.0_neutral_~_8wekyb3d8bbwe
    goto :appx
)

if %message3% == 27 (
    dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.WindowsFeedbackHub_2022.106.2230.0_neutral_~_8wekyb3d8bbwe
    goto :appx
)

if %message3% == 28 (
    dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.WindowsMaps_2022.2202.6.0_neutral_~_8wekyb3d8bbwe
    goto :appx
)

if %message3% == 29 (
    dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.WindowsNotepad_11.2112.32.0_neutral_~_8wekyb3d8bbwe
    goto :appx
)

if %message3% == 30 (
    dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.WindowsSoundRecorder_2021.2103.28.0_neutral_~_8wekyb3d8bbwe
    goto :appx
)

if %message3% == 31 (
    dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.WindowsTerminal_3001.12.10983.0_neutral_~_8wekyb3d8bbwe
    goto :appx
)

if %message3% == 32 (
    dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.YourPhone_1.22022.147.0_neutral_~_8wekyb3d8bbwe
    goto :appx
)

if %message3% == 33 (
    dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.ZuneMusic_11.2202.46.0_neutral_~_8wekyb3d8bbwe
    goto :appx
)

if %message3% == 34 (
    dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.ZuneVideo_2019.22020.10021.0_neutral_~_8wekyb3d8bbwe
    goto :appx
)

if %message3% == 35 (
    dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:MicrosoftCorporationII.QuickAssist_2022.414.1758.0_neutral_~_8wekyb3d8bbwe
    goto :appx
)

if %message3% == 36 (
    dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.WebMediaExtensions_1.0.42192.0_neutral_~_8wekyb3d8bbwe
    goto :appx
)

if %message3% == 37 (
    dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.WebpImageExtension_1.0.42351.0_x64__8wekyb3d8bbwe
    goto :appx
)

if %message3% == 38 (
    dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.XboxSpeechToTextOverlay_1.17.29001.0_neutral_~_8wekyb3d8bbwe
    goto :appx
)

if %message3% == 39 (
    dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.XboxIdentityProvider_12.50.6001.0_neutral_~.0_x64__8wekyb3d8bbwe
    goto :appx
)

if %message3% == 40 goto :menu

:GameBar
dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.XboxGamingOverlay_2.622.3232.0_neutral_~_8wekyb3d8bbwe
dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.XboxGamingOverlay_2.622.3232.0_neutral_~_8wekyb3d8bbwe
goto :appx

:Store
dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.WindowsStore_22204.1400.4.0_neutral_~_8wekyb3d8bbwe
dism /image:mount /Remove-ProvisionedAppxPackage /PackageName:Microsoft.StorePurchaseApp_12008.1001.113.0_neutral_~_8wekyb3d8bbwe
goto :appx

:Update
cd C:/Users/%USERNAME%/ISO
reg load HKLM\zSOFTWARE "mount\Windows\System32\config\SOFTWARE"
cd C:/Users/%USERNAME%/ISO/mount/Windows/System32
:: wuauserv service it looks like
del wuauclt.exe /f
:: Self explanitory
del WindowsUpdateElevatedInstaller.exe /f
:: Windows Update API executable
del wuapihost.exe /f
:: Windows Update Engine
del wuaueng.dll /f
:: Windows Update API source
del wuapi.dll /f
:: Windows Update Driver stub apparently
del wudriver.dll /f
:: Looks to be a proxy stub. same with wups2.dll
del wups.dll /f
del wups2.dll /f
:: Windows Update System Library
del wusys.dll /f
:: Windows Update Health Agent
del WaaSAssessment.dll
del WaaSMedicPS.dll
del WaaSMedicSvc.dll
reg add "HKLM\zSOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d 1 /f
reg add "HKLM\zSOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableWindowsUpdateAccess" /t REG_DWORD /d 1 /f
reg add "HKLM\zSOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 1 /f
reg add "HKLM\zSOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUServer" /t REG_SZ /d " " /f
reg add "HKLM\zSOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d 1 /f
reg add "HKLM\zSOFTWARE\Microsoft\WindowsSelfHost\UI\Visibility" /v "HideInsiderPage" /t REG_DWORD /d "1" /f
goto :menu


:Defender
echo soon...
timeout 5 > nul
goto :menu




:Loggers
echo The Chambers oooo spooky
timeout 5
goto :menu

:menu2
echo Locked lmao
timeout 5
goto :menu
































:end
cd C:/Users/%USERNAME%/ISO
dism /image:mount /Cleanup-Image /StartComponentCleanup /ResetBase
dism /unmount-image /mountdir:mount /commit
md %pathOnly%/ISO
xcopy "C:\Users\%USERNAME%\ISO" "%pathOnly%/ISO" /e /y
cd %pathOnly%
oscdimg.exe -m -o -u2 -udfver102 -bootdata:2#p0,e,bISO\boot\etfsboot.com#pEF,e,bISO\efi\microsoft\boot\efisys.bin ISO Windows.iso
echo Cleaning up...
cd C:/Users/%USERNAME%/ISO
del mount
cd .. 
del ISO
echo Finished!
timeout 5 > nul
exit