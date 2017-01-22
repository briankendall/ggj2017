import java.io.File;
import tiled.core.Map;
import tiled.core.MapLayer;
import tiled.core.ObjectGroup;
import tiled.core.TileLayer;
import tiled.io.TMXMapReader;

class Test2 {
    public static String combine(String path1, String path2)
    {
        File file1 = new File(path1);
        File file2 = new File(file1, path2);
        return file2.getPath();
    }

    public void printSomething(String dataPath) {
        try {
            Map map = new TMXMapReader().readMap(combine(dataPath, "sewers.tmx"));
            System.out.print("Level width: " + map.getWidth() + "\n");
            System.out.print("Level height: " + map.getHeight() + "\n");
        } catch (Exception e) {
            System.out.print("Exception!");
        }
    }
}
