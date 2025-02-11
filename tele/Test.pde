Tele tele;
float angle = 0f;
float camX = 0;
float camY = 0;
float camZ = 0;
float rayon = 1000; // Rayon pour la caméra
float phi = 0;
float theta = 0;
float longueur = 970;// 9.785m
float largeur = 600; // 6 m 
float hauteur = 450;
PShader lightShader; 
PVector[] lightPos = { 
  new PVector(300, -300, 300),
  new PVector(-300, 300, 300),
  new PVector(-300, 300, -300),
  new PVector(0, -300, 0)
};

PVector[] lightColor = {
  new PVector(255, 255, 255),
  new PVector(40, 100, 255),
  new PVector(255, 200, 55),
  new PVector(255, 0, 0)
};


void setup() {
  size(800, 800, P3D);
  // Créer une chaise avec des dimensions et couleurs
  tele = new Tele(1,1,1);
  lightShader = loadShader("Lambert1DiffuseFrag.glsl","Lambert1DiffuseVert.glsl");   
  if (lightShader != null) {
    println("Shader light chargé"); 
  } else println("Shader light pas chargé"); 

}

void draw() {
  background(200);
  //lights();
  //textlightShader(lightShader); 
  bougerCamera(); 
  camera(camX, camY, camZ, 0,0,0,0,1,0); 
  //translate(width / 2, height / 2);
  // Dessiner la chaise
  shape(tele.getShape());
  drawRepere(); 
  for(int i=0; i<lightPos.length; i++) {
    pointLight(lightColor[i].x, lightColor[i].y, lightColor[i].z, 
               lightPos[i].x, lightPos[i].y, lightPos[i].z);
}   

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
  line(0, 0, 0, 1000, 0, 0);

  // Axe Y en vert
  stroke(0, 255, 0);
  line(0, 0, 0, 0, 1000, 0);

  // Axe Z en bleu
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, 1000);

  // Remet la couleur à l'état initial
  noStroke();
}  