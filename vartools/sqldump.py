import sqlite3

def sqldump():
	con = sqlite3.connect("../var.db")
	with open('../backup/dump.sql', 'w') as f:
		for line in con.iterdump():
			f.write('%s\n' % line.encode('utf8'))
