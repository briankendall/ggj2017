class Ripple {
    public int life;
    public color c;
}

class RippleSet {
    private ArrayList<Ripple> ripples = new ArrayList<Ripple>();
    private int x;
    private int y;
    private int maxRadius;
    private ArrayList<Integer> colors;
    private int spawnCount = 0;
    private final int minSpawnTime = 12;
    private final int maxSpawnTime = 24;
    private final int lifeSpan = 60;
    private final int fadeInTime = lifeSpan/2;
    private final int fadeOutTime = lifeSpan/2;
    private final float overallOpacity = 0.5;
    
    RippleSet(int inX, int inY, int inMaxRadius, ArrayList<Integer> inColors) {
        x = inX;
        y = inY;
        maxRadius = inMaxRadius;
        colors = inColors;
    }
    
    void draw() {
        if (spawnCount <= 0) {
            spawnCount = randomInt(minSpawnTime, maxSpawnTime);
            Ripple r = new Ripple();
            r.life = 0;
            r.c = colors.get(randomInt(0, colors.size()-1));
            ripples.add(r);
        } else {
            spawnCount -= 1;
        }
        
        for(Ripple r : ripples) {
            float radius = float(r.life * maxRadius) / float(lifeSpan);
            float opacity = 1.0;
            
            if (r.life < fadeInTime) {
                opacity = float(r.life) / float(fadeInTime);
            } else if (r.life > (lifeSpan-fadeOutTime)) {
                opacity = float(lifeSpan - r.life) / float(fadeOutTime);
            }
            
            noFill();
            stroke(r.c, int(opacity*overallOpacity*255));
            strokeWeight(2);
            //ellipse(x - radius/2, y - radius/2, radius, radius);
            ellipse(x, y, radius, radius);
            
            r.life += 1;
        }
        
        for(int i = ripples.size()-1; i >= 0; --i) {
            if (ripples.get(i).life == lifeSpan) {
                ripples.remove(i);
            }
        }
    }
}

class RippleRenderer {
    private HashMap<Integer, RippleSet> rippleSets = new HashMap<Integer, RippleSet>();
    private int lastKey = 0;
    
    public void setup() {
    }
    
    public void draw() {
        for(RippleSet ripple : rippleSets.values()) {
            ripple.draw();
        }
    }
    
    public int createRipples(int x, int y, int radius, ArrayList<Integer> colors) {
        lastKey += 1;
        rippleSets.put(lastKey, new RippleSet(x, y, radius, colors));
        return lastKey;
    }
    
    public void removeRipples(int key) {
        rippleSets.remove(key);
    }
}

RippleRenderer _rippleRenderer = null;

RippleRenderer getRippleRenderer() {
    if (_rippleRenderer ==  null) {
        _rippleRenderer = new RippleRenderer();
    }
    
    return _rippleRenderer;
}
