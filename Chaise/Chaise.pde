public class Chaise {

    private color[] couleurs;
    private PShape chaiseShape; // Le PShape pour représenter la chaise
    PImage texture_pied; 
    PImage texture_chaise; 

    // Constructeur
    public Chaise() {
        // Stocker les couleurs passées en paramètre
        texture_pied = loadImage("texture_pied.jpg");
        texture_chaise = loadImage("texture_chaise.jpg"); 
        this.chaiseShape = init(); // Initialiser et construire la chaise
    }

    // Méthode pour initialiser et construire la forme de la chaise
private PShape init() {
    // Création des groupes pour la chaise
    PShape chaise = createShape(GROUP); // Créer un groupe pour la chaise
    PShape pieds = createShape(GROUP);  // Créer un groupe pour les pieds

    // Création des éléments de la chaise 
    PShape composant1 = monCube(250, 25, 250,texture_chaise); // Partie de la chaise où l'on s'assoie
    PShape dossier = monCube(25, 250, 250,texture_chaise);   // Dossier de la chaise

    // Création des pieds de la chaise (en utilisant un tableau)
    PShape[] tabPieds = new PShape[4];  // Créer un tableau pour les 4 pieds

    for (int i = 0; i < tabPieds.length; ++i) {
        tabPieds[i] = monCube(15, 240, 15,texture_pied);  // Créer un cube pour chaque pied
    }

    // Transformation sur le dossier
    dossier.translate(115, -125, 0);  // Positionner le dossier en hauteur et centré

    // Transformation sur les 4 pieds
    tabPieds[0].translate(-100, 130, 100); // Pied haut-droite
    tabPieds[1].translate(-100, 130, -100); // Pied haut-gauche
    tabPieds[2].translate(100, 130, 100);  // Pied bas-droit
    tabPieds[3].translate(100, 130, -100); // Pied bas-gauche

    // Ajouter les pieds au groupe
    for (PShape pied : tabPieds) {
        pieds.addChild(pied);  // Ajouter chaque pied au groupe
    }

    // Ajouter tous les composants à la chaise
    chaise.addChild(composant1);  // Ajouter la base de la chaise
    chaise.addChild(dossier);     // Ajouter le dossier
    chaise.addChild(pieds);       // Ajouter les pieds

    return chaise;  // Retourner la forme complète de la chaise
}

    // Méthode pour accéder à la forme
    public PShape getShape() {
        return this.chaiseShape;
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
