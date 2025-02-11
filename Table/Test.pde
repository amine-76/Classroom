PShader lightShader ; 
Table table;
float angle = 0f;
float camX = 0;
float camY = 0;
float camZ = 0;
float rayon = 800; // Rayon pour la caméra
float phi = 0;
float theta = 0;
float longueur = 970;// 9.785m
float largeur = 600; // 6 m 
float hauteur = 450;
PVector[] lightPos = { 
  new PVector(300, -300, 300)
};

PVector[] lightColor = {
  new PVector(255, 255, 255)
};


void setup() {
  size(800, 800, P3D);
  lightShader = loadShader("Lambert1DiffuseFrag.glsl","Lambert1DiffuseVert.glsl");   


  // Couleurs pour les faces
  color[] couleurs = {
    color(255, 0, 0),    // Rouge
    color(0, 255, 0),    // Vert
    color(0, 0, 255),    // Bleu
    color(255, 255, 0),  // Jaune
    color(255, 0, 255),  // Magenta
    color(0, 255, 255)   // Cyan
  };

  // Créer une table avec des dimensions et couleurs
  table = new Table();
}

void draw() {
  background(255);
  shader(lightShader);
  bougerCamera(); 
  camera(camX, camY, camZ, 0,0,0,0,1,0); 

  // Dessiner la chaise
  shape(table.getShape());
  drawRepere(); 
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
