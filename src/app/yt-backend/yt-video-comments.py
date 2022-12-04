#!/usr/bin/python3
import sys
#import json
import orjson
import subprocess
import sqlite3
p = print
def ep(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)
    
    
videoId=sys.argv[1]
parentId=sys.argv[2] # must be 'root' by defaulr 

r = subprocess.run(["korni3", "db", "yt"], capture_output=True)
path = r.stdout.decode('utf-8').strip()

con = sqlite3.connect(path)
cur = con.cursor()

result = []
if parentId=='root':
	res=cur.execute('select A."id",A."zT",A."parent", A."text", A."timestamp", '+
						'A."author",A."author_id",A."author_thumbnail", '+
						'A."like_count", (SELECT count() FROM "yt-comments" B WHERE B.parent=A.id) repliesCount '+
						'FROM "yt-comments" A '+ 
						'WHERE A."video"=? '+
						'	AND A."parent"=? '+
						'ORDER BY A."like_count" DESC' , (videoId,parentId))
else:
	res=cur.execute('select A."id",A."zT",A."parent", A."text", A."timestamp", '+
						'A."author",A."author_id",A."author_thumbnail", '+
						'A."like_count", (SELECT count() FROM "yt-comments" B WHERE B.parent=A.id) repliesCount '+
						'FROM "yt-comments" A '+ 
						'WHERE A."video"=? '+
						'	AND A."parent"=? '+
						'ORDER BY A."timestamp" ASC' , (videoId,parentId))
					
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
	item = {
		"id": r[0],
		"zT": r[1],
		"parent": r[2], 
		"text": r[3],
		"timestamp": r[4],
		"author": r[5],
		"author_id": r[6],
		"author_thumbnail": '',  #r[7], # TODO download it 
		"like_count": r[8],
		"repliesCount": r[9] if bool(r[9]) else 0,
	}
	result.append(item)
p(orjson.dumps(result).decode('utf-8')) # 
