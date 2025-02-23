public class LumierePlafond {
    private PShape lampeShape;
    private PVector position;
    private PImage textureLumiere;

    // Constructeur
    public LumierePlafond(float x, float y, float z, PImage texture) {
        this.position = new PVector(x, y, z);
        this.textureLumiere = texture;
        this.lampeShape = init();
    }

    // Initialisation de la forme de la lampe
    private PShape init() {
        PShape lampe = createShape(GROUP);
        PShape base = monCube(1700, 100, 200, textureLumiere); // Cube aplati
        base.translate(position.x, position.y, position.z);
        lampe.addChild(base);
        return lampe;
    }

    // Afficher la lampe
    public void afficher() {
        shape(lampeShape);
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
