import java.util.Locale;
import processing.serial.*;
import controlP5.*;
import peasy.*;


// define class
Serial serial = null; 
ControlP5 cp5;
PeasyCam camera;
stewartplatform xPlatform;
GUI gui;


// define multiplier trans and rot
float Mult_TRANSLASI = 30;
float Mult_ROTASI = radians(18); // atau di 18 derajat

// define input variable
float posX = 0, posY = 0, posZ = 0, rotX = 0, rotY = 0, rotZ = 0;
float plusX = 0, minusX = 0, plusY = 0, minusY = 0, plusZ = 0, minusZ = 0;
float digiX = 0, digiY = 0, digiZ = 0, digiRoll = 0, digiPitch = 0, digiYaw = 0;
float plusRoll = 0, minusRoll = 0, plusPitch = 0, minusPitch = 0, plusYaw = 0, minusYaw = 0;
float incrementrot = 0, incrementtrans = 0;

boolean ctrlPress = false, togglestate,switchcam1;
float[] servo;

int time, wait = 0;
String sendX, sendY, sendZ, sendRoll, sendPitch, sendYaw;

float[] datamasuk;
String usbString;

float satu, dua, tiga, empat, lima, enam;
float previousTime = 0, prevcounter = 0, prevcounter1 = 0;
int  prevmillis = 0;
int timesampling = 0;

int numbermotion = 0;
float t = 0.0, dt = 0.1;
float frequency = 1.5;
PVector outplanar, outprecession, outverticalshm, outrollshm, outpitchshm, outyawshm, setpoint_balancing, rawdatain, rawdatain2;

String[] Sendconvdata;
int buttonsendstate = 0;

Table table; boolean recordpress; String filename;

void setup() {
  background(0);
  size(1280, 900, P3D);   //1024 768
  smooth();
  frameRate(60);
  textSize(20);
  Locale.setDefault(Locale.US);
  
  camera = new PeasyCam(this, 500);
  camera.setRotations(-1.12, 0, 0);  //-1.19, -0.52, 0.2
  camera.lookAt(-226, -10, 30);   //-220, -100, 50
  camera.setResetOnDoubleClick(false);
  camera.setActive(true);

  xPlatform = new stewartplatform(1);
  xPlatform.applyTranslasidanRotasi(new PVector(), new PVector());
  
  cp5    = new ControlP5(this);
  gui    = new GUI();
  table  = new Table();
  
  // GUI setup init
  gui.GUIsetup();
  cp5.setAutoDraw(false);
  rectMode(CENTER);
  
  // table config
  table.addColumn("ROLL");
  table.addColumn("PITCH");
  table.addColumn("YAW");
  table.addColumn("Time");
}

void draw() {
  // setup camera background
  camera.setActive(false);
  background(0);
  surface.setTitle("Stewart platform GUI ver.0.8 | Copyright ©2021");
  
  // calculate HARMONIC MOTION PLANNING
  if(numbermotion == 1) {
     calcplanar();
     xPlatform.applyTranslasidanRotasi(PVector.mult(new PVector(-1*outplanar.x, outplanar.y, 0), Mult_TRANSLASI),
     PVector.mult(new PVector(0, 0, 0), Mult_ROTASI));
     convertdata(outplanar.x, outplanar.y, 0, 0, 0, 0, 0);
   }
   else if(numbermotion == 2) {
     calcprecession();
     xPlatform.applyTranslasidanRotasi(PVector.mult(new PVector(0, 0, 0), Mult_TRANSLASI),
     PVector.mult(new PVector(outprecession.x, -1 * outprecession.y, 0), Mult_ROTASI));
     convertdata(0, 0, 0, outprecession.x, outprecession.y, 0, 0);
   }
   else if(numbermotion == 3) {
     calcverticalshm();
     xPlatform.applyTranslasidanRotasi(PVector.mult(new PVector(outverticalshm.x, outverticalshm.y, outverticalshm.z), Mult_TRANSLASI),
     PVector.mult(new PVector(0, 0, 0), Mult_ROTASI));
     convertdata(outverticalshm.x, outverticalshm.y, outverticalshm.z, 0, 0, 0, 0);
   }
   else if(numbermotion == 4) {
     calcrollshm();
     xPlatform.applyTranslasidanRotasi(PVector.mult(new PVector(0, 0, 0), Mult_TRANSLASI),
     PVector.mult(new PVector(outrollshm.x, outrollshm.y, outrollshm.z), Mult_ROTASI));
     convertdata(0, 0, 0, outrollshm.x, outrollshm.y, outrollshm.z, 0);
   }
   else if(numbermotion == 5) {
     calcpitchshm();
     xPlatform.applyTranslasidanRotasi(PVector.mult(new PVector(0, 0, 0), Mult_TRANSLASI),
     PVector.mult(new PVector(outpitchshm.x, -1*outpitchshm.y, outpitchshm.z), Mult_ROTASI));
     convertdata(0, 0, 0, outpitchshm.x, outpitchshm.y, outpitchshm.z, 0);
   }
   else if(numbermotion == 6) {
     calcyawshm();
     xPlatform.applyTranslasidanRotasi(PVector.mult(new PVector(0, 0, 0), Mult_TRANSLASI),
     PVector.mult(new PVector(outyawshm.x, outyawshm.y, -1*outyawshm.z), Mult_ROTASI));
     convertdata(0, 0, 0, outyawshm.x, outyawshm.y, outyawshm.z, 0);
   }
   
// FOR SELF BALANCING INPUT DATA
   else if(numbermotion == 7) {
     //setupbalancing();
     convertdata(0, 0, 0, 0.001, 0.001, 0.001, 1);
     //convertdata(0, 0, 0, setpoint_balancing.x, setpoint_balancing.y, setpoint_balancing.z, 1);
   }
  
  //  SLIDER CONTROL INPUT
  if(togglestate == true && numbermotion == 0) {
    xPlatform.applyTranslasidanRotasi(PVector.mult(new PVector(-1*posX, posY, posZ), Mult_TRANSLASI),
    PVector.mult(new PVector(rotX, -1 * rotY, -1*rotZ), Mult_ROTASI));
    convertdata(posX, posY, posZ, rotX, rotY, rotZ, 0);
  }
    else if(togglestate == false && numbermotion == 0) {
      xPlatform.applyTranslasidanRotasi(PVector.mult(new PVector(-1*digiX, digiY, digiZ), Mult_TRANSLASI),
      PVector.mult(new PVector(digiRoll, -1*digiPitch, -1*digiYaw), Mult_ROTASI));
      convertdata(digiX, digiY, digiZ, digiRoll, digiPitch, digiYaw, 0);
  }

  // send data in array
  String RotxTrans = "<"+Sendconvdata[0]+ ","+Sendconvdata[1]+","+Sendconvdata[2]+","+Sendconvdata[3]+","+Sendconvdata[4]+","+Sendconvdata[5]+","+Sendconvdata[6];
  
  // send via serial monitor
  if(buttonsendstate == 1) {
    serial.write(RotxTrans);
    
  // send input data via serial
  //float currentTime = millis();
  //if(currentTime - previousTime >= 10){
  //  serial.write(RotxTrans);
  //  serial.write("\n \r");
  //  previousTime = currentTime;
  //  }
  }
  
  // monitoring update nilai input ke tampilan numberbox
  GUIvalueinputbutton();
  
  // monitor servo rotation in degree
  float[] servo = xPlatform.getAlpha();
  gui.knob(servo);
  
  // monitor response roll, pitch, yaw
  incomingmpu6050();
  datarealtime();
  
  // visualisasi 3D stewart platform
  xPlatform.draw();
  
  // gambar background grid
  gui.DrawGridbackground();
  
  if(recordpress == true) {
    Tablelogdata();
  } else {
  
  }
  
  hint(DISABLE_DEPTH_TEST);
  camera.beginHUD();
  cp5.draw();
  gui.copyrightGUI();
  gui.titleGUI();
  camera.endHUD();
  hint(ENABLE_DEPTH_TEST);
}


void serialEvent(Serial serial) {
  
  try {
    usbString = serial.readStringUntil ('\n');
    
    if (usbString != null) 
    {
      usbString = trim(usbString);
      //println(usbString);
    }
    
    datamasuk = float(split(usbString, ','));
    float satu  = datamasuk[0];  // roll
    float dua   = datamasuk[1];  // pitch
    float tiga  = datamasuk[2];  // yaw
    float empat = datamasuk[3];  // PID roll
    float lima  = datamasuk[4];  // PID pitch
    //float enam  = datamasuk[5];
    //float tujuh = datamasuk[6];
    //float delapan = datamasuk[7];

    
    rawdatain  = new PVector(satu,dua,tiga);
    rawdatain2 = new PVector(empat,lima,0.01);

    //print("Debug Outfuzzy = ");print(enam);print(","); print(tujuh);print(",");print(delapan); 
    //println();
  }
  catch(RuntimeException e)
  {
    //null
  }
}

void incomingmpu6050() {
  try {
      // monitor and plot graphic from serial monitor
      gui.chartroll.push("incoming",rawdatain.x);   // rawdatain.x
      gui.chartpitch.push("incoming1",rawdatain.y); // rawdatain.y
      gui.chartyaw.push("incoming2",rawdatain.z);   // rawdatain.z
  }
  catch(RuntimeException e) {
    // null
  }
}

void datarealtime() {
  try {
      gui.rollvalue.setValue(rawdatain.x);  // rawdatain.x
      gui.pitchvalue.setValue(rawdatain.y); // rawdatain.y
      gui.yawvalue.setValue(rawdatain.z);   // rawdatain.z
      gui.PIDx.setValue(rawdatain2.x);      // rawdatain2.x
      gui.PIDy.setValue(rawdatain2.y);      // rawdatain2.y
  }
  catch(RuntimeException e) {
    // null
  }
}

void GUIvalueinputbutton() {
  gui.coordinateX(togglestate);gui.coordinateY(togglestate);gui.coordinateZ(togglestate);
  gui.attitudeRoll(togglestate);gui.attitudePitch(togglestate);gui.attitudeYaw(togglestate);
}
 
void controlEvent(ControlEvent theEvent) {
  camera.setActive(false);
  if(switchcam1==true){camera.setActive(true);}
  else{camera.setActive(false);}
  camera.setResetOnDoubleClick(false);
}
