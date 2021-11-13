// button view kamera action
void kameraswitch(boolean sw) {
  if(sw==true) {
    switchcam1 = true;
  } else {
    switchcam1 = false;}
}

void tampak3D() {
  camera.setActive(false);
  camera.setRotations(-1.12, 0, 0);  //-1.19, -0.52, 0.2
  camera.lookAt(-226, -10, 30);   //-220, -100, 50
  //println("Posisi tampak 3d = "+rotationstampak3d[0], rotationstampak3d[1], rotationstampak3d[2]);
}

void tampakdepan() {
    camera.setActive(false);
    camera.lookAt(-226, -10, 70);
    camera.setRotations(300.1, 0.17, 0);
    //println("Posisi tampak depan = "+rotationsdepan[0], rotationsdepan[1], rotationsdepan[2]);
}

void tampakbelakang() {
    camera.setActive(false);
    camera.lookAt(226, 10, 70);
    camera.setRotations(-300, -0.17, 3.140);
    //println("Posisi tampak depan = "+rotationsbelakang[0], rotationsbelakang[1], rotationsbelakang[2]);
}
void tampakkanan() {
    camera.setActive(false);
    camera.lookAt(-100, 180, 50);
    camera.setRotations(-1.5, 1.4, -0.1);
    //println("Posisi tampak depan = "+rotationskanan[0], rotationskanan[1], rotationskanan[2]);
}
void tampakkiri() {
    camera.setActive(false);
    camera.lookAt(100, -180, 0.2);
    camera.setRotations(0, -1.4, 1.52);
    //println("Posisi tampak depan = "+rotationskiri[0], rotationskiri[1], rotationskiri[2]);
}
void tampakatas() {
    camera.setActive(false);
    camera.lookAt(-200, 0, 300);
    camera.setRotations(0, 0.4, 0);
    //println("Posisi tampak atas = "+rotationstampakatas[0], rotationstampakatas[1], rotationstampakatas[2]);
}
void tampakbawah() {
    camera.setActive(false);
    camera.lookAt(-215, -0.5, 1);
    camera.setRotations(600, 0.3, 0);
    //println("Posisi tampak atas = "+rotationstampakatas[0], rotationstampakatas[1], rotationstampakatas[2]);
}

// button reset action
void Butreset() {
    gui.Butreset();
    prevmillis = millis();
}

// toggle switch motion digit and continous
void toggle(boolean theFlag) {
  if(theFlag==true) {
    togglestate = false;
  } else {
    togglestate = true;
  }
}

// button planar motion action 
void planarSHM(boolean theFlag) {
  if(theFlag==false) {
    numbermotion = 1;
  } else {numbermotion = 0;}
}

void Precession(boolean theFlag) {
  if(theFlag==false) {
    numbermotion = 2;
  } else {numbermotion = 0;}
}

void verticalSHM(boolean theFlag) {
  if(theFlag==false) {
    numbermotion = 3;
  } else {numbermotion = 0;}
}

void rollSHM(boolean theFlag) {
  if(theFlag==false) {
    numbermotion = 4;
  } else {numbermotion = 0;}
}

void pitchSHM(boolean theFlag) {
  if(theFlag==false) {
    numbermotion = 5;
  } else {numbermotion = 0;}
}

void yawSHM(boolean theFlag) {
  if(theFlag==false) {
    numbermotion = 6;
  } else {numbermotion = 0;}
}

void SB(boolean theFlag) {  // self balancing button
  if(theFlag==true) {
    numbermotion = 7;
  } else {numbermotion = 0;}
}

void Butsend() {
  buttonsendstate = 1;
}

void Butstop() {
  buttonsendstate = 0;
}

void Butdown() {
  int d = day();
  int m = month();
  int y = year();
  int h = hour();
  int min = minute();
  int s   = second();
  
  filename = "data/1_SP_Datalog" + str(d) + "-" + str(m)+ "-"+ str(y) + "--" + str(h) + "-" + str(min) + "-" + str(s) + ".csv";
  saveTable(table, filename);
}

void Butrecord(boolean theFlag) {
  if(theFlag == true) {
    recordpress = true;
  } else {
    recordpress = false;
  }
}

void butconnect() {
  gui.butdisconnect.bringToFront();
  // setup serial comm
  if(serial == null) {
  serial = new Serial(this, "COM3", 115200);
  }
  //stateactivebuttonserial = true;
}

void butdisconnect() {
  gui.butconnect.bringToFront();
  if(serial != null) {
    serial.stop();
    serial = null;
  }
}

// digital translasional dan rotasional
void plusX(){ gui.plusX();}
void minusX(){ gui.minusX(); }
void plusY(){ gui.plusY(); } 
void minusY(){ gui.minusY(); }
void plusZ(){ gui.plusZ(); } 
void minusZ(){ gui.minusZ(); }

void plusRoll(){ gui.plusRoll();} 
void minusRoll() { gui.minusRoll(); }
void plusPitch(){ gui.plusPitch(); } 
void minusPitch(){ gui.minusPitch(); }
void plusYaw(){ gui.plusYaw(); } 
void minusYaw(){gui.minusYaw();}
