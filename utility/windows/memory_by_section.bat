# Определение цветов
$ORANGE = "Yellow"  # Цвет для размера
$BLUE = "Blue"      # Цвет для названия секции

# Проверка аргументов
if ($args.Length -eq 0 -or $args[0] -eq "-h") {
    Write-Host "Usage: script.ps1 <ELF file>"
    Write-Host "Displays memory usage by section."
    exit
}

# Проверка существования файла
$file = $args[0]
if (-not (Test-Path $file)) {
    Write-Host "Error: File '$file' does not exist." -ForegroundColor Red
    exit
}

# Заголовок
Write-Host "Memory usage by section in $file:"
Write-Host -NoNewline -ForegroundColor $ORANGE "Size (bytes)"
Write-Host -NoNewline "`t"
Write-Host -ForegroundColor $BLUE "Section"
Write-Host "---------------------------------------"

# Выполнение команды и обработка вывода
& arm-none-eabi-size -A $file | Select-Object -Skip 1 | ForEach-Object {
    $columns = $_ -split '\s+'
    if ($columns.Length -ge 2) {
        $size = $columns[1]
        $section = $columns[0]
        Write-Host -NoNewline -ForegroundColor $ORANGE ("{0,-12}" -f $size)
        Write-Host -NoNewline "`t"
        Write-Host -ForegroundColor $BLUE $section
    }
}