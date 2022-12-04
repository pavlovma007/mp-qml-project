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


id=sys.argv[1] or ''

r = subprocess.run(["korni3", "db", "yt"], capture_output=True)
path = r.stdout.decode('utf-8').strip()

con = sqlite3.connect(path)

cur = con.cursor()

# плейлисты в случайном порядке
res = cur.execute('select "yt-playlists"."id", "yt-playlists"."zT", "yt-playlists"."name","yt-playlists"."type","yt-playlists"."zU","yt-playlists"."uploader",'+
	'"yt-playlists"."url" FROM "yt-playlists" where id=? limit 1;', (id,))
r = res.fetchall()

# calculate TAGS list for this playlist
res2 = cur.execute('SELECT json_group_array(json("yt-tags"."tags")),  "yt-link-playlist-video"."playlistId"'+
		'from "yt-tags" '+
		'inner join "yt-link-playlist-video" on "yt-tags"."id"="yt-link-playlist-video"."videoId"'+
		'GROUP by "yt-link-playlist-video"."playlistId"'+
		'having "yt-link-playlist-video"."playlistId" = ? '+
		'limit 1'
	, (id,))
tagsRecord=res2.fetchone();
tags=set()
try:
	for tl in json.loads(tagsRecord[0]):
		for tag in tl:
			#p(tag)
			tags.add(tag)
except TypeError: 
	pass

result = {
		"id": r[0][0],
		"zT": r[0][1],
		"name": r[0][2],
		"type": r[0][3],
		"zU": r[0][4],
		"uploader": r[0][5],
		"url": r[0][6],
		"tags": list(tags)
	}
p(orjson.dumps(result).decode('utf-8')) # 
#ep(orjson.dumps(result).decode('utf-8')) # 
