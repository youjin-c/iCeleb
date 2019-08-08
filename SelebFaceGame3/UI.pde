void drawUI() {
  background(255);
  switch(MENU) {
  case 'H' :
    home();
    break;
  case 'C' :
    //println("videoframe : " + videoFrame + "  Mtime : "+round(myMovie.time()*10)/10.0 + "  MDuration : "+ floor(myMovie.duration()*10)/10.0);
    if (myMovie.available()) {
      myMovie.read();
    }
    imageMode(CENTER);
    image(myMovie, width/2, height/2);  
    image(Btn01, width/2-140, height-40, 50, 50);
    image(Btn02, width/2-70, height-40, 50, 50);
    image(Btn03, width/2, height-40, 50, 50);
    image(Btn04, width/2+70, height-40, 50, 50);
    image(Btn05, width/2+140, height-40, 50, 50);
    image(num0c,width/2,height/2);
    if (round(myMovie.time()*10)/10.0>=floor(myMovie.duration()*10)/10.0) {
      println("Exit charSel");
      Btn03=loadImage("Btn-03.png");
      myMovie.stop();
      play=true;
      myMovie = new Movie(this, clipAddress);
      myMovie.speed(1);
      myMovie.play();
      MENU = 'G';
    }
    break;
  case 'G' :
     if (cam.available() ==true) { 
      cam.read();
    }     
    if (myMovie.available()) {
      myMovie.read();
    }
    imageMode(CORNER);
    image(myMovie, 0, 200, width/2, height/2);
    pushMatrix(); 
    translate(canvas.width, 0);
    scale(-1, 1); 
    canvas.beginDraw();
    canvas.image(cam, 0, 0, canvas.width, canvas.height);
    canvas.endDraw();
    image(canvas, -canvas.width, 200);
    popMatrix();
    scoreBoard(); 
    image(Btn01, 10, 10, 50, 50);
    //image(light, width/2+20, 570, 50, 50);
    gameSet();
    break;
  }
}
int timerGame;
int reset=0;
int countTime=3000;
int counting;

void gameSet() {
  switch (GAME) {
  case 'I':
    image(num0b,0,0);
    timerGame=millis()-reset;
    countTime=2000;
      if (millis()>=reset+countTime) {
        reset = millis();
        videoFrame = 0;
        myMovie.volume(0); 
        myMovie.play();
        GAME = 'T';
      }
  break;
    
  case 'T': //tutorial: show video once! and 3, 2, 1
    myMovie.play();
    if (round(myMovie.time()*10)/10.0 >= floor(myMovie.duration()*10)/10.0) {// WHEN CLIP ends 
      GAME = 'W';
      endOfClip = true;
      println("gameEnds");
      myMovie.stop();
      myMovie.jump(0);
      waittime = true;      
      println("first: "+timerGame);
      reset=millis();
    }
    break;
  case 'W':
      timerGame=millis()-reset;
      countTime=7000;
      counting = ((countTime-timerGame)/1000);   
      if (millis()>=reset+countTime) {
        reset = millis();
        videoFrame = 0;
        myMovie.volume(0); 
        myMovie.play();
        GAME = 'P';
      } 
      if (counting == 3) {
        image(layout,0,0);
        image(num3, 0, 0);
        image(num0d,0,0);
      } else if (counting == 2) {
        image(layout,0,0);
        image(num2, 0, 0);
        image(num0d,0,0);
      } else if (counting == 1) {
        image(layout,0,0);
        image(num1, 0, 0);
        image(num0d,0,0);
      } else if (counting > 3) {
        image(layout,0,0);
        image(num0, 0, 0);
      }
     break;
  case 'P': //Play : clip plays again and player have to mimic the clip
  textSize(24);
  fill(0);
    text("Facial Famous Points: "+scoreP, width/2, 100); 
    if (waittime) { 
    }
    if (round(myMovie.time()*10)/10.0 >= floor(myMovie.duration()*10)/10.0) {// WHEN CLIP ends 
      //GAME = 'S';
      endOfClip = true;
    image(rBtn, 20, 650, 50, 50);
    //image(loopBtn, 80, 650, 50, 50);
      // waittime=true;
      //println("gameEnds");
    }else{
      endOfClip = false;
    }
    break;
  case 'S':
  // cam();
    text("playing time", width/2, height-100);
    textFont(Head);
    textSize(24);
    fill(0);
    text("Facial Famous Points: "+score, width/2, 100);
    light = loadImage("greenLight.png");
    break;
  }
}