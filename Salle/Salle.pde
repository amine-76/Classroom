float angle = 0f;
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
float camX = 0;
float camY = 0;
float camZ = 0;
float rayon = 425; // Rayon pour la caméra
float phi = 0;
float theta = 0;
float longueur = 9700;// 9.785m
float largeur = 6000; // 6 m 
float hauteur = 2500;
float cameraSpeed = 10; // Vitesse de déplacement de la caméra

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

//Shader 
PShader colorShader;
PShader lightShader;  
PShader lightShaderTex;  

//Position des lumières 
PVector[] lightPos = { 
  new PVector(300, -300, 300),
  new PVector(-300, 300, 300),
  new PVector(-300, 300, -300),
  new PVector(0, -300, 0)
};



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
  tex_pied = loadImage("texture_pied.jpg"); 
  tex_porte = loadImage("texture_porte.jpg");
  tex_wall = loadImage("texture_wall.jpg");
  tex_tableau = loadImage("texture_tableau.jpg");
  tex_papier = loadImage("texture_papier.jpg"); 
  tex_plafond = loadImage("texture_plafond.jpg");
  tex_tele = loadImage("texture_tele.jpg"); 
  tex_chaise = loadImage("texture_chaise.jpg"); 
  tex_fenetre = loadImage("texture_fenetre.jpg"); 
  salle = maSalle(largeur, hauteur, longueur, couleurs); // Création de la boîte paramétrée
  tableFond = new tableFond(); 
  bureauProf = new tableFond();
  chaiseProf = new Chaise();  
  formeTableFond = tableFond.getShape(); 
  formebureauProf = bureauProf.getShape(); 
  formeChaiseProf = chaiseProf.getShape(); 
  formeTableFond.rotateY(PI); 
  formebureauProf.rotateY(PI); 

  tele = new Tele(2,2,2);
  maTele = tele.getShape();
  colorShader = loadShader("ColorShaderFrag.glsl","ColorShaderVert.glsl");
  lightShader = loadShader("Lambert1DiffuseFrag.glsl","Lambert1DiffuseVert.glsl");   
  lightShaderTex = loadShader("LightShaderTexFrag.glsl","LightShaderTexVert.glsl");   
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
          espacementX += 630; 
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
  perspective(fov, float(width)/float(height), 10, 9000);
}

void draw() {
  background(0);
  noStroke();
  bougerCamera();
  //shader(lightShader);

  camera(camX, camY, camZ, 0, 0, 0, 0, 1, 0);

  drawRepere(0,0,0); 
  shape(salle); // Afficher la boîte

  // transformation sur la télé 
  pushMatrix();
      translate(largeur / 2 - 1200, hauteur / 2 - 1500, longueur/2-2000); // Translation vers la position de la télé
      rotateY(PI/3);
      scale(2.6); 
      shader(colorShader);  
     shape(maTele);
     resetShader(); 
  popMatrix();
  // transformation tables
  pushMatrix();
  translate(-2600, 0, -3000);
      shape(groupeTables);
  popMatrix();

  pushMatrix();
    translate(0, hauteur/2-750, -longueur/2+400);
    scale(3);
    shape(formeTableFond); 
  popMatrix();
  // Bureau Prof
  pushMatrix();
    translate(largeur/5-500, hauteur/2-750, longueur/5+400);
    scale(1.6);
    shape(formebureauProf); 
  popMatrix();
  // Chaise Prof
  pushMatrix();
    translate(largeur/5-500, hauteur/2-500, longueur/5+600);
    scale(1.1);
    rotateY(PI); 
    shape(formeChaiseProf); 
  popMatrix();
  // Lumières - Cubes blancs alignés sur le plafond
  pushMatrix();
  float hauteurPlafond = hauteur / 2 - 100; // Position proche du plafond
  float espacementX = 800; // Espacement horizontal
  float espacementZ = 1000; // Espacement en profondeur
  //shader(colorShader);
  shader(lightShaderTex); 

  // Première rangée de lumières (côté gauche)
  for (int i = 0; i < 4; i++) {
    pushMatrix(); 
    fill(255, 255, 255); // Blanc pur
    emissive(255, 255, 255); // Simule l'émission lumineuse
    translate(-espacementX, -hauteurPlafond, -1500 + i * espacementZ); // Positionnement
    pointLight(0,0,255
                ,-espacementX, -hauteurPlafond, -1500 + i * espacementZ);
    box(150); // Cube lumineux
    popMatrix();
  }

  // Deuxième rangée de lumières (côté droit)
  for (int i = 0; i < 4; i++) {
    pushMatrix();
    fill(255, 255, 255);
    emissive(255, 255, 255); 
    translate(espacementX, -hauteurPlafond, -1500 + i * espacementZ); // Position symétrique
    pointLight(255,0,0
                ,espacementX, -hauteurPlafond, -1500 + i * espacementZ);
    box(150); // Cube lumineux
    popMatrix();
  }
  resetShader(); 
  popMatrix();




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
  face1.vertex(-x, -y, -z,0,0);
  face1.vertex(-x, -y, z,1,0);
  face1.vertex(-x, y, z,1,1);
  face1.vertex(-x, y, -z,0,1);
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
  facePorte.vertex(porteX, -500,porteZ, 0, 0);
  facePorte.vertex(porteX, -500,porteZ-1000, 1, 0);
  facePorte.vertex(porteX, porteY,porteZ-1000, 1, 1);
  facePorte.vertex(porteX, porteY,porteZ, 0, 1);

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

  // Face avant  
  PShape face5 = createShape();
   face5.beginShape(QUADS);
  face5.textureMode(NORMAL);
  face5.texture(tex_papier);
  face5.vertex(-x, -y, z, 0, 0); // Coin supérieur gauche du mur
  face5.vertex(x, -y, z, 1, 0);  // Coin supérieur droit du mur
  face5.vertex(x, y, z, 1, 1);   // Coin inférieur droit du mur
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

faceTableau.vertex(-tableauLargeur / 2, -tableauHauteur / 2, tableauZ, 0, 0);
faceTableau.vertex(tableauLargeur / 2-500, -tableauHauteur / 2, tableauZ, 1, 0);
faceTableau.vertex(tableauLargeur / 2-500, tableauHauteur / 2, tableauZ, 1, 1);
faceTableau.vertex(-tableauLargeur / 2, tableauHauteur / 2, tableauZ, 0, 1);

faceTableau.endShape();


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

  // Porte derrière 
   PShape facePorte2 = createShape(); 
  facePorte2.beginShape();
  float portederriereZ = (-longueur/2)+100; 
  float portederriereX = x-250;
  float portederriereY = hauteur/2;
  facePorte2.textureMode(NORMAL);  
  facePorte.texture(tex_porte);
  facePorte2.shininess(200.0);  
  facePorte2.vertex(portederriereX, -500,portederriereZ, 0, 0);
  facePorte2.vertex(portederriereX-1000, -500,portederriereZ, 1, 0);
  facePorte2.vertex(portederriereX-1000, porteY,portederriereZ, 1, 1);
  facePorte2.vertex(portederriereX, porteY,portederriereZ, 0, 1);
  facePorte2.endShape();

  // Porte derrière la télé 
   PShape facePorte3 = createShape(); 
  facePorte3.beginShape();
  portederriereZ = (longueur/2)-20;

  facePorte3.textureMode(NORMAL);  
  facePorte3.texture(null);
  facePorte3.shininess(200.0);  
  facePorte3.vertex(portederriereX, -500,portederriereZ, 0, 0);
  facePorte3.vertex(portederriereX-1000, -500,portederriereZ, 1, 0);
  facePorte3.vertex(portederriereX-1000, porteY,portederriereZ, 1, 1);
  facePorte3.vertex(portederriereX, porteY,portederriereZ, 0, 1);
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
void drawRepere(float x , float y, float z) {
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

/*PShape creerTables(int lignes, int colonnes){
  PShape groupeTables = createShape(GROUP);
  float decalageZ = 500;

  for (int i = 0; i < lignes; ++i) {
    decalageZ = decalageZ + 600; 
    float decalageX = 0; 
    for (int j = 0; j < colonnes; ++j) {
      Table table = new Table();
      Chaise chaise = new Chaise(); 
      PShape formeChaise = chaise.getShape(); 
      PShape formeTable = table.getShape();
      formeChaise.scale(0.5);
      formeTable.scale(1.5);
      formeTable.translate(decalageZ, hauteur / 2 - 400, decalageX); 
      formeChaise.translate(decalageZ-300, hauteur / 2 - 400, decalageX); 
      groupeTables.addChild(formeTable);
      groupeTables.addChild(formeChaise); 
      decalageX += 300 ;   
    }
  }
  return groupeTables; 
}*/

// //Crée un groupe de tables disposées en grille
// PShape creerTables(int lignes, int colonnes) {
//   PShape groupeTables = createShape(GROUP);

//   float espacementX = 500; // Espace horizontal entre les tables
//   float espacementZ = 300; // Espace vertical entre les tables

//   // Position de départ pour aligner les tables au centre de la salle
//   float offsetX = -(colonnes - 1) * espacementX / 2;
//   float offsetZ = -(lignes - 1) * espacementZ / 2;

//   for (int i = 0; i < lignes; i++) {
//     for (int j = 0; j < colonnes; j++) {
//       // Position de chaque table
//       float posX = offsetX + j * espacementX;
//       float posZ = offsetZ + i * espacementZ;

//       // Créer une table
//       Table table = new Table(posX, 500, posZ); 
//       PShape formeTable = table.getShape();
//        formeTable.rotateY(-HALF_PI); 
//        //formeTable.rotateZ(HALF_PI); 

//       groupeTables.addChild(formeTable);
//       // Debug position
//       println("Table position: X=" + posX + ", Z=" + posZ);
//       drawRepere(posX,1000,posZ); 
//     }
//   }

//   return groupeTables;
// }
