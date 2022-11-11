#!/bin/bash
#sudo apt install -y webp
#sudo apt install -y parallel 
#####sudo apt install -y csvtool  # NO 
#
# need: yt-dlp dwebp parallel   find ls wget cat jq sed wait 

# doc yt-dlp
	# --write-comments
	# --write-thumbnail --write-all-thumbnails --list-thumbnails
	# --convert-thumbnails jpg|png|webp
	# --dump-json
	# --write-subs --sub-langs all 


# doc tables
	# files  id .....
	# videos id ...... 
	# playlists id....
	# linkVideoToPl  id(uuid), vid, plid
	# authors id,author,thumbinalUrl // get from info // from comments 
	#
	# myLikes id=uuid,zT,zU,objT=video|comment,obj=<videoId or commentId>,UD=u|d (up or down)
	# subtitlesFiles id=vid+lng,zT,lang=ru|en|pl|es|...,fileId(GFS...)								OK
	# videoinfoFiles id=vid,zT,fileId
	# comments TODO 

#TODO download subtitles
#TODO extract sound
#TODO recognize sound to text for search
# TODO extract from info.json
#  "categories": [
#    "Science & Technology"
#  ],
#  "tags": [
#    "мехамозг",
#    "mehamozg",
#    "сверло из болта",
#    "как сделать сверло",
#    "сверло своими руками",
#    "сверло в домашних условиях"
#  ],

#TODO exctract comments + videoId to it 
# remove field "like_count"(compute it)  , "is_favorited" (myLike)
#    {
#      "id": "Ugzs8VWxDs_ytloVmiN4AaABAg.9gPqxK5h3r99gQyw5y4dDu",
#      "text": "Прошу прощения за долгое отсутствие. Новое видео выйдет совсем скоро.",
#      "timestamp": 1664150400,
#      "time_text": "6 days ago",
#      "like_count": 1,
#      "is_favorited": false,
#      "author": "Mehamozg",
#      "author_id": "UCbBpOkDpWLcSossZkDIfeSA",
#      "author_thumbnail": "https://yt3.ggpht.com/ytc/AMLnZu_wWzX3-GobQqdFRSJKK5uT7V2NT9UxaMNMNurG=s176-c-k-c0x00ffffff-no-rj",
#      "author_is_uploader": true,
#      "parent": "Ugzs8VWxDs_ytloVmiN4AaABAg"
#    },
#    {
#      "id": "Ugz6apSt7SCbKg35kUN4AaABAg",
#      "text": "идея класс, супер. Но про отсутствие сверла у человека, у которого есть токарный станок - НЕ ВЕРЮ.",
#      "timestamp": 1663632000,
#      "time_text": "12 days ago",
#      "like_count": 0,
#      "is_favorited": false,
#      "author": "Костянтин Муніч",
#      "author_id": "UCvbHBv6f995iJ-A3C5pA_ZQ",
#      "author_thumbnail": "https://yt3.ggpht.com/ytc/AMLnZu989PutZbaaXMTOBPcpprkPgz7eNt46i0zMnhA_yA=s176-c-k-c0x00ffffff-no-rj",
#      "author_is_uploader": false,
#      "parent": "root"
#    },



#### PARAMS 
url=$1

### INIT
here=$(pwd)
#
#replaceTmp='/'
replaceTmp='/media/mp/ac22fd5c-3daf-4f5a-a4bf-65b346984f64/BACKUP/KORNI-DATA/TMP'

# OK - helper
jOff='PRAGMA journal_mode=off; PRAGMA synchronous=normal;'
disableJournal(){
	sqlite3 `korni3 db yt` "PRAGMA journal_mode=off"
	sqlite3 `korni3 db yt` "PRAGMA synchronous=normal"
	sqlite3 `korni3 db yt` "show"
}
#disableJournal
#exit


# OK - helper
# more than 1GB - ok,   less -fail
isSpaceAvailable(){
	dbName=$1
	
	#dir_path="/tmp"
	free_space=$(df -k --output=avail $(korni3 db $dbName 2>/dev/null) | tail -1)
	if [ "${free_space}" -lt $((1*1024*1024)) ]; then
		echo "free_space It is less than 1GB."
		return 1
	else
		echo "free_space It is more than 1GB."
		return 0
	fi
}
#isSpaceAvailable yt && echo 'ok' && exit || {echo fail; exit 1}


# OK - helper
goToTmp() {
	tmp_dir=$(mktemp -d -p $replaceTmp -t yt-korni-XXXXXXXXXX)
	cd $tmp_dir
	echo $tmp_dir
}
#goToTmp 
#pwd
# working
#cd $here
#exit 

# OK
# в папке найти все webp и сконвертировать
convertWebpToPng() {
	# https://stackoverflow.com/questions/55161334/convert-webp-images-to-png-by-linux-command#55258068	
	
	# convert webp to png with H=256 aspect ratio
	## --dry-run
	find . -name "*.webp" -print0 | parallel -0 dwebp -scale 0 256 {} -o {.}.png
}


# helper
ytId() {
	filePath=$1
	#echo fp=$filePath; pwd; ls -lF
	
	exp='\[(.*)\]\.'
	id=$( [[ $filePath =~ $exp ]] ; echo ${BASH_REMATCH[1]}; )
	echo $id
}
thumbId() {
	filePath=$1
	
	exp='/(.*)/'
	id=$( [[ $filePath =~ $exp ]] ; echo ${BASH_REMATCH[1]}; )
	echo $id
}

# OK
# save one thumb by path to korni
savePlThumbs() {
	file=$1
	
	id=$(thumbId "$file")
	#echo $id
	info=$(file $file)
	#echo $info
	exp='([0-9])+ x ([0-9]+)'
	[[ $info =~ $exp ]];
	w=${BASH_REMATCH[1]}
	h=${BASH_REMATCH[2]}
	
	
	file2=`pwd`/$id/thumb--VID--$id--S--${w}x${h}.png
	mv -f $file $file2 # TODO mv
	
	fileId=$( korni3 file yt "$file2"     3>&1 1>/dev/null 2>&3-   | awk '{print $1}')
	korni3 insert yt thumbinal "{\"id\":\"$id\",  \"w\":$w,  \"h\":$h,  \"fileId\":\"$fileId\" }"  --ignore 
	
	# clean 
	echo 1> $file
	echo 1> $file2
	rm -rf ./$id
}
#cd '/tmp/yt-korni-ngb1IIRHe5/'
#savePlThumbs "./c5yijpv_TxA/maxresdefault.png"
##               c5yijpv_TxA
#exit

# save thumbnails from playlist on directories with video id
collectPlThumbs() {
	# playlist url
	plUrl=$1
	
	goToTmp
	pwd #TODO remove
	
	# --playlist-start 250
	yt-dlp -i  --no-warnings --get-thumbnail $plUrl | \
		wget --no-check-certificate -x -nH --cut-dirs 1 -i -
		
	convertWebpToPng
	
	
		# table=thumbinal
		# {"vId": <videoId>, w: <width>, h: <height>, }
		
}
#collectPlThumb https://www.youtube.com/c/Mehamozg/videos
#exit


collectSubs() {
	url=$1
	
	yt-dlp --skip-download   --write-subs --sub-langs all      $url
}

# OK TODO test after hash redesign
# save ONE sub file to korni
saveSubs() {
	
	find -size +32c -type f | grep '\.vtt$' | xargs -I {} bash -c '
		file="{}"
		#echo $file
		id=$( exp="\[(.*)\]\.";     [[ $file =~ $exp ]] ;     echo ${BASH_REMATCH[1]}; ) # ytId replace
		exp="\]\.(\w+)\.vtt"
		[[ $file =~ $exp ]];
		lang=${BASH_REMATCH[1]}
		#echo $lang
		
		#korni3 file yt "$file"  --ignore --empty    | jq -rc ".id"
		fileId=$( korni3 file yt "$file"  --ignore  2>/dev/null  | jq -rc ".id")
		#echo len ${#fileId}   $fileId
		if [ ${#fileId} == 199 ]; then
			#echo $fileId
			# TODO --ignore 
			korni3 insert yt subtitlesFiles "{\"id\":\"VID--$id--LANG--$lang\",  \"lang\":\"$lang\", \"video\":\"$id\",  \"fileId\":\"$fileId\" }" --ignore
		fi   
		# file handled in any case
		echo $lang	$file
		echo 10000 >"$file"
	'
	
	return 
}
#cd /media/mp/ac22fd5c-3daf-4f5a-a4bf-65b346984f64/BACKUP/KORNI-DATA/yt-korni-WfoAvg6ooB
#time saveSubs
#exit


# generate and save template function
downloadSubs() {
	url=$1
	
	# outfiles	
		# SAVE.pid 
		# SAVE.log
		# GEN.pid
		# GEN.log
		# RESULT // "OK" or not exists

	
	save() {
		echo once=$#
		
		while true ; do
			saveSubs
			if [ ! $# -eq 0  ]; then
				break
			fi
			echo SLEEP 20 sec - wait new files
			sleep 20
		done
		return 0
	}

	generate() {
		collectSubs $url
	}

	save >SAVE.log &
	pid=$!
	echo $pid > SAVE.pid 
	
	generate >GEN.log &
	genPid=$!
	echo $genpid >GEN.pid
	wait $genPid
	
	kill $pid
	echo last scan and save ... >>SAVE.log
	save 1 >>SAVE.log
	echo OK > RESULT
	exit
}
#cd /media/mp/ac22fd5c-3daf-4f5a-a4bf-65b346984f64/BACKUP/KORNI-DATA/yt-korni-WfoAvg6ooB
#downloadSubs https://www.youtube.com/c/Mehamozg/videos
#exit 



collectComments() {
	url=$1
	
	yt-dlp --skip-download   --write-info-json  --write-comments     $url
}

saveComments() {
	# Не самый простой навесной замок. Чертежи. [SgmJZ8AgGog].info.json	
	find -size +32c -type f | grep '\.info\.json$' |  head -n 1 | xargs -I {} bash -cx '
		file="{}"
		echo `date +"%Y-%m-%d %T"`  $file .....
		id=$( exp="\[(.*)\]\.";     [[ $file =~ $exp ]] ;     echo ${BASH_REMATCH[1]}; ) # ytId replace
		
		jq -c -r ".comments[]" <"$file"    |     jq -c -r ". +={\"video\": \"$id\"}"   |    korni3 insert yt comments --ignore --skip-db-update
		
		jq -c -r "{\"id\":\"$id\", \"video\":\"$id\", tag:.tags[]}" <"$file"  | korni3 insert yt tags --ignore --skip-db-update
		jq -c -r "{\"id\":\"$id\", \"video\":\"$id\", category:.categories[]}" <"$file" | korni3 insert yt categories --ignore --skip-db-update
		
		echo `date +"%Y-%m-%d %T"`  $file saves
		#echo 10000 >"$file"
	'
	
	return 	
}
# запускать поле сбора videos потому что эта функция дополняет  информацию о видео..
# TODO test 
downloadComments() {
	url=$1
	
	# outfiles	
		# SAVE.pid 
		# SAVE.log
		# GEN.pid
		# GEN.log
		# RESULT // "OK" or not exists

	
	save() {
		echo once=$#
		
		while true ; do
			saveComments
			if [ ! $# -eq 0  ]; then
				break
			fi
			echo SLEEP 20 sec - wait new files
			sleep 20
		done
		return 0
	}

	generate() {
		collectComments $url
	}

	save 						>SAVE.log &
	pid=$!
	echo $pid 					>SAVE.pid 
	
	generate 					>GEN.log &
	genPid=$!
	echo $genpid 				>GEN.pid
	wait $genPid
	
	kill $pid
	echo last scan and save ... >>SAVE.log
	save once					>>SAVE.log
	korni3 repack yt comments 	>>SAVE.log
	korni3 scan yt comments 	>>SAVE.log
	echo OK 					> RESULT
	exit	
}
#cd /media/mp/ac22fd5c-3daf-4f5a-a4bf-65b346984f64/BACKUP/KORNI-DATA/yt-korni-WfoAvg6ooB
#downloadComments https://www.youtube.com/c/Mehamozg/videos
#exit





# OK
# save bu url (one video |   playlist )
#TODO option "comments" скачивать комментарии "в фоне"
collectYTVideos() {
	url=$1
	
	## save playlist's image
	#imgUrl=$(yt-dlp -i --no-warnings --get-thumbnail $url)
	#echo $imgUrl
	#wget --no-check-certificate -O image1 $imgUrl

	# TODO создать "файлы - пустышки" перед загрузкой по плейлисту , чтобы лишнее не качать снова
	yt-dlp  -ci -f 18    $url
}
#collectYTVideos https://www.youtube.com/c/Mehamozg/videos
#exit

saveMp4() {
	# TODO empty size || --rm ||  --empty-size
	count=$(find -size +32c -type f | grep '\.mp4$' | wc -l)
	find -size +32c -type f | grep '\.mp4$' | sed -s "s/'/\\\\\'/g" | xargs -I {} bash -c '
		isSpaceAvailable(){
			dbName=$1
			
			#dir_path="/tmp"
			free_space=$(df -k --output=avail $(korni3 db $dbName 2>/dev/null) | tail -1)
			if [ "${free_space}" -lt $((1*1024*1024)) ]; then
				echo "free_space It is less than 1GB."
				return 1
			else
				echo "free_space It is more than 1GB."
				return 0
			fi
		}

		isSpaceAvailable yt >/dev/null
		if [ $? == 0 ] ; then
			filePath="{}"
			id=$( exp="\[(.*)\]\.";     [[ $filePath =~ $exp ]] ;     echo ${BASH_REMATCH[1]}; )

			# TODO --empty 
			# echo $filePath | korni3 file yt  --ignore | cat -n 
			fileid=$( echo $filePath | korni3 file yt  --ignore --empty   | jq -rc ".id"  ) 
			echo fileid $fileid

			if [ ${#fileid} == 199  ]; then
				korni3 insert yt videoFiles  "{\"id\":\"$id-$fileid\",  \"video\":\"$id\",   \"fileId\":\"$fileid\" }" --ignore
				echo video $id  saved  path $filePath
			fi 
			

		else
			echo no free space; exit 1; 
		fi 
		'
	return $count
}
#cd /media/mp/ac22fd5c-3daf-4f5a-a4bf-65b346984f64/BACKUP/KORNI-DATA/yt-korni-WfoAvg6ooB
#echo saveMp4
#saveMp4
#exit
# OK
downloadVideos() {
	url=$1
	
	save() {
		#echo once=$#

		while true ; do
			saveMp4
			if [ ! $# -eq 0  ]; then
				break
			fi
			sleep 10
		done
		return 0
	}

	generate() {
		collectYTVideos $url
	}

	save >SAVE.log &
	pid=$!
	echo $pid > SAVE.pid 
	
	generate >GEN.log &
	genPid=$!
	echo $genpid >GEN.pid
	wait $genPid
	
	kill $pid
	echo last scan and save ... >>SAVE.log
	save 1 >>SAVE.log
	echo OK > RESULT
	exit	

}
cd /media/mp/ac22fd5c-3daf-4f5a-a4bf-65b346984f64/BACKUP/KORNI-DATA/yt-korni-WfoAvg6ooB
downloadVideos https://www.youtube.com/c/Mehamozg/videos
exit 




# OK
collectPlInfo() {
	url=$1
	
	yt-dlp -j --flat-playlist  $url > playlist1.json    & 
	yt-dlp -j --flat-playlist $url | gzip --best > playlist.log.gz    	&
	wait
	
	plId=$(cat playlist1.json | jq -r "[.playlist_id] | @csv" | head -n 1 | sed -s 's/"//g')
	plName=$(cat playlist1.json | jq -r "[.playlist] | @csv" | head -n 1 | sed -s 's/"//g')
	echo $plId > plId.txt
	echo $plName > plName.txt
	echo 1/4 OK playlist1.json
	#  add playlist id $plId	
	cat playlist1.json | jq -c ".+= {\"pl_id\":\"$plId\"}" >  playlist2.json      &&     rm -f playlist1.json
	echo 2/4 OK playlist2.json

	cat playlist2.json | jq -rc "[.pl_id,.id,.title,.description,.duration,.view_count,.upload_date,.filename,.epoch] | @csv"	> videos.csv
	cat playlist2.json | jq -rc "[.pl_id,.id,.title,.description,.duration,.view_count,.upload_date,.filename,.epoch] | @json"	> videos.json
	echo 3/4 OK videos.json
	# select columns
	cat playlist2.json | jq -rc " . | {id,title,description,duration,view_count,uploader,thumbnails,upload_date,release_timestamp,playlist,filename,epoch} " > videos3.json
	echo 4/4 OK videos3.json
	
	#TODO upload to korni:
		# playlist1.json   DEPRECATED
		# playlist.log.gz  for history 
		# playlist2.json   need  for record   videos
		# videos.csv 
		# ? videos.json    this videos ? 

}
#goToTmp; pwd;
#collectPlInfo https://www.youtube.com/c/Mehamozg/videos
#exit
# OK проверено. дубликатов не плодит
# TODO опции: скачать только метаинформацию, 
# TODO + превью большое в большом качестве + превью разного размера 
savePlInfo() {
	DB=yt

	plName=$(cat plName.txt)
	plId=$(cat plId.txt)

	# создаём запись, что этот плейлист имеет такое - то имя
	korni3 insert $DB playlists "{\"id\":\"$plId\", \"name\":\"$plId\", \"type\":\"youtube\"}" --ignore
	
	# just upload video.json to korni
	cat videos3.json | korni3 insert $DB       videos  --ignore --skip-db-update
	#                                ^dbName    ^ table
	echo OK videos table changes are created
	
	# TODO сначала надо дораоботать, чтобы система работала только если места на диске больше 1ГБ
	isSpaceAvailable yt && { 
		# упаковать 
		# korni3 repack yt videos
		# просканировать все в контейнере со "вчера"
		echo start scan for db update ...
		korni3 scan yt --date $(date --date="yesterday" +"%Y-%m-%d"|sed -s "s/-0/-/")
		echo scan completed
	}
}
downloadPlInfo() {
	url=$1
	# outfiles	
		# SAVE.pid 
		# SAVE.log
		# GEN.pid
		# GEN.log
		# RESULT // "OK" or not exists

	collectPlInfo $url 	> GEN.log
	savePlInfo 			> SAVE.log
	echo OK 			> RESULT
}
#cd /media/mp/ac22fd5c-3daf-4f5a-a4bf-65b346984f64/BACKUP/KORNI-DATA/yt-korni-WfoAvg6ooB
#downloadPlInfo https://www.youtube.com/c/Mehamozg/videos
#exit



# generate and save template function
test2() {
	# outfiles	
		# SAVE.pid 
		# SAVE.log
		# GEN.pid
		# GEN.log
		# RESULT // "OK" or not exists

	
	save() {
		echo once=$#
		
		# helper
		ytId() {
			filePath=$1
			
			exp='\[(.*)\]\.'
			id=$( [[ $filePath =~ $exp ]] ; echo ${BASH_REMATCH[1]}; )
			echo $id
		}		
			
		while true ; do
			echo SAVE
			sleep 1
			if [ ! $# -eq 0  ]; then
				break
			fi
		done
		return 0
	}

	generate() {
		echo g start
		sleep 10
		echo g end
	}

	save >SAVE.log &
	pid=$!
	echo $pid > SAVE.pid 
	
	generate >GEN.log &
	genPid=$!
	echo $genpid >GEN.pid
	wait $genPid
	
	kill $pid
	echo last scan and save ...
	save 1
	echo OK > RESULT
	exit
}
#test2







exit 
ХРЕНЬ - не работает , глюки с экранированием символов в именах файлов

	cd /media/mp/ac22fd5c-3daf-4f5a-a4bf-65b346984f64/BACKUP/KORNI-DATA/yt-korni-WfoAvg6ooB/
	#ls *.mp4 | head -n 3 | xargs -I {} ytId {}  #bash -c 's="{}"; echo $s; [[ $s =~ $exp ]] ; echo ${BASH_REMATCH[1]};  '
	for file in ` find -type f | grep mp4 | head -n 3 | awk '{print "\"" $0 "\""; }' ` ; do 
		echo $file
	done







# выбор по видео всех комментариев
select id,max(zT) as zT, text 
	from (select id,zT,text from comments where video='O2G9vaUmTVc' and parent='root' ORDER by zT desc)
	group by id
	order by zT DESC





  DropArea {
        anchors.fill: parent
        onDropped: {
            console.log(drop.text);
        }
    }
    
    
import QtQuick.Window 2.2
import QtQuick 2.2
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.0

ApplicationWindow {
    id: rootId
    visible: true
    title: "Drag Drop MRE"
    property int margin: 16
    minimumWidth: 600
    minimumHeight: 480

   FileDialog {
        id: fileDialog
        title: "Choose File Attachment"
        folder: shortcuts.home    
