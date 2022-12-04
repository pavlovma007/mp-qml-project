#!/usr/bin/python3
import sys
import json
import orjson
#import ujson
import subprocess
import sqlite3
p = print
def ep(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)
    
    
videoId=sys.argv[1]

r = subprocess.run(["korni3", "db", "yt"], capture_output=True)
path = r.stdout.decode('utf-8').strip()

con = sqlite3.connect(path)
cur = con.cursor()

result = []
#res = cur.execute("select id, title,description,duration,view_count,uploader,thumbnails,upload_date,playlist,filename,epoch"
#					" from videos where playlist=? ", (playlistName,))
res=cur.execute('select V."id",V."zT",V."title",V."description",V."duration",V."view_count",'+
		'V."uploader",V."upload_date",V."release_timestamp",'+
		'V."playlist",V."epoch",V."zU"  ,   (SELECT "yt-videoFiles"."fileId" FROM "yt-videoFiles" WHERE "yt-videoFiles"."video"=V.id) fileId   '+
	'FROM "yt-videos" V ' + 
	'WHERE "id"=? '+
	'limit 1' , (videoId,))
	
	
					
def getFileId(videoId):
	cur2 = con.cursor()
	cur2.execute("select fileId from 'yt-videoFiles' where video=?;", (videoId,))
	result = cur2.fetchone()
	return result[0] if result else ''

# def getThumbinalFileId(videoId):
	# cur2 = con.cursor()
	# cur2.execute('SELECT "yt-thumbinal"."fileId" FROM "yt-thumbinal" WHERE "id"=?', (videoId,))
	# result = cur2.fetchone()
	# return result[0] if result else ''
		
	
r=res.fetchall()[0]

fid = getFileId(r[0])

#thid=getThumbinalFileId(r[0])
#if thid:
#	pr = subprocess.run(["korni3", "fhtp", "yt", thid], capture_output=True)
#	thpath = pr.stdout.decode('utf-8').strip()
#else: 
#	thpath = ''

fileId = r[12]
pr = subprocess.run(["korni3", "fhtp", "yt", fileId], capture_output=True)
vpath = pr.stdout.decode('utf-8').strip()

res2=cur.execute('SELECT "yt-tags"."tags" FROM "yt-tags" where id=?', (videoId, ))
tags=[]
try:
	#ep('tags=', res2.fetchone()[0])
	tags = json.loads(res2.fetchone()[0])
except TypeError: 
	pass
except SyntaxError:
	pass


result = {
		"id": r[0], 
		"zT": r[1],
#		"imagePreviewSource": thpath,
		
		"videoFileId": fid,
		"videoFile": vpath,
		
		"name": r[2],
		
		"description": r[3], 
		"duration": r[4], 
		"viewCount": r[5], 
		
		"channelName": r[6],
		
		"whenLoaded" : r[7],
		
		"epoch": r[10], 
		"zU": r[11],
		
		"tags": tags, 
		
		"likedByYour": False, # TODO
		"dislikedByYour": False,
		
	}
#p(len(json.dumps(r).encode('utf-8')))  	# 312668
#p(len(orjson.dumps(r)))					# 275399
#p(len(ujson.dumps(r)))						# 316529
p(orjson.dumps(result).decode('utf-8')) # 


#SELECT LAST (by zT) RECORD with id
#
#SELECT a.* FROM [files] a INNER JOIN ( 
#	SELECT id, MAX(zT) zT FROM [files]  GROUP BY id 
#) b ON a.id = b.id AND a.zT = b.zT WHERE a.id='GFS-QmRFbRMEMWUkpecPCRSQ2tqJ5QqCjotfrgq8jY9VCisdcK-S1-61168520e19219ddc26b167e792f068c6990b405-M-1d9c7435fa3a55ad8f91fbb67fb57bb7-S256-63c3bbc6c70486259d1fe2b679e69c5f108f56702a003ac3ffee5a47c3480c90'; 
