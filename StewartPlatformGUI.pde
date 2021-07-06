 import java.util.Locale;
import processing.serial.*;
import controlP5.*;
import peasy.*;

// define maximum trans and rot
float MAX_TRANSLASI = 50;
float MAX_ROTASI = (PI/10); 

// define class
Serial serial; 
ControlP5 cp5;
PeasyCam camera;
stewartplatform xPlatform;
GUI gui;

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
long eventInterval = 50, previousTime = 0;

int numbermotion = 0;
float t = 0.0, dt = 0.1;
float frequency = radians(30);
PVector outplanar, outprecession, outverticalshm, outrollshm, outpitchshm, outyawshm, setpoint_balancing, rawdatain;

String[] Sendconvdata;
int buttonsendstate = 0;

void setup() {
  // size windows deskX, deskY
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
  
  gui.GUIsetup();
  cp5.setAutoDraw(false);
  
  // setup serial comm
  serial = new Serial(this, "COM3", 115200);
}

void draw() {
  // setup camera background
  camera.setActive(false);
  background(0);
  surface.setTitle("Stewart platform GUI v1.0");
  
  // calculate HARMONIC MOTION PLANNING
  if(numbermotion == 1) {
     calcplanar();
     xPlatform.applyTranslasidanRotasi(PVector.mult(new PVector(outplanar.x, outplanar.y, 0), MAX_TRANSLASI),
     PVector.mult(new PVector(0, 0, 0), MAX_ROTASI));
     convertdata(outplanar.x, outplanar.y, 0, 0, 0, 0, 0);
   }
   else if(numbermotion == 2) {
     calcprecession();
     xPlatform.applyTranslasidanRotasi(PVector.mult(new PVector(0, 0, 0), MAX_TRANSLASI),
     PVector.mult(new PVector(outprecession.x, -1 * outprecession.y, 0), MAX_ROTASI));
     convertdata(0, 0, 0, outprecession.x, outprecession.y, 0, 0);
   }
   else if(numbermotion == 3) {
     calcverticalshm();
     xPlatform.applyTranslasidanRotasi(PVector.mult(new PVector(outverticalshm.x, outverticalshm.y, outverticalshm.z), MAX_TRANSLASI),
     PVector.mult(new PVector(0, 0, 0), MAX_ROTASI));
     convertdata(outverticalshm.x, outverticalshm.y, outverticalshm.z, 0, 0, 0, 0);
   }
   else if(numbermotion == 4) {
     calcrollshm();
     xPlatform.applyTranslasidanRotasi(PVector.mult(new PVector(0, 0, 0), MAX_TRANSLASI),
     PVector.mult(new PVector(outrollshm.x, outrollshm.y, outrollshm.z), MAX_ROTASI));
     convertdata(0, 0, 0, outrollshm.x, outrollshm.y, outrollshm.z, 0);
   }
   else if(numbermotion == 5) {
     calcpitchshm();
     xPlatform.applyTranslasidanRotasi(PVector.mult(new PVector(0, 0, 0), MAX_TRANSLASI),
     PVector.mult(new PVector(outpitchshm.x, outpitchshm.y, outpitchshm.z), MAX_ROTASI));
     convertdata(0, 0, 0, outpitchshm.x, outpitchshm.y, outpitchshm.z, 0);
   }
   else if(numbermotion == 6) {
     calcyawshm();
     xPlatform.applyTranslasidanRotasi(PVector.mult(new PVector(0, 0, 0), MAX_TRANSLASI),
     PVector.mult(new PVector(outyawshm.x, outyawshm.y, outyawshm.z), MAX_ROTASI));
     convertdata(0, 0, 0, outyawshm.x, outyawshm.y, outyawshm.z, 0);
   }
   
   // FOR SELF BALANCING INPUT DATA
   else if(numbermotion == 7) {
     setupbalancing();
     convertdata(0, 0, 0, setpoint_balancing.x, setpoint_balancing.y, setpoint_balancing.z, 1);
   }
  
  //  SLIDER CONTROL INPUT
  if(togglestate == true && numbermotion == 0) {
    xPlatform.applyTranslasidanRotasi(PVector.mult(new PVector(posX, posY, posZ), MAX_TRANSLASI),
    PVector.mult(new PVector(rotX, -1 * rotY, rotZ), MAX_ROTASI));
    convertdata(posX, posY, posZ, rotX, rotY, rotZ,0);
  }
    else if(togglestate == false && numbermotion == 0) {
      xPlatform.applyTranslasidanRotasi(PVector.mult(new PVector(digiX, digiY, digiZ), MAX_TRANSLASI),
      PVector.mult(new PVector(digiRoll, -1*digiPitch, digiYaw), MAX_ROTASI));
      convertdata(digiX, digiY, digiZ, digiRoll, digiPitch, digiYaw,0);
  }

  // send data in array
  String RotxTrans = "<"+Sendconvdata[0]+ ","+Sendconvdata[1]+","+Sendconvdata[2]+","+Sendconvdata[3]+","+Sendconvdata[4]+","+Sendconvdata[5]+","+Sendconvdata[6];
  
  // send via serial monitor
  if(buttonsendstate == 1) {
  // println(RotxTrans);
  
  // send input data via serial
  long currentTime = millis();
  if(currentTime - previousTime >= eventInterval){
    serial.write(RotxTrans);
    serial.write("\n \r");
    previousTime = currentTime;
    }
  }
  
  // monitoring update nilai input ke tampilan numberbox
  gui.coordinateX(togglestate);gui.coordinateY(togglestate);gui.coordinateZ(togglestate);
  gui.attitudeRoll(togglestate);gui.attitudePitch(togglestate);gui.attitudeYaw(togglestate);
  
  // monitor servo rotation in degree
  float[] servo = xPlatform.getAlpha();
  gui.knob(servo);
  
  // monitor response roll, pitch, yaw
  incomingmpu6050();
  
  // visualisasi 3D stewart platform
  xPlatform.draw();
  
  // gambar background grid
  gui.DrawGridbackground();
  
  hint(DISABLE_DEPTH_TEST);
  camera.beginHUD();
  cp5.draw();
  camera.endHUD();
  hint(ENABLE_DEPTH_TEST);
}

// parseInt from arduino

void serialEvent(Serial serial) {
  try {
    usbString = serial.readStringUntil ('\n');

    if (usbString != null) 
    {
      usbString = trim(usbString);
      //println(usbString);
    }

    datamasuk = float(split(usbString, ','));
    float satu  = datamasuk[0];
    float dua   = datamasuk[1];
    float tiga  = datamasuk[2];
    float empat = datamasuk[3];
    float lima  = datamasuk[4];
    
    rawdatain = new PVector(satu,dua,tiga);
    print("Debug PID = ");print(empat);print(","); print(lima); print(" || "); print("Debug IMU = "); print(satu); print(","); print(dua); print(","); print(tiga); 
    println();
  }
  catch(RuntimeException e)
  {
    //null
  }
}

void incomingmpu6050() {
  try {
        // monitor and plot graphic from serial monitor
        gui.chartroll.push("incoming",rawdatain.x);
        gui.chartpitch.push("incoming1",rawdatain.y);
        gui.chartyaw.push("incoming2",rawdatain.z);
  }
  catch(RuntimeException e) {
    //null
  }
}
 
void controlEvent(ControlEvent theEvent) {
  camera.setActive(false);
  if(switchcam1==true){camera.setActive(true);}
  else{camera.setActive(false);}
  camera.setResetOnDoubleClick(false);
}
