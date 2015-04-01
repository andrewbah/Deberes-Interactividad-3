class Cajas {
  PVector pos;
  PVector vel;
  color color1;
  float tam;
  PShape Objeto;
  float rad;

  Cajas() {
    pos= new PVector(random(50, 400), random( 50, 400), random( 50, 400));
    vel= new PVector (random(1, 5), random( 1, 5), random(1, 5));
    color1 = color(random(0, 255), random(0, 255), random(0, 255), random(10, 255));
    
    //tam= random(10, 100);
    tam= random(1, 10);
    Objeto = loadShape("objeto2.obj");
    rad= random(0, 0.02);
  }
  void display() {
    if ( pos.x > 1000 || pos.x<0) {
      vel.x= -1.0*vel.x;
      //color1= color(random(0, 255), random(0, 255), random(0, 255));
    }
    if ( pos.y > 1000||  pos.y<0) {
      vel.y= -1.0 *vel.y;
      //color1= color(random(0, 255), random(0, 255), random(0, 255));
    }
    if ( pos.z < -500 || pos.z>500) {
      vel.z= -1.0*vel.z;
      //color1= color(random(0, 255), random(0, 255), random(0, 255));
    }
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    fill(color1);
    Objeto.rotate(rad);
    scale(tam);  
    shape(Objeto);
    //noStroke();
    //box(tam);
    popMatrix();
  }
  void actualizar() {
    pos.add(vel);
  }
}

