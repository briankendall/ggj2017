class Light {
    public int[][] values;
    
    Light(int startX, int startY, int direction, int lightColor, int levelWidth, int levelHeight) {
        values = new int [levelWidth][levelHeight];
        
        int x = startX;
        int y = startY;
        
        while(x >= 0 && y >= 0 && x < levelWidth && y < levelHeight) {
            values[x][y] = lightColor;
            
            if (direction == UP_DIRECTION) {
                y -= 1;
            } else if (direction == RIGHT_DIRECTION) {
                x += 1;
            } else if (direction == LEFT_DIRECTION) {
                x -= 1;
            } else if (direction == DOWN_DIRECTION) {
                y += 1;
            }
        }
    }
}

class LightManager {
    private Level level = null;
    private HashMap<Integer, Light> lights = new HashMap<Integer, Light>();
    private int lastKey = 0;
    private int[][] combinations = new int[TOTAL_LIGHT][TOTAL_LIGHT];
    private final int lightAlpha = 127;
    
    LightManager() {
        combinations[LIGHT_NONE] [LIGHT_NONE] = LIGHT_NONE;
        combinations[LIGHT_NONE] [LIGHT_RED] = LIGHT_RED;
        combinations[LIGHT_NONE] [LIGHT_GREEN] = LIGHT_GREEN;
        combinations[LIGHT_NONE] [LIGHT_BLUE] = LIGHT_BLUE;
        combinations[LIGHT_NONE] [LIGHT_YELLOW] = LIGHT_YELLOW;
        combinations[LIGHT_NONE] [LIGHT_CYAN] = LIGHT_CYAN;
        combinations[LIGHT_NONE] [LIGHT_MAGENTA] = LIGHT_MAGENTA;
        combinations[LIGHT_NONE] [LIGHT_WHITE] = LIGHT_WHITE;
        
        combinations[LIGHT_RED] [LIGHT_NONE] = LIGHT_RED;
        combinations[LIGHT_RED] [LIGHT_RED] = LIGHT_RED;
        combinations[LIGHT_RED] [LIGHT_GREEN] = LIGHT_YELLOW;
        combinations[LIGHT_RED] [LIGHT_BLUE] = LIGHT_MAGENTA;
        combinations[LIGHT_RED] [LIGHT_YELLOW] = LIGHT_YELLOW;
        combinations[LIGHT_RED] [LIGHT_CYAN] = LIGHT_WHITE;
        combinations[LIGHT_RED] [LIGHT_MAGENTA] = LIGHT_MAGENTA;
        combinations[LIGHT_RED] [LIGHT_WHITE] = LIGHT_WHITE;
        
        combinations[LIGHT_GREEN] [LIGHT_NONE] = LIGHT_GREEN;
        combinations[LIGHT_GREEN] [LIGHT_RED] = LIGHT_YELLOW;
        combinations[LIGHT_GREEN] [LIGHT_GREEN] = LIGHT_GREEN;
        combinations[LIGHT_GREEN] [LIGHT_BLUE] = LIGHT_CYAN;
        combinations[LIGHT_GREEN] [LIGHT_YELLOW] = LIGHT_YELLOW;
        combinations[LIGHT_GREEN] [LIGHT_CYAN] = LIGHT_CYAN;
        combinations[LIGHT_GREEN] [LIGHT_MAGENTA] = LIGHT_WHITE;
        combinations[LIGHT_GREEN] [LIGHT_WHITE] = LIGHT_WHITE;
        
        combinations[LIGHT_BLUE] [LIGHT_NONE] = LIGHT_BLUE;
        combinations[LIGHT_BLUE] [LIGHT_RED] = LIGHT_MAGENTA;
        combinations[LIGHT_BLUE] [LIGHT_GREEN] = LIGHT_CYAN;
        combinations[LIGHT_BLUE] [LIGHT_BLUE] = LIGHT_BLUE;
        combinations[LIGHT_BLUE] [LIGHT_YELLOW] = LIGHT_WHITE;
        combinations[LIGHT_BLUE] [LIGHT_CYAN] = LIGHT_CYAN;
        combinations[LIGHT_BLUE] [LIGHT_MAGENTA] = LIGHT_MAGENTA;
        combinations[LIGHT_BLUE] [LIGHT_WHITE] = LIGHT_WHITE;
        
        combinations[LIGHT_YELLOW] [LIGHT_NONE] = LIGHT_YELLOW;
        combinations[LIGHT_YELLOW] [LIGHT_RED] = LIGHT_YELLOW;
        combinations[LIGHT_YELLOW] [LIGHT_GREEN] = LIGHT_YELLOW;
        combinations[LIGHT_YELLOW] [LIGHT_BLUE] = LIGHT_WHITE;
        combinations[LIGHT_YELLOW] [LIGHT_YELLOW] = LIGHT_YELLOW;
        combinations[LIGHT_YELLOW] [LIGHT_CYAN] = LIGHT_WHITE;
        combinations[LIGHT_YELLOW] [LIGHT_MAGENTA] = LIGHT_WHITE;
        combinations[LIGHT_YELLOW] [LIGHT_WHITE] = LIGHT_WHITE;
        
        combinations[LIGHT_CYAN] [LIGHT_NONE] = LIGHT_CYAN;
        combinations[LIGHT_CYAN] [LIGHT_RED] = LIGHT_WHITE;
        combinations[LIGHT_CYAN] [LIGHT_GREEN] = LIGHT_CYAN;
        combinations[LIGHT_CYAN] [LIGHT_BLUE] = LIGHT_CYAN;
        combinations[LIGHT_CYAN] [LIGHT_YELLOW] = LIGHT_WHITE;
        combinations[LIGHT_CYAN] [LIGHT_CYAN] = LIGHT_CYAN;
        combinations[LIGHT_CYAN] [LIGHT_MAGENTA] = LIGHT_WHITE;
        combinations[LIGHT_CYAN] [LIGHT_WHITE] = LIGHT_WHITE;
        
        combinations[LIGHT_MAGENTA] [LIGHT_NONE] = LIGHT_MAGENTA;
        combinations[LIGHT_MAGENTA] [LIGHT_RED] = LIGHT_MAGENTA;
        combinations[LIGHT_MAGENTA] [LIGHT_GREEN] = LIGHT_WHITE;
        combinations[LIGHT_MAGENTA] [LIGHT_BLUE] = LIGHT_MAGENTA;
        combinations[LIGHT_MAGENTA] [LIGHT_YELLOW] = LIGHT_WHITE;
        combinations[LIGHT_MAGENTA] [LIGHT_CYAN] = LIGHT_WHITE;
        combinations[LIGHT_MAGENTA] [LIGHT_MAGENTA] = LIGHT_MAGENTA;
        combinations[LIGHT_MAGENTA] [LIGHT_WHITE] = LIGHT_WHITE;
        
        combinations[LIGHT_WHITE] [LIGHT_NONE] = LIGHT_WHITE;
        combinations[LIGHT_WHITE] [LIGHT_RED] = LIGHT_WHITE;
        combinations[LIGHT_WHITE] [LIGHT_GREEN] = LIGHT_WHITE;
        combinations[LIGHT_WHITE] [LIGHT_BLUE] = LIGHT_WHITE;
        combinations[LIGHT_WHITE] [LIGHT_YELLOW] = LIGHT_WHITE;
        combinations[LIGHT_WHITE] [LIGHT_CYAN] = LIGHT_WHITE;
        combinations[LIGHT_WHITE] [LIGHT_MAGENTA] = LIGHT_WHITE;
        combinations[LIGHT_WHITE] [LIGHT_WHITE] = LIGHT_WHITE;
    }
    
    public int createLight(int x, int y, int direction, int lightColor) {
        ++lastKey;
        Light l = new Light(x, y, direction, lightColor, level.getLevelWidth(),
                            level.getLevelHeight());
        lights.put(lastKey, l);
        return lastKey;
    }
    
    public void removeLight(int key) {
        lights.remove(key);
    }
    
    public int combineLight(int a, int b) {
        return combinations[a][b];
    }
    
    public int colorAtTile(int x, int y) {
        int currentColor = LIGHT_NONE;
        
        for(Light light : lights.values()) {
            int c = light.values[x][y];
            currentColor = combineLight(currentColor, c);
        }
        
        return currentColor;
    }
    
    public void setup(Level inLevel) {
        level = inLevel;
    }
    
    public void draw() {
        noStroke();
        
        for(int x = 0; x < level.getLevelWidth(); ++x) {
            for(int y = 0; y < level.getLevelHeight(); ++y) {
                int c = colorForLightColor(colorAtTile(x,y), lightAlpha);
                
                if (c != 0) {
                    fill(c);
                    rect(x*64, y*64, 64, 64);
                }
            }
        }
    }
}

LightManager _lightManager = null;

LightManager getLightManager() {
    if (_lightManager ==  null) {
        _lightManager = new LightManager();
    }
    
    return _lightManager;
}
