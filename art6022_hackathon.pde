import java.io.File;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Map;

String basedir = "/Users/vincent/Documents/Processing/art6022/week3/art6022_hackathon/";
String path = basedir + "emojis/";
String emptyIcon = basedir + "emojis/empty.png";
Map<String, PImage> emojiDict = new Hashtable<String, PImage>();

int titleLength = 5;


String[] listFiles(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String[] filenames = file.list(); // List all the files in the directory
    return filenames;
  } else {
    return null;
  }
}


Map generateEmojiDict(String[] files){
  // Cette fonction sert a créer un dictionnaire d'emoji a partir d'une liste d'image qui lui ait donnée
  // le nom de l'emoji devient la clef, et la valeur qui lui est associée est l'image de l'emoji 
  
  Map emojiDict = new Hashtable();
  // on passe au travers l'ensemble des images dans le dossier
  for (int i = 0; i < files.length; i++) {
    //on supprime l'extension .png pour n'avoir que le nom de l'emoji qui devient un mot clé
    if (files[i].contains(".png")) {
      String keyword = files[i].replace(".png", "");
      // on place dans le dictionnaire le mot clé ainsi extrait et on charge l'image qui lui est associé
      emojiDict.put(keyword, loadImage(path + files[i]));
    }
  }
  return emojiDict;
}



ArrayList<ArrayList<PImage>> replaceTitles(String[] titles, Map<String, PImage> emojiDict){
  // Cette fonction remplace els titres qui lui sont données en entrée par leur equivelent en emoji
  // Si aucun mot n'est toruvé dans notre liste, l'emoji "vide" est utilisé à la place
  
  ArrayList<ArrayList<PImage>> titlesReplaced = new ArrayList<ArrayList<PImage>>();    // Create a structure to store the result of our transformations
  
  // go through the list of words and try to find an emoji matching the word in our dictionary
  //if none is found, the empty emoji is used.
  for (int i = 0; i < titles.length; i++) {
    String[] titleWords = titles[i].split(" ");
    
    ArrayList<PImage> emojis = new ArrayList<PImage>();
    
    for (int j = 0; j < titleWords.length; j++) {
      
      PImage replacedEmoji = new PImage();
      if (emojiDict.containsKey(titleWords[j])) {
        replacedEmoji = emojiDict.get(titleWords[j]);
      } else {
        replacedEmoji = emojiDict.get("empty");
      }
      //println("My path is : " + emojiPath);
      emojis.add(replacedEmoji);  
    }  
  titlesReplaced.add(emojis); 
  }  
  return titlesReplaced;
}


void emojize(ArrayList<ArrayList<PImage>> titlesReplaced) {
  int currentLine = 0;
  int currentPosition = 0;
  int positionMax = 40;
  int lineMax = 45;
  int emojiSize = 20;
  
    for (int i = 0; i < titlesReplaced.size(); i++) {
    for (int j = 0; j < titlesReplaced.get(i).size(); j++){
      image(titlesReplaced.get(i).get(j), currentPosition*20, currentLine * emojiSize, emojiSize, emojiSize);
      currentPosition++;
      if (currentPosition > positionMax) {
        currentLine++;
        if (currentLine >= lineMax) {
          currentLine = 0;
          background(0);
        } 
      currentPosition = 0;
      }
    }
  }
}



void setup(){
  //fullScreen();
  size(800,600);
  background(0);
 
  // List all emoji files from our folder using the function list files created previously
  // Uses that list to generate a dictionnary of emoji that associate the "word" represented 
  // by an emoji to its image content 
  String[] emojisList ; 
  emojisList = listFiles(path);
  emojiDict = generateEmojiDict(emojisList);
}



void draw(){  
  // this array of String is used for debugging
  // Will be replaced by the feed of data extracted from the API
  String[] titles = {"canada beer yyy home love", "happy up her gsdds cold"};
  
  // Replace all the titles by the corresponding Emojis using the functiones defined before
  ArrayList<ArrayList<PImage>> titlesReplaced = replaceTitles(titles, emojiDict);
  
  // Fill the titles with th Emoji we just obtained
  emojize(titlesReplaced);
  
  // Wait 1 second before doing it again (1000ms)
  delay(1000);
}
