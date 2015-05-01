class Agua {

  float x, y, w, h;
  float c;

  Agua(float x_, float y_, float w_, float h_, float c_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    c = c_;
  }
  boolean contenedor(Gaviota m) {
    PVector l = m.pos2;
    if (l.x > x && l.x < x + w && l.y > y && l.y < y + h) {
      return true;
    } else {
      return false;
    }
  }
  PVector drag(Gaviota m) {
    float vel = m.vel.mag();
    float dragMagnitude = c * vel * vel;
    PVector fuerzaAgua = m.vel.get();
    fuerzaAgua.mult(-5000);
    //fuerzaAgua.normalize();
    fuerzaAgua.mult(dragMagnitude);
    m.vel.limit(1);
    return fuerzaAgua;
  }
  void display() {
    noStroke();
    //stroke(0);
    fill(0, 0);
    rect(x, y, w, h);
  }
}

