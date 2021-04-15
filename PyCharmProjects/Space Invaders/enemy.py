# Enemy class
class enemy:
    def __init__(self, x, y, x_change, y_change):
        self.x = x
        self.y = y
        self.x_change = x_change
        self.y_change = y_change

    def getX(self):
        return self.x

    def getY(self):
        return self.y

    def get_x_change(self):
        return self.x_change

    def get_y_change(self):
        return self.y_change

    def setX(self, x):
        self.x = x

    def setY(self, y):
        self.y = y

    def set_x_change(self, x):
        self.x_change = x

    def set_y_change(self, y):
        self.y_change = y
