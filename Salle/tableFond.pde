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


    private PShape monCube(float longueur, float hauteur, float largeur, PImage texture) {
    PShape cube = createShape(GROUP); // Créer un groupe pour le cube
    float x = longueur / 2;
    float y = hauteur / 2;
    float z = largeur / 2;

    // Création des 6 faces avec la texture
    for (int i = 0; i < 6; i++) {
        PShape face = createShape();
        face.beginShape(QUADS);
        face.textureMode(NORMAL);
        face.texture(texture);
        face.shininess(200.0);

        // Coordonées des sommets et normales pour chaque face
        switch (i) {
            case 0: // Face gauche
                face.normal(-1, 0, 0); face.vertex(-x, -y, -z, 0, 0);
                face.normal(-1, 0, 0); face.vertex(-x, -y, z, 1, 0);
                face.normal(-1, 0, 0); face.vertex(-x, y, z, 1, 1);
                face.normal(-1, 0, 0); face.vertex(-x, y, -z, 0, 1);
                break;
            case 1: // Face droite
                face.normal(1, 0, 0); face.vertex(x, -y, -z, 0, 0);
                face.normal(1, 0, 0); face.vertex(x, -y, z, 1, 0);
                face.normal(1, 0, 0); face.vertex(x, y, z, 1, 1);
                face.normal(1, 0, 0); face.vertex(x, y, -z, 0, 1);
                break;
            case 2: // Face bas
                face.normal(0, 1, 0); face.vertex(-x, y, -z, 0, 0);
                face.normal(0, 1, 0); face.vertex(x, y, -z, 1, 0);
                face.normal(0, 1, 0); face.vertex(x, y, z, 1, 1);
                face.normal(0, 1, 0); face.vertex(-x, y, z, 0, 1);
                break;
            case 3: // Face haut
                 face.normal(0, -1, 0); face.vertex(-x, -y, -z, 0, 0);
                face.normal(0, -1, 0); face.vertex(-x, -y, z, 1, 0);
                face.normal(0, -1, 0); face.vertex(x, -y, z, 1, 1);
                face.normal(0, -1, 0); face.vertex(x, -y, -z, 0, 1);
                break;
            case 4: // Face devant
                face.normal(0, 0, 1); face.vertex(-x, -y, z, 0, 0);
                face.normal(0, 0, 1); face.vertex(x, -y, z, 1, 0);
                face.normal(0, 0, 1); face.vertex(x, y, z, 1, 1);
                face.normal(0, 0, 1); face.vertex(-x, y, z, 0, 1);
                break;
            case 5: // Face derrière
                face.normal(0, 0, -1); face.vertex(-x, -y, -z, 0, 0);
                face.normal(0, 0, -1); face.vertex(x, -y, -z, 1, 0);
                face.normal(0, 0, -1); face.vertex(x, y, -z, 1, 1);
                face.normal(0, 0, -1); face.vertex(-x, y, -z, 0, 1);
                break;
        }
        face.endShape();
        cube.addChild(face);
    }
    return cube;
}

}
