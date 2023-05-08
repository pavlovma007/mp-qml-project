#!/bin/bash 

#11111111111111111111111111111111111111111111111111111

stage1() {
	zenity --question --ellipsize --text "<b>Korni - youtube backup</b>  \n  Утилита для сохранения видео из ютуба. \n
	1.  вводим адрес плейлиста 

	2. выбираем опции скачивания (метаинформация, видео файлы, комментарии, субтитры, картинки предпросмотра)

	3. смотрим за ходом процесса

	Автор: <tt>http://mapavlov.ru/</tt>
	" 
}
#stage1 

stage2() { # set env url
	export url=$(zenity --entry --width=800  \
		--title="Ввидите url ПЛЕЙЛИСТА" \
		--text="Ссылка на https://www.youtube.com/ " \
		--entry-text "")
	if [ $? == 0 ] ;
		then 
		#echo $url; 
		return 0
	fi
	return 1
}
#stage2

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

#yttool=$(dirname $0)/yt1.tool.sh
yttool="$SCRIPT_DIR/yt1.tool.sh"

#replaceTmp='/media/mp/ac22fd5c-3daf-4f5a-a4bf-65b346984f64/BACKUP/KORNI-DATA/TMP'
replaceTmp='/tmp'
goToTmp() { # set env tmp_dir
	export tmp_dir=$(mktemp -d -p $replaceTmp -t yt-korni-XXXXXXXXXX)
	cd $tmp_dir
	echo $tmp_dir
}


stage3() {
	
	options=$(zenity --list --multiple --checklist  --separator="\n" --width=600 --height=300  \
				--title="Что конкретно скачивать?" \
				--column="Качать?" --column="Кратко" --column="Описание" \
					true plinfo "список видео, состав плейлиста, мета-информация" \
					true videos "Сами видео файлы" \
					true thumbs "картинки предпросмотра для видео" \
					false comments "комментарии" \
					false subs "субтитры на всех доступных языках, если есть"  )
	goToTmp
	
	touch SAVE.log
	touch GEN.log
	#tail -f SAVE.log  | zenity --progress --modal --title='Сохранение данных в базу' --width=700 --height=700 \
	# 	--text='Сохраняю, жду готовности данных...' &
	tail -f SAVE.log  | zenity --text-info --modal --width=700 --height=700 \
	 	--title='Сохраняю, жду готовности данных...' --auto-scroll&
	pid1=$!
	#tail -f GEN.log   | zenity --progress --modal --title='Скачивание данных' --width=800 --height=800 \
	#	--text='Загрузка началась...' &
	tail -f GEN.log   | zenity --text-info --modal --width=800 --height=800 \
		--title='Загрузка началась...' --auto-scroll &		
		
	pid2=$!
	#echo pids $pid1 $pid2 
	
	for item in ${options}
	do
	  #echo $item
	  $yttool $item "$url"
	  #sleep 5
	done
	
	name=$url
	plName=$(cat plName.txt)
	if [ -n "$plName" ]; then
		name=$plName
	fi
	
	zenity --notification  --window-icon="info" --text="Обработка $name завершена"
	zenity --question      --ellipsize --text="Прочитали логи? сейчас закрою всё!" --cancel-label='Да'
	
    kill -9 $pid1
    kill -9 $pid2
}
#stage3

#exit 2

stage1
if [ $? == 1 ] ; then 
	exit; 
fi
stage2
if [ $? == 1 ] ; then exit; fi
stage3
