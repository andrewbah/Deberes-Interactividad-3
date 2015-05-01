class Bote { 

  PImage botepez;
  PVector pos;
  PVector vel;
  PVector acel;
  float tamano;
  float masa;
  float t= 0;
  float t1= 0;
  float t2= 0;
  float t3= 0;
  float marea;



  Bote() {
    masa = 10000;
    botepez = loadImage("boat3.png");
    pos= new PVector( 0, height/2-50);
    vel= new PVector( 0, 0);
    acel = new PVector(0, 0);
    tamano = 400;
    marea=random(-10, 10);
  } 
  void display() {


    image(botepez, pos.x, pos.y, tamano+100, tamano);
  }

  void update() {
    vel.add(acel);
    pos.add(vel);
    vel.limit(1);
    acel.mult(0);
  }


  void Fuerza() {

    float nX = noise(t);
    float nY = noise(t1);
    float x= map(nX, 0, 1, 0, width);
    float y= map(nY, 0, 1, 0, height);
    t= t+ 0.1 ;
    t1= t1+0.1;
    PVector fuerza= new PVector(x, y);
    PVector f= PVector.div(fuerza, masa);
    acel.add(f);
  }

  void Fuerza2() {

    float nX1 = noise(t2);
    float nY2 = noise(t3);
    float x1= map(nX1, 0, 1, 0, width);
    float y1= map(nY2, 0, 1, 0, height);
    t2= t+0.3;
    t3= t1+marea;
    PVector fuerza2= new PVector(x1, -y1);
    PVector f2= PVector.div(fuerza2, masa);
    acel.add(f2);
  }

  boolean intersecta(Pez d) {

    float distancia = dist(pos.x, pos.y, d.pos.x, d.pos.y); 


    if (distancia < tamano/4 + d.diametro) { 
      return true;
    } else {
      return false;
    }
  }


  boolean intersecta(Pezpeq c) {

    float distancia = dist(pos.x, pos.y, c.pos.x, c.pos.y); 


    if (distancia < tamano/4 + c.diametro) { 
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

