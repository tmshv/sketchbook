# from PIL import Image, ImageDraw
import Image, ImageDraw
import os

flist = os.listdir("./aa3")

columns = 5
rows = 8

# tile = Image.open('tile.png')
# twidth = tile.size[0]
# theight = tile.size[1]
twidth = 500
theight = 500
mwidth = twidth * columns;
mheight = theight * rows;
matrix = Image.new('RGB', (mwidth, mheight))

for y in range(0, rows):
	for x in range(0, columns):
		i = y * columns + x + 1
		fname = flist[i]
		if(fname != ".DS_Store"):
			tile = Image.open("./aa3/"+fname)
			matrix.paste(tile, (x*twidth, y*theight))

matrix.save('mtx3.png')
print('done')