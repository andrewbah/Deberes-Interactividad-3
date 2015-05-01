class Pezpeq {
  PVector pos;
  PVector vel;
  PVector acel;
  float masa;
  PImage pezpeq;
  float t= 0;
  float t1= 0;
  float t2= 0;
  float t3= 0;
  Pezpeq[] others;
  int id;
  float diametro;
  float marea;

  Pezpeq(float din, int idin, Pezpeq[] oin, float marea_) {
    masa = random(1, 2);
    acel = new PVector(0, 0);

    pos = new PVector(random(100, width-100), random(height/2, height-100));
    //pos= new PVector(width +500, random(height/2, height-100));
    vel= new PVector( 0, 0);
    pezpeq= loadImage("pez_peq.png");
    marea= marea_;
    others = oin;
    id = idin;
    diametro = din;
  }

  void colision() {

    for (int i = id + 1; i < numpezpeq; i++) {
      //se reemplaza las posiciones de others que era el nuero arreglo para esta funcion con la de dx y dy y se las pasa al float distancia
      float dx = others[i].pos.x - pos.x;
      float dy = others[i].pos.y - pos.y;
      float distancia = sqrt(dx*dx + dy*dy);
      //se crea un float para distancia minima de impacto2 con la variable del diametro de cada elemento ya que son diferentes
      float minDist = others[i].diametro/2 + diametro/2;
      if (distancia < minDist) { 
        //float angulo para calcular el angulo en radianes con y y x ya que el orden es atan2(y, x)
        float angulo = atan2(dy, dx);
        //targetX para calcular la posicion en x y multiplicar el coseno del angulo por la distancia minima de impacto2
        float targetX = pos.x + cos(angulo) * minDist;
        float targetY = pos.y + sin(angulo) * minDist;
        //se resta el targetX de la posicion de los elementos y con el impacto2( que es la cantidad de impacto2 y con la cual se distancian los objetos al chocar.
        float ax = (targetX - others[i].pos.x) * impacto2;
        float ay = (targetY - others[i].pos.y) * impacto2;
        vel.x -= ax;
        vel.y -= ay;
        others[i].vel.x += ax;
        others[i].vel.y += ay;
      }
    }
  }
  void update() {
    vel.add(acel);
    //limite para la velocidad.
    vel.limit(3);
    pos.add(vel);
    //mult por escalar 0 para normalizar el vector aceleracion y que no se repita cada vez y se haga mas rapido
    acel.mult(0);
  }

  void display() {
    imageMode(CENTER);
    fill(0);
    image(pezpeq, pos.x, pos.y, diametro, diametro);
  }





  void atrapado() {
    pos.x = random(0, width);
    pos.y= height-50;
    //println("chao pezpeq");
  }


  void aplicarFuerza(PVector fuerza) {
    PVector f = PVector.div(fuerza, masa);
    acel.add(f);
  }

  PVector atraccion(Pezpeq a) {
    PVector fuerza = PVector.sub(pos, a.pos);             
    float distancia = fuerza.mag();   
    // el constrain funciona con dos valores un minimo y un maximo en este caso es la cantidad de distancia minima y maxima que los objetos van a ser atraidos osea practicamente su fuerza de atraccion    
    distancia = constrain(distancia, 1, 10);  
    //normaliza la fuera del vector en una escala de 1    
    fuerza.normalize();   
    // campograv es la formula para sacar el campo gravitacional entre los objetos y su fuerza de atraccion, en donde g es la "constante gravitacional" masa y a.masa son las masas de los objetos y a esto se lo divide por distancia al cuadrado.    
    float campograv = (g * masa *a.masa) / (distancia * distancia); 
    //a la final se multiplica la fuerza por la fuerza del campo gravitacional y se obtiene la variable fuerza con un return
    fuerza.mult(campograv);  
    return fuerza;
  }

  void fuerzas() {
    PVector fuerza = new PVector(0, 0);
    if (pos.x < 0) {
      fuerza.x = 1;
      pos.x = random(0, width);
      pos.y= height-50;
    } else if (pos.x > width +10) {
      fuerza.x = -1;
      pos.x = random(0, width);
      pos.y= height-50;
    } 
    if (pos.y < height/2 +50) {
      pos.x = random(0, width);
      pos.y= height-50;
      fuerza.y = 1;
    } else if (pos.y > height-10) {
      fuerza.y = -1;
      pos.x = random(0, width);
      pos.y= height-50;
    } 
    fuerza.normalize();
    fuerza.mult(0.5);
    aplicarFuerza(fuerza);
  }
}

