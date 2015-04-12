class Mover {
  PVector pos;
  PVector vel;
  PVector acel;
  float masa;
  PImage globo;
  float t= 0;
  float t1= 0;
  float t2= 0;
  float t3= 0;
  Mover[] others;
  int id;
  float diametro;

  Mover(float din, int idin, Mover[] oin) {
    masa = 10000;
    acel = new PVector(0, 0);
    pos = new PVector(random(20, 1024), random(200, 700));
    vel= new PVector( 0, 0);
    globo = loadImage("ballon.png");
    others = oin;
    id = idin;
    diametro = din;
  }

  void colision() {

    for (int i = id + 1; i < numMovers; i++) {
      //se reemplaza las posiciones de others que era el nuero arreglo para esta funcion con la de dx y dy y se las pasa al float distancia
      float dx = others[i].pos.x - pos.x;
      float dy = others[i].pos.y - pos.y;
      float distancia = sqrt(dx*dx + dy*dy);
      //se crea un float para distancia minima de impacto con la variable del diametro de cada elemento ya que son diferentes
      float minDist = others[i].diametro/2 + diametro/8;
      if (distancia < minDist) { 
        //float angulo para calcular el angulo en radianes con y y x ya que el orden es atan2(y, x)
        float angulo = atan2(dy, dx);
        //targetX para calcular la posicion en x y multiplicar el coseno del angulo por la distancia minima de impacto
        float targetX = pos.x + cos(angulo) * minDist;
        float targetY = pos.y + sin(angulo) * minDist;
        //se resta el targetX de la posicion de los elementos y con el giro( que es la cantidad de impacto y con la cual se distancian los objetos al chocar.
        float ax = (targetX - others[i].pos.x) * giro/2;
        float ay = (targetY - others[i].pos.y) * giro/2;
        vel.x -= ax;
        vel.y -= ay;
        others[i].vel.x += ax;
        others[i].vel.y += ay;
      }
    }
  }
  void update() {
    vel.add(acel);
    pos.add(vel);
    vel.limit(2);
    //vel.limit(2);
    //añade efecto sin gravedad
    acel.mult(0);
    comprobarBorde();
  }

  void comprobarBorde() {
    if (pos.y>height-50 ) {
      pos.y = height-50;
      vel.y*= -1;
    } else if (pos.y< 0) {
      pos.y = 0;
      vel.y*= -1;
    }
    if (pos.x>width-10 ) {
      pos.x = width-10;
      vel.x*= -1;
    } else if (pos.x< 0) {
      pos.x = 0;
      vel.x*= -1;
    }
  }
  void display() {
    imageMode(CENTER);
    fill(0);
    image(globo, pos.x, pos.y, diametro, diametro);
  }

  void Fuerza() {

    //GRAVEDAD

    float nX = noise(t);
    float nY = noise(t1);
    float x= map(nX, 0, 1, 0, width);
    float y= map(nY, 0, 1, 0, height);
    t= t+random(-500, 500);
    t1= t1+random(-500, 500);
    PVector fuerza= new PVector(x, y);

    PVector f= PVector.div(fuerza, masa);
    acel.add(f);
  }

  void Fuerza2() {
    //VIENTO

    float nX1 = noise(t2);
    float nY2 = noise(t3);
    float x1= map(nX1, 0, 1, 0, width);
    float y1= map(nY2, 0, 1, 0, height);
    t2= t+random(-500, 500);
    t3= t1+random(-500, 500);
    PVector fuerza2= new PVector(-x1, -y1);
    PVector f2= PVector.div(fuerza2, masa);
    acel.add(f2);
  }
}

