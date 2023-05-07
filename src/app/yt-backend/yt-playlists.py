#!/usr/bin/python3
import sys
import json
import orjson
import ujson
import subprocess
import sqlite3

"несколько прейлистов по name , TODO по uploader"

p = print
def ep(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)


filterText=sys.argv[1] or ''
filterText='%'+filterText+'%'

r = subprocess.run(["korni3", "db", "yt"], capture_output=True)
path = r.stdout.decode('utf-8').strip()

con = sqlite3.connect(path, timeout=10)
cur = con.cursor()

offset=0
limit=10000
# плейлисты в случайном порядке
res = cur.execute('select "yt-playlists"."id", "yt-playlists"."zT", "yt-playlists"."name","yt-playlists"."type","yt-playlists"."zU","yt-playlists"."uploader",'+
	'"yt-playlists"."url" FROM "yt-playlists" where name like ? order by random() limit ? offset ? ;', (filterText, limit, offset))

result = []
for r in res.fetchall(): 
	result.append({
		"id": r[0],
		"zT": r[1],
		"name": r[2],
		"type": r[3],
		"zU": r[4],
		"uploader": r[5],
		"url": r[6],
	})
p(orjson.dumps(result).decode('utf-8')) # 

