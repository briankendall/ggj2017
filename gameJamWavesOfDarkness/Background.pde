class BackgroundCloud {
    public float r1 = 0;
    public float r2 = 0;
    public float dr1 = 0;
    public float dr2 = 0;
    public float innerRotationRadius = 0;
    public float originX = 0;
    public float originY = 0;
}

class BackgroundRenderer {
    private BackgroundCloud[] clouds;
    private PImage cloudImage;

    public void setup() {
        clouds = new BackgroundCloud[10];
        
        for(int i = 0; i < clouds.length; ++i) {
            clouds[i] = new BackgroundCloud();
            clouds[i].dr1 = random(0.001, 0.006);
            clouds[i].dr2 = random(0.0003, 0.0011);
            clouds[i].innerRotationRadius = 120;
            clouds[i].originX = random(-512, 512);
            clouds[i].originY = random(-384, 384);
        }
        
        cloudImage = loadImage("clouds.png");
    }
    
    private boolean pointOnScreen(float x, float y) {
        return ((x >= 0 || x <= 1024) || (y >= 0 || y <= 768));
    }
    
    private boolean rectOnScreen(float x, float y, float width, float height) {
        return (pointOnScreen(x, y) || pointOnScreen(x + width, y) || 
                pointOnScreen(x + width, y + height) || pointOnScreen(x, y + height));
    }
    
    private void drawCloud(BackgroundCloud cloud) {
        cloud.r1 += cloud.dr1;
        cloud.r2 += cloud.dr2;
        
        pushMatrix();
        
        translate(512 + cloud.originX, 384 + cloud.originY);
        rotate(cloud.r1);
        translate(cloud.innerRotationRadius, 0);
        rotate(cloud.r2);
        
        for(int x = -5; x < 5; ++x) {
            for(int y = -5; y < 5; ++y) {
                float gx = screenX(x * cloudImage.width, y * cloudImage.height);
                float gy = screenY(x * cloudImage.width, y * cloudImage.height);
                
                if (rectOnScreen(gx, gy, cloudImage.width, cloudImage.height)) {
                    image(cloudImage, x * cloudImage.width, y * cloudImage.height);
                }
            }
        }
        
        popMatrix();
    }
    
    public void draw() {
        tint(255, 20);
        
        for(int i = 0; i < clouds.length; ++i) {
            drawCloud(clouds[i]);
        }
        
        noTint();
    }
}
