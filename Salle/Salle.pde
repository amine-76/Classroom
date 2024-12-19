float angle = 0f;
PShape salle; // Déclaration de la variable pour la boîte
float camX = 0;
float camY = 0;
float camZ = 0;
float rayon = 425; // Rayon pour la caméra
float phi = 0;
float theta = 0;
float longueur = 9700;// 9.785m
float largeur = 6000; // 6 m 
float hauteur = 2500;
//Texture
PImage tex_porte;
PImage tex_wall;
PImage tex_papier; 
PImage tex_tableau; 
PImage tex_plafond; 

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
  tex_porte = loadImage("texture_porte.jpg");
  tex_wall = loadImage("texture_wall.jpg");
  tex_tableau = loadImage("texture_tableau.jpg");
  tex_papier = loadImage("texture_papier.jpg"); 
  tex_plafond = loadImage("texture_plafond.jpg"); 
  salle = maSalle(largeur, hauteur, longueur, couleurs); // Création de la boîte paramétrée


  if (tex_porte == null) {
    println("Erreur : Impossible de charger texture_porte.jpg");
  } else {
    println("texture_porte.jpg chargée avec succès !");
  }

  if (tex_wall == null) {
    println("Erreur : Impossible de charger texture_wall.jpg");
  } else {
    println("texture_wall.jpg chargée avec succès !");
  }
  float fov = PI/3;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 10, 9000);
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
  face1.textureMode(NORMAL);
  face1.texture(tex_papier); // Applique la texture sur cette face
  face1.shininess(200.0);
  //face1.fill(couleurs[0]); // Couleur rouge par défaut
  face1.vertex(-x, -y, -z,0,0);
  face1.vertex(-x, -y, z,1,0);
  face1.vertex(-x, y, z,1,1);
  face1.vertex(-x, y, -z,0,1);
  face1.endShape();

  // Face droite
  PShape face2 = createShape();
  face2.beginShape(QUADS);
  face2.textureMode(NORMAL);
  face2.texture(tex_papier); // Applique la texture sur cette face
  face2.shininess(200.0);

  // Définition des sommets avec coordonnées UV pour mapper une partie de la texture
  face2.vertex(x, -y, -z, 0, 0); // Coin supérieur gauche de la porte
  face2.vertex(x, -y, z, 1, 0);  // Coin supérieur droit de la porte
  face2.vertex(x, y, z, 1, 1);   // Coin inférieur droit de la porte
  face2.vertex(x, y, -z, 0, 1);  // Coin inférieur gauche de la porte

  face2.endShape();


  // Face bas
  PShape face3 = createShape();
  face3.beginShape(QUADS);
  //face3.fill(couleurs[2]); // Couleur bleue par défaut
  face3.textureMode(NORMAL);
  println(tex_wall);
  face3.texture(tex_wall); // Applique la texture sur cette face
  face3.shininess(200.0);

  face3.vertex(-x, y, -z,0,0);
  face3.vertex(x, y, -z,1,0);
  face3.vertex(x, y, z,1,1);
  face3.vertex(-x, y, z,0,1);
  face3.endShape();

  // Face haut
  PShape face4 = createShape();
  face4.beginShape(QUADS);
  face4.textureMode(NORMAL);
  face4.texture(tex_plafond); 
  face4.shininess(200.0);
  face4.vertex(-x, -y, -z,0,0);
  face4.vertex(-x, -y, z,1,0);
  face4.vertex(x, -y, z,1,1);
  face4.vertex(x, -y, -z,0,1);
  face4.endShape();

  // Face devant
  PShape faceMur = createShape();
  faceMur.beginShape(QUADS);
  faceMur.textureMode(NORMAL);

  // Texture du mur
  faceMur.texture(tex_papier);
  faceMur.vertex(-x, -y, z, 0, 0); // Coin supérieur gauche du mur
  faceMur.vertex(x, -y, z, 1, 0);  // Coin supérieur droit du mur
  faceMur.vertex(x, y, z, 1, 1);   // Coin inférieur droit du mur
  faceMur.vertex(-x, y, z, 0, 1);  // Coin inférieur gauche du mur
  faceMur.endShape();

  // Face tableau (centrée sur le mur)
  PShape faceTableau = createShape();
  faceTableau.beginShape(QUADS);
  faceTableau.textureMode(NORMAL);

  // Texture du tableau
  faceTableau.texture(tex_tableau);
  faceTableau.vertex(-2500, -y + 2000, z-500, 0, 0); // Coin supérieur gauche du tableau
  faceTableau.vertex(2500, -y + 2000, z-500, 1, 0);  // Coin supérieur droit du tableau
  faceTableau.vertex(2500, 0, z-500, 1, 1);         // Coin inférieur droit du tableau
  faceTableau.vertex(-2500, 0, z-500, 0, 1);        // Coin inférieur gauche du tableau
  faceTableau.endShape();

  // Ajout des deux faces au groupe
  PShape groupeMurEtTableau = createShape(GROUP);
  groupeMurEtTableau.addChild(faceMur);       // Ajout du mur
  groupeMurEtTableau.addChild(faceTableau);   // Ajout du tableau

  // Face derrière
  PShape face6 = createShape();
  face6.beginShape(QUADS);
  face6.textureMode(NORMAL);
  face6.texture(tex_papier); // Applique la texture sur cette face
  face6.shininess(200.0);
  //face6.fill(couleurs[5]); // Couleur cyan par défaut
  face6.vertex(-x, -y, -z,0,0);
  face6.vertex(x, -y, -z,1,0);
  face6.vertex(x, y, -z,1,1);
  face6.vertex(-x, y, -z,0,1);
  face6.endShape();

  // Ajout des faces au groupe
  cube.addChild(face1);
  cube.addChild(face2);
  cube.addChild(face3);
  cube.addChild(face4);
  cube.addChild(groupeMurEtTableau);
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