class Coral { 
  PVector pos;
  float altura;
  float ancho;

  Coral(float pos_) {

    pos= new PVector(pos_, height-20);
    altura= random(100, 200);
    ancho =random(50, 100);
  } 
  void display() {
    plants.loop();
    image(plants, pos.x, pos.y);
    //image(coral, pos.x, pos.y, ancho, altura);
  }
}

