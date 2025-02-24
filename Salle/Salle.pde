PShape salle; // Déclaration de la variable pour la boîte
PShape tables;
PShape maTele;
PShape formeTableFond;
PShape formebureauProf;
PShape groupeTables;
PShape formeChaiseProf;
Chaise chaiseProf;
Tele tele;
tableFond tableFond;
tableFond bureauProf;
LumierePlafond lampe;



float longueur = 9700;// 9.785m
float largeur = 6000; // 6 m
float hauteur = 2500;

//Texture
PImage tex_porte;
PImage tex_wall;
PImage tex_papier;
PImage tex_tableau;
PImage tex_plafond;
PImage tex_tele;
PImage tex_chaise;
PImage tex_pied;
PImage tex_fenetre;
PImage textureLumiere;

//Shader
PShader colorShader;
PShader lightShader;
PShader lightShaderTex;

//Position des lumières
PVector[] lightPos = {
  new PVector(0, -hauteur/2 + 100, 0), // Lumière qui passe dynamiquement autour de la salle
  new PVector(-250, -hauteur/3, longueur/2-100) // Lumière qui eclaire le tableau
};

// Position de la caméra
PVector cameraPos = new PVector(0, 0, -500);
PVector cameraTarget = new PVector(0, 0, 0);

float angleLumiere = 0; // Angle de rotation de la lumière
float rayonLumiere = 100; // Distance du centre pour la lumière

float speed = 20;

boolean allume = true;


color[] couleurs = {
  color(255, 0, 0), // Rouge
  color(0, 255, 0), // Vert
  color(0, 0, 255), // Bleu
  color(255, 255, 0), // Jaune
  color(255, 0, 255), // Magenta
  color(0, 255, 255)   // Cyan
};

void setup() {
  size(600, 600, P3D);
  tex_pied = loadImage("texture_pied.jpg");
  tex_porte = loadImage("texture_porte.jpg");
  tex_wall = loadImage("texture_wall.jpg");
  tex_tableau = loadImage("texture_tableau.jpg");
  tex_papier = loadImage("texture_papier.jpg");
  tex_plafond = loadImage("texture_haut.jpg");
  tex_tele = loadImage("texture_tele.jpg");
  tex_chaise = loadImage("texture_chaise.jpg");
  tex_fenetre = loadImage("texture_fenetre.jpg");
  textureLumiere = loadImage("texture_lum.jpeg");

  salle = maSalle(largeur, hauteur, longueur, couleurs); // Création de la boîte paramétrée
  tableFond = new tableFond();
  bureauProf = new tableFond();
  chaiseProf = new Chaise();
  formeTableFond = tableFond.getShape();
  formebureauProf = bureauProf.getShape();
  formeChaiseProf = chaiseProf.getShape();
  formeTableFond.rotateY(PI);
  formebureauProf.rotateY(PI);

  tele = new Tele();
  //Lumière plafond
  lampe = new LumierePlafond(lightPos[1].x, lightPos[1].y, lightPos[1].z, textureLumiere);
  maTele = tele.getShape();
  colorShader = loadShader("ColorShaderFrag.glsl", "ColorShaderVert.glsl");
  lightShader = loadShader("Lambert1DiffuseFrag.glsl", "Lambert1DiffuseVert.glsl");
  lightShaderTex = loadShader("LightShaderTexFrag.glsl", "LightShaderTexVert.glsl");

  //Tables
  groupeTables = createShape(GROUP);
  float espacementZ = 700;
  for (int i = 0; i < 5; ++i) {
    float espacementX = 0;
    for (int j = 0; j < 6; ++j) {
      Chaise chaise = new Chaise();
      Table table = new Table();
      PShape formeTable = table.getShape();
      PShape formeChaise = chaise.getShape();
      formeTable.scale(2.10);
      formeChaise.scale(1.20);
      formeTable.translate(espacementX, hauteur / 2 - 400, espacementZ);
      formeChaise.translate(espacementX, hauteur / 2 - 200, espacementZ-350);
      groupeTables.addChild(formeTable);
      groupeTables.addChild(formeChaise);
      espacementX += 650;
    }
    espacementZ += 1000;
  }


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
  if (tex_plafond == null) {
    println("Erreur : Impossible de charger texture_plafond.jpg");
  } else {
    println("texture_plafond.jpg chargée avec succès !");
  }
  if (tex_tableau == null) {
    println("Erreur : Impossible de charger texture_tableau.jpg");
  } else {
    println("texture_tableau.jpg chargée avec succès !");
  }
  if (tex_chaise == null) {
    println("Erreur : Impossible de charger texture_chaise.jpg");
  } else {
    println("texture_chaise.jpg chargée avec succès !");
  }
  if (tex_pied == null) {
    println("Erreur : Impossible de charger texture_pied.jpg");
  } else {
    println("texture_pied.jpg chargée avec succès !");
  }
  if (tex_fenetre == null) {
    println("Erreur : Impossible de charger texture_fenetre.jpg");
  } else {
    println("texture_feentre.jpg chargée avec succès !");
  }
  if (tex_porte == null) {
    println("Erreur : Impossible de charger texture_porte.jpg");
  } else {
    println("texture_porte.jpg chargée avec succès !");
  }
  if (lightShader == null) {
    println("Erreur : Impossible de charger le lightShader");
  } else {
    println("lightShader chargée avec succès !");
  }

  float fov = PI/3;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 10, 200000);
}

void draw() {
  background(115);
  noStroke();
  bougerCamera();


  camera(cameraPos.x, cameraPos.y, cameraPos.z, cameraTarget.x, cameraTarget.y, cameraTarget.z, 0, 1, 0);
  // Mise à jour de l'angle pour la rotation
  angleLumiere += 0.02; // Vitesse de rotation de la lumière
  if (angleLumiere > TWO_PI) {
    angleLumiere = 0;
  }

  // Calcul de la position de la lumière au-dessus
  lightPos[0].x = longueur / 5 * cos(angleLumiere);  // Mouvement circulaire
  lightPos[0].y = largeur / 5 * sin(angleLumiere);
  lightPos[0].z =  0;

  shader(lightShaderTex);
  //pointLight(255, 255, 255, lightPos[0].x, lightPos[0].y, lightPos[0].z);
    // Si allumer est vrai, on allume les lumières
  if (allume) {
    for (int i = 0; i < lightPos.length; i++) {
      pointLight(255, 255, 255, lightPos[i].x, lightPos[i].y, lightPos[i].z);
    }
  }

  specular(255, 255, 255); // Reflet blanc pour la brillance
  shininess(255);           // Concentration du reflet
  ambientLight(50, 50, 50);
  shape(salle); // Afficher la boîte

  // Dessiner la boîte autour de la table
  /*pushMatrix();
   noStroke();
   translate(lightPos[2].x, lightPos[2].y, lightPos[2].y);  // Centrer la boîte sur la table
   box(150);  // Dimensions légèrement plus grandes que la table
   popMatrix();*/

  // transformation sur la télé
  pushMatrix();
  translate(largeur / 2 - 1200, hauteur / 2 - 1400, longueur/2-2000); // Translation vers la position de la télé
  rotateY(PI/3);
  scale(2.6);
  //shader(colorShader);
  shape(maTele); // télé arc en ciel : shader du cours utiliser sur le modèle de couleur
  resetShader();
  popMatrix();

  // transformation tables
  pushMatrix();
  translate(-2600, -100, -3000);
  shape(groupeTables);
  popMatrix();

  lampe.afficher();



  // Table de fond
  pushMatrix();
  translate(0, hauteur/2-750, -longueur/2+400);
  scale(3);
  shape(formeTableFond);
  popMatrix();

  // Bureau Prof
  pushMatrix();
  translate(largeur/5-500, hauteur/2-500, longueur/5+400);
  scale(2);
  shape(formebureauProf);
  popMatrix();

  // Chaise Prof
  pushMatrix();
  translate(largeur/5-500, hauteur/2-300, longueur/5+600);
  scale(1.1);
  rotateY(PI);
  shape(formeChaiseProf);
  popMatrix();

  resetShader();
}

PShape maSalle(float l, float L, float P, color[] couleurs) {
  PShape cube = createShape(GROUP);
  float x = l / 2;
  float y = L / 2;
  float z = P / 2;

  // Face droite
  PShape face1 = createShape();
  face1.beginShape(QUADS);
  face1.textureMode(NORMAL);
  face1.texture(tex_papier); // Applique la texture sur cette face
  face1.shininess(200.0);
  face1.fill(couleurs[0]); // Couleur rouge par défaut
  face1.normal(1, 0, 0);
  face1.vertex(-x, -y, -z, 0, 0);
  face1.normal(1, 0, 0);
  face1.vertex(-x, -y, z, 1, 0);
  face1.normal(1, 0, 0);
  face1.vertex(-x, y, z, 1, 1);
  face1.normal(1, 0, 0);
  face1.vertex(-x, y, -z, 0, 1);
  face1.endShape();

  // Porte
  PShape facePorte = createShape();
  facePorte.beginShape();
  float porteZ = 4000;
  float porteX = -x+20;
  float porteY = hauteur/2;
  facePorte.textureMode(NORMAL);
  facePorte.texture(tex_porte);
  facePorte.shininess(200.0);
  facePorte.normal(1, 0, 0);
  facePorte.vertex(porteX, -500, porteZ, 0, 0);
  facePorte.normal(1, 0, 0);
  facePorte.vertex(porteX, -500, porteZ-1000, 1, 0);
  facePorte.normal(1, 0, 0);
  facePorte.vertex(porteX, porteY, porteZ-1000, 1, 1);
  facePorte.normal(1, 0, 0);
  facePorte.vertex(porteX, porteY, porteZ, 0, 1);

  facePorte.endShape();

  // groupe porte et face
  PShape groupeMurEtporte = createShape(GROUP);
  groupeMurEtporte.addChild(face1);
  groupeMurEtporte.addChild(facePorte);


  // Face gauche
  PShape face2 = createShape();
  face2.beginShape(QUADS);
  face2.textureMode(NORMAL);
  face2.texture(tex_papier); // Applique la texture sur cette face
  face2.shininess(200.0);

  // // Définition des sommets avec coordonnées UV pour mapper une partie de la texture
  face2.normal(-1, 0, 0);
  face2.vertex(x, -y, -z, 0, 0); // Coin supérieur gauche de la porte
  face2.normal(-1, 0, 0);
  face2.vertex(x, -y, z, 1, 0);  // Coin supérieur droit de la porte
  face2.normal(-1, 0, 0);
  face2.vertex(x, y, z, 1, 1);   // Coin inférieur droit de la porte
  face2.normal(-1, 0, 0);
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
  face3.normal(-1, -1, 0);
  face3.vertex(-x, y, -z, 0, 0);
  face3.normal(1, -1, 0);
  face3.vertex(x, y, -z, 1, 0);
  face3.normal(1, -1, 0);
  face3.vertex(x, y, z, 1, 1);
  face3.normal(-1, -1, 0);
  face3.vertex(-x, y, z, 0, 1);
  face3.endShape();

  // Face haut
  PShape face4 = createShape();
  face4.beginShape(QUADS);
  face4.textureMode(NORMAL);
  face4.texture(tex_plafond);
  face4.shininess(200.0);
  normal(0, -1, -1);
  face4.vertex(-x, -y, -z, 0, 0);
  normal(0, -1, 1);
  face4.vertex(-x, -y, z, 1, 0);
  normal(0, -1, 1);
  face4.vertex(x, -y, z, 1, 1);
  normal(0, -1, -1);
  face4.vertex(x, -y, -z, 0, 1);
  face4.endShape();

  // Face avant
  PShape face5 = createShape();
  face5.beginShape(QUADS);
  face5.textureMode(NORMAL);
  face5.texture(tex_papier);
  face5.normal(-1, 0, -1);
  face5.vertex(-x, -y, z, 0, 0); // Coin supérieur gauche du mur
  face5.normal(1, 0, -1);
  face5.vertex(x, -y, z, 1, 0);  // Coin supérieur droit du mur
  face5.normal(1, 0, -1);
  face5.vertex(x, y, z, 1, 1);   // Coin inférieur droit du mur
  face5.normal(-1, 0, -1);
  face5.vertex(-x, y, z, 0, 1);  // Coin inférieur gauche du mur
  face5.endShape();

  // Face tableau (centrée sur le mur)
  PShape faceTableau = createShape();
  faceTableau.beginShape(QUADS);
  faceTableau.textureMode(NORMAL);
  faceTableau.texture(tex_tableau);


  // Position ajustée pour apparaître sur la face avant
  float tableauLargeur = 4000; // 2 mètres
  float tableauHauteur = 1200; // 1,2 mètres
  float tableauZ = z -20;      // Légèrement en avant du mur avant pour éviter le chevauchement
  faceTableau.normal(-1, 0, -1);
  faceTableau.vertex(-tableauLargeur / 2, -tableauHauteur / 2, tableauZ, 0, 0);
  faceTableau.normal(1, 0, -1);
  faceTableau.vertex(tableauLargeur / 2-500, -tableauHauteur / 2, tableauZ, 1, 0);
  faceTableau.normal(1, 0, -1);
  faceTableau.vertex(tableauLargeur / 2-500, tableauHauteur / 2, tableauZ, 1, 1);
  faceTableau.normal(-1, 0, -1);
  faceTableau.vertex(-tableauLargeur / 2, tableauHauteur / 2, tableauZ, 0, 1);

  faceTableau.endShape();


  // Face derrière
  PShape face6 = createShape();
  face6.beginShape(QUADS);
  face6.textureMode(NORMAL);
  face6.texture(tex_papier); // Applique la texture sur cette face
  face6.shininess(200.0);
  //face6.fill(couleurs[5]); // Couleur cyan par défaut
  face6.vertex(-x, -y, -z, 0, 0);
  face6.vertex(x, -y, -z, 1, 0);
  face6.vertex(x, y, -z, 1, 1);
  face6.vertex(-x, y, -z, 0, 1);
  face6.endShape();

  // Porte derrière
  PShape facePorte2 = createShape();
  facePorte2.beginShape();
  float portederriereZ = (-longueur/2)+100;
  float portederriereX = x-250;
  facePorte2.textureMode(NORMAL);
  facePorte2.texture(tex_porte);
  facePorte2.shininess(200.0);
  facePorte2.normal(-1, 0, 1);
  facePorte2.vertex(portederriereX, -500, portederriereZ, 0, 0);
  facePorte2.normal(1, 0, 1);
  facePorte2.vertex(portederriereX-1000, -500, portederriereZ, 1, 0);
  facePorte2.normal(1, 0, 1);
  facePorte2.vertex(portederriereX-1000, porteY, portederriereZ, 1, 1);
  facePorte2.normal(-1, 0, 1);
  facePorte2.vertex(portederriereX, porteY, portederriereZ, 0, 1);
  facePorte2.endShape();

  // Porte derrière la télé
  PShape facePorte3 = createShape();
  facePorte3.beginShape();
  portederriereZ = (longueur/2)-20;

  facePorte3.textureMode(NORMAL);
  facePorte3.texture(tex_porte);
  facePorte3.shininess(200.0);
  facePorte3.vertex(portederriereX, -500, portederriereZ, 0, 0);
  facePorte3.vertex(portederriereX-1000, -500, portederriereZ, 1, 0);
  facePorte3.vertex(portederriereX-1000, porteY, portederriereZ, 1, 1);
  facePorte3.vertex(portederriereX, porteY, portederriereZ, 0, 1);
  facePorte3.endShape();

  // création du groupe pour mur et porte derriere
  PShape groupeMurEtporte2 = createShape(GROUP);
  groupeMurEtporte2.addChild(facePorte2);
  groupeMurEtporte2.addChild(face6);




  //Face fenetre 1
  PShape faceFenetre = createShape();
  faceFenetre.beginShape();
  faceFenetre.textureMode(QUADS);
  faceFenetre.texture(tex_fenetre);

  float fenetreX = x -20;
  float fenetreHauteur = 1200;
  float fenetreZ = longueur/3;



  faceFenetre.vertex(fenetreX, -fenetreHauteur/2, -fenetreZ, 0, 0); // Coin supérieur gauche du tableau
  faceFenetre.vertex(fenetreX, -fenetreHauteur/2, fenetreZ, 1, 0);  // Coin supérieur droit du tableau
  faceFenetre.vertex(fenetreX, fenetreHauteur/2, fenetreZ, 1, 1);         // Coin inférieur droit du tableau
  faceFenetre.vertex(fenetreX, fenetreHauteur/2, -fenetreZ, 0, 1);        // Coin inférieur gauche du tableau

  faceFenetre.endShape();


  PShape groupeMurEtFenetre = createShape(GROUP);
  groupeMurEtFenetre.addChild(face2);
  groupeMurEtFenetre.addChild(faceFenetre);

  // Ajout des deux faces au groupe
  PShape groupeMurEtTableau = createShape(GROUP);
  groupeMurEtTableau.addChild(face5);       // Ajout du mur
  groupeMurEtTableau.addChild(faceTableau);   // Ajout du tableau
  groupeMurEtTableau.addChild(facePorte3);   // Ajout porte

  // Ajout des faces au groupe
  cube.addChild(groupeMurEtporte);
  cube.addChild(groupeMurEtFenetre);
  cube.addChild(face3);
  cube.addChild(face4);
  cube.addChild(groupeMurEtTableau);
  cube.addChild(groupeMurEtporte2);
  return cube;
}


void bougerCamera() {
  if (keyPressed) {
    float speed = 35;
    if (keyCode == SHIFT) {
      cameraPos.y -= speed;
    }
    if (key == 'd' || key == 'D') {
      cameraPos.y += speed;
    }
    if (keyCode == UP) {
      cameraPos.z -= speed; // Avancer
    }
    if (keyCode == DOWN) {
      cameraPos.z += speed; // Reculer
    }
    if (keyCode == LEFT) {
      cameraPos.x -= speed; // Aller à gauche
    }
    if (keyCode == RIGHT) {
      cameraPos.x += speed; // Aller à droite
    }
    if (key == 'r' || key == 'R') { // Réinitialiser la position
      cameraPos.set(0, 0, -50);
    }
    if (key == 'z' || key == 'Z') cameraTarget.z -= speed; // Avancer
    if (key == 's' || key == 'S') cameraTarget.z += speed; // Reculer
    if (key == 'q' || key == 'Q') cameraTarget.x -= speed; // Gauche
    if (key == 'l' || key == 'L') cameraTarget.x += speed; // Droite
    if (key == ' ') cameraTarget.y += speed; // Monter (Espace)
    if (key == 'c' || key == 'C') cameraTarget.y -= speed; // Descendre
  }
}



// Fonction pour dessiner le repère
void drawRepere() {
  strokeWeight(3);

  // Axe X en rouge
  stroke(255, 0, 0);
  line(0, 0, 0, 500, 0, 0);

  // Axe Y en vert
  stroke(0, 255, 0);
  line(0, 0, 0, 0, 500, 0);

  // Axe Z en bleu
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, 500);

  // Remet la couleur à l'état initial
  noStroke();
}
