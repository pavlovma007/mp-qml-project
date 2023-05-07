#!/usr/bin/python3
import sys
import json
import orjson
import ujson
import subprocess
import sqlite3

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
limit=1000
# плейлисты в случайном порядке
res = cur.execute('select distinct "yt-playlists"."uploader" '+
	' FROM "yt-playlists" where uploader like ? order by random() limit ? offset ? ;', (filterText, limit, offset))

result = []
for r in res.fetchall(): 
	result.append({
		"uploader": r[0],
	})
p(orjson.dumps(result).decode('utf-8')) # 

