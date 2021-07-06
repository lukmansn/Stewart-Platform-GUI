// untuk konversi data yang mau dikirim
String[] convertdata(float a, float b, float c, float d, float e, float f, float g){
  Sendconvdata = new String[7];
  Sendconvdata[0] = String.format("%.2f",a);
  Sendconvdata[1] = String.format("%.2f",b);
  Sendconvdata[2] = String.format("%.2f",c);
  Sendconvdata[3] = String.format("%.2f",d);
  Sendconvdata[4] = String.format("%.2f",e);
  Sendconvdata[5] = String.format("%.2f",f);
  Sendconvdata[6] = String.format("%.2f",g); // << bit state untuk aktivasi self balancing: state_ON = 1; state_OFF = 0
 
  return Sendconvdata;
}
// Backup converting
  /*String sendX = String.format("%.2f",a);
  String sendY = String.format("%.2f",b);
  String sendZ = String.format("%.2f",c);
  String sendRoll  = String.format("%.2f",d);
  String sendPitch = String.format("%.2f",e);
  String sendYaw   = String.format("%.2f",f);*/
  
  //String RotxTrans = "<"+sendX+ ","+sendY+","+sendZ+","+sendRoll+","+sendPitch+","+sendYaw;
