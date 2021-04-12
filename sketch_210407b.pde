import java.io.File;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Map;

String path = "/Users/vincent/Documents/Processing/art6022/week3/sketch_210407b/emojis/";
String emptyIcon = "/Users/vincent/Documents/Processing/art6022/week3/sketch_210407b/emojis/empty.png";
Map emojiDict = new Hashtable();

String[] listFiles(String dir) {
  println("my directory : " + dir);
  File file = new File(dir);
  if (file.isDirectory()) {
    //String[] files = file.list();
    String[] filenames = file.list();
    return filenames;
  } else {
    return null;
  }
}


Map generateEmojiDict(String[] files){
  Map emojiDict = new Hashtable();
  for (int i = 0; i < files.length; i++) {
    String keyword = files[i].replace(".png", "");
    // println(keyword);
    emojiDict.put(keyword, loadImage(path + files[i]));
  }
  return emojiDict;
}



ArrayList<ArrayList<String>> replaceTitles(String[] titles, Map emojiDict){
  
  ArrayList<ArrayList<String>> titlesReplaced = new ArrayList<ArrayList<String>>();
  
  for (int i = 0; i < titles.length; i++) {
    String[] titleWords = titles[i].split(" ");
    
    ArrayList<String> emojis = new ArrayList<String>();
    
    for (int j = 0; j < titleWords.length; j++) {
      
      String emojiPath = new String();
      if (emojiDict.containsKey(titleWords[j])) {
        emojiPath = emojiDict.get(titleWords[j]).toString();
      } else {
        emojiPath = emptyIcon;
      }
      println("My path is : " + emojiPath);
      emojis.add(emojiPath);  
    }  
  titlesReplaced.add(emojis); 
  }  
  return titlesReplaced;
}



void setup(){
  fullScreen();
  
  
  String[] emojisList ; 
  emojisList = listFiles(path);
  
  emojiDict = generateEmojiDict(emojisList);
  
  //println(emojiDict.get("love"));
}



void draw(){
  String[] titles = {"love","bsaads","up","were"};
  
  ArrayList<ArrayList<String>> titlesReplaced = new ArrayList<ArrayList<String>>();
  titlesReplaced = replaceTitles(titles, emojiDict);
}
