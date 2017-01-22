import java.io.File;
import tiled.core.*;
import tiled.io.TMXMapReader;
import java.util.List;

/*
The Level class provides the information for generating 
the level's sprite layout and item placement
*/
public class Level
{
  //The level needs a tilemap (matrix) of sprites
  protected int levelHeight;
  protected int levelWidth;
  protected int levelLayers;
  protected int[][][] tilemap;
  //The TMX filename used to load the level
  protected String filepath;
  //The TMX Map object
  protected Map levelMap;
  
  //The layout of actual entities in the game
  protected Entity[][] entityMap;
  
  //Constructor reads in information from TMX map file for level data
  /*Parameters:
      (String) fpath = absolute path to file
    Returns:
      -------
  */
  public Level(String fpath)
  {
    filepath = fpath;
    try
    {
      levelMap = (new TMXMapReader()).readMap(fpath);
    }
    catch(Exception e)
    {
      //println("Warning: Level " + fpath + " does not exist!");
      e.printStackTrace();
      println(e);
      exit();
    }
    levelHeight = levelMap.getHeight();
    levelWidth = levelMap.getWidth();
    levelLayers = levelMap.getLayerCount();
    
    //Fill in the items in the tileset
    entityMap = new Entity[levelHeight][levelWidth];
    
    //Fill in the tilemap with the tileset indeces
    tilemap = new int[levelLayers][levelHeight][levelWidth];
    for(int layer = 0; layer < min(1, levelLayers); layer++)
    {
      MapLayer l = levelMap.getLayer(layer);
      for(int row = 0; row < levelHeight; row++)
      {
        for(int col = 0; col < levelWidth; col++)
        {
          Tile t = ((TileLayer)l).getTileAt(col, row);
          tilemap[layer][row][col] = ((t == null) ? NO_TILE:t.getId());
          entityMap[row][col] = ((t == null) ? null:new Entity(itemset.get(t.getId()), col, row));
          if(entityMap[row][col] != null) {entityMap[row][col].makeVisible(true);}
        }
      }
    }
    for(int layer = 1; layer < levelLayers; layer++)
    {
      MapLayer l = levelMap.getLayer(layer);
      for(int row = 0; row < levelHeight; row++)
      {
        for(int col = 0; col < levelWidth; col++)
        {
          Tile t = ((TileLayer)l).getTileAt(col, row);
          tilemap[layer][row][col] = ((t == null) ? NO_TILE:t.getId());
        }
      }
    }
    
    if(DEBUG)
    {
      //Get the tilesets
      List<TileSet> tsList = levelMap.getTileSets();
      print("Level has " + tsList.size() + " tilesets\n");
      
      //Check the tile set(s)
      for(int i = 0; i < tsList.size(); i++)
      {
        TileSet ts = tsList.get(i);
        for(int j = 0; j < ts.getMaxTileId(); j++)
        {
          Tile t = ts.getTile(j);
          print(t.toString() + ":\n");
          print("\t" + t.getSource() + "\n");
          t.getProperties().list(System.out);
        }
      }
      
      //Check the tile layout itself
      for(int layer = 0; layer < levelMap.getLayerCount(); layer++)
      {
        MapLayer l = levelMap.getLayer(layer);
        print("Layer " + layer + ":\n");
        for(int row = 0; row < levelHeight; row++)
        {
          for(int col = 0; col < levelWidth; col++)
          {
            Tile t = ((TileLayer)l).getTileAt(col, row);
            if(t != null)
            {
              /*
              print("\t" + t.toString() + " at [" + row + ", " + col + "]:\n");
              print("\t\t" + t.getSource() + "\n");
              t.getProperties().list(System.out);
              */
            }
          }
        }
      }
    }
  }
  
  //Accessor Methods - BEGIN
  public int getLevelHeight() {return levelHeight;}
  public int getLevelWidth() {return levelWidth;}
  public int getLevelLayers() {return levelLayers;}
  public int[][][] getTileMap() {return tilemap;}
  public String getFilepath() {return filepath;}
  
  public Entity[][] getEntityMap() {return entityMap;}
  //Accessor Methods - END
}