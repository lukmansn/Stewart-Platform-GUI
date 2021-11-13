// motion input
void calcplanar() {
  float amplitud = 0.6;
  float planarX = amplitud* cos(frequency*t);
  float planarY = amplitud* sin(frequency*t);
  t += dt;
  outplanar = new PVector(planarX,planarY);
}

void calcprecession() {
  float amplitud = 0.4;
  float precessionRoll = amplitud * cos(frequency*t);
  float precessionPitch = amplitud * sin(frequency*t);
  t += dt;
  outprecession = new PVector(precessionRoll, precessionPitch, 0);
}

void calcverticalshm() {
  float amplitud = 0.3;
  float verticalSHMZ = amplitud * sin(frequency*t);
  t += dt;
  outverticalshm = new PVector(0,0,verticalSHMZ);
}

void calcrollshm() {
  float amplitud = 0.45;
  float rollshmX = amplitud * sin(frequency*t);
  t += dt;
  outrollshm = new PVector(rollshmX,0,0);
}

void calcpitchshm() {
  float amplitud = 0.5;
  float pitchshmY = amplitud * sin(frequency*t);
  t += dt;
  outpitchshm = new PVector(0,pitchshmY);
}

void calcyawshm() {
  float amplitud = 0.7;
  float yawshmZ = amplitud * sin(frequency*t);
  t += dt;
  outyawshm = new PVector(0,0,yawshmZ);
}

//void setupbalancing() {
//  setpoint_balancing = new PVector(0, 0, 0);
//}
