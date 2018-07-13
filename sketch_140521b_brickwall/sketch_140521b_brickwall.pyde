def setup():
    size(500, 500)
    
def draw():
    brick = Rect(40, 25)
    posx = 0
    posy = 0
    for y in range(20):
        odd = y % 2
        offset = -brick.half() * odd
        posx = offset
        for x in range(50):
            rect(posx, posy, brick.w, brick.h)
            posx += brick.w
        posy += brick.h
    
class Rect():
    def __init__(self, w, h):
        self.w = w
        self.h = h
    
    def half(self):
        return self.w / 2;
