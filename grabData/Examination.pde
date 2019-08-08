void Score(){
  //println("///////////////////////////////CSV : "+NKBrowL +"  WEBCAM : "+leftEyebrowHeight + "  SCORE : "+score);
    //if(NKBrowL-area <leftEyebrowHeight && NKBrowL+area >leftEyebrowHeight){
    //  score++;
    //}if (NKBrowR-area<rightEyebrowHeight && NKBrowR+area >rightEyebrowHeight){
    //  score++;
    //}if(NKEyeL-area< eyeLeftHeight && NKEyeL+area> eyeLeftHeight){
    //  score++;
    //}if(NKEyeR-area< eyeRightHeight && NKEyeR+area >eyeRightHeight ){
    //  score++;
    //}if(NKNose-area< nostrilHeight && NKNose+area >nostrilHeight){
    //  score++;
    //}if(NKMouthH-area< mouthHeight && NKMouthH+area> mouthHeight){
    //  score++;
    //}if (NKMouthW-area< mouthWidth && NKMouthW+area> mouthWidth){
    //  score++;
    //}if(NKOriX-area<poseOrt_x && NKOriX+area>poseOrt_x){
    //  score++;
    //}if(NKOriY-area<poseOrt_y && NKOriY+area>poseOrt_y){
    //  score++;
    //}if(NKOriZ-area<poseOrt_z && NKOriZ+area>poseOrt_z){
    //  score++;
    //}
    //textSize(60);
    //text(score+"\n"+scoreString,30,100);
  
  if (score < 300){
    //text(score+"You are such a mundane person.",100,150);
    //text();
    scoreString = "You are such a mundane person.";
  } else if (score>=300 && score<=450){
    println(score+"Your acting is ok but still too boring.");
    //text(score+"Your acting is ok but still too boring.",100,150);
    scoreString = "Your acting is ok but still too boring.";
  } else if ( score>450 & score <=650){
    println(score+"You are kidda fancy person.");
    scoreString = "You are kidda fancy person.";
    //text(score+"You are kidda fancy person.",100,150);
  } else if ( score>650 & score <=800){
    println(score+"Ahrr.. May be you can be a star one day.");
    scoreString = "Ahrr.. May be you can be a star one day.";
    //text(score+"Ahrr.. May be you can be a star one day.",100,150);
  }else if ( score>800 ){
    println(score+"Yeah... you do good. Ready for a celeb life?");
    scoreString = "Yeah... you do good. Ready for a celeb life?";
    //text(score+"Yeah... you do good. Ready for a celeb life?",100,150);
  }
}

float area =0.2; //threshold
float ori = 0.01;
void loadReferTable(){
  //referTable = loadTable("NikkiVideoData.csv","header");
  //println(referTable.getRowCount() + "total rows in table");
  for(TableRow row : referTable.rows()){
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
    println("DATA FROM THE CSV : "+NKOriZ);
    if(NKBrowL-area <leftEyebrowHeight && NKBrowL+area >leftEyebrowHeight){
      score++;
    }if (NKBrowR-area<rightEyebrowHeight && NKBrowR+area >rightEyebrowHeight){
      score++;
    }if(NKEyeL-area< eyeLeftHeight && NKEyeL+area> eyeLeftHeight){
      score++;
    }if(NKEyeR-area< eyeRightHeight && NKEyeR+area >eyeRightHeight ){
      score++;
    }if(NKNose-area< nostrilHeight && NKNose+area >nostrilHeight){
      score++;
    }if(NKMouthH-area< mouthHeight && NKMouthH+area> mouthHeight){
      score++;
    }if (NKMouthW-area< mouthWidth && NKMouthW+area> mouthWidth){
      score++;
    }if(NKOriX-ori<poseOrt_x && NKOriX+ori>poseOrt_x){
      score++;
    }if(NKOriY-ori<poseOrt_y && NKOriY+ori>poseOrt_y){
      score++;
    }if(NKOriZ-ori<poseOrt_z && NKOriZ+ori>poseOrt_z){
      score++;
    }
  }
}