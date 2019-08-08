 import oscP5.*;
import processing.video.*;
import com.hamoid.*;

OscP5 oscP5;
Capture cam;
Movie myMovie;
PFont Head;
PFont subTitle;
PImage light; //playing signal
PImage qBtn;//quitGame to Homescreen
PImage pBtn;//pause
PImage rBtn;//resetGame
//PImage loopBtn;//loop vid
PGraphics homeCanvas;
PGraphics canvas;
PVector[] meshPoints;
PVector posePosition, poseOrientation;
boolean found; //FaceOSC
Table infoTable, referTable;
PImage Btn01,Btn02,Btn03,Btn04,Btn05;//charSel Buttons
PImage num1,num2,num3,num0,num0b, num0c, num0d;//count numbers to play game
///
float poseScale, posePos_x, posePos_y, poseOrt_x, poseOrt_y, poseOrt_z;
float leftEyebrowHeight, rightEyebrowHeight, eyeLeftHeight, eyeRightHeight, mouthWidth, mouthHeight, nostrilHeight;
int programFrame, videoFrame = 0, i;
//reference values
int NKframe;
float NKBrowL, NKBrowR, NKEyeL, NKEyeR, NKNose, NKMouthH, NKMouthW, NKOriX, NKOriY, NKOriZ;
boolean play=true, readytoPlay=false, gameMode =false, endOfClip = false, waittime= false;
char MENU = 'H'; //Home,Char,Game 
char GAME = 'I'; //Tutorial, Play, Score

int waveCount = 0;
int mouseOver=0;
PImage js,ksi,nk,bb,gm,gg,pew,pom,shane,title,layout;
String celebName="";
//settings
int score = 0, w =1440, h=860; //w = 1440, h = 860, score =0;
String scoreString="", videoAddress = "", clipAddress = "";

void settings() {
  size(w, h, P3D);
}
void setup() {
  setupNewUI();
  noStroke();
  smooth();
  ellipseMode(CENTER);
  //XXXXXXXXXXXXXXXXXX
  //CAMERA PLUG-INS FOR LIVE PLAYING
  //XXXXXXXXXXXXXXXXXX
  String[] cameras = Capture.list();
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  }      
  //cam = new Capture(this, cameras[1]); //built in mac cam "isight"
  //cam = new Capture(this,1280,960, "USB Camera");
  cam = new Capture(this, cameras[0]);
  cam.start();
  //FACEOSC PLUG-INS
  posePosition = new PVector();
  poseOrientation = new PVector();
  initMesh();
  oscP5 = new OscP5(this, 8338);
  // USE THESE 2 EVENTS TO DRAW THE 
  // FULL FACE MESH:
  oscP5.plug(this, "found", "/found");
  oscP5.plug(this, "loadMesh", "/raw");
  oscP5.plug(this, "eyeLeftReceived", "/gesture/eye/left");
  oscP5.plug(this, "eyeRightReceived", "/gesture/eye/right");
  oscP5.plug(this, "eyebrowLeftReceived", "/gesture/eyebrow/left");
  oscP5.plug(this, "eyebrowRightReceived", "/gesture/eyebrow/right");
  oscP5.plug(this, "mouthHeightReceived", "/gesture/mouth/height");
  oscP5.plug(this, "mouthWidthReceived", "/gesture/mouth/width");
  oscP5.plug(this, "nostrilsReceived", "/gesture/nostrils");
  oscP5.plug(this, "jawReceived", "/gesture/jaw");
  oscP5.plug(this, "posePosition", "/pose/position");
  oscP5.plug(this, "poseScale", "/pose/scale");
  oscP5.plug(this, "poseOrientation", "/pose/orientation");
  //loadReferTable();
  referTable = loadTable("../csv/pew.csv", "header");
  //canvas = createGraphics(w, h, P3D);
  frameRate(30);
}

//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

void draw() {
  drawUI();
  //loadReferTable();
  //frameCount = programFrame;
  //print ("MENU : " + MENU + "  GAME :" +GAME +"\n");
  if(GAME == 'P'){
    comparison();
    //println("PLAY : " + play);
    //println("videoframe : " + videoFrame + "  Mtime : "+round(myMovie.time()*100)/100.0 + "  MDuration : "+ floor(myMovie.duration()*100)/100.0);
  }
  //exportFiles();///saveStringfile
  //println("FC in draw: "+frameCount);
  //println("FRAMECOUNT : "+frameCount+"    SCORE : "+score);
  //saveTable(infoTable, "table.csv");//,"html");
}