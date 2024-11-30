@echo off

echo Hi Na-chan!
echo Go to purchaseRequest Recovery!

:: Get current time in YYYYMMDDHHMMSS format
for /f "tokens=*" %%A in ('powershell -Command "Get-Date -Format yyyyMMddHHmmss"') do set currentTime=%%A
echo %currentTime%

:: Ask the user for input
echo What type you want to recover? (1: ComPurReq, 2: ComPurRst, 3: ComPurSrc, 4: ComPurInf)
set /p inputype=

set "mqType="
if "%inputype%"=="1" (
    echo koubaiirai!
    set "mqType=PurchaseReq"
) else if "%inputype%"=="2" (
    echo kounyuuyoukyuu
    set "mqType=purchaseRequisition"
) else if "%inputype%"=="3" (
    echo kyoukyuumoto
    set "mqType=PurchaseSource"
) else if "%inputype%"=="4" (
    echo koubaijouhou
    set "mqType=PurchaseInfor"
) else (
    echo Error!
    pause
    exit /b
)

:: Generate the output file name
set "outputFileName=%mqType%_%currentTime%.txt"

:: Initialize the MQ IDs (requires PowerShell to process the data file)
setlocal enabledelayedexpansion
set "mqIds="

:: Read IDs from data.txt and format them
for /f "tokens=*" %%A in (data.txt) do (
    set "mqIds=!mqIds!<purchaseRequestId>%%A</purchaseRequestId>^n"
)

:: Read the format file and merge with MQ IDs
set "line=1"
(for /f "tokens=*" %%B in (Format\%mqType%.txt) do (
    if !line! equ 2 (
        echo !mqIds!
    )
    echo %%B
    set /a line+=1
)) > mq\%outputFileName%

:: Execute SQL for updating mirroring status (placeholder)
:: Replace this section with actual SQL execution commands
echo Executing SQL to update mirroring status...
REM Add your SQL commands here

:: Execute Batch for MQ (placeholder)
:: Replace this section with actual batch commands for MQ
echo Executing Batch for MQ...
REM Add your MQ batch execution commands here

pause