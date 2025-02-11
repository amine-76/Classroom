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
        PShape surface = monCube(310, 25, 250, texture_surface);
        PShape partiedroite = monCube(25, 250, 250, texture_noire);
        PShape partieGauche = monCube(25, 250, 250, texture_noire);
        PShape partieface = monCube(250, 250, 25, texture_noire);

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
        PShape clavier = monCube(150, 10, 50, texture_clavier);
        clavier.setFill(color(0));
        clavier.translate(0, -20, -50); // Position sur la surface de la table
        table.addChild(clavier);

        // Création et ajout de la souris
        PShape souris = monCube(15, 10, 30, texture_souris);
        souris.setFill(color(0));
        souris.translate(-95, -10, -40); // Position sur la surface à droite du clavier
        table.addChild(souris);

        // Création et ajout de l'écran
        PShape ecran = createShape(BOX, 200, 120, 10); // Écran mince et vertical
        ecran.setFill(color(0)); // Remplir l'écran en noir (couleur RGB)
        ecran.translate(0, -80, 50); // Position derrière le clavier
        table.addChild(ecran);

        // Création du support de l'écran
        PShape support = monCube(30, 10, 30, texture_noire);
        support.translate(0, -15, 50); // Position sous l'écran
        table.addChild(support);

        // Création de la partie haute de l'écran 
        PShape partieHaut = monCube(250, 20, 50, texture_surface);
        partieHaut.translate(0, -170, 50); // Position sur le haut de l'écran
        table.addChild(partieHaut);

        // Création du support de la partie haute  
        PShape supportHaut = monCube(50, 160, 15, texture_noire);
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
            face.shininess(200.0);

            // Coordonées des sommets pour chaque face
            switch (i) {
                case 0: // Face gauche
                    face.vertex(-x, -y, -z, 0, 0);
                    face.vertex(-x, -y, z, 1, 0);
                    face.vertex(-x, y, z, 1, 1);
                    face.vertex(-x, y, -z, 0, 1);
                    break;
                case 1: // Face droite
                    face.vertex(x, -y, -z, 0, 0);
                    face.vertex(x, -y, z, 1, 0);
                    face.vertex(x, y, z, 1, 1);
                    face.vertex(x, y, -z, 0, 1);
                    break;
                case 2: // Face bas
                    face.vertex(-x, y, -z, 0, 0);
                    face.vertex(x, y, -z, 1, 0);
                    face.vertex(x, y, z, 1, 1);
                    face.vertex(-x, y, z, 0, 1);
                    break;
                case 3: // Face haut
                    face.vertex(-x, -y, -z, 0, 0);
                    face.vertex(-x, -y, z, 1, 0);
                    face.vertex(x, -y, z, 1, 1);
                    face.vertex(x, -y, -z, 0, 1);
                    break;
                case 4: // Face devant
                    face.vertex(-x, -y, z, 0, 0);
                    face.vertex(x, -y, z, 1, 0);
                    face.vertex(x, y, z, 1, 1);
                    face.vertex(-x, y, z, 0, 1);
                    break;
                case 5: // Face derrière
                    face.vertex(-x, -y, -z, 0, 0);
                    face.vertex(x, -y, -z, 1, 0);
                    face.vertex(x, y, -z, 1, 1);
                    face.vertex(-x, y, -z, 0, 1);
                    break;
            }
            face.endShape();
            cube.addChild(face);
        }
        return cube;
    }
}
