float angle = 0f;
PShape salle; // Déclaration de la variable pour la boîte
float camX = 0;
float camY = 0;
float camZ = 0;
float rayon = 425; // Rayon pour la caméra
float phi = 0;
float theta = 0;
float longueur = 970;// 9.785m
float largeur = 600; // 6 m 
float hauteur = 450;
PImage tex_porte;

color[] couleurs = {
  color(255, 0, 0),    // Rouge
  color(0, 255, 0),    // Vert
  color(0, 0, 255),    // Bleu
  color(255, 255, 0),  // Jaune
  color(255, 0, 255),  // Magenta
  color(0, 255, 255)   // Cyan
};

void setup() {
  size(600, 600, P3D);
  salle = maSalle(largeur, hauteur, longueur, couleurs); // Création de la boîte paramétrée
  tex_porte = loadImage("Texture/texture_porte.jpg");
  float fov = PI/3;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 10, 1500);
}

void draw() {
  background(0);
  noStroke();
  bougerCamera();
  camera(camX, camY, camZ, 0, 0, 0, 0, 1, 0);
  drawRepere(); 
  shape(salle); // Afficher la boîte
}

PShape maSalle(float l, float L, float P, color[] couleurs) { 
  PShape cube = createShape(GROUP);
  float x = l / 2;
  float y = L / 2;
  float z = P / 2;

  // Face gauche
  PShape face1 = createShape();
  face1.beginShape(QUADS);
  //face1.fill(couleurs[0]); // Couleur rouge par défaut
  face1.vertex(-x, -y, -z);
  face1.vertex(-x, -y, z);
  face1.vertex(-x, y, z);
  face1.vertex(-x, y, -z);
  face1.endShape();

  // Face droite
  PShape face2 = createShape();
  face2.beginShape(QUADS);
  face2.textureMode(NORMAL);
  face2.texture(tex_porte); // Applique la texture sur cette face
  face2.shininess(200.0);

  // Définition des sommets avec coordonnées UV pour mapper une partie de la texture
  face2.vertex(x, -y, -z, 0.15, 0.75); // Coin supérieur gauche de la porte
  face2.vertex(x, -y, z, 0.25, 0.75);  // Coin supérieur droit de la porte
  face2.vertex(x, y, z, 0.25, 0.95);   // Coin inférieur droit de la porte
  face2.vertex(x, y, -z, 0.15, 0.95);  // Coin inférieur gauche de la porte

  face2.endShape();


  // Face bas
  PShape face3 = createShape();
  face3.beginShape(QUADS);
  //face3.fill(couleurs[2]); // Couleur bleue par défaut
  face3.vertex(-x, y, -z);
  face3.vertex(x, y, -z);
  face3.vertex(x, y, z);
  face3.vertex(-x, y, z);
  face3.endShape();

  // Face haut
  PShape face4 = createShape();
  face4.beginShape(QUADS);
  //face4.fill(couleurs[3]); // Couleur jaune par défaut
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
  //face6.fill(couleurs[5]); // Couleur cyan par défaut
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

void bougerCamera() {
  theta = map(mouseX, 0, width, 0, TWO_PI); // Rotation autour de l'axe Y (horizontal)
  phi = map(mouseY, 0, height, -PI / 2, PI / 2); // Rotation vers le haut/bas (vertical)

  // Conversion des coordonnées sphériques en cartésiennes
  camX = rayon * cos(phi) * sin(theta);
  camY = rayon * sin(phi);
  camZ = rayon * cos(phi) * cos(theta);
}


// Fonction pour dessiner le repère
void drawRepere() {
  strokeWeight(3);

  // Axe X en rouge
  stroke(255, 0, 0);
  line(0, 0, 0, 200, 0, 0);

  // Axe Y en vert
  stroke(0, 255, 0);
  line(0, 0, 0, 0, 200, 0);

  // Axe Z en bleu
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, 200);

  // Remet la couleur à l'état initial
  noStroke();
}