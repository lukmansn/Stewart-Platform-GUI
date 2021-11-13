class GUI {
  private float x_pos, y_pos, z_pos, rollX, pitchY, yawZ;
  private float x, y, spasi, xmin, ymin, xplus, yplus, xplus1, yplus1,z;
  PImage title = loadImage("titlebar.png");
  
  Numberbox incrementRot; Numberbox incrementTrans;
  Numberbox showX; Numberbox showY; Numberbox showZ; Numberbox showRoll; Numberbox showPitch; Numberbox showYaw;
  Slider slidX; Slider slidY; Slider slidZ; Slider slidRoll; Slider slidPitch; Slider slidYaw;
  Button BplusX; Button BplusY; Button BplusZ; Button BminusX; Button BminusY; Button BminusZ;
  Button BplusRoll; Button BplusPitch; Button BplusYaw; Button BminusRoll; Button BminusPitch; Button BminusYaw;
  Knob knobserv1; Knob knobserv2; Knob knobserv3; Knob knobserv4; Knob knobserv5; Knob knobserv6;
  Chart chartroll; Chart chartpitch; Chart chartyaw;
  Numberbox rollvalue; Numberbox pitchvalue; Numberbox yawvalue; Numberbox PIDx; Numberbox PIDy;
  Button butconnect; Button butdisconnect;
  
  public void GUIsetup() {
  int paddingX, paddingY, paddingX1, paddingY1, paddinggrupX, paddinggrupY;

  paddingX1=0; paddingY1=20;
  paddinggrupX = -30; paddinggrupY = -40;
  paddingX = -20; paddingY = -30;
  PImage[] plus           = {loadImage("plusbutton.png"), loadImage("plusbutton1.png"), loadImage("plusbuttonback.png")};
  PImage[] minus          = {loadImage("minusbutton.png"), loadImage("minusbutton1.png"), loadImage("minusbuttonback.png")};
  PImage[] play           = {loadImage("play1.png"), loadImage("play2.png"), loadImage("play3.png")};
  PImage[] resetImg       = {loadImage("reset1.png"), loadImage("reset2.png"), loadImage("reset3.png")};
  PImage[] stop           = {loadImage("stop1.png"), loadImage("stop2.png"), loadImage("stop3.png")};
  PImage[] tombolview1    = {loadImage("view3d.png"), loadImage("view3d2.png"), loadImage("view3d3.png")};
  PImage[] tombolview2    = {loadImage("tampakdepan.png"), loadImage("tampakdepan2.png"), loadImage("tampakdepan3.png")};
  PImage[] tombolview3    = {loadImage("tampakbelakang.png"), loadImage("tampakbelakang2.png"), loadImage("tampakbelakang3.png")};
  PImage[] tombolview4    = {loadImage("tampakkanan.png"), loadImage("tampakkanan2.png"), loadImage("tampakkanan3.png")};
  PImage[] tombolview5    = {loadImage("tampakkiri.png"), loadImage("tampakkiri2.png"), loadImage("tampakkiri3.png")};
  PImage[] tombolview6    = {loadImage("tampakatas.png"), loadImage("tampakatas2.png"), loadImage("tampakatas3.png")};
  PImage[] tombolview7    = {loadImage("tampakbawah.png"), loadImage("tampakbawah2.png"), loadImage("tampakbawah3.png")};
  PImage[] tombolview8    = {loadImage("eye1.png"), loadImage("eye2.png"), loadImage("eye3.png")};
  PImage[] tomboldownload = {loadImage("download1.png"),loadImage("download2.png"),loadImage("download3.png")};
  PImage[] record         = {loadImage("record1.png"),loadImage("record2.png"),loadImage("record3.png")};
  PImage[] tombolconn     = {loadImage("connect1.png"),loadImage("connect2.png"),loadImage("connect3.png")};
  PImage[] tomboldisconn  = {loadImage("disconnect1.png"),loadImage("disconnect2.png"),loadImage("disconnect3.png")};

  
  // Sekumpulan grup
  Group grupall = cp5.addGroup("allgrouptray")
                .setLabel("")
                .hideBar()
                .setColorLabel(color(255))
                .setPosition(0, 10)
                .setWidth(770)
                .setBackgroundHeight(900)
                .setBackgroundColor(color(0, 0, 0,200))
                .setColorBackground(color(0,0,0,0))
                ;
  Group g0 = cp5.addGroup("Slider kontrol panel")
                .setLabel("Slider kontrol panel")
                .setFont(createFont("Arial Black",10))
                .setBarHeight(18)
                .setColorLabel(color(255))
                .setPosition(270, 678)
                .setWidth(242)
                .setBackgroundHeight(159)
                .setBackgroundColor(color(20, 20, 20))
                .setColorBackground(color(11,159,115))
                .setColorForeground(color(14,208,150))
                ;
  Group g1 = cp5.addGroup("Independent kontrol panel")
                .setLabel("Independent kontrol panel")
                .setFont(createFont("Arial Black",10))
                .setBarHeight(20)
                .setPosition(20, 678)
                .setWidth(242)
                .setBackgroundHeight(159)
                .setBackgroundColor(color(230, 230, 230, 200))
                .setBackgroundHeight(159)
                .setBackgroundColor(color(20, 20, 20))
                ;
 Group g2 = cp5.addGroup("Servo angle monitor")
                .setPosition(20, 105)
                .setLabel("Servo angle monitor")
                .setFont(createFont("Arial Black",10))
                .setBarHeight(18)
                .setWidth(242)
                .setBackgroundHeight(220)
                .setBackgroundColor(color(20, 20, 20))
                .setColorBackground(color(255,60,0))
                .setColorForeground(color(255,104,58))
                ;
 Group g3 = cp5.addGroup("Motion Platform")
                .setPosition(20, 350)
                .setWidth(242)
                .setLabel("Motion Platform")
                .setFont(createFont("Arial Black",10))
                .setBarHeight(20)
                .setBackgroundHeight(110)
                .setBackgroundColor(color(20, 20, 20))
                .setColorBackground(color(69,21,202))
                ;
 Group g4 = cp5.addGroup("Harmonic Motion")
                .setLabel("Harmonic Motion")
                .setFont(createFont("Arial Black",10))
                .setBarHeight(20)
                .setColorLabel(color(255))
                .setPosition(518, 678)
                .setWidth(242)
                .setBackgroundHeight(159)
                .setBackgroundColor(color(20, 20, 20))
                .setColorBackground(color(11,159,115))
                .setColorForeground(color(14,208,150))
                ;
 Group g5 = cp5.addGroup("outputvisual")
                .setLabel("Output Response")
                .setFont(createFont("Arial Black",10))
                .setBarHeight(20)
                .setColorLabel(color(255))
                .setPosition(270, 107)
                .setWidth(490)
                .setBackgroundHeight(545)
                .setBackgroundColor(color(20, 20, 20))
                .setColorForeground(color(255,198,81))
                .setColorBackground(color(255,188,0))
                ;
 Group g6 = cp5.addGroup("Gyrosensors")
                .setLabel("Real-time data log")
                .setFont(createFont("Arial Black",10))
                .setBarHeight(20)
                .setColorLabel(color(255))
                .setPosition(20, 484)
                .setWidth(242)
                .setBackgroundHeight(169)
                .setBackgroundColor(color(20, 20, 20))
                .setColorForeground(color(255,94,0))
                .setColorBackground(color(255,60,0))
                ;
 Group g7 = cp5.addGroup("Grupkamera")
                .setLabel("")
                .setBarHeight(20)
                .setColorLabel(color(255))
                .setPosition(774, 107)
                .setWidth(30)
                .setBackgroundHeight(320)
                .setBackgroundColor(color(20, 20, 20, 0))
                .setColorBackground(color(0,0,0,300))
                .setColorForeground(color(0,0,0,300))
                ;
 Group g8 = cp5.addGroup("sendandreset")
                .setLabel("")
                .hideBar()
                .setColorLabel(color(255))
                .setPosition(920, 758)
                .setWidth(200)
                .setBackgroundHeight(81)
                .setBackgroundColor(color(20, 20, 20,0))
                .setColorBackground(color(0,0,0,0))
                .setColorForeground(color(0,0,0))
                ;
                
  // Isi grup 0
  slidX = cp5.addSlider("posX")
             .setPosition(10, 20+paddingY1)
             .setSize(80, 20).setRange(-1, 1)
             .setValue(0)
             .setLabel("posX")
             .setColorCaptionLabel(color(255))
             .setColorForeground(color(11,159,115))
             .setColorBackground(color(9,118,85))
             .setColorActive(color(14,208,150))
             .setGroup(g0);
  slidY = cp5.addSlider("posY")
             .setPosition(10, 50+paddingY1)
             .setSize(80, 20).setRange(-1, 1)
             .setValue(0)
             .setLabel("posY")
             .setColorCaptionLabel(color(255))
             .setColorForeground(color(11,159,115))
             .setColorBackground(color(9,118,85))
             .setColorActive(color(14,208,150))
             .setColorCaptionLabel(color(255))
             .setGroup(g0);
  slidZ = cp5.addSlider("posZ")
             .setPosition(10, 80+paddingY1)
             .setSize(80, 20).setRange(-1, 1)
             .setValue(0)
             .setLabel("posZ")
             .setColorCaptionLabel(color(255))
             .setColorForeground(color(11,159,115))
             .setColorBackground(color(9,118,85))
             .setColorActive(color(14,208,150))
             .setColorCaptionLabel(color(255))
             .setGroup(g0);
  Textlabel slidertranslasi = cp5.addTextlabel("slidertrans")
                   .setText("Translasi")
                   .setPosition(10, 20-5)
                   .setColorValue(255)
                   .setFont(createFont("Arial",15))
                   .setGroup(g0)
                    ;

  slidRoll = cp5.addSlider("rotX")
                .setPosition(130, 20+paddingY1)
                .setSize(80, 20).setRange(-1, 1)
                .setValue(0)
                .setColorCaptionLabel(0)
                .setCaptionLabel("Roll")
                .setColorCaptionLabel(color(255))
                .setColorForeground(color(11,159,115))
                .setColorBackground(color(9,118,85))
                .setColorActive(color(14,208,150))
                .setGroup(g0);
  slidPitch = cp5.addSlider("rotY")
                 .setPosition(130, 50+paddingY1)
                 .setSize(80, 20).setRange(-1, 1)
                 .setValue(0)
                 .setColorCaptionLabel(0)
                 .setCaptionLabel("Pitch")
                 .setColorCaptionLabel(color(255))
                 .setColorForeground(color(11,159,115))
                 .setColorBackground(color(9,118,85))
                 .setColorActive(color(14,208,150))
                 .setGroup(g0);
  slidYaw = cp5.addSlider("rotZ")
               .setPosition(130, 80+paddingY1)
               .setSize(80, 20).setRange(-1, 1)
               .setValue(0)
               .setColorCaptionLabel(0)
               .setCaptionLabel("Yaw")
               .setColorCaptionLabel(color(255))
               .setColorForeground(color(11,159,115))
               .setColorBackground(color(9,118,85))
               .setColorActive(color(14,208,150))
               .setGroup(g0);
   Textlabel sliderrotasi = cp5.addTextlabel("sliderrot")
                   .setText("Rotasional")
                   .setPosition(130, 20-5)
                   .setColorValue(255)
                   .setFont(createFont("Arial",15))
                   .setGroup(g0)
                   ;
                   cp5.addToggle("toggle")
                      .setPosition(161, 111+paddingY1)
                      .setSize(50,20)
                      .setLabelVisible(false)
                      .setColorForeground(color(201,108,27))
                      .setColorBackground(color(201,108,27))
                      .setColorActive(color(255,162,0))
                      .setValue(true)
                      .setMode(ControlP5.SWITCH)
                      .moveTo(g0)
                      ;
                      cp5.addButton("SB")
                         .setCaptionLabel("self balancing")
                         .setFont(createFont("Arial Black",10))
                         .setPosition(0, 170)
                         .setSize(242, 20)
                         .setColorBackground(color(0,51,255))
                         .setColorForeground(color(0,128,255))
                         .setColorActive(color(11,159,115))
                         .setSwitch(true)
                         .moveTo(g0)
                         ;
    
  // Isi grup 1 independent button
   BplusX = cp5.addButton("plusX")
       .setPosition(70+paddinggrupX, 61+paddinggrupY)
       .setImages(plus)
       .setValue(0)
       .updateSize()
       .setGroup(g1)
       ;
  BminusX =cp5.addButton("minusX")
       .setPosition(92+paddinggrupX, 61+paddinggrupY)
       .setImages(minus)
       .setValue(0)
       .updateSize()
       .setGroup(g1)
       ;
       Textlabel labelX = cp5.addTextlabel("labelX")
                   .setText("X:")
                   .setPosition(40+paddinggrupX, 61+paddinggrupY)
                   .setColorValue(255)
                   .setFont(createFont("Arial",15))
                   .setGroup(g1)
                    ;
    BplusY = cp5.addButton("plusY")
       .setPosition(70+paddinggrupX, 85+paddinggrupY)
       .setImages(plus)
       .setValue(0)
       .updateSize()
       .setGroup(g1)
       ;
    BminusY = cp5.addButton("minusY")
       .setPosition(92+paddinggrupX, 85+paddinggrupY)
       .setImages(minus)
       .setValue(0)
       .updateSize()
       .setGroup(g1)
       ;
       Textlabel labelY = cp5.addTextlabel("labelY")
                    .setText("Y:")
                    .setPosition(40+paddinggrupX, 85+paddinggrupY)
                    .setColorValue(255)
                    .setFont(createFont("Arial",15))
                    .setGroup(g1)
                    ;
   BplusZ = cp5.addButton("plusZ")
       .setPosition(70+paddinggrupX, 108+paddinggrupY)
       .setImages(plus)
       .setValue(0)
       .updateSize()
       .setGroup(g1)
       ;
   BminusZ = cp5.addButton("minusZ")
       .setPosition(92+paddinggrupX, 108+paddinggrupY)
       .setImages(minus)
       .setValue(0)
       .updateSize()
       .setGroup(g1)
       ;
       Textlabel labelZ = cp5.addTextlabel("labelZ")
                    .setText("Z:")
                    .setPosition(40+paddinggrupX, 108+paddinggrupY)
                    .setColorValue(255)
                    .setFont(createFont("Arial",15))
                    .setGroup(g1)
                    ;
                   incrementTrans = cp5.addNumberbox("incrementtrans")
                                   .setColorCaptionLabel(color(255))
                                   .setSize(88, 20)
                                   .setPosition(40+paddinggrupX, 140+paddinggrupY)
                                   .setValue(0)
                                   .setMultiplier(0.01)
                                   .setRange(0,1)
                                   .setGroup(g1)
                                   ;
  // tombol rotasional
    BplusRoll = cp5.addButton("plusRoll")
       .setPosition(209+paddinggrupX, 61+paddinggrupY)
       .setImages(plus)
       .setValue(0)
       .updateSize()
       .setGroup(g1)
       ;
    BminusRoll = cp5.addButton("minusRoll")
       .setPosition(231+paddinggrupX, 61+paddinggrupY)
       .setImages(minus)
       .setValue(0)
       .updateSize()
       .setGroup(g1)
       ;
       Textlabel labelRoll = cp5.addTextlabel("labelRoll")
                    .setText("Roll:")
                    .setPosition(162+paddinggrupX, 61+paddinggrupY)
                    .setColorValue(255)
                    .setFont(createFont("Arial",15))
                    .setGroup(g1)
                    ;
    BplusPitch = cp5.addButton("plusPitch")
       .setPosition(209+paddinggrupX, 85+paddinggrupY)
       .setImages(plus)
       .setValue(0)
       .updateSize()
       .setGroup(g1)
       ;
    BminusPitch = cp5.addButton("minusPitch")
       .setPosition(231+paddinggrupX, 85+paddinggrupY)
       .setImages(minus)
       .setValue(0)
       .updateSize()
       .setGroup(g1)
       ;
       Textlabel labelPitch = cp5.addTextlabel("labelPitch")
                    .setText("Pitch:")
                    .setPosition(162+paddinggrupX, 85+paddinggrupY)
                    .setColorValue(255)
                    .setFont(createFont("Arial",15))
                    .setGroup(g1)
                    ;
   BplusYaw = cp5.addButton("plusYaw")
       .setPosition(209+paddinggrupX, 108+paddinggrupY)
       .setImages(plus)
       .setValue(0)
       .updateSize()
       .setGroup(g1)
       ;
   BminusYaw = cp5.addButton("minusYaw")
       .setPosition(231+paddinggrupX, 108+paddinggrupY)
       .setImages(minus)
       .setValue(0)
       .updateSize()
        .setGroup(g1)
       ;
      Textlabel labelYaw = cp5.addTextlabel("labelYaw")
                    .setText("Yaw:")
                    .setPosition(162+paddinggrupX, 108+paddinggrupY)
                    .setColorValue(255)
                    .setFont(createFont("Arial",15))
                    .setGroup(g1)
                    ;
                    incrementRot = cp5.addNumberbox("incrementrot")
                                   .setColorCaptionLabel(color(255))
                                   .setSize(88, 20)
                                   .setPosition(162+paddinggrupX,140+paddinggrupY)
                                   .setValue(0)
                                   .setMultiplier(0.01)
                                   .setRange(0,1)
                                   .setGroup(g1)
                                   ;
  
  // Grup 7 kamera
  int posisiXkamera = 0, posisiYkamera = 4;
  Button camactive = cp5.addButton("kameraswitch")
     .setPosition(posisiXkamera, posisiYkamera)
     .setImages(tombolview8)
     .setSwitch(true)
     .updateSize()
     .setGroup(g7)
     ;
  Button cam3d = cp5.addButton("tampak3D")
     .setPosition(posisiXkamera, posisiYkamera+40)
     .setImages(tombolview1)
     .updateSize()
     .setGroup(g7)
     ;
  Button camdepan = cp5.addButton("tampakdepan")
     .setPosition(posisiXkamera, posisiYkamera+80)
     .setImages(tombolview2)
     .updateSize()
     .setGroup(g7)
     ;
  Button cambelakang = cp5.addButton("tampakbelakang")
     .setPosition(posisiXkamera, posisiYkamera+120)
     .setImages(tombolview3)
     .updateSize()
     .setGroup(g7)
     ;
  Button camkanan =  cp5.addButton("tampakkanan")
     .setPosition(posisiXkamera, posisiYkamera+160)
     .setImages(tombolview4)
     .updateSize()
     .setGroup(g7)
     ;
  Button camkiri = cp5.addButton("tampakkiri")
     .setPosition(posisiXkamera, posisiYkamera+200)
     .setImages(tombolview5)
     .updateSize()
     .setGroup(g7)
     ;
  Button camatas = cp5.addButton("tampakatas")
     .setPosition(posisiXkamera, posisiYkamera+240)
     .setImages(tombolview6)
     .updateSize()
     .setGroup(g7)
     ;
  Button cambawah = cp5.addButton("tampakbawah")
     .setPosition(posisiXkamera, posisiYkamera+280)
     .setImages(tombolview7)
     .updateSize()
     .setGroup(g7)
     ;
     
  // Isi Grup 8
  Button Butsend = cp5.addButton("Butsend")
       .setPosition(25+65, 10)
       .setImages(play)
       .updateSize()
       .setGroup(g8)
       ;
  Button Butreset = cp5.addButton("Butreset")
       .setPosition(25, 10)
       .setImages(resetImg)
       .updateSize()
       .setGroup(g8)
       ;
  Button Butstop = cp5.addButton("Butstop")
       .setPosition(25+65+65, 10)
       .setImages(stop)
       .updateSize()
       .setGroup(g8)
       ;
  Button Butdown = cp5.addButton("Butdown")
       .setPosition(-140, 75)
       .setImages(tomboldownload)
       .updateSize()
       .setGroup(g8)
       ;
  Button Butrecord = cp5.addButton("Butrecord")
       .setPosition(-140, 25)
       .setSwitch(true)
       .setImages(record)
       .updateSize()
       .setGroup(g8)
       ;
   
  // Grup 2 monitoring sudut servo 
 knobserv1 = cp5.addKnob("knob1")
                .setRange(-100,100)
                .setPosition(13,17)
                .setColorCaptionLabel(color(255))
                .setColorBackground(color(20, 20, 20))
                .setColorActive(color(255,104,58))
                .setColorForeground(color(255,60,0))
                .setCaptionLabel("SERVO 1")
                .setRadius(35)
                .setBroadcast(true)
                .setDragDirection(Knob.VERTICAL)
                .moveTo(g2)
                ;
 knobserv2 = cp5.addKnob("knob2")
                .setRange(-100,100)
                .setPosition(86,17)
                .setColorCaptionLabel(color(255))
                .setColorBackground(color(20, 20, 20))
                .setColorActive(color(255,104,58))
                .setColorForeground(color(255,60,0))
                .setCaptionLabel("SERVO 2")
                .setRadius(35)
                .setDragDirection(Knob.VERTICAL)
                .moveTo(g2)
                ;
 knobserv3 = cp5.addKnob("knob3")
                .setRange(-100,100)
                .setPosition(160,17)
                .setColorCaptionLabel(color(255))
                .setColorBackground(color(20, 20, 20))
                .setColorActive(color(255,104,58))
                .setColorForeground(color(255,60,0))
                .setCaptionLabel("SERVO 3")
                .setRadius(35)
                .setDragDirection(Knob.VERTICAL)
                .moveTo(g2)
                ;
 knobserv4 = cp5.addKnob("knob4")
                .setRange(-100,100)
                .setPosition(13,110)
                .setColorCaptionLabel(color(255))
                .setColorBackground(color(20, 20, 20))
                .setColorActive(color(255,104,58))
                .setColorForeground(color(255,60,0))
                .setCaptionLabel("SERVO 4")
                .setRadius(35)
                .setDragDirection(Knob.VERTICAL)
                .moveTo(g2)
                ;
 knobserv5 = cp5.addKnob("knob5")
                .setRange(-100,100)
                .setPosition(86,110)
                .setColorCaptionLabel(color(255))
                .setColorBackground(color(20, 20, 20))
                .setColorActive(color(255,104,58))
                .setColorForeground(color(255,60,0))
                .setCaptionLabel("SERVO 5")
                .setRadius(35)
                .setDragDirection(Knob.VERTICAL)
                .moveTo(g2)
                ;
 knobserv6 = cp5.addKnob("knob6")
                .setRange(-100,100)
                .setPosition(160,110)
                .setColorCaptionLabel(color(255))
                .setColorBackground(color(20, 20, 20))
                .setColorActive(color(255,104,58))
                .setColorForeground(color(255,60,0))
                .setCaptionLabel("SERVO 6")
                .setRadius(35)
                .setDragDirection(Knob.VERTICAL)
                .moveTo(g2)
                ;
 
  // Isine grup 3
 showX = cp5.addNumberbox("ShowX")
            .setColorCaptionLabel(color(255))
            .setCaptionLabel("X")
            .setColorBackground(color(61,31,142))
            .setColorForeground(color(172,158,212))
            .setSize(60, 20)
            .setPosition(10,10)
            .setRange(-1,1)
            .moveTo(g3)
            ;
            cp5.getController("ShowX").getCaptionLabel().align(ControlP5.CENTER, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
 showY = cp5.addNumberbox("ShowY")
            .setColorCaptionLabel(color(255))
            .setCaptionLabel("Y")
            .setColorBackground(color(61,31,142))
            .setColorForeground(color(172,158,212))
            .setSize(60, 20)
            .setPosition(90,10)
            .setRange(-1,1)
            .moveTo(g3)
            ;
            cp5.getController("ShowY").getCaptionLabel().align(ControlP5.CENTER, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
 showZ = cp5.addNumberbox("ShowZ")
            .setColorCaptionLabel(color(255))
            .setCaptionLabel("Z")
            .setColorBackground(color(61,31,142))
            .setColorForeground(color(172,158,212))
            .setSize(60, 20)
            .setPosition(170,10)
            .setRange(-1,1)
            .moveTo(g3)
            ;
            cp5.getController("ShowZ").getCaptionLabel().align(ControlP5.CENTER, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
 showRoll = cp5.addNumberbox("ShowRoll")
               .setColorCaptionLabel(color(255))
               .setCaptionLabel("ROLL")
               .setColorBackground(color(61,31,142))
               .setColorForeground(color(172,158,212))
               .setSize(60, 20)
               .setPosition(10,50)
               .setRange(-1,1)
               .moveTo(g3)
               ;
               cp5.getController("ShowRoll").getCaptionLabel().align(ControlP5.CENTER, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
 showPitch = cp5.addNumberbox("ShowPitch")
                .setColorCaptionLabel(color(255))
                .setCaptionLabel("PITCH")
                .setColorBackground(color(61,31,142))
                .setColorForeground(color(172,158,212))
                .setSize(60, 20)
                .setPosition(90,50)
                .setRange(-1,1)
                .moveTo(g3)
                ;
                cp5.getController("ShowPitch").getCaptionLabel().align(ControlP5.CENTER, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
 showYaw = cp5.addNumberbox("ShowYaw")
              .setColorCaptionLabel(color(255))
              .setCaptionLabel("YAW")
              .setColorBackground(color(61,31,142))
              .setColorForeground(color(172,158,212))
              .setSize(60, 20)
              .setPosition(170,50)
              .setRange(-1,1)
              .moveTo(g3)
              ;
              cp5.getController("ShowYaw").getCaptionLabel().align(ControlP5.CENTER, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
              
 // Isine grup 4
cp5.addToggle("planarSHM")
                      .setPosition(15, 10)
                      .setCaptionLabel("Planar SHM")
                      .setSize(79,26)
                      .setColorForeground(color(201,108,27))
                      .setColorBackground(color(201,108,27))
                      .setColorActive(color(255,162,0))
                      .setValue(true)
                      .moveTo(g4)
                      ;
cp5.addToggle("rollSHM")
                      .setPosition(15+130, 10)
                      .setCaptionLabel("Roll SHM")
                      .setSize(79,26)
                      .setColorForeground(color(201,108,27))
                      .setColorBackground(color(201,108,27))
                      .setColorActive(color(255,162,0))
                      .setValue(true)
                      .moveTo(g4)
                      ;
cp5.addToggle("pitchSHM")
                      .setPosition(15+130, 10+45)
                      .setCaptionLabel("Pitch SHM")
                      .setSize(79,26)
                      .setColorForeground(color(201,108,27))
                      .setColorBackground(color(201,108,27))
                      .setColorActive(color(255,162,0))
                      .setValue(true)
                      .moveTo(g4)
                      ;
cp5.addToggle("yawSHM")
                      .setPosition(15+130, 10+45+45)
                      .setCaptionLabel("Yaw SHM")
                      .setSize(79,26)
                      .setColorForeground(color(201,108,27))
                      .setColorBackground(color(201,108,27))
                      .setColorActive(color(255,162,0))
                      .setValue(true)
                      .moveTo(g4)
                      ;
cp5.addToggle("verticalSHM")
                      .setPosition(15, 10+45)
                      .setCaptionLabel("Vertical SHM")
                      .setSize(79,26)
                      .setColorForeground(color(201,108,27))
                      .setColorBackground(color(201,108,27))
                      .setColorActive(color(255,162,0))
                      .setValue(true)
                      .moveTo(g4)
                      ;
cp5.addToggle("Precession")
                      .setPosition(15, 10+45+45)
                      .setCaptionLabel("Precession")
                      .setSize(79,26)
                      .setColorForeground(color(201,108,27))
                      .setColorBackground(color(201,108,27))
                      .setColorActive(color(255,162,0))
                      .setValue(true)
                      .moveTo(g4)
                      ;
 // Isine grup 5
 chartroll = cp5.addChart("plotroll")
                .setPosition(20,20)
                .setCaptionLabel("Roll")
                .setSize(450,150)
                .setRange(-20,20)
                .setView(Chart.LINE)
                .setStrokeWeight(2)
                .setColorCaptionLabel(color(255))
                .setColorBackground(color(0,0,0))
                .setColorValueLabel(color(255,0,0))
                .moveTo(g5);
                chartroll.addDataSet("incoming");
                chartroll.setColors("incoming", color(255,0,0));
                chartroll.setData("incoming", new float[1000]);
 chartpitch = cp5.addChart("plotpitch")
                .setPosition(20,20+150+20)
                .setCaptionLabel("Pitch")
                .setSize(450,150)
                .setRange(-20,20)
                .setView(Chart.LINE)
                .setStrokeWeight(2)
                .setColorCaptionLabel(color(255))
                .setColorBackground(color(0,0,0))
                .moveTo(g5);
                chartpitch.addDataSet("incoming1");
                chartpitch.setData("incoming1", new float[1000]);
 chartyaw = cp5.addChart("plotyaw")
                .setPosition(20,20+150+20+150+20)
                .setCaptionLabel("Yaw")
                .setSize(450,150)
                .setRange(-20,20)
                .setView(Chart.LINE)
                .setStrokeWeight(2)
                .setColorCaptionLabel(color(255))
                .setColorBackground(color(0,0,0))
                .moveTo(g5);
                chartyaw.addDataSet("incoming2");
                chartyaw.setColors("incoming2", color(255,220,40));
                chartyaw.setData("incoming2", new float[1000]);
                
 butdisconnect = cp5.addButton("butdisconnect")
                 .setPosition(1140, 83)
                 .setImages(tomboldisconn)
                 .setVisible(true)
                 ;
 butconnect = cp5.addButton("butconnect")
                 .setPosition(1140, 83)
                 .setImages(tombolconn)
                 .setVisible(true)
                 ;

                
 cp5.addTextlabel("teksroll")
    .setText("Roll :")
    .setPosition(10,15+10)
    .setFont(createFont("Arial", 15))
    .setGroup(g6)
    ;
    rollvalue = cp5.addNumberbox("")
                 .setSize(50, 30)
                 .setLabelVisible(false)
                 .setFont(createFont("Arial Black",12))
                 .setColorBackground(color(128,0,0))
                 .setColorForeground(color(255, 145, 0))
                 .setPosition(60,10+10)
                 .setGroup(g6)
                 ;
 cp5.addTextlabel("tekspitch")
    .setText("Pitch :")
    .setPosition(10,55+10)
    .setFont(createFont("Arial", 15))
    .setGroup(g6)
    ;
    pitchvalue = cp5.addNumberbox(" ")
                 .setSize(50, 30)
                 .setLabelVisible(false)
                 .setFont(createFont("Arial Black",12))
                 .setColorBackground(color(0,58,108))
                 .setColorForeground(color(0, 99, 184))
                 .setPosition(60,40+10+10)
                 .setGroup(g6)
                 ;
 cp5.addTextlabel("teksyaw")
    .setText("Yaw :")
    .setPosition(10,95+10)
    .setFont(createFont("Arial", 15))
    .setGroup(g6)
    ;
    yawvalue = cp5.addNumberbox("  ")
                 .setSize(50, 30)
                 .setLabelVisible(false)
                 .setFont(createFont("Arial Black",12))
                 .setColorBackground(color(255, 111, 0))
                 .setColorForeground(color(201, 108, 27))
                 .setPosition(60,40+50+10)
                 .setGroup(g6)
                 ;
                 
cp5.addTextlabel("tekspidx")
    .setText("PID X:")
    .setPosition(10+114,15+10)
    .setFont(createFont("Arial", 15))
    .setGroup(g6)
    ;
    PIDx = cp5.addNumberbox("   ")
                 .setSize(50, 30)
                 .setLabelVisible(false)
                 .setFont(createFont("Arial Black",12))
                 .setColorBackground(color(128,0,0))
                 .setColorForeground(color(255, 145, 0))
                 .setPosition(60+115,10+10)
                 .setGroup(g6)
                 ;
cp5.addTextlabel("tekspidy")
    .setText("PID Y:")
    .setPosition(10+114,55+10)
    .setFont(createFont("Arial", 15))
    .setGroup(g6)
    ;
    PIDy = cp5.addNumberbox("    ")
                 .setSize(50, 30)
                 .setLabelVisible(false)
                 .setFont(createFont("Arial Black",12))
                 .setColorBackground(color(0,58,108))
                 .setColorForeground(color(0, 99, 184))
                 .setPosition(60+115,40+10+10)
                 .setGroup(g6)
                 ;
}

public void copyrightGUI() {
  // Copyright GUI builder
  text("Developed By: Lukman Sidiq TRIK 19 || ©2021", 20, 880);
  textFont(createFont("Arial", 10));
  fill(255);
}

public void titleGUI() {
  image(title,14,10);
}

public void plusX(){
  if(minusX <= 1) {
    digiX = plusX + incrementtrans;
    plusX = digiX;
    minusX = digiX;
  }}
public void minusX(){ 
  if(plusX >= -1) {
    digiX = minusX - incrementtrans;
    minusX = digiX;
    plusX = digiX;
  }}

public void plusY(){ 
  if(minusY <= 1) {
    digiY = plusY + incrementtrans;
    plusY = digiY;
    minusY = digiY;
  }} 
public void minusY(){ 
  if(plusY >= -1) {
    digiY = minusY - incrementtrans;
    minusY = digiY;
    plusY = digiY;
  }}
public void plusZ(){ 
  if(minusZ <= 1) {
    digiZ = plusZ + incrementtrans;
    plusZ = digiZ;
    minusZ = digiZ;
  }} 
public void minusZ(){ 
  if(plusZ >= -1) {
    digiZ = minusZ - incrementtrans;
    minusZ = digiZ;
    plusZ = digiZ;
  }}

public void plusRoll(){ 
  if(minusRoll <= 1) {
    digiRoll = plusRoll + incrementrot;
    plusRoll = digiRoll;
    minusRoll = digiRoll;
  }} 
public void minusRoll() { 
  if(plusRoll >= -1) {
    digiRoll = minusRoll - incrementrot;
    minusRoll = digiRoll;
    plusRoll = digiRoll;
  }}
public void plusPitch(){ 
  if(minusPitch <= 1) {
    digiPitch = plusPitch + incrementrot;
    plusPitch = digiPitch;
    minusPitch = digiPitch;
  }} 
public void minusPitch() { 
  if(plusPitch >= -1) {
    digiPitch = minusPitch - incrementrot;
    minusPitch = digiPitch;
    plusPitch = digiPitch;
  }}
public void plusYaw(){ 
  if(minusYaw <= 1) {
    digiYaw = plusYaw + incrementrot;
    plusYaw = digiYaw;
    minusYaw = digiYaw;
  }} 
public void minusYaw() { 
  if(plusYaw >= -1) {
    digiYaw = minusYaw - incrementrot;
    minusYaw = digiYaw;
    plusYaw = digiYaw;
  }}

// reset button action
public void Butreset() {
  slidX.setValue(0);slidY.setValue(0);slidZ.setValue(0);
  slidRoll.setValue(0);slidPitch.setValue(0);slidYaw.setValue(0);
  incrementTrans.setValue(0);incrementRot.setValue(0);

  plusX=0; plusY=0; plusZ=0; minusX=0; minusY=0; minusZ=0;
  plusRoll=0; plusPitch=0; plusYaw=0; minusRoll=0; minusPitch=0;minusYaw=0;
  digiX=0; digiY=0; digiZ=0;
  digiRoll=0; digiPitch=0; digiYaw=0;
  }
  
// Monitoring data sudut servo pada knob
public void knob(float[] servo){
   knobserv1.setValue(degrees(servo[0])).setStringValue(String.format("%.2f",degrees(servo[0])));
   knobserv2.setValue(degrees(servo[1])).setStringValue(String.format("%.2f",degrees(servo[1])));
   knobserv3.setValue(degrees(servo[2])).setStringValue(String.format("%.2f",degrees(servo[2])));
   knobserv4.setValue(degrees(servo[3])).setStringValue(String.format("%.2f",degrees(servo[3])));
   knobserv5.setValue(degrees(servo[4])).setStringValue(String.format("%.2f",degrees(servo[4])));
   knobserv6.setValue(degrees(servo[5])).setStringValue(String.format("%.2f",degrees(servo[5])));
  }

// Monitoring nilai via number box
public void coordinateX(boolean togglestate){ 
  if(togglestate == true){
  x_pos = slidX.getValue(); }
  else{ x_pos = digiX;}
  showX.setValue(x_pos);
 }
public void coordinateY(boolean togglestate) {
  if(togglestate == true){
  y_pos = slidY.getValue();}
  else{ y_pos = digiY;}
    showY.setValue(y_pos);
 }
public void coordinateZ(boolean togglestate) { 
  if(togglestate == true){
  z_pos = slidZ.getValue();}
  else{ z_pos = digiZ;}
  showZ.setValue(z_pos);
}
public void attitudeRoll(boolean togglestate) { 
  if(togglestate == true){
  rollX = slidRoll.getValue();}
  else{ rollX = digiRoll;}
  showRoll.setValue(rollX);
}
public void attitudePitch(boolean togglestate) { 
  if(togglestate == true){
  pitchY = slidPitch.getValue();}
  else{ pitchY = digiPitch;}
  showPitch.setValue(pitchY);
}
public void attitudeYaw(boolean togglestate) {
  if(togglestate == true){
  yawZ = slidYaw.getValue();}
  else{ yawZ = digiYaw;}
  showYaw.setValue(yawZ);
}

// menggambar grid background
public void DrawGridbackground(){
  stroke(255);
  strokeWeight(1);
  x = 0;
  xmin = 0;
  xplus = 0; xplus1 = 0;
  z = -38;
  spasi = 10;
  while(x<width){
    line(x,0,z, x, height,z);
     x = x+spasi;
    line(xmin,0,z,xmin,-height,z);
    xmin = xmin-spasi;
   }
  while(xplus<width){
    line(xplus,-900,z,xplus,0,z);
    xplus = xplus+spasi;
    line(xplus1,0,z,xplus1,height,z);
    xplus1 = xplus1-spasi;
  }
  y = 0;
  ymin = 0;
  yplus = 0; 
  yplus1 = 0;
  while(y<height){
    line(0,y,z,width,y,z);
    y = y+spasi;
    line(0,ymin,z,width,ymin,z);
    ymin = ymin-spasi;}
  while(yplus<height){
    line(0,yplus,z,-width,yplus,z);
    yplus = yplus+spasi;
    line(0,yplus1,z,-width,yplus1,z);
    yplus1 = yplus1-spasi;}
}

}
