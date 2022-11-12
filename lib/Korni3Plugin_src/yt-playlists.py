#!/usr/bin/python3
import sys
import json
import orjson
import ujson
import subprocess
import sqlite3

p = print

r = subprocess.run(["korni3", "db", "yt"], capture_output=True)
path = r.stdout.decode('utf-8').strip()

con = sqlite3.connect(path)

cur = con.cursor()

res = cur.execute("select distinct playlist from videos;")
r = res.fetchall()
#p(len(json.dumps(r).encode('utf-8')))  	# 312668
#p(len(orjson.dumps(r)))					# 275399
#p(len(ujson.dumps(r)))						# 316529
p(orjson.dumps(r).decode('utf-8')) # 
