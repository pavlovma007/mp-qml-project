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
#replaceTmp='/media/mp/ac22fd5c-3daf-4f5a-a4bf-65b346984f64/BACKUP/KORNI-DATA/TMP'
replaceTmp='/tmp'

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
	echo tmpdir = $tmp_dir
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
# save thumbnails from playlist on directories with video id
collectPlThumbs() {
	# playlist url
	plUrl=$1
	
	# --playlist-start 250
	yt-dlp -i  --no-warnings --get-thumbnail $plUrl | \
		wget --no-check-certificate -x -nH --cut-dirs 1 -i -
		
	convertWebpToPng
	
}
saveThumbs() {

	isSpaceAvailable yt && find . | grep '\/.*\/' |  xargs -I {} file "{}" | \
		grep 'image data' | awk -F ':' '{print $1}'  | xargs -I {} bash -c '
		thumbId() {
			filePath=$1
			
			exp="/(.*)/"
			id=$( [[ $filePath =~ $exp ]] ; echo ${BASH_REMATCH[1]}; )
			echo $id
		}		
		
		file={}
		#echo "$file"
		fileId=$( echo $file | korni3 file yt --ignore  2>/dev/null | jq -c -r .id )
		
		id=$(thumbId "$file")
		
		#info=$(file $file)
		#exp="([0-9])* x ([0-9]*)"
		#[[ $info =~ $exp ]];
		#w=${BASH_REMATCH[1]}
		#h=${BASH_REMATCH[2]}
		#echo w,h = $w $h #    \"w\":$w,  \"h\":$h,
		
		korni3 insert yt "yt-thumbinal" "{\"id\":\"$id\",    \"fileId\":\"$fileId\" }" --ignore 
'
		return 
}
downloadThumbs() {
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
			saveThumbs
			if [ ! $# -eq 0  ]; then
				break
			fi
			echo SLEEP 20 sec - wait new files
			sleep 20
		done
		return 0
	}

	generate() {
		collectPlThumbs $url
	}

	save >SAVE.log &
	pid=$!
	echo $pid > SAVE.pid 
	
	generate >GEN.log &
	#echo 123
	
	genPid=$!
	echo $genpid >GEN.pid
	wait $genPid
	
	kill $pid
	echo last scan and save ... >>SAVE.log
	save 1 >>SAVE.log
	echo OK > RESULT
}



collectSubs() {
	url=$1
	
	yt-dlp --skip-download   --write-subs --sub-langs all      $url
}
# tables: yt-subtitlesFiles
saveSubs() {
	
	isSpaceAvailable yt && find -size +32c -type f | grep '\.vtt$' | \
		xargs -I {}  python3 -c "
#-*- coding: utf-8 -*-
import json, sys, re, subprocess, os

#pspace=subprocess.run(['df -k --output=avail $(korni3 db yt  2>/dev/null) | tail -1' ], shell=True, capture_output=True)
#sizeSpace=int(pspace.stdout.decode())
if False: #1*1024*1024 > sizeSpace:
	print('ERROR no space in disk ')
	exit(1)
else: 

	filePath = sys.argv[1] # .decode('utf-8')
	
	def FAIL():
		exit(2)
	def SUCCESS():
		# trancate size - handled
		#fp = open(filePath, 'w')
		#fp.truncate(0)
		#fp.close()
		try:
			os.rename(filePath, filePath+'-HANDLED')
		except FileNotFoundError:
			pass	
	
	#filePath=input(); #filePath=filePath.strip();
	#filePath=sys.stdin.readline()
	#filePath=sys.stdin.readline()
	
	#print('filePath=', filePath)

	# video id
	try:
		id=re.search('\[(.+)\]\..+\.vtt', filePath).group(1)
		# lang 
		lang = re.search('\[.+\]\.(.+)\.vtt', filePath).group(1)
		print('handle subs video', id, ' lang=', lang, ' ...')
	except AttributeError:
		print('ERROR extract ID LANG from file=', filePath)
		FAIL()

	p=subprocess.run(['korni3', 'file' , 'yt', '--ignore', '--empty'], input=filePath.encode('utf-8'), capture_output=True)
	obj = json.loads(p.stdout.decode())
	fileId=obj['id']
	if len(fileId)==199:
		vfobj={
			'id': id+'---'+lang,
			'video': id, 
			'lang': lang, 
			'fileId': fileId
		}
		p2=subprocess.run(['korni3', 'insert', 'yt', 'yt-subtitlesFiles', '--ignore'], 
			input=json.dumps(vfobj).encode('utf-8'), capture_output=True)	
		print('SUCCESS subtitles video=', id, ' lang=', lang)
				
		SUCCESS()
		exit(0)
	else:
		print('FAIL    subtitles video=', id, ' lang=', lang, p2.stdout.decode() )
		FAIL()
		exit(1)
" "{}"
	
	
	
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
# + tables: yt-comments  yt-tags   yt-categories
saveComments() {
	# Не самый простой навесной замок. Чертежи. [SgmJZ8AgGog].info.json	
	
	isSpaceAvailable yt && find -size +32c -type f | grep -v  'HANDLED$'| grep '\.info\.json$' \
		 | xargs -I {} python3 -c "
#-*- coding: utf-8 -*-
import json, sys, re, subprocess, os


#pspace=subprocess.run(['df -k --output=avail $(korni3 db yt  2>/dev/null) | tail -1' ], shell=True, capture_output=True)
#sizeSpace=int(pspace.stdout.decode())
#if 1*1024*1024 > sizeSpace:
if False:
	print('ERROR no space in disk ')
	exit(1)
else: 

	filePath = sys.argv[1] # .decode('utf-8')
	
	def FAIL():
		exit(2)
		
	def SUCCESS():
		# trancate size - handled
		#fp = open(filePath, 'w')
		#fp.truncate(0)
		#fp.close()
		try:
			os.rename(filePath, filePath+'-HANDLED')
		except FileNotFoundError:
			pass
		
	#filePath=input(); #filePath=filePath.strip();
	#filePath=sys.stdin.readline()
	#filePath=sys.stdin.readline()
	
	print('filePath=', filePath)

	# video id
	id=re.search('\[(.*)\]\.', filePath).group(1)
	print('id=', id)

	isFail = False
	
	with open(filePath, 'rb') as fp:
		obj=json.load(fp)
		fp.close()
		
	comments = obj['comments'] if 'comments' in obj else []
	if len(comments):
		inputstream='';
		for c in comments:
			c['video'] = id
			del c['time_text']
			inputstream += json.dumps(c) + '\n'
		#print(json.dumps(comments))
		#print(inputstream)

		pc=subprocess.run(['korni3', 'insert', 'yt', 'yt-comments', '--ignore'],  
				input=inputstream.encode('utf-8'), capture_output=True) #input=json.dumps(comments).encode('utf-8')
		if pc.returncode==0:
			print('SUCCESS comments video=', id)
			#SUCCESS()
		else: 
			print('FAIL    comments video=', id, pc)
			isFail = True
			#FAIL()
		
	tags=obj['tags'] if 'tags' in obj else []
	if len(tags):
		#print(tags)
		#inputstream=''
		tags = [t.replace('\'', '').replace('\"', '')   for t in tags ]
		#for t in tags: 
			#inputstream += json.dumps(t) + '\n'
		#print('inputstream', inputstream)
		obj={ 'id':id, 'tags': tags}
		pc=subprocess.run(['korni3', 'insert', 'yt', 'yt-tags', '--ignore'],
				input=json.dumps(obj).encode('utf-8'), capture_output=True) #
		if pc.returncode==0:
			print('SUCCESS tags tags=', id)
			#SUCCESS()
		else: 
			print('FAIL    tags tags=', id, pc)
			isFail = True
			#FAIL()
	
	categories=obj['categories'] if 'categories' in obj else []
	if len(categories):
		#print(categories)
		#inputstream=''
		categories = [t.replace('\'', '').replace('\"', '')   for t in categories ]
		#for t in tags: 
			#inputstream += json.dumps(t) + '\n'
		#print('inputstream', inputstream)
		obj={ 'id':id, 'categories': categories}
		pc=subprocess.run(['korni3', 'insert', 'yt', 'yt-categories', '--ignore'],
				input=json.dumps(obj).encode('utf-8'), capture_output=True) #
		if pc.returncode==0:
			print('SUCCESS tags categories=', id)
			#SUCCESS()
		else: 
			print('FAIL    tags categories=', id, pc)
			isFail = True
			#FAIL()
	
	if isFail: 
		FAIL()
	else:
		SUCCESS()
	
	exit(0)

" "{}"
	
	
	return 
}
# запускать поле сбора videos потому что эта функция дополняет  информацию о видео..
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
	
	#TODO
	generate 					>GEN.log &
	#ls *.info.json
	
	genPid=$!
	echo $genpid 				>GEN.pid
	wait $genPid
	
	kill $pid
	echo last scan and save ... >>SAVE.log
	save once					>>SAVE.log
	#korni3 repack yt comments 	>>SAVE.log
	#korni3 scan yt comments 	>>SAVE.log
	echo OK 					> RESULT
	exit	
}
#cd /media/mp/ac22fd5c-3daf-4f5a-a4bf-65b346984f64/BACKUP/KORNI-DATA/yt-korni-WfoAvg6ooB
#downloadComments https://www.youtube.com/c/Mehamozg/videos
#exit



makeLinkVideoToPlaylist() {
	plid=$1
	(python3 -c  '
import json, sys, subprocess
plid=sys.argv[1]

def makeLink(plid, vid):
	r = {
		"id": plid+"---"+vid, 
		"videoId": vid,
		"playlistId": plid
	}
	s = json.dumps(r)
	r = subprocess.run(["korni3", "insert", "yt", "yt-link-playlist-video", s, "--ignore"])
	#print(r)
	
#print(plid)
try:
	for line in sys.stdin: 
		if not bool(line):
			#print("BREAK",line)
			break
		line.strip()
		o = json.loads(line.strip())
		#print(o["id"])
		makeLink(plid, o["id"])
except BrokenPipeError:
	#print("BrokenPipeError")
	pass
'  $plid)
}
#makeLinkVideoToPlaylist 123
#exit 

# OK
# videos3.json  as objects {}
# videos.json   as lists [...]
collectPlInfo() {
	url=$1
	
	yt-dlp -j --flat-playlist  $url > playlist1.json    & 
	#yt-dlp -j --flat-playlist  $url | gzip --best > playlist.log.gz    	&
	wait
	
	plId=$(cat playlist1.json | jq -r "[.playlist_id] | @csv" | head -n 1 | sed -s 's/"//g')
	plName=$(cat playlist1.json | jq -r "[.playlist] | @csv" | head -n 1 | sed -s 's/"//g')
	echo $plId > plId.txt
	echo $plName > plName.txt
	echo '1/4 OK playlist1.json'
	#  add playlist id $plId	
	cat playlist1.json | jq -c ".+= {\"pl_id\":\"$plId\"}" >  playlist2.json      &&     rm -f playlist1.json
	echo '2/4 OK playlist2.json'

	cat playlist2.json | jq -rc "[.pl_id,.id,.title,.description,.duration,.view_count,.upload_date,.filename,.epoch] | @csv"	> videos.csv
	cat playlist2.json | jq -rc "[.pl_id,.id,.title,.description,.duration,.view_count,.upload_date,.filename,.epoch] | @json"	> videos.json
	echo '3/4 OK videos.json'
	# select columns
	cat playlist2.json | jq -rc " . | {id,title,description,duration,view_count,uploader,thumbnails,upload_date,release_timestamp,playlist,filename,epoch} " > videos3.json
	echo '4/4 OK videos3.json'
	
	#TODO upload to korni:
		# playlist1.json   DEPRECATED
		# playlist.log.gz  for history 
		# playlist2.json   need  for record   videos
		# videos.csv 
		# ? videos.json    this videos ? 

}
# OK TODO add url to yt-playlists
# TODO type not only youtube
savePlInfo() {
	url=$1
	DB=yt

	plName=$(cat plName.txt)
	plId=$(cat plId.txt)
	plUploader=$(cat playlist2.json | head -n 1 | jq -rc '.playlist_uploader')

	if [[ ! -z "$plName" ]]; then
		# PLAYLIST
		# создаём запись, что этот плейлист имеет такое - то имя
		korni3 insert $DB yt-playlists "{\"id\":\"$plId\", \"name\":\"$plName\", \"type\":\"youtube\",  \"url\": \"$url\", \"uploader\": \"$plUploader\"  }"  --ignore
		# just upload video.json to korni
		cat videos3.json | korni3 insert $DB       yt-videos  --ignore # --skip-db-update
		#                                ^dbName    ^ table
		echo 'OK videos table changes are created'
		cat videos3.json | makeLinkVideoToPlaylist "$plId"
	else 
		cat videos3.json | korni3 insert $DB       yt-videos  --ignore # --skip-db-update
		#                                ^dbName    ^ table
	fi
	return 

	
	## TODO сначала надо дораоботать, чтобы система работала только если места на диске больше 1ГБ
	#isSpaceAvailable yt && { 
	#	# упаковать 
	#	# korni3 repack yt videos
	#	# просканировать все в контейнере со "вчера"
	#	echo 'start scan for db update ...'
	#	korni3 scan yt --date $(date --date="yesterday" +"%Y-%m-%d"|sed -s "s/-0/-/")
	#	echo 'scan completed'
	#}
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
	savePlInfo 	$url	> SAVE.log
	echo OK 			> RESULT
}
#cd /media/mp/ac22fd5c-3daf-4f5a-a4bf-65b346984f64/BACKUP/KORNI-DATA/yt-korni-WfoAvg6ooB
#downloadPlInfo https://www.youtube.com/c/Mehamozg/videos
#exit





# OK
# save bu url (one video |   playlist )
#TODO option "comments" скачивать комментарии "в фоне"
collectYTVideos() {
	url=$1
	collectPlInfo "$url"
	plId=$(cat plId.txt)
	
	## save playlist's image
	#imgUrl=$(yt-dlp -i --no-warnings --get-thumbnail $url)
	#echo $imgUrl
	#wget --no-check-certificate -O image1 $imgUrl

	# TODO создать "файлы - пустышки" перед загрузкой по плейлисту , чтобы лишнее не качать снова
	echo plid=$plId
	
	( (sqlite3 `korni3 db yt` <<EEE 
select files.path from "yt-playlists"
	inner join "yt-link-playlist-video" on playlistId="yt-playlists".id
	inner join "yt-videos"  on "yt-link-playlist-video"."videoId"="yt-videos".id
	inner join "yt-videoFiles" on "yt-videoFiles"."video" = "yt-videos".id
	inner join "files" on "yt-videoFiles".fileId = files.id
where "yt-playlists".id='$plId'	
EEE
) | xargs -I {} bash -c 'touch "{}";  ' ) 2>&1

	#while yt-dlp  -ci -f 18    $url   ; do :; done 
	yt-dlp  -ci -f 18    $url   
}
#collectYTVideos https://www.youtube.com/c/Mehamozg/videos
#exit

saveMp4() {
	url=$1
	# TODO empty size || --rm ||  --empty-size
	count=$(find -size +32c -type f | grep '\.mp4$' | wc -l)
	
	find -size +32c -type f | grep '\.mp4$' | sed -s "s/'/\\\\\'/g" | xargs -I {} python3 -c "
#-*- coding: utf-8 -*-
import json, sys, re, subprocess

pspace=subprocess.run(['df -k --output=avail $(korni3 db yt  2>/dev/null) | tail -1' ], shell=True, capture_output=True)
sizeSpace=int(pspace.stdout.decode())
if 1*1024*1024 > sizeSpace:
	print('ERROR no space in disk ')
	exit(1)
else: 

	filePath = sys.argv[1] # .decode('utf-8')
	
	#filePath=input(); #filePath=filePath.strip();
	#filePath=sys.stdin.readline()
	#filePath=sys.stdin.readline()
	
	#print('filePath=', filePath)

	# video id
	try:
		# pattern 1
		id=re.search('\[([^\[\]]*?)\]\.mp4$', filePath).group(1)
	except AttributeError:
		try : 
			# pattern 2
			id=re.search('-(.*)\.mp4$', filePath).group(1) # ..Любви-yCO40Ck78hY.mp4
		except AttributeError:
			print('Error detect video-ID in path=', filePath)
			exit(1)

	p=subprocess.run(['korni3', 'file' , 'yt', '--ignore', '--lns'], input=filePath.encode('utf-8'), capture_output=True)
	obj = json.loads(p.stdout.decode())
	if p.returncode != 0 : 
		print('ERROR korni3 file: ', p.stdout, p.stderr)
	fileId=obj['id']
	if len(fileId)==199:
		vfobj={
			'id': id+'---'+fileId,
			'video': id, 
			'fileId': fileId
		}
		p2=subprocess.run(['korni3', 'insert', 'yt', 'yt-videoFiles', '--ignore'], 
			input=json.dumps(vfobj).encode('utf-8'), capture_output=True)	
		print('SUCCESS video=', id, ' fileid=',fileId)
		exit(0)
	else:
		print('ERROR fileId for file=', filePath)
		exit(1)
" "{}"
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
			saveMp4 $url
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
	
	untilfail() {
		n=0
		ATEMPTS=2
		$@
		while [ ! $? -eq 0 ]; do
			echo ATEMPT N $n
			$@
			n=$(($n+1))
			if [ $n -eq $ATEMPTS ]; then break; fi
		done
	}
	try() {
		 generate > GEN.log & 
		 genPid=$! 
		 echo $genpid >GEN.pid 
		 wait $genPid
		 e=$?
		 echo status = $e
		 return $e
	}
	untilfail try
	
	kill $pid
	echo last scan and save ... >>SAVE.log
	save 1 >>SAVE.log
	echo OK > RESULT
	#exit	
}
#cd /media/mp/ac22fd5c-3daf-4f5a-a4bf-65b346984f64/BACKUP/KORNI-DATA/yt-korni-WfoAvg6ooB
#downloadVideos https://www.youtube.com/c/Mehamozg/videos
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


#downloadPlInfo https://www.youtube.com/watch?v=7xhRTaiKVsU
#downloadVideos https://www.youtube.com/watch?v=7xhRTaiKVsU
#downloadComments https://www.youtube.com/watch?v=7xhRTaiKVsU
#exit 


playlistsOfChannel() {
	url=$1 # channel 
	text=$(wget -q -S -O - $url   2>&1)
	echo $text | python3 -c "
import re, sys, subprocess

text=sys.stdin.read()
for g in re.findall('\"playlistId\":\"(.+?)\"', text, re.MULTILINE):
	url='https://www.youtube.com/playlist?list='+g
	#print('start download ', url)
	print(url)
	
"
}
#playlistsOfChannel "https://www.youtube.com/@Black_Triangle/playlists"
#exit 0


case $1 in
	plinfo)
		downloadPlInfo $2;; 	# OK
	videos)
		downloadVideos $2;; 	#OK
	comments)
		downloadComments $2;;	#OK
	subs)
		downloadSubs $2;;
	thumbs)
		downloadThumbs $2;;
	playlistsOfChannel)
		channel=$2
		urls=$(playlistsOfChannel "$channel")
		for url in $urls ; do 
			echo $url
			goToTmp
			downloadPlInfo $url
			goToTmp
			downloadVideos $url
			downloadThumbs $url
			#downloadComments $url
		done	
		;;
	all)
		$(downloadPlInfo $2);
		$(downloadVideos $2);
		$(downloadThumbs $2);
		$(downloadComments $2);
		$(downloadSubs $2);;
	*)
	  echo "COMMANDS:";
	  echo "    plinfo    <url>";
	  echo "    videos    <url>";
	  echo "    comments  <url>";
	  echo "    subs      <url>";
	  echo "    thumbs    <url>";
	  echo "    all       <url>";
	  echo "    playlistsOfChannel  <url of page with playlist list>";
esac


exit 0










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


          # /media/mp/KORNI/KORNI-DATA/yt-korni-WfoAvg6ooB/Приспособление для протачивания многогранников [SffBNPlxHjo].mp4
