int f;
int max;
void mousePressed() {
  switch (MENU) {
  case 'H' :
    if (mouseOver!=0) {
      switch (mouseOver) {
      case 1 :  
        videoAddress = "../data/vdos/pew_vid.mp4";  
        clipAddress = "../data/gameClips/pew_trim.mp4"; 
        layout=loadImage("../data/gameClips/pew_layout.png");
        f = 35;  
        referTable = loadTable("../csv/pew.csv", "header");
        celebName="PewDiePie";
        max=70;
        break;
      case 2 :  
        videoAddress = "../data/vdos/ksi_vid2.mp4"; 
        clipAddress = "../data/gameClips/ksi_trim.mp4";
        layout=loadImage("../data/gameClips/ksi_layout.png");
        f = 53;  
        referTable = loadTable("../csv/KSI.csv", "header");
        celebName="KSI"; 
        max=200;
        break;
      case 3 :  
        videoAddress = "../data/vdos/js_vid.mp4";   
        clipAddress = "../data/gameClips/JS11_hi.mp4"; 
        layout=loadImage("../data/gameClips/js_layout.png");
        f=154; 
        referTable=loadTable("../csv/JS.csv", "header");
        celebName="JEFFREE STARR";
        max=200;
        break;
      case 4 :  
        videoAddress = "../data/vdos/German_vid.mp4";
        clipAddress = "../data/gameClips/German_trim.mp4";
        layout=loadImage("../data/gameClips/German_layout.png");
        f=14; 
        referTable=loadTable("../csv/German.csv","header");
        celebName="HolaSoyGerman";
        max=80;
        break;
      case 5 :  
        videoAddress = "../data/vdos/shane_vid.mp4";
        clipAddress = "../data/gameClips/shane_trim.mp4"; 
        layout=loadImage("../data/gameClips/shane_layout.png");
        f=17; 
        referTable=loadTable("../csv/shane.csv","header");
        celebName="Shane Dawson";
        max=80;
        break;
      case 6 :  
        videoAddress = "../data/vdos/BB_vid.mp4";   
        clipAddress = "../data/gameClips/BB_trim.mp4";
        layout=loadImage("../data/gameClips/BB_layout.png");
        f=33; 
        referTable=loadTable("../csv/BB.csv","header");
        celebName="BB Ki Vines";
        max=150;
        break;
      case 7 :  
        videoAddress = "../data/vdos/gigi_vid.mp4"; 
        clipAddress = "../data/gameClips/gigi_trim.mp4";
        layout=loadImage("../data/gameClips/gigi_layout.png");
        f=71; 
        referTable=loadTable("../csv/GiGi.csv","header");
        celebName="Gigi Gorgeous";
        max=300;
        break;
      case 8 :  
        videoAddress = "../data/vdos/pomz_vid.mp4"; 
        clipAddress = "../data/gameClips/pomz_trim.mp4";
        layout=loadImage("../data/gameClips/pomz_layout.png");
        f=38; 
        referTable=loadTable("../csv/pomz.csv","header");
        celebName="SoftPomz";
        max=200;
        break;
      case 9 :  
        videoAddress = "../data/vdos/NK_vid.mp4";   
        clipAddress = "../data/gameClips/NK8_trim.mp4"; 
        layout=loadImage("../data/gameClips/NK8_layout.png");
        f=90; 
        referTable=loadTable("../csv/nk.csv","header");
        celebName="Nikkie Tutorial";
        max=300;
        break;
      }
    }
    homeCanvas.beginDraw();
    homeCanvas.clear();
    homeCanvas.endDraw();     
    myMovie = new Movie(this, videoAddress); 
    myMovie.speed(1);
    myMovie.play();
    MENU = 'C';
    break;
  case 'C' :
    //myMovie.stop();
    //myMovie = new Movie(this, clipAddress);     
    if (mouseX>width/2-20 && mouseX<width/2+20 && mouseY>height-60 && mouseY <height-20) {
      if (play) {
        Btn03=loadImage("Btn-06.png");
        myMovie.pause();
        play=false;
      } else {
        Btn03=loadImage("Btn-03.png");
        myMovie.speed(1);
        myMovie.play();
        play=true;
      }
    } else if (mouseX<width/2+165 && mouseX>width/2+105 && mouseY>height-60 && mouseY <height-20) {
      println("Skip");
      Btn03=loadImage("Btn-03.png");
      myMovie.stop();
      play=true;
      myMovie = new Movie(this, clipAddress);  
      MENU = 'G';
      reset=millis();
    } else if (mouseX>width/2-155 && mouseX<width/2-115 && mouseY>height-60 && mouseY <height-20) {
      println("Exit");
      Btn03=loadImage("Btn-03.png");
      imageMode(CORNER);
      myMovie.stop();
      play=true;
      MENU = 'H';
    } else if (mouseX>width/2-90 && mouseX<width/2-45 && mouseY>height-60 && mouseY <height-20) {
      println("CurrentTime: "+myMovie.time());
      myMovie.jump(myMovie.time()-8.0);
      myMovie.play();
      play=true;
    } else if (mouseX<width/2+90 && mouseX>width/2+45 && mouseY>height-60 && mouseY <height-20) {
      println("fastforward");
      myMovie.speed(8.0);
      myMovie.play();
      play=true;
    }
    break;
  case 'G' :   
    if ((mouseX>20&&mouseX<70)&&(mouseY > 650 && mouseY <700)) {//reset
      println("reset");
      myMovie.jump(0);
      myMovie.pause();
      score=0;
      videoFrame = 0;
      endOfClip = true;
      reset=millis();
      scoreString="";
      GAME='W';
    }
    if ((mouseX>10&&mouseX<60)&&(mouseY>10&&mouseY<70)) {//exit
      println("exit");
      MENU = 'H';
      myMovie.stop();
      canvas.beginDraw();
      canvas.clear();
      canvas.endDraw();
      score=0;
      endOfClip=false;
      readytoPlay=false;
      waittime=false;
      GAME = 'I';
    }
    break;
  }
}
void home() {
  //println("mouseOver: "+mouseOver);
  homeCanvas.beginDraw();
  homeCanvas.background(255);
  homeCanvas.textAlign(CENTER);
  homeCanvas.image(title, width/2-185, 40);
  homeCanvas.noFill();
  homeCanvas.image(pew, width/5, 200, width/5, height/5);
  homeCanvas.image(ksi, width/5*2, 200, width/5, height/5);
  homeCanvas.image(js, width/5*3, 200, width/5, height/5);
  homeCanvas.image(gm, width/5, height/5+200, width/5, height/5);
  homeCanvas.image(shane, width/5*2, height/5+200, width/5, height/5);
  homeCanvas.image(bb, width/5*3, height/5+200, width/5, height/5);
  homeCanvas.image(gg, width/5, height/5*2+200, width/5, height/5);
  homeCanvas.image(pom, width/5*2, height/5*2+200, width/5, height/5);
  homeCanvas.image(nk, width/5*3, height/5*2+200, width/5, height/5);
  homeCanvas.endDraw();
  if (mouseX>width/5&&mouseX<width/5*2&&mouseY>200&&mouseY<height/5+200) {
    mouseOver=1;//println("PewDiePie");
  }
  if (mouseX>width/5*2 && mouseX<width/5*3 && mouseY>200 && mouseY<height/5+200) {
    mouseOver= 2;//println("KSI");
  }
  if (mouseX>width/5*3 && mouseX<width/5*4 && mouseY>200 && mouseY<height/5+200) {
    mouseOver=3;//println("Jeffree");
  }
  if (mouseX>width/5 && mouseX<width/5*2 && mouseY>height/5+200 && mouseY<height/5+370) {
    mouseOver=4;//println("German");
  }
  if (mouseX>width/5*2 && mouseX<width/5*3 && mouseY>height/5+200 && mouseY<height/5+370) {
    mouseOver=5;//println("Shane");
  }
  if (mouseX>width/5*3 && mouseX<width/5*4 && mouseY>height/5+200 && mouseY<height/5+370) {
    mouseOver=6;//println("BB");
  }
  if (mouseX>width/5 && mouseX<width/5*2 && mouseY>height/5*2+200 && mouseY<height/5*2+370) {
    mouseOver=7;//println("Gigi");
  }
  if (mouseX>width/5*2 && mouseX<width/5*3 && mouseY>height/5*2+200 && mouseY<height/5*2+370) {
    mouseOver=8;//println("SoftPomz");
  }
  if (mouseX>width/5*3 && mouseX<width/5*4 && mouseY>height/5*2+200 && mouseY<height/5*2+370) {
    mouseOver=9;//println("Nikkie");
  }
  image(homeCanvas, 0, 0);
}
void setupNewUI() {
  //fullScreen(); //full screen size is 1440x900
  textAlign(CENTER);
  Head = createFont("SanFranciscoDisplay-Bold.otf", 32);
  subTitle = createFont("SanFranciscoDisplay-Regular.otf", 12);
  canvas = createGraphics(w/2, h/2, P3D);
  homeCanvas = createGraphics(w, h);
  fill(0);
  //myMovie = new Movie(this, "../NK8_trim.mp4"); 
  // put after cam.start to get it play at the same time.
  qBtn = loadImage("quitBtn.png");
  rBtn = loadImage("reSetBtn.png");
  //loopBtn = loadImage("loopBtn.png");
  //light = loadImage("redLight.png");
  js=loadImage("thumbnails/JS.jpg");
  ksi=loadImage("thumbnails/ksi.jpg");
  nk=loadImage("thumbnails/nk.jpg");
  bb=loadImage("thumbnails/BB.jpg");
  gm=loadImage("thumbnails/German.jpg");
  gg=loadImage("thumbnails/gg.jpg");
  pew=loadImage("thumbnails/pew.jpg");
  pom=loadImage("thumbnails/pomz.jpg");
  shane=loadImage("thumbnails/shane.jpg");
  title=loadImage("cNNtitle.png");
  ///
  //charSel buttons
  Btn01=loadImage("Btn-01.png");
  Btn02=loadImage("Btn-02.png");
  Btn03=loadImage("Btn-03.png");
  Btn04=loadImage("Btn-04.png");
  Btn05=loadImage("Btn-05.png");
  ///
  //count numers
  num1=loadImage("num_1.png");
  num2=loadImage("num_2.png");
  num3=loadImage("num_3.png");
  num0=loadImage("num_0.png");
  num0b=loadImage("num_0_1.png");
  num0c=loadImage("num_0_2.png");
  num0d=loadImage("num_0_3.png");
}
void scoreBoard() {
  textFont(subTitle);
  textSize(20);
  fill(#009AEA);
  text(celebName, width/4, height-190);
  text("Prospective Celeb", width-(width/4), height-190);
  textSize(24);
  fill(0);
  text(scoreString, width/2, height-100);
}