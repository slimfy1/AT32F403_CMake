@echo off
:: Define memory sizes of your microcontroller
set FLASH_SIZE=16384  :: Flash size in bytes
set RAM_SIZE=2048     :: RAM size in bytes

:: Function to display help
if "%1" == "-h" (
    echo Usage: %~nx0 [options] ^<ELF file^>
    echo.
    echo Options:
    echo   -h       Show this help message
    echo.
    echo Arguments:
    echo   ^<ELF file^>  Path to the ELF file to analyze
    echo.
    echo Example:
    echo   %~nx0 Testgg.elf
    exit /b 0
)

:: Check if the argument is provided
if "%~1"=="" (
    echo Error: No ELF file specified. Use -h for help.
    exit /b 1
)

:: Check if the file exists
if not exist "%~1" (
    echo Error: File "%~1" does not exist.
    exit /b 1
)

:: Run arm-none-eabi-size and parse the output
for /f "skip=1 tokens=1,2,3" %%A in ('arm-none-eabi-size "%~1"') do (
    set /a TEXT=%%A
    set /a DATA=%%B
    set /a BSS=%%C
    goto calculate
)

:calculate
:: Calculate Flash usage in percentage
set /a FLASH_USED=%TEXT% + %DATA%
set /a FLASH_PERCENT=100 * %FLASH_USED% / %FLASH_SIZE%

:: Calculate RAM usage in percentage
set /a RAM_USED=%DATA% + %BSS%
set /a RAM_PERCENT=100 * %RAM_USED% / %RAM_SIZE%

:: Output results
echo Flash Usage: %FLASH_PERCENT%% of %FLASH_SIZE% bytes
echo RAM Usage: %RAM_PERCENT%% of %RAM_SIZE% bytes
