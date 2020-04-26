import os,sys
from datetime import datetime
from random import choice,randrange

def make_canvas(n, x, y, headstart=0):
	colors = ["r","b","y","t","k","w"]
	for i in range(int(n)):
		cols = []
		for k in range(randrange(3,10)):
			cols.append(choice(colors))
		cols = ",".join(cols)
		if int(n) > 1:
			os.system("python3 mondrian.py "+x+" "+y+" "+cols+" "+headstart+" ./canvas/mondrian_canvas_"+str(i+1)+".csv")
		else:
			os.system("python3 mondrian.py "+x+" "+y+" "+cols+" "+headstart+" ./canvas/mondrian_canvas_"+datetime.now().strftime("%Y%m%d-%H%M%S")+".csv")

def main():
	print("""
	Enter the number of paintings and tiles you want and if you want a random starting point (headstart=1) or start from 0:0 (headstart=0; default).
	
	For example:
	
		python3 make_mondrians.py 9 5 5 1
	
	... this gives 9 paintings, each as a 5x5 grid, and a random starting point.
	""")
	make_canvas(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4])

if __name__=="__main__":
	main()
