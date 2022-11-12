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
    
    
playlistName=sys.argv[1]
ep(playlistName)

r = subprocess.run(["korni3", "db", "yt"], capture_output=True)
path = r.stdout.decode('utf-8').strip()

con = sqlite3.connect(path)
cur = con.cursor()

result = []
res = cur.execute("select id, title,description,duration,view_count,uploader,thumbnails,upload_date,playlist,filename,epoch"
					" from videos where playlist=?", (playlistName,))
					
for r in res.fetchall(): 
	item = {
		"id": r[0], 
		"title": r[1], 
		"description": r[2], 
		"duration": r[3], 
		"view_count": r[4], 
		"uploader": r[5], 
		"thumbnails": r[6], 
		"upload_date": r[7], 
		"playlist": r[8], 
		"filename": r[9], 
		"epoch": r[10], 
	}
	result.append(item)
#p(len(json.dumps(r).encode('utf-8')))  	# 312668
#p(len(orjson.dumps(r)))					# 275399
#p(len(ujson.dumps(r)))						# 316529
p(orjson.dumps(result).decode('utf-8')) # 


