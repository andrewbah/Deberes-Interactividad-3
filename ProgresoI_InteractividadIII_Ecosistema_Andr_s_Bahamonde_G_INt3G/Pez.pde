class Pez {
  PVector pos;
  PVector vel;
  PVector acel;
  float masa;
  PImage pez;
  float t= 0;
  float t1= 0;
  float t2= 0;
  float t3= 0;
  Pez[] others;
  int id;
  float diametro;
  float marea;

  Pez(float din, int idin, Pez[] oin, float marea_) {
    masa = 1000;
    acel = new PVector(0, 0);
    pos= new PVector(random(0, width), random(height/2, height-100));
    vel= new PVector( 0, 0);
    pez= loadImage("pez_gra.png");
    marea= marea_;
    others = oin;
    id = idin;
    diametro = din;
  }

  void colision() {

    for (int i = id + 1; i < numpez; i++) {
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
        //se resta el targetX de la posicion de los elementos y con el impacto( que es la cantidad de impacto y con la cual se distancian los objetos al chocar.
        float ax = (targetX - others[i].pos.x) * impacto/2;
        float ay = (targetY - others[i].pos.y) * impacto/2;
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
    vel.limit(1);
    //vel.limit(2);
    //añade efecto sin gravedad
    acel.mult(0);
  }


  void display() {
    imageMode(CENTER);
    fill(0);
    image(pez, pos.x, pos.y, diametro, diametro);
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

  void atrapado() {
    pos.x = random(-500, -100);
    pos.y= random(height/2, height-100);
    // println("chao pez");
  }
}

