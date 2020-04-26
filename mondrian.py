import sys,csv
import numpy as np
from collections import defaultdict
from random import random, randint, choice

def make_canvas(w=20,h=20,headstart="0"):
	headstart = int(headstart)
	canvas = np.zeros((w,h), dtype=int)
	if headstart!=0:
		x1 = randint(0,w)
		y1 = randint(0,h)
		x2 = randint(x1,w)
		y2 = randint(y1,h)
		for x in range(x1,x2):
			for y in range(y1,y2):
				canvas[x,y] = -1
	return canvas

def get_space(locus, canvas):
	(x,y) = locus
	empty = np.argwhere(canvas[x,] == 0)
	if len(empty) > 0:
		y2 = empty[-1][0]
	else:
		y2 = len(canvas[y])-1
	x1 = x
	y1 = y
	x2 = len(canvas)-1
	space = (x1,y1,x2,y2)
	return space

def get_start(canvas):
	return np.argwhere(canvas == 0)

def make_tile(space):
	(xmin,ymin,xmax,ymax) = space
	big = random()
	x1 = xmin
	y1 = ymin
	if big > .3:
		x2 = randint(xmin,xmax)
		y2 = randint(ymin,ymax)
	else:
		x2 = randint(xmin,round(xmin+(xmax-xmin)/2))
		y2 = randint(ymin,round(ymin+(ymax-ymin)/2))
	return (x1,y1,x2,y2)

def paint_canvas(w,h,cols,headstart):
	colors = {
		"r": "#C52F24",
		"b": "#1513C6",
		"y": "#FDF851",
		"t": "#7AB3BA",
		"k": "#000000",
		"w": "#FFFFFF"
	}
	col = ["w","w","w","w"]
	for c in cols.split(","):
		col.append(c)
	coords = []
	canvas = make_canvas(w,h,headstart)
	empty = get_start(canvas)
	i = 1
	while len(empty) > 0:
		locus = empty[0]
		space = get_space(locus, canvas)
		tile = make_tile(space)
		coords.append((tile[0],tile[2],tile[1],tile[3],colors[choice(col)]))
		for x in range(tile[0],tile[2]+1):
			for y in range(tile[1],tile[3]+1):
				canvas[x,y] = i
		empty = get_start(canvas)
		i += 1
	return canvas,coords

def paint_mondrian(coords,outfile):
	with open(outfile,"w",encoding="utf-8") as f:
		f.write("x1,x2,y1,y2,color\n")
		for c in coords:
			row = ",".join(str(i) for i in c)+"\n"
			f.write(row)

def main():
	canvas,coords = paint_canvas(int(sys.argv[1]),int(sys.argv[2]),sys.argv[3],sys.argv[4])
	paint_mondrian(coords,sys.argv[5])

if __name__=="__main__":
	main()
