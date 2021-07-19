void Tablelogdata() {
  int d = day(); int m = month(); int y = year(); int h = hour(); int min = minute(); int s = second();
  
  try{
  TableRow newRow = table.addRow();
           newRow.setFloat("ROLL", rawdatain.x);  // log data roll
           newRow.setFloat("PITCH", rawdatain.y); // log data pitch
           newRow.setFloat("YAW", rawdatain.z);   // log data yaw
           newRow.setString("Time", str(h) + ":" + str(min) + ":" + str(s));
           
  }
  catch(RuntimeException e) {
    //null
  }
}
