# Функция для вывода с цветом
function Write-Colored {
    param (
        [string]$Text,
        [string]$Color
    )
    Write-Host -NoNewline -ForegroundColor $Color $Text
}

# Проверка аргументов
if ($args.Length -eq 0 -or $args[0] -eq "-h") {
    Write-Host "Usage: script.ps1 <ELF file>"
    Write-Host "Displays a list of functions sorted by size in kB."
    exit
}

# Проверка существования файла
$file = $args[0]
if (-not (Test-Path $file)) {
    Write-Host "Error: File '$file' does not exist." -ForegroundColor Red
    exit
}

# Заголовок
Write-Host "Functions sorted by size in $file:"
Write-Colored "Size (kB)" "Yellow"
Write-Host -NoNewline "`tAddress`t`t"
Write-Colored "Function`n" "Blue"
Write-Host "---------------------------------------------"

# Команда arm-none-eabi-nm и обработка вывода
& arm-none-eabi-nm --print-size --size-sort --radix=d --demangle $file | ForEach-Object {
    if ($_ -match " T ") {
        $columns = $_ -split '\s+'
        $sizeKB = [math]::Round($columns[1] / 1024, 3)
        Write-Colored ("{0,-10}" -f $sizeKB) "Yellow"
        Write-Host -NoNewline ("{0,-12}" -f $columns[0])
        Write-Colored $columns[3] "Blue"
        Write-Host
    }
}