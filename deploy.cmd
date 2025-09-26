@echo off
title Windows Image Deployment Script
setlocal enabledelayedexpansion

:Menu
title Windows Image Deployment Script
echo ---------------------------------------
echo --- Windows Image Deployment Script ---
echo ---------------------------------------
echo.
echo 1. Deploy Windows Image
echo 2. Windows Install Repair
echo 3. About
echo 4. Exit
echo.
echo ---------------------------------------
echo.
set /p choice="> "

if "%choice%"=="1" (
    goto :Deploy
)


if "%choice%"=="2" (
    goto :Repair
)


if "%choice%"=="3" (
    goto :About
)

if "%choice%"=="4" (
    exit
)
goto :Menu

:Deploy
echo ---------------------------------------
echo 1. Partition Disk For Windows Installation
echo 2. Apply Windows Image To Disk
echo 3. Setup Bootloader Files
echo 4. Back to Main Menu
echo.
set /p deploychoice="> "
if "%deploychoice%"=="1" (
    call :Partition
)
if "%deploychoice%"=="2" (
    call :ApplyImage
)
if "%deploychoice%"=="3" (
    call :Bootloader
)
if "%deploychoice%"=="4" (
    goto :Menu
)
goto :Deploy

:Partition
echo Partitioning Disk...
echo.
diskpart /s X:\windows\dpart.txt
echo Disk Partitioning Complete.
goto :Deploy

:ApplyImage
echo Applying Windows Image to Disk...
echo.
set /p imagefile="Enter the path of the WIM File: "
dism /apply-image /imagefile:%imagefile% /index:1 /applydir:C:\
echo Windows Image Application Complete.
goto :Deploy

:Bootloader
echo Creating Boot Files For Windows
echo.
bcdboot C:\windows /l en-us /s a: /f ALL
goto :Deploy


:Repair
dism /online /cleanup-image /restorehealth
sfc /scannow
goto :Menu

:about
echo PE Deployment Tool By MelonCat, [© MelonCat 2025]
echo This script was made for Deploying, Formating and Repairing Windows images on UEFI and BIOS based systems in a Preinstallation Environment (PE).
echo.
echo This script was made for light weight Preinstallation Environments (PE).
echo.
echo This script is not affiliated with Microsoft Corporation. All trademarks are the property of their respective owners.
echo.
echo For more information, visit https://github.com/JustAMelonCat/PE-DeployTool
echo. 
echo [*] YOU CAN DISTRIBUTE THIS SCRIPT FREELY IN YOUR OWN PREINSTALLATION ENVIRONMENTS, ALTHOUGH YOU CAN DISTRIBUTE THIS SCRIPT FREELY DO NOT CLAIM/PASS IT OFF AS YOUR OWN WORK.
echo [*] PLEASE CREDIT ME (MELONCAT) IF YOU USE THIS SCRIPT IN YOUR OWN PREINSTALLATION ENVIRONMENTS AND DO NOT REMOVE THIS ABOUT SECTION.
goto :Menu