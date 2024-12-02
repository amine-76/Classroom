Chaise chaise;
float angle = 0f;
PShape salle; // Déclaration de la variable pour la boîte
float camX = 0;
float camY = 0;
float camZ = 0;
float rayon = 400; // Rayon pour la caméra
float phi = 0;
float theta = 0;
float longueur = 970;// 9.785m
float largeur = 600; // 6 m 
float hauteur = 450;

void setup() {
  size(800, 800, P3D);

  // Couleurs pour les faces
  color[] couleurs = {
    color(255, 0, 0),    // Rouge
    color(0, 255, 0),    // Vert
    color(0, 0, 255),    // Bleu
    color(255, 255, 0),  // Jaune
    color(255, 0, 255),  // Magenta
    color(0, 255, 255)   // Cyan
  };

  // Créer une chaise avec des dimensions et couleurs
  chaise = new Chaise();
}

void draw() {
  background(0);
  lights();
  //bougerCamera(); 
  //camera(camX, camY, camZ, 0,0,0,0,1,0); 
  translate(width / 2, height / 2);
   rotateX(frameCount * 0.01);
   rotateY(frameCount * 0.01);

  // Dessiner la chaise
  shape(chaise.getShape());
}

void bougerCamera() {
  theta = map(mouseX, 0, width, 0, TWO_PI); // Rotation autour de l'axe Y (horizontal)
  phi = map(mouseY, 0, height, -PI / 2, PI / 2); // Rotation vers le haut/bas (vertical)

  // Conversion des coordonnées sphériques en cartésiennes
  camX = rayon * cos(phi) * sin(theta);
  camY = rayon * sin(phi);
  camZ = rayon * cos(phi) * cos(theta);
}
 