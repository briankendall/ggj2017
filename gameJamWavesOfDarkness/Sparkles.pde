import java.util.HashMap;

private PImage[] sparkleImages;

class Sparkle {
    public int x;
    public int y;
    public int life;
    public int lifeSpan;
    public float r;
    public float dr;
    public float opacity;
    public PImage image;
}

class SparkleRegion {
    private int x;
    private int y;
    private int width;
    private int height;
    private color c;
    private float rate;
    private ArrayList<Sparkle> sparkles = new ArrayList<Sparkle>();
    private int spawnCount = 0;
    private final int sparkleLifeSpan = 30;
    private final int minSparkleSpawnTime = 3;
    private final int maxSparkleSpawnTime = 6;
    private final float minSparkleRotateSpeed = -0.03;
    private final float maxSparkleRotateSpeed = 0.03;
    private final float minSparkleOpacity = 0.5;
    private final float maxSparkleOpactiy = 1.0;
    private final float sparkleScale = 0.8;
    
    public SparkleRegion(int inX, int inY, int inWidth, int inHeight, color inColor, float inRate) {
        x = inX;
        y = inY;
        width = inWidth;
        height = inHeight;
        c = inColor;
        rate = inRate;
    }
    
    public void draw() {
        if (spawnCount <= 0) {
            spawnCount = randomInt(int(minSparkleSpawnTime*rate), int(maxSparkleSpawnTime*rate));
            Sparkle s = new Sparkle();
            s.x = randomInt(x, x+width);
            s.y = randomInt(y, y+height);
            s.life = 0;
            s.lifeSpan = sparkleLifeSpan;
            s.image = sparkleImages[randomInt(0, sparkleImages.length-1)];
            s.dr = random(minSparkleRotateSpeed, maxSparkleRotateSpeed);
            s.r = random(0, PI);
            s.opacity = random(minSparkleOpacity, maxSparkleOpactiy);
            sparkles.add(s);
            
        } else {
            spawnCount -= 1;
        }
        
        for(Sparkle s : sparkles) {
            float alpha = 0;
            int halfLife = s.lifeSpan/2;
            
            if (s.life < s.lifeSpan/2) {
                alpha = (255 * s.life) / halfLife;
            } else {
                alpha = (255 * (s.lifeSpan - s.life)) / halfLife;
            }
            
            tint(c, alpha*s.opacity);
            
            pushMatrix();
            //translate(s.x - s.image.width/2, s.y - s.image.height/2);
            translate(s.x, s.y);
            rotate(s.r);
            scale(sparkleScale, sparkleScale);
            translate(-s.image.width/2, -s.image.height/2);
            image(s.image, 0,0);
            popMatrix();
            noTint();
            
            s.life += 1;
            s.r += s.dr;
        }
        
        for(int i = sparkles.size()-1; i >= 0; --i) {
            if (sparkles.get(i).life == sparkles.get(i).lifeSpan) {
                sparkles.remove(i);
            }
        }
    }
}

public class SparkleRenderer {
    private HashMap<Integer, SparkleRegion> sparkleRegions = new HashMap<Integer, SparkleRegion>();
    private int lastSparkleKey = 0;
    
    int createSparkles(int x, int y, int width, int height, color c, float rate) {
        lastSparkleKey += 1;
        sparkleRegions.put(lastSparkleKey, new SparkleRegion(x, y, width, height, c, rate));
        return lastSparkleKey;
    }
    
    void removeSparkles(int key) {
        sparkleRegions.remove(key);
    }
    
    void setup() {
        sparkleImages = new PImage[4];
        sparkleImages[0] = loadImage("sparkle1.png");
        sparkleImages[1] = loadImage("sparkle2.png");
        sparkleImages[2] = loadImage("sparkle3.png");
        sparkleImages[3] = loadImage("sparkle4.png");
    }
    
    void draw() {
        for(SparkleRegion region : sparkleRegions.values()) {
            region.draw();
        }
    }
}

SparkleRenderer _sparkleRenderer = null;

SparkleRenderer getSparkleRenderer() {
    if (_sparkleRenderer ==  null) {
        _sparkleRenderer = new SparkleRenderer();
    }
    
    return _sparkleRenderer;
}
