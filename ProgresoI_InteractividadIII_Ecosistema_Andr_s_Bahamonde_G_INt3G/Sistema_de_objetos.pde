class SistemaDeObjetos {

  ArrayList <Objeto> objetos;
  PVector origen;

  //constructor1
  SistemaDeObjetos () {
    origen = new PVector(width/2, 0);
    objetos = new ArrayList<Objeto>();
  }
  //constructor2 

  SistemaDeObjetos (float x, float y) {
    origen = new PVector(x, y);
    objetos = new ArrayList<Objeto>();
  }


  void adicionarObjeto() {
    Objeto p= new Objeto(random(0, width), height, random(3, 5));
    objetos.add(p);
  }
  void actualizar() {
    for (int i=0; i<objetos.size (); i++) {
      Objeto p = objetos.get(i);
      p.actualizar();

      if (p.estaMuerta()) {
        objetos.remove(i);
      }
    }
  }
  void dibujar() {

    for (int i=0; i<objetos.size (); i++) {
      Objeto p = objetos.get(i);
      p.dibujar();
    }
  }
}

