#!/bin/pwsh

param($first, $second, $third)
if($first -eq $null) { 
    write-host "Использование: snapshot.ps1 КОМАНДА АРГУМЕНТЫ"
    write-host "Команды: init, last, load, save"
    write-host "Аргумент к команде load: номер версии, которую надо восстановить"
    exit 1
} 

if ($first -eq "init") {
    if( ! (Test-Path ./.bd)) {
        New-Item -Path './.bd' -ItemType Directory | Out-Null
    } else {
        write-host "Ошибка: репозиторий уже инициализирован"
        exit 1
    }
    Set-Content ./.bd/variable.txt 'last=1'
    New-Item -Path './.bd/1' -ItemType Directory | Out-Null
    Copy-Item -Path ./* -Destination ./.bd/1/ -recurse -exclude .bd/,snapshot.ps1

} elseif ($first -eq "last") {
    if (!(Test-Path  "./.bd")) {
        write-host "Ошибка: репозирорий не инициализирован"
        exit 1
    }
    $last = Get-Content './.bd/variable.txt' | Out-String | ConvertFrom-StringData

    $last = Get-Content './.bd/variable.txt' | Out-String | ConvertFrom-StringData
    $num = [System.Decimal]::Parse($last.last)
    $num--
    [string]$num = $num

    if (!(Test-Path  "./.bd/$num")) {
        write-host "Ошибка: предыдущая версия не найдена"
        exit 1
    }

    Remove-Item './*' -recurse -exclude .bd/,snapshot.ps1
    Copy-Item -Destination ./ -Path ./.bd/$num/* -recurse -exclude .bd/,snapshot.ps1

} elseif ($first -eq "load") {
    if (!(Test-Path  "./.bd")) {
        write-host "Ошибка: репозирорий не инициализирован"
        exit 1
    }
    if($second -eq $null) {
        write-host "Ошибка: не введён номер версии"
        exit 1
    }
    if(Test-Path ./.bd/$second) {
        # write-host "Не сохраненные данные будут утеряны. Продолжить? [y/n] " 
        $confirmation = Read-Host "Не сохраненные данные будут утеряны. Продолжить? [y/n]"
        if ($confirmation -eq 'y') {
            # proceed
            Remove-Item './*' -recurse -exclude .bd/,snapshot.ps1
            Copy-Item -Destination ./ -Path ./.bd/$second/* -recurse -exclude .bd/,snapshot.ps1
        } elseif($confirmation -eq 'n') {

        } else {
            exit 1
        }
    } else {
        write-host "Ошибка: версии с данным номером не существует"
        exit 1
    }

} elseif ($first -eq "save") {
    if (!(Test-Path  "./.bd")) {
        write-host "Ошибка: репозирорий не инициализирован"
        exit 1
    }

    $last = Get-Content './.bd/variable.txt' | Out-String | ConvertFrom-StringData
    $num = [System.Decimal]::Parse($last.last)
    $num++
    Set-Content ./.bd/variable.txt "last=$num"
    [string]$num = $num

    if (!(Test-Path "./.bd/$num")) {
        New-Item -Path "./.bd/$num" -ItemType Directory  | Out-Null
    }
    Copy-Item -Path ./* -Destination ./.bd/$num/ -recurse -exclude .bd/,snapshot.ps1
} else {
    write-host "Ошибка: неизвестная комманда $first"
    exit 1
}
