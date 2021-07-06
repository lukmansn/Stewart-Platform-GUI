class stewartplatform {
   private PVector translasi, rotasi, h0;              // h0 = posisi home awal
   private PVector[] Bi, Pi_p, Qi, Li, A, posservo;    // A  = vektor arm || Qi = vektor perpindahan platform  || Li = vektor panjang kaki
   private float[] alpha;                              // Sudut servo
   private float radiusbasis, radiusplatform, arm, s;  // s = panjang rod, arm = panjang lengan servo
   private PShape hexabasis, hexaplatform, hexabasisbawah;
   
   // SPESIFIKASI SUDUT SUDUT
   // sudut Basis
   private final float sudutbasis[] = {240, 300, 360, 60, 120, 180};
   private final float basisbelok[] = {3.078, -3.078, 3.078, -3.078, 3.078, -3.078};   // eling! iki posisi titik sudut shaft servo terhadap pusat basis (cek corelDraw)
   // sudut platform
   private final float sudutplatform[] = {220, 320, 340, 75, 105, 200};
   // sudut beta
   private final float beta[] = {0, -PI, PI*2/3, -PI/3, PI*4/3, -PI/3*5}; // 0, -180, 120, -60 (300), 240, -300 (60) //0, -PI, PI*2/3, -PI/3, PI*4/3, -PI/3*5
   
   // Spesifikasi ukuran Basis dan Platform ((dalam milimeter))
   private final float skala_tinggi_awal = 160;           // mm
   private final float skala_radius_basis = 93.115;      // jari jari basis round 1 = 84.32 | jari jari basis round 2 = 93.115
   private final float skala_radius_platform = 79.253;   // jari jari platform
   private final float skala_panjang_arm = 30;
   private final float skala_panjang_kaki = 175;         // panjang rod 17.5 cm
   
   public stewartplatform(float prod) {
     translasi = new PVector();
     h0 = new PVector(0, 0, prod *skala_tinggi_awal);
     rotasi = new PVector();
     Bi = new PVector[6];    // vektor joint di basis
     Pi_p = new PVector[6];  // vektor joint di platform
     alpha = new float[6];
     Qi = new PVector[6];  // jarak  vektor translasi dari O ke Pi
     Li = new PVector[6];  // panjang kaki virtual
     A = new PVector[6];   // vektor posisi joint arm servo
     posservo = new PVector[6];
     
     // Spesifikasi ukuran stewart platform akhir
     radiusbasis = prod * skala_radius_basis;
     radiusplatform = prod * skala_radius_platform;
     arm = prod * skala_panjang_arm;
     s = prod * skala_panjang_kaki;
     //rd_servo = prod * jarak_rd_servo;
     
     // revisi
     // penentuan vektor dari posisi titik basis
     for (int i=0; i<6; i++) {
       float Xi = (radiusbasis * cos(radians(sudutbasis[i])) + radians(basisbelok[i])) /*+ (jarak_rd_servo[i]*sin(radians(beta[i])))*/;
       float Yi = (radiusbasis * sin(radians(sudutbasis[i])) + radians(basisbelok[i])) /*+ (jarak_rd_servo[i]*cos(radians(beta[i])))*/;
       float Zi = 0;
       Bi[i] = new PVector(Xi, Yi, Zi);
     }
     
     // penentuan vektor dari posisi titik joint platform
     for (int i=0; i<6; i++) {
       float Xi_p = radiusplatform * cos(radians(sudutplatform[i]));
       float Yi_p = radiusplatform * sin(radians(sudutplatform[i]));
       float Zi_p = 0;
       Pi_p[i] = new PVector(Xi_p, Yi_p, Zi_p);
       
       Qi[i] = new PVector(0, 0, 0);
       Li[i] = new PVector(0, 0, 0);
       A[i]  = new PVector(0, 0, 0);
     }
     calcQi();
   }
   public void applyTranslasidanRotasi(PVector t, PVector r) {
     rotasi.set(r);     // vektor roll = x, pitch = y , yaw = z
     translasi.set(t);  // vektor translasi antara pusat basis (O) dan joint platform (Pi)
     calcQi();
     calcAlpha();
   }
   
   private void calcQi() {
     for (int i=0; i<6; i++) {
       
       //matriks rotasi P_Rb * vektor Pi_p
       Qi[i].x = cos(rotasi.z) * cos(rotasi.y) * Pi_p[i].x +
                 ((-sin(rotasi.z) * cos(rotasi.x)) + (cos(rotasi.z) * sin(rotasi.y) * sin(rotasi.x))) * Pi_p[i].y +
                 ((sin(rotasi.z) * sin(rotasi.x)) + (cos(rotasi.z) * sin(rotasi.y) * cos(rotasi.x))) * Pi_p[i].z;
                 
       Qi[i].y = sin(rotasi.z) * cos(rotasi.y) * Pi_p[i].x +
                 ((cos(rotasi.z) * cos(rotasi.x)) + (sin(rotasi.z) * sin(rotasi.y) * sin(rotasi.x))) * Pi_p[i].y +
                 ((-cos(rotasi.z) * sin(rotasi.x)) + (sin(rotasi.z) * sin(rotasi.y) * cos(rotasi.x))) * Pi_p[i].z;
                 
       Qi[i].z = -sin(rotasi.y) * Pi_p[i].x +
                 cos(rotasi.y) * sin(rotasi.x) * Pi_p[i].y +
                 cos(rotasi.y) * cos(rotasi.x) * Pi_p[i].z;
       
       // qi akhir = T + P_Rb + vektor Pi_p
       Qi[i].add(PVector.add(translasi, h0));
       
       // menghitung vektor Li = vektor kaki virtual
       Li[i] = PVector.sub(Qi[i], Bi[i]);
     }
   }
   
   private void calcAlpha() {
     for (int i=0; i<6; i++) {
       // Menghitung sudut alpha
       float L = Li[i].magSq()-(s * s) + (arm * arm);
       float M = 2 * arm * (Qi[i].z - Bi[i].z);
       float N = 2 * arm * ((cos(beta[i])) * (Qi[i].x - Bi[i].x) + (sin(beta[i])) * (Qi[i].y - Bi[i].y));
       alpha[i] = asin (L / sqrt(M*M + N*N)) - atan2(N, M);
       
       // Menghitung vektor arm
       A[i].set(arm * cos(alpha[i]) * cos(beta[i]) + Bi[i].x,
       arm * cos(alpha[i]) * sin(beta[i]) + Bi[i].y,
       arm * sin(alpha[i]) + Bi[i].z);
       
       // menentukan parameter home position
       float xpminxb = (Qi[i].x - Bi[i].x);
       float ypminyb = (Qi[i].y - Bi[i].y);
       float homepos = sqrt((s * s) + (arm * arm) - (xpminxb * xpminxb) - (ypminyb * ypminyb) - Qi[i].z);
       
       // Menghitung sudut alpha saat homee position
       float L0 = 2 * arm * arm;
       float M0 = 2 * arm * (Pi_p[i].x - Bi[i].x);
       float N0 = 2 * arm * (homepos + Pi_p[i].z);
       float alpha0 = asin(L0 / sqrt((M0 * M0) + (N0 * N0))) - atan2(N0, M0);
     }
   }
   
   public float[] getAlpha() {
     return alpha;
   }
   private void ShapeBasis(float expand) {
      hexabasis = createShape();
      hexabasis.beginShape();
      hexabasis.fill(0, 74, 116);
      hexabasis.noStroke();
      /*
      for(int i = 0; i<6; i++){
        hexabasis.vertex(Bi[i].x,Bi[i].y);
      }
      */
      hexabasis.vertex(expand * -52.11, expand * -73.023);
      hexabasis.vertex(expand * 52.11, expand * -73.023);
      hexabasis.vertex(expand * 89.295, expand * -8.617);
      hexabasis.vertex(expand * 37.185, expand * 81.64);
      hexabasis.vertex(expand * -37.185, expand * 81.64);
      hexabasis.vertex(expand * -89.295, expand * -8.617);//
      hexabasis.endShape(CLOSE);
   }
   
   private void ShapePlatform(float expand) {
      hexaplatform = createShape();
      hexaplatform.beginShape();
      hexaplatform.fill(254, 212, 0);  // tosca
      hexaplatform.noStroke();
      hexaplatform.vertex(expand * -27.107, expand * 74.475);
      hexaplatform.vertex(expand * 27.107, expand * 74.475);
      hexaplatform.vertex(expand * 76.553, expand * -20.512);
      hexaplatform.vertex(expand * 56.084, expand * -56.084);
      hexaplatform.vertex(expand * -56.089, expand * -56.089);
      hexaplatform.vertex(-expand * 76.635, expand * -20.534);
      hexaplatform.endShape(CLOSE); 
   }
   
   private void ShapeBasisbawah(float expand) {
      hexabasisbawah = createShape();
      hexabasisbawah.beginShape();
      hexabasisbawah.fill(68, 152, 201,100);
      hexabasisbawah.noStroke();
      hexabasisbawah.vertex(expand * -52.11, expand * -73.023);
      hexabasisbawah.vertex(expand * 52.11, expand * -73.023);
      hexabasisbawah.vertex(expand * 89.295, expand * -8.617);
      hexabasisbawah.vertex(expand * 37.185, expand * 81.64);
      hexabasisbawah.vertex(expand * -37.185, expand * 81.64);
      hexabasisbawah.vertex(expand * -89.295, expand * -8.617);//
      hexabasisbawah.endShape(CLOSE);
   }
   // sudut vector servo
   private float sudutpasangservo[] = {232.212, 307.799, 352.192, 67.857, 112.114, 187.808}; //R = 72.792
   
   public void draw() {
     ShapeBasis(1);
     ShapePlatform(1);
     ShapeBasisbawah(1);
                 
   // GUR nggo masang servo tok raono hubungane ro rumus
   for(int i=0; i<6; i++) {
      float x_servo = 68.742 * cos(radians(sudutpasangservo[i]));
      float y_servo = 68.742 * sin(radians(sudutpasangservo[i]));
      float z_servo = 0;
      posservo[i] = new PVector(x_servo, y_servo, z_servo);
     }
     
     // Basis atas
     pushMatrix();
     translate(0, 0, 5);
     shape(hexabasis, 0, 0);
     popMatrix();
      
     // Basis bawah
      pushMatrix();
      translate(0, 0, -35);
      shape(hexabasisbawah, 0, 0);
      popMatrix();
      
      
     // Gambar 6 servo
     for(int i=0; i<6; i++){
        pushMatrix();
        translate(posservo[i].x, posservo[i].y, -16);
        rotateZ(beta[i]);
        fill(126, 126, 126);
        box(19.9, 37.5, 40);
        popMatrix();
      }
      
      for(int i=0; i<6; i++) {
        pushMatrix();
        translate(Bi[i].x, Bi[i].y, Bi[i].z);
        int a = i+1;
        //noStroke();
        stroke(0);
        strokeWeight(3);
        fill(45, 192, 158);
        //ellipse(0, 0, 5, 5);
        text(a,5,5,7);
        popMatrix();
        
        // Arm
        stroke(255, 0, 0);
        line(Bi[i].x, Bi[i].y, Bi[i].z, A[i].x, A[i].y, A[i].z);
        
        // Gambar push rod
        PVector rod = PVector.sub(Qi[i], A[i]);
        rod.setMag(s);
        rod.add(A[i]);
        
        stroke(100);
        strokeWeight(3);
        line(A[i].x, A[i].y, A[i].z, rod.x, rod.y, rod.z);
      }
      
      // platform joint
      for (int i=0; i<6; i++) {
         pushMatrix();
         translate(Qi[i].x, Qi[i].y, Qi[i].z);
         noStroke();
         fill(0);
         ellipse(0,0,5,5);
         popMatrix();
         
         // kski vitual
         stroke(100);
         strokeWeight(1);
         line(Bi[i].x, Bi[i].y, Bi[i].z, Qi[i].x, Qi[i].y, Qi[i].z); 
      }
      
      pushMatrix();
      translate(h0.x, h0.y, h0.z);
      translate(translasi.x, translasi.y, translasi.z);
      rotateZ(rotasi.z);
      rotateY(rotasi.y);
      rotateX(rotasi.x);
      stroke(245);
      noFill();
      shape(hexaplatform, 0, 0);
      popMatrix();
   
   }
}
