public class Chaise extends PShape {
    private float longueur; 
    private float largeur; 
    private float hauteur;

    public Chaise (float longueur, float largeur, float hauteur) {
        this.longueur = longueur;
        this.largeur = largeur; 
        this.hauteur = hauteur;
        init(longueur, largeur, hauteur) 
    }
    
    private PShape init(float longueur, float largeur, float hauteur){
        PShape cube = createShape(GROUP);
        float x = longueur / 2;
        float y = largeur / 2;
        float z = hauteur / 2;

        // Face gauche
        PShape face1 = createShape();
        face1.beginShape(QUADS);
        face1.fill(couleurs[0]); // Couleur rouge par défaut
        face1.vertex(-x, -y, -z);
        face1.vertex(-x, -y, z);
        face1.vertex(-x, y, z);
        face1.vertex(-x, y, -z);
        face1.endShape();

        // Face droite
        PShape face2 = createShape();
        face2.beginShape(QUADS);
        face2.fill(couleurs[1]); // Couleur verte par défaut
        face2.vertex(x, -y, -z);
        face2.vertex(x, -y, z);
        face2.vertex(x, y, z);
        face2.vertex(x, y, -z);
        face2.endShape();

        // Face bas
        PShape face3 = createShape();
        face3.beginShape(QUADS);
        face3.fill(couleurs[2]); // Couleur bleue par défaut
        face3.vertex(-x, y, -z);
        face3.vertex(x, y, -z);
        face3.vertex(x, y, z);
        face3.vertex(-x, y, z);
        face3.endShape();

        // Face haut
        PShape face4 = createShape();
        face4.beginShape(QUADS);
        face4.fill(couleurs[3]); // Couleur jaune par défaut
        face4.vertex(-x, -y, -z);
        face4.vertex(-x, -y, z);
        face4.vertex(x, -y, z);
        face4.vertex(x, -y, -z);
        face4.endShape();

        // Face devant
        PShape face5 = createShape();
        face5.beginShape(QUADS);
        face5.fill(couleurs[4]); // Couleur magenta par défaut
        face5.vertex(-x, -y, z);
        face5.vertex(x, -y, z);
        face5.vertex(x, y, z);
        face5.vertex(-x, y, z);
        face5.endShape();

        // Face derrière
        PShape face6 = createShape();
        face6.beginShape(QUADS);
        face6.fill(couleurs[5]); // Couleur cyan par défaut
        face6.vertex(-x, -y, -z);
        face6.vertex(x, -y, -z);
        face6.vertex(x, y, -z);
        face6.vertex(-x, y, -z);
        face6.endShape();

        // Ajout des faces au groupe
        cube.addChild(face1);
        cube.addChild(face2);
        cube.addChild(face3);
        cube.addChild(face4);
        cube.addChild(face5);
        cube.addChild(face6);
        //cube.scale(970, 250, 600);
        return cube;
    }
}
