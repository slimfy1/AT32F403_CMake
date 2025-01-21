# Проверка аргументов
if ($args.Length -eq 0 -or $args[0] -eq "-h") {
    Write-Host "Usage: script.ps1 <ELF file>"
    Write-Host "Displays the sizes of all sections in the ELF file."
    exit
}

# Проверка существования файла
$file = $args[0]
if (-not (Test-Path $file)) {
    Write-Host "Error: File '$file' does not exist." -ForegroundColor Red
    exit
}

# Заголовок
Write-Host "Section sizes in $file:"
Write-Host "------------------------------------"

# Выполнение команды и обработка вывода
& arm-none-eabi-objdump -h $file | ForEach-Object {
    if ($_ -match "^\s+\d+\s+(\S+)\s+(\d+)") {
        $section = $matches[1]
        $size = $matches[2]
        Write-Host ("{0,-15} {1,10} bytes" -f $section, $size)
    }
}