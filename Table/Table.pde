public class Table {
    private PShape table; 
    private PImage texture_surface; 
    private PImage texture_noire;
    private PImage texture_clavier; 
    private PImage texture_souris;
    private PImage texture_ecran;

    public Table() {
        texture_surface = loadImage("texture_surface_table.jpg");
        texture_noire = loadImage("texture_noire.jpg");
        texture_clavier = loadImage("texture_clavier.jpg"); // Texture pour le clavier
        texture_souris = loadImage("texture_souris.jpg");   // Texture pour la souris
        texture_ecran = loadImage("texture_ecran.jpg");     // Texture pour l'écran
        this.table = init(); 
    }

    public PShape init() {
        PShape table = createShape(GROUP);

        // Création des parties de la table
        PShape surface = monCube(310, 25, 250, null);
        PShape partiedroite = monCube(25, 250, 250, null);
        PShape partieGauche = monCube(25, 250, 250, null);
        PShape partieface = monCube(250, 250, 25, null);

        // Positionnement des parties
        partiedroite.translate(250 / 2, 250 / 2, 0); 
        partieGauche.translate(-250 / 2, 250 / 2, 0);
        partieface.translate(0, 125, 250 / 2); 

        // Ajout des parties à la table
        table.addChild(surface);
        table.addChild(partiedroite);
        table.addChild(partieGauche);
        table.addChild(partieface);

        // Création et ajout du clavier
        PShape clavier = monCube(220, 10, 90, null);
        clavier.translate(0, -20, -50); // Position sur la surface de la table
        table.addChild(clavier);

        // Création et ajout de la souris
        PShape souris = monCube(30, 10, 20, null);
        souris.translate(80, -10, -50); // Position sur la surface à droite du clavier
        table.addChild(souris);

        // Création et ajout de l'écran
        PShape ecran = createShape(BOX, 200, 120, 10); // Écran mince et vertical
        ecran.setFill(color(0)); // Remplir l'écran en noir (couleur RGB)
        ecran.translate(0, -80, 50); // Position derrière le clavier
        table.addChild(ecran);

        // Création du support de l'écran
        PShape support = monCube(30, 10, 30, null);
        support.translate(0, -15, 50); // Position sous l'écran
        table.addChild(support);

        // Création de la partie haute de l'écran 
        PShape partieHaut = monCube(250, 20, 50, null);
        partieHaut.translate(0, -170, 50); // Position sur le haut de l'écran
        table.addChild(partieHaut);

        // Création du support de la partie haute  
        PShape supportHaut = monCube(50, 160, 15, null);
        supportHaut.translate(0, -100, 65); // Position sous l'écran
        table.addChild(supportHaut);

        // Ajout de l'unité centrale
        PShape uniteCentrale = monCube(50, 100, 100,null); // Taille de l'unité centrale
        uniteCentrale.translate(-90, 70, -60); // Position en bas à droite de la table
        table.addChild(uniteCentrale);

        return table;
    }


    // Méthode pour accéder à la forme
    public PShape getShape() {
        return this.table;
    }

    // Méthode pour créer un cube avec une texture
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
        face.shininess(50.0); // Brillance de la surface
        face.specular(color(255, 255, 255)); // Réflexion spéculaire (blanc)

        // Coordonées des sommets pour chaque face et application des normales
        switch (i) {
            case 0: // Face gauche
                normal(-1, 0, 0);  // Normal vers la gauche
                face.vertex(-x, -y, -z, 0, 0);
                face.vertex(-x, -y, z, 1, 0);
                face.vertex(-x, y, z, 1, 1);
                face.vertex(-x, y, -z, 0, 1);

                // Dessiner la normale (une ligne partant du centre de la face)
                line(-x, -y, -z, -x - 200, -y, -z); // Ligne représentant la normale
                break;
            case 1: // Face droite
                normal(1, 0, 0);   // Normal vers la droite
                face.vertex(x, -y, -z, 0, 0);
                face.vertex(x, -y, z, 1, 0);
                face.vertex(x, y, z, 1, 1);
                face.vertex(x, y, -z, 0, 1);

                // Dessiner la normale (une ligne partant du centre de la face)
                line(x, -y, -z, x + 200, -y, -z); // Ligne représentant la normale
                break;
            case 2: // Face bas
                normal(0, 1, 0);   // Normal vers le bas
                face.vertex(-x, y, -z, 0, 0);
                face.vertex(x, y, -z, 1, 0);
                face.vertex(x, y, z, 1, 1);
                face.vertex(-x, y, z, 0, 1);

                // Dessiner la normale (une ligne partant du centre de la face)
                line(-x, y, -z, -x, y + 200, -z); // Ligne représentant la normale
                break;
            case 3: // Face haut
                normal(0, -1, 0);  // Normal vers le haut
                face.vertex(-x, -y, -z, 0, 0);
                face.vertex(-x, -y, z, 1, 0);
                face.vertex(x, -y, z, 1, 1);
                face.vertex(x, -y, -z, 0, 1);

                // Dessiner la normale (une ligne partant du centre de la face)
                line(-x, -y, -z, -x, -y - 200, -z); // Ligne représentant la normale
                break;
            case 4: // Face devant
                normal(0, 0, 1);   // Normal vers l'avant
                face.vertex(-x, -y, z, 0, 0);
                face.vertex(x, -y, z, 1, 0);
                face.vertex(x, y, z, 1, 1);
                face.vertex(-x, y, z, 0, 1);

                // Dessiner la normale (une ligne partant du centre de la face)
                line(-x, -y, z, -x, -y, z + 200); // Ligne représentant la normale
                break;
            case 5: // Face derrière
                normal(0, 0, -1);  // Normal vers l'arrière
                face.vertex(-x, -y, -z, 0, 0);
                face.vertex(x, -y, -z, 1, 0);
                face.vertex(x, y, -z, 1, 1);
                face.vertex(-x, y, -z, 0, 1);

                // Dessiner la normale (une ligne partant du centre de la face)
                line(-x, -y, -z, -x, -y, -z - 200); // Ligne représentant la normale
                break;
        }
        face.endShape();
        cube.addChild(face);
    }
    return cube;
}



}
