import peasy.*;

float r1 = 150, r2 = 50;
int n = 180, k = 180;
int a = 6, b = 6;
int total_frames = 360; 

boolean sphere = true;

Point3D points[][];
PeasyCam cam;

void setup () {
  size(600, 600, P3D);  
  
  points = new Point3D[n][k];
  //cam = new PeasyCam(this, 400);
}

void draw () {
  background(0);
  
  lights();
  translate(width/2, height/2);
  rotateX(atan(cos(QUARTER_PI)));
  
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < k; j++) {
      float phi = map(i, 0, n, -PI, PI);
      float theta = map(j, 0, k, 0, TWO_PI);
      
      float x = r1 * cos(phi) + r2 * cos(phi) * cos(theta);
      float y = r1 * sin(phi) + r2 * sin(phi) * cos(theta); 
      float z = r2 * sin(theta);
      
      points[i][j] = new Point3D(x, y, z);
    }
  }
  
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < k; j++) {
      Point3D t1 = points[i][j];
      Point3D t2 = points[i][(j+1 + k) % k];
      Point3D t3 = points[(i+1 + n) % n][(j+1 + k) % k];
      Point3D t4 = points[(i+1 + n) % n][j];
      
      noStroke();
      //stroke(255);
      //noFill();
      if ((floor(i / b) % 2 == 0 && floor(j / a) % 2 == 1) || (floor(i / b) % 2 == 1 && floor(j / a) % 2 == 0)) {
        fill(123, 217, 255);
      } else {
        fill(42, 71, 96);  
      }
      
      beginShape(QUADS);
      
      vertex(t1.pos.x, t1.pos.y, t1.pos.z);
      vertex(t2.pos.x, t2.pos.y, t2.pos.z);
      vertex(t3.pos.x, t3.pos.y, t3.pos.z);
      vertex(t4.pos.x, t4.pos.y, t4.pos.z);
      
      endShape();
    }
  }
  
  saveFrame("img/###.png");
  
  if (frameCount > 0 && frameCount <= total_frames/4 && sphere && r1 > 0) {
    r1 -= 150 / (total_frames / 4); 
    r2 += 0.5; 
    if (frameCount == total_frames/4) {
      sphere = false;
    }
  } else if (frameCount > total_frames/2 && frameCount <= 3 * total_frames/4 && !sphere && r1 < 150) {
    r1 += 150 / (total_frames / 4); 
    r2 -= 0.5; 
    if (frameCount == 3 * total_frames/4) {
      sphere = true;
    }
  } else if (frameCount > total_frames) {
    exit();  
  }
}
