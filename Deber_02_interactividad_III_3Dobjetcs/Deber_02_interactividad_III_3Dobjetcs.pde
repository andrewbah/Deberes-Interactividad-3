import peasy.*;
int num = 150;
Cajas[] caja = new Cajas[num];
PeasyCam cam;
int fondo =0;
int value = 0;

void setup() {
  size(1024, 700, P3D);
  cam = new PeasyCam(this, 1000);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(2000);
  stroke(random(0, 255), random(0, 255), random(0, 255), random(0, 50));

  for (int i = 0; i < caja.length; i ++ ) { 
    caja[i] = new Cajas();
  }
}
void draw() {
  background(255);
  pointLight(255, 255, 255, width/2, height/2, 1000);
  for (int i = 0; i < caja.length; i ++ ) { 
    caja[i].actualizar();
    caja[i].display();
  }
}

