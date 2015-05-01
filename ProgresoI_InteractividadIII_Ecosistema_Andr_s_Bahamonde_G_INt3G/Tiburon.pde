class Tiburon { 

  PImage tiburon;
  PVector pos;
  PVector vel;
  PVector acel;
  float tamano;



  Tiburon() {

    tiburon = loadImage("shark2.png");
    pos= new PVector( width +200, random(height/2 +100, height-100));
    vel= new PVector( 0, 0);
    acel = new PVector(-1, random(0.5, -0.5));
    tamano = 50;
  } 
  void display() {

    shark.loop();
    image(shark, pos.x, pos.y);
    image(tiburon, pos.x, pos.y, tamano+200, tamano +100);
  }

  void update() {
    vel.add(acel);
    pos.add(vel);
    vel.limit(1);
    //acel.mult(0);
  }


  boolean intersecta(Pez d) {

    float distancia = dist(pos.x, pos.y, d.pos.x, d.pos.y); 


    if (distancia < tamano + d.diametro) { 
      return true;
    } else {
      return false;
    }
  }


  boolean intersecta(Pezpeq c) {

    float distancia = dist(pos.x, pos.y, c.pos.x, c.pos.y); 


    if (distancia < tamano + c.diametro) { 
      return true;
    } else {
      return false;
    }
  }

  float getPosX() {
    return pos.x;
  }

  float  getPosY() {
    return pos.y;
  }
}

