import tiled.core.Map;
import tiled.core.MapLayer;
import tiled.core.ObjectGroup;
import tiled.core.TileLayer;
import tiled.io.TMXMapReader;

class Test2 {
    public void printSomething(String dataPath) {
        try {
            Map map = new TMXMapReader().readMap(dataPath + "/sewers.tmx");
            System.out.print("Level width: " + map.getWidth() + "\n");
            System.out.print("Level height: " + map.getHeight() + "\n");
        } catch (Exception e) {
            System.out.print("Exception!");
        }
    }
}
