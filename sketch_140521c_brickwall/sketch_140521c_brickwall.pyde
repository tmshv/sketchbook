class Rect():
    def __init__(self, w, h):
        self.w = w
        self.h = h
    
    def half(self):
        return self.w / 2;
        
bricks = [Rect(40, 25), Rect(30, 25), Rect(28, 25), Rect(13, 25)]

def setup():
    size(500, 500)
    noLoop()
    
def draw():
    
    posx = 0
    posy = 0
    i = 0
    for y in range(20):
        posx = 0
        for x in range(50):
            fill(random(100, 250))
            brick = get_brick(i)
            rect(posx, posy, brick.w, brick.h)
            posx += brick.w
            i += 1
        posy += brick.h

def get_brick(index):
    i = int(random(len(bricks)))
#     i = index % len(bricks)
    return bricks[i]
