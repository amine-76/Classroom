public class tableFond  {

   private PShape table; 
    private PImage texture_surface; 
    private PImage texture_noire;

    
  public tableFond() {
    texture_surface = loadImage("texture_surface_table.jpg");
    texture_noire = loadImage("texture_noire.jpg"); 
    this.table = init(); 
  }

  public PShape init(){
      PShape table = createShape(GROUP);
      //PShape pieds = createShape(GROUP);

      PShape surface = monCube(500,25,250,texture_surface);
      PShape partiedroite = monCube(25,250,250,texture_noire); 
      PShape partieGauche = monCube(25,250,250,texture_noire);
      PShape partieface = monCube(500,250,25,texture_noire);
      
      partiedroite.translate(500/2,250/2,0); 
      partieGauche.translate(-500/2,250/2,0);
      partieface.translate(0,125,250/2); 
      

      table.addChild(surface);
      table.addChild(partiedroite);
      table.addChild(partieGauche);  
      table.addChild(partieface); 

      return table;    
  }
      // Méthode pour accéder à la forme
    public PShape getShape() {
        return this.table;
    }


   private PShape monCube(float longueur, float hauteur, float largeur,PImage texture){
         PShape cube = createShape(GROUP); // Créer un groupe pour le cube
        float x = longueur / 2;
        float y = hauteur / 2;
        float z = largeur / 2;

        // Face gauche
        PShape face1 = createShape();
        face1.beginShape(QUADS);
        //face1.fill(couleurs[0]); // Couleur rouge
        face1.textureMode(NORMAL); 
        face1.texture(texture); // Applique la texture sur cette face
        face1.shininess(200.0);
        face1.vertex(-x, -y, -z,0,0);
        face1.vertex(-x, -y, z,1,0);
        face1.vertex(-x, y, z,1,1);
        face1.vertex(-x, y, -z,1,0);
        face1.endShape();
        cube.addChild(face1); // Ajouter la face au groupe

        // Face droite
        PShape face2 = createShape();
        face2.beginShape(QUADS);
        //face2.fill(couleurs[1]); // Couleur verte
        face2.textureMode(NORMAL); 
        face2.texture(texture); // Applique la texture sur cette face
        face2.shininess(200.0);
        face2.vertex(x, -y, -z,0,0);
        face2.vertex(x, -y, z,1,0);
        face2.vertex(x, y, z,1,1);
        face2.vertex(x, y, -z,0,1);
        face2.endShape();
        cube.addChild(face2);

        // Face bas
        PShape face3 = createShape();
        face3.beginShape(QUADS);
        //face3.fill(couleurs[2]); // Couleur bleue
        face3.textureMode(NORMAL); 
        face3.texture(texture); // Applique la texture sur cette face
        face3.shininess(200.0);
        face3.vertex(-x, y, -z,0,0);
        face3.vertex(x, y, -z,1,0);
        face3.vertex(x, y, z,1,1);
        face3.vertex(-x, y, z,0,1);
        face3.endShape();
        cube.addChild(face3);

        // Face haut
        PShape face4 = createShape();
        face4.beginShape(QUADS);
        //face4.fill(couleurs[3]); // Couleur jaune
        face4.textureMode(NORMAL); 
        face4.texture(texture); // Applique la texture sur cette face
        face4.shininess(200.0);
        face4.vertex(-x, -y, -z,0,0);
        face4.vertex(-x, -y, z,1,0);
        face4.vertex(x, -y, z,1,1);
        face4.vertex(x, -y, -z,0,1);
        face4.endShape();
        cube.addChild(face4);

        // Face devant
        PShape face5 = createShape();
        face5.beginShape(QUADS);
        //face5.fill(couleurs[4]); // Couleur magenta
        face5.textureMode(NORMAL); 
        face5.texture(texture); // Applique la texture sur cette face
        face5.shininess(200.0);
        face5.vertex(-x, -y, z,0,0);
        face5.vertex(x, -y, z,1,0);
        face5.vertex(x, y, z,1,1);
        face5.vertex(-x, y, z,0,1);
        face5.endShape();
        cube.addChild(face5);

        // Face derrière
        PShape face6 = createShape();
        face6.beginShape(QUADS);
        //face6.fill(couleurs[5]); // Couleur cyan
        face6.textureMode(NORMAL); 
        face6.texture(texture); // Applique la texture sur cette face
        face6.shininess(200.0);
        face6.vertex(-x, -y, -z,0,0);
        face6.vertex(x, -y, -z,1,0);
        face6.vertex(x, y, -z,1,1);
        face6.vertex(-x, y, -z,0,1);
        face6.endShape();
        cube.addChild(face6);

        return cube;
    }

}
