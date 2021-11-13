void Tablelogdata() {
  int h = hour(); int min = minute(); int s = second();
  
  try{
    timesampling = millis() - prevmillis;
  
  TableRow newRow = table.addRow();
           newRow.setFloat("ROLL", rawdatain.x);  // log data roll
           newRow.setFloat("PITCH", rawdatain.y); // log data pitch
           newRow.setFloat("YAW", rawdatain.z);   // log data yaw
           newRow.setString("Time", str(timesampling)); //str(h) + ":" + str(min) + ":" + str(s) + "|" +
           
  }
  catch(RuntimeException e) {
    //null
  }
}
