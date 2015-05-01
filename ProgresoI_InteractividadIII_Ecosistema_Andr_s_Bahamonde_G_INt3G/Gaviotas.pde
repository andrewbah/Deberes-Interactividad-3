class Gaviota { 
  PVector pos2;
  PVector vel;
  PVector acel;
  PImage gaviota, gaviota2;
  float masa2;
  float t= 0;
  float t1= 0;
  float t2= 0;
  float t3= 0;
  float diametro;
  float marea;

  Gaviota(float din) {
    gaviota= loadImage("gaviota.png");
    gaviota2= loadImage("gaviotasumergida.png");
    masa2 = 1;
    acel = new PVector(mouseX, mouseY  );
    pos2= new PVector(random(0, width), random(0, height/2)-100);
    vel= new PVector( 0, 0);
    diametro = din;
  }

  void update() {

    PVector mouse= new PVector(mouseX, mouseY);
    PVector dir= PVector.sub(mouse, pos2);
    dir.normalize();
    dir.mult(0.2);
    acel = dir;
    vel.add(acel);
    vel.limit(5);
    pos2.add(vel);

    if ( pos2.x > width) {
      pos2.x= 0;
    } else if ( pos2.x < 0) {
      pos2.x = width;
    } else if ( pos2.y >height ) {
      pos2= new PVector(random(0, width), random(0, height/2)-100);

      //pos2.y=height/2+200;
    } else if ( pos2.y < 0) {
      pos2.y=0;
    }
  }
  void display() {
    gavio.loop();
    image(gavio, pos2.x, pos2.y);
    image(gaviota, pos2.x, pos2.y, diametro, diametro);
  }

  void aplicarFuerza(PVector fuerza) {
    PVector f = PVector.div(fuerza, masa2);
    acel.add(f);
  }

  void fuerzas() {
    PVector fuerza = new PVector(0, 0);
    if (pos2.x < 50) {
      fuerza.x = 1;
    } else if (pos2.x > width -50) {
      fuerza.x = -1;
    } 
    if (pos2.y < 50) {
      fuerza.y = 1;
    } else if (pos2.y >  height/2-100) {
      fuerza.y = -1;
    } 
    fuerza.normalize();
    fuerza.mult(0.5);
    aplicarFuerza(fuerza);
  }


  boolean intersecta(Pez d) {

    float distancia = dist(pos2.x, pos2.y, d.pos.x, d.pos.y); 


    if (distancia < diametro/2 + d.diametro) { 
      return true;
    } else {
      return false;
    }
  }



  boolean intersecta(Pezpeq c) {

    float distancia = dist(pos2.x, pos2.y, c.pos.x, c.pos.y); 


    if (distancia < diametro/2 + c.diametro/2) { 
      return true;
    } else {
      return false;
    }
  }

  void cambioColor() {
    //gavio = new Gif(this, "gaviota2.gif");
    image(gaviota2, pos2.x, pos2.y+5, diametro, diametro);
  }



  float getPosX() {
    return pos2.x;
  }

  float  getPosY() {
    return pos2.y;
  }
}

