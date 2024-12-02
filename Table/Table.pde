public class Table  {
    private PShape table; 

  public Table() {
    this.table = init(); 
  }

  public PShape init(){
      PShape table = createShape(GROUP);
      PShape pieds = createShape(GROUP);

      PShape pied1 = monCube(50,250,50); 
      PShape pied2 = monCube(50,250,50); 
      PShape pied3 = monCube(50,250,50); 
      PShape pied4 = monCube(50,250,50);
      PShape surface = monCube(250,50,250);

      pied1.translate(-100,250/2,100);//pied haut-droite
      pied2.translate(-100,250/2,-100);//pied haut gauche
      pied3.translate(100,250/2,100);//pied bas-droit
      pied4.translate(100,250/2,-100);//pied bas-gauche

      pieds.addChild(pied1);  
      pieds.addChild(pied2);  
      pieds.addChild(pied3);  
      pieds.addChild(pied4);

      table.addChild(pieds);
      table.addChild(surface); 

      return table;    
  }
      // Méthode pour accéder à la forme
    public PShape getShape() {
        return this.table;
    }


   private PShape monCube(float longueur, float hauteur, float largeur){
         PShape cube = createShape(GROUP); // Créer un groupe pour le cube
        float x = longueur / 2;
        float y = hauteur / 2;
        float z = largeur / 2;

        // Face gauche
        PShape face1 = createShape();
        face1.beginShape(QUADS);
        //face1.fill(couleurs[0]); // Couleur rouge
        face1.vertex(-x, -y, -z);
        face1.vertex(-x, -y, z);
        face1.vertex(-x, y, z);
        face1.vertex(-x, y, -z);
        face1.endShape();
        cube.addChild(face1); // Ajouter la face au groupe

        // Face droite
        PShape face2 = createShape();
        face2.beginShape(QUADS);
        //face2.fill(couleurs[1]); // Couleur verte
        face2.vertex(x, -y, -z);
        face2.vertex(x, -y, z);
        face2.vertex(x, y, z);
        face2.vertex(x, y, -z);
        face2.endShape();
        cube.addChild(face2);

        // Face bas
        PShape face3 = createShape();
        face3.beginShape(QUADS);
        //face3.fill(couleurs[2]); // Couleur bleue
        face3.vertex(-x, y, -z);
        face3.vertex(x, y, -z);
        face3.vertex(x, y, z);
        face3.vertex(-x, y, z);
        face3.endShape();
        cube.addChild(face3);

        // Face haut
        PShape face4 = createShape();
        face4.beginShape(QUADS);
        //face4.fill(couleurs[3]); // Couleur jaune
        face4.vertex(-x, -y, -z);
        face4.vertex(-x, -y, z);
        face4.vertex(x, -y, z);
        face4.vertex(x, -y, -z);
        face4.endShape();
        cube.addChild(face4);

        // Face devant
        PShape face5 = createShape();
        face5.beginShape(QUADS);
        //face5.fill(couleurs[4]); // Couleur magenta
        face5.vertex(-x, -y, z);
        face5.vertex(x, -y, z);
        face5.vertex(x, y, z);
        face5.vertex(-x, y, z);
        face5.endShape();
        cube.addChild(face5);

        // Face derrière
        PShape face6 = createShape();
        face6.beginShape(QUADS);
        //face6.fill(couleurs[5]); // Couleur cyan
        face6.vertex(-x, -y, -z);
        face6.vertex(x, -y, -z);
        face6.vertex(x, y, -z);
        face6.vertex(-x, y, -z);
        face6.endShape();
        cube.addChild(face6);

        return cube;
    }

}
