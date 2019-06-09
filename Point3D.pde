class Point3D {
  PVector pos;
  
  Point3D (float _x, float _y, float _z) {
    pos = new PVector (_x, _y, _z);
  }
  
  void show () {
    stroke(255);
    strokeWeight(4);
    point(pos.x, pos.y, pos.z);
  }
}
