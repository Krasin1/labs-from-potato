#!/bin/sh

if [ ! -n "$1" ]
then
    echo "Использование: $0 КОМАНДА АРТУМЕНТЫ"
    echo "Команды: init, last, load, save"
    echo "Аргумент к команде load: номер версии, которую надо восстановить"
    exit 1
fi

if [ "$1" == "init" ]
then
    if [ ! -d .bd ]
    then
    mkdir .bd
    else
        echo "Ошибка: репозиторий уже инициализирован"
        exit 1
    fi
    echo last=1 >> .bd/variable.txt
    rsync -r . .bd/1/ --exclude .bd --exclude snapshot.sh

elif [ "$1" == "last" ]
then
    if [ ! -e .bd/ ]
    then
        echo "Ошибка: репозирорий не инициализирован"
        exit 1
    fi
    source .bd/variable.txt
    last=$((last-1))
    if [ ! -e ./.bd/$last/ ] 
    then 
        echo "Ошибка: предыдущая версия не найдена"
        exit 1
    fi
        for file in *; do if [ ! "$file" == .bd ] | [ ! "$file" == "snapshot.sh" ] ; then rm -rf $file; fi; done
    cp -r .bd/$last/* ./

elif [ "$1" == "load" ]
then
    if [ ! -e .bd/ ]
    then
        echo "Ошибка: репозирорий не инициализирован"
        exit 1
    fi
    if [ ! -n "$2" ]
    then
        echo "Ошибка: не введён номер версии"
        exit 1
    fi

    if [ -e .bd/$2 ]
    then
        read -n 1 -p "Не сохраненные данные будут утеряны. Продолжить? [y/n] " yn
        case $yn in
            [Yy]* ) echo ""; break;;
            [Nn]* ) echo ""; exit 0;;
            * ) echo ""; exit 1;;
        esac

        for file in *; do if [ ! "$file" == .bd ] | [ ! "$file" == "snapshot.sh" ] ; then rm -rf $file; fi; done
        cp -r .bd/$2/* .
    else
        echo "Ошибка: версии с данным номером не существует"
        exit 1
    fi

elif [ "$1" == "save" ]
then
    if [ ! -e .bd/ ]
    then
        echo "Ошибка: репозирорий не инициализирован"
        exit 1
    fi
source .bd/variable.txt
last=$((last+1))
echo last=$last > .bd/variable.txt
if [ ! -e $last/ ] 
then 
    mkdir .bd/$last/ 
fi
rsync -r . .bd/$last --exclude .bd --exclude snapshot.sh

else
    echo "Ошибка: неизвестная команда $1"
    exit 1
fi
