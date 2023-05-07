#!/usr/bin/python3
import sys
#import json
import orjson
#import ujson
import subprocess
import sqlite3
p = print
def ep(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)
    
    
playlistId=sys.argv[1]

r = subprocess.run(["korni3", "db", "yt"], capture_output=True)
path = r.stdout.decode('utf-8').strip()

con = sqlite3.connect(path)
cur = con.cursor()

result = []
#res = cur.execute("select id, title,description,duration,view_count,uploader,thumbnails,upload_date,playlist,filename,epoch"
#					" from videos where playlist=? ", (playlistName,))
res=cur.execute('select "yt-videos"."id","yt-videos"."zT","yt-videos"."title","yt-videos"."description","yt-videos"."duration","yt-videos"."view_count",'+
		'"yt-videos"."uploader","yt-videos"."upload_date","yt-videos"."release_timestamp",'+
		'"yt-videos"."playlist","yt-videos"."epoch","yt-videos"."zU"'+
	'FROM "yt-videos" '+
	'INNER JOIN "yt-link-playlist-video" on "yt-link-playlist-video"."videoId" = "yt-videos"."id"'+
	'WHERE "yt-link-playlist-video"."playlistId"=? '+
	'order by random() ' , (playlistId,))
					
def getFileId(videoId):
	cur2 = con.cursor()
	cur2.execute("select fileId from 'yt-videoFiles' where video=?;", (videoId,))
	result = cur2.fetchone()
	return result[0] if result else ''

def getThumbinalFileId(videoId):
	cur2 = con.cursor()
	cur2.execute('SELECT "yt-thumbinal"."fileId" FROM "yt-thumbinal" WHERE "id"=?', (videoId,))
	result = cur2.fetchone()
	return result[0] if result else ''
		
	
for r in res.fetchall(): 
	thid=getThumbinalFileId(r[0])
	pr = subprocess.run(["korni3", "fhtp", "yt", thid], capture_output=True)
	thpath = pr.stdout.decode('utf-8').strip()

#	fid = getFileId(r[0])

	item = {
		"id": r[0], 
		"zT": r[1],
		"imagePreviewSource": thpath,
		
#		"videoFileId": fid,
		
		"name": r[2],
		
		"description": r[3], 
		"duration": r[4], 
		"viewCount": r[5], 
		
#		"uploader": r[6], 
		"channelName": r[6],
		
#		"upload_date": r[7], 
		"whenLoaded" : r[7],
		"release_timestamp": r[8],
		
		"playlist": r[9], 
#		"filename": r[9], 
		"epoch": r[10], 
		"zU": r[11],
	}
	result.append(item)
#p(len(json.dumps(r).encode('utf-8')))  	# 312668
#p(len(orjson.dumps(r)))					# 275399
#p(len(ujson.dumps(r)))						# 316529
p(orjson.dumps(result).decode('utf-8')) # 


#SELECT LAST (by zT) RECORD with id
#
#SELECT a.* FROM [files] a INNER JOIN ( 
#	SELECT id, MAX(zT) zT FROM [files]  GROUP BY id 
#) b ON a.id = b.id AND a.zT = b.zT WHERE a.id='GFS-QmRFbRMEMWUkpecPCRSQ2tqJ5QqCjotfrgq8jY9VCisdcK-S1-61168520e19219ddc26b167e792f068c6990b405-M-1d9c7435fa3a55ad8f91fbb67fb57bb7-S256-63c3bbc6c70486259d1fe2b679e69c5f108f56702a003ac3ffee5a47c3480c90'; 
