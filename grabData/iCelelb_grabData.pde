import oscP5.*;
OscP5 oscP5;

//camera recoding 
import com.hamoid.*;
import processing.video.*;
Capture cam;
PGraphics canvas;

boolean found;
PVector[] meshPoints;
float poseScale;
float posePos_x;
float posePos_y;
float poseOrt_x;
float poseOrt_y;
float poseOrt_z;
//
PVector posePosition;
PVector poseOrientation;
float leftEyebrowHeight;
float rightEyebrowHeight;
float eyeLeftHeight;
float eyeRightHeight;
float mouthWidth;
float mouthHeight;
float nostrilHeight;
//
int programFrame;
int videoFrame;
int i;
//info Array
float[][] info;
Table infoTable;
//reference values
Table referTable;
int NKframe;
float NKBrowL,NKBrowR,NKEyeL,NKEyeR,NKNose,NKMouthH,NKMouthW,NKOriX,NKOriY,NKOriZ;

//settings
int w = 1280;
int h = 920;
int score =0;
String scoreString="";
//int area =1; //threshold
void settings(){
  size(w,h,P3D);
}
void setup(){
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
  
  
   //XXXXXXXXXXXXXXXXXX
  //FACEOSC PLUG-INS
  //XXXXXXXXXXXXXXXXXX
  posePosition = new PVector();
  poseOrientation = new PVector();
  initMesh();
  oscP5 = new OscP5(this, 8338);
  // USE THESE 2 EVENTS TO DRAW THE 
  // FULL FACE MESH:
  oscP5.plug(this, "found", "/found");oscP5.plug(this, "loadMesh", "/raw");oscP5.plug(this, "eyeLeftReceived", "/gesture/eye/left");oscP5.plug(this, "eyeRightReceived", "/gesture/eye/right");
  oscP5.plug(this, "eyebrowLeftReceived", "/gesture/eyebrow/left");oscP5.plug(this, "eyebrowRightReceived", "/gesture/eyebrow/right");oscP5.plug(this, "mouthHeightReceived", "/gesture/mouth/height");
  oscP5.plug(this, "mouthWidthReceived", "/gesture/mouth/width");oscP5.plug(this, "nostrilsReceived", "/gesture/nostrils");oscP5.plug(this, "jawReceived", "/gesture/jaw");oscP5.plug(this, "posePosition", "/pose/position");
  oscP5.plug(this, "poseScale", "/pose/scale");oscP5.plug(this, "poseOrientation", "/pose/orientation");
   infoTable = new Table();infoTable.addColumn("frameCount");infoTable.addColumn("LBrowH");infoTable.addColumn("RBrowH");infoTable.addColumn("LEyeH");infoTable.addColumn("REyeH");
   infoTable.addColumn("nose");infoTable.addColumn("MouseH");infoTable.addColumn("MouseW");infoTable.addColumn("OriX");infoTable.addColumn("OriY");infoTable.addColumn("OriZ");
   saveTable(infoTable, "table.csv");
   //loadReferTable();
  referTable = loadTable("NikkiVideoData.csv","header");
  canvas = createGraphics(w,h,P3D);
  frameRate(30);
}

//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

void draw(){
  if(cam.available() ==true){
     cam.read(); 
   }
   pushMatrix();
   translate(canvas.width,0);
   scale(-1,1);
   canvas.beginDraw();
   
   image(cam,0,0);
   canvas.endDraw();
   popMatrix();
   //loadReferTable();
 //frameCount = programFrame;
   //TableRow newRow = infoTable.addRow();
   // newRow.setInt("frameCount", frameCount);//infoTable.lastRowIndex());
   // newRow.setFloat("LBrowH", Math.round(leftEyebrowHeight*100)/100.0);
   // newRow.setFloat("RBrowH", Math.round(rightEyebrowHeight*100)/100.0);
   // newRow.setFloat("LEyeH", Math.round(eyeLeftHeight*100)/100.0);
   // newRow.setFloat("REyeH", Math.round(eyeRightHeight*100)/100.0);
   // newRow.setFloat("nose", Math.round(nostrilHeight*100)/100.0);  
   // newRow.setFloat("MouseH", Math.round(mouthHeight*100)/100.0);
   // newRow.setFloat("MouseW", Math.round(mouthWidth*100)/100.0);
   // newRow.setFloat("OriX", Math.round(poseOrt_x*100)/100.0);
   // newRow.setFloat("OriY", Math.round(poseOrt_y*1000)/1000.0);
   // newRow.setFloat("OriZ", Math.round(poseOrt_z*100)/100.0);
 
 
 
 
 
   if (eyeLeftHeight != 0.0&& plugged){
    //reportFrame();
    TableRow newRow = infoTable.addRow();
    newRow.setInt("frameCount", frameCount);//infoTable.lastRowIndex());
    newRow.setFloat("LBrowH", Math.round(leftEyebrowHeight*100)/100.0);
    newRow.setFloat("RBrowH", Math.round(rightEyebrowHeight*100)/100.0);
    newRow.setFloat("LEyeH", Math.round(eyeLeftHeight*100)/100.0);
    newRow.setFloat("REyeH", Math.round(eyeRightHeight*100)/100.0);
    newRow.setFloat("nose", Math.round(nostrilHeight*100)/100.0);  
    newRow.setFloat("MouseH", Math.round(mouthHeight*100)/100.0);
    newRow.setFloat("MouseW", Math.round(mouthWidth*100)/100.0);
    newRow.setFloat("OriX", Math.round(poseOrt_x*100)/100.0);
    newRow.setFloat("OriY", Math.round(poseOrt_y*1000)/1000.0);
    newRow.setFloat("OriZ", Math.round(poseOrt_z*100)/100.0);
    /*if(frameCount<90){
      TableRow row = referTable.getRow(frameCount);
      NKframe = row.getInt("frameCount");
      NKBrowL = row.getFloat("LBrowH");
      NKBrowR = row.getFloat("RBrowH");
      NKEyeL = row.getFloat("LEyeH");
      NKEyeR = row.getFloat("REyeH");
      NKNose = row.getFloat("nose");
      NKMouthH = row.getFloat("MouseH");
      NKMouthW = row.getFloat("MouseW");
      NKOriX = row.getFloat("OriX");
      NKOriY = row.getFloat("OriY");
      NKOriZ = row.getFloat("OriZ");
    }*/
    
   //if(frameCount >=90){
   //  Score();
   //  frameCount =0;
   //  score = 0;
   //}
 } else {//if(eyeLeftHeight == 0){//
   frameCount =0;
   //score = 0;
   
   
 }
 //exportFiles();///saveStringfile

 println(frameCount +" : "+ poseOrt_y);
 //println("FRAMECOUNT : "+frameCount+"    SCORE : "+score);
 saveTable(infoTable, "table.csv");//,"html");
}