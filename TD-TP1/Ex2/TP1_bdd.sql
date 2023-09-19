/*Creation de la base de données TP1*/

/*creation des tables*/


/*table des appareils*/
CREATE TABLE Appareil(
    id_appareil INTEGER PRIMARY KEY,
    marque VARCHAR(50),
    modele VARCHAR(50)
);


/*table des utilisateurs*/
CREATE TABLE Utilisateur(
    id_utilisateur INTEGER PRIMARY KEY,
    nom VARCHAR(50),
    prenom VARCHAR(50)
);

/*table des abonnements*/
CREATE TABLE Abonne(
    id_utilisateur1 INTEGER NOT NULL,
    id_utilisateur2 INTEGER NOT NULL,
    PRIMARY KEY(id_utilisateur1, id_utilisateur2),
    FOREIGN KEY(id_utilisateur1) REFERENCES Utilisateur(id_utilisateur),
    FOREIGN KEY(id_utilisateur2) REFERENCES Utilisateur(id_utilisateur)
);

/*table des configurations*/
CREATE TABLE Configuration(
    id_configuration INTEGER PRIMARY KEY,
    ouverture_focale FLOAT,
    temps_exposition FLOAT,
    flash VARCHAR(1),
    distance_focale float,
    CONSTRAINT Check_flash CHECK(flash IN ('Y','N'))
    );

/*tables des Collections*/
CREATE TABLE Collection(
    id_collection INTEGER PRIMARY KEY
);


/*table des Albums*/


/*table des Galeries*/
CREATE TABLE Galerie(
    id_galerie INTEGER PRIMARY KEY,
    id_utilisateur INTEGER,
    FOREIGN KEY(id_galerie) REFERENCES Collection(id_collection),
    FOREIGN KEY(id_utilisateur) REFERENCES Utilisateur(id_utilisateur)
);

/*table des contenus numériques*/
CREATE TABLE ContenuNumerique(
    id_contenu INTEGER PRIMARY KEY
);

/*table des photos*/
CREATE TABLE Photo(
    id_photo INTEGER PRIMARY KEY,
    resolution VARCHAR(50),
    date_photo DATE NOT NULL,
    lieu VARCHAR(50) NOT NULL,
    licence VARCHAR(50),
    id_utilisateur INTEGER,
    id_appareil INTEGER,
    id_configuration INTEGER,
    FOREIGN KEY(id_photo) REFERENCES ContenuNumerique(id_contenu),
    FOREIGN KEY(id_utilisateur) REFERENCES Utilisateur(id_utilisateur),
    FOREIGN KEY(id_appareil) REFERENCES Appareil(id_appareil),
    FOREIGN KEY(id_configuration) REFERENCES Configuration(id_configuration),
    CONSTRAINT Check_licence CHECK ( licence IN ('TousDroitsReserves', 'UtilisationCommercialeAutorisee', 'ModificationImageAutorisee'))
);

/*table des balises*/
CREATE TABLE Balise(
    id_balise INTEGER PRIMARY KEY
);

/*table des tags*/
CREATE TABLE Tag(
    id_tag INTEGER PRIMARY KEY,
    tag VARCHAR(50) NOT NULL,
    id_photo INTEGER,
    FOREIGN KEY(id_tag) REFERENCES Balise(id_balise)
);

/*table des mots clés*/
CREATE TABLE MotCle(
    id_mot_cle INTEGER PRIMARY KEY,
    mot_cle VARCHAR(50) NOT NULL,
    FOREIGN KEY(id_mot_cle) REFERENCES Balise(id_balise)
);
/*table des balises sur une photo*/
CREATE TABLE PhotoBalises(
    id_photo INTEGER,
    id_balise INTEGER,
    PRIMARY KEY(id_balise,id_photo),
    FOREIGN KEY(id_photo) REFERENCES Photo(id_photo),
    FOREIGN KEY(id_balise) REFERENCES Balise(id_balise)
);
/*table des photos dans les collections*/
CREATE TABLE PhotoCollection(
    id_photo INTEGER,
    id_collection INTEGER,
    PRIMARY KEY(id_photo, id_collection),
    FOREIGN KEY(id_photo) REFERENCES Photo(id_photo),
    FOREIGN KEY(id_collection) REFERENCES Collection(id_collection)
);

/*table des photos aimées par un utilisateur*/
CREATE TABLE Aimer(
    id_photo INTEGER,
    id_utilisateur INTEGER,
    PRIMARY KEY(id_photo, id_utilisateur),
    FOREIGN KEY(id_photo) REFERENCES Photo(id_photo),
    FOREIGN KEY(id_utilisateur) REFERENCES Utilisateur(id_utilisateur)
);

/*table des discussions sur une photo*/
CREATE TABLE Discussion(
    id_discussion INTEGER PRIMARY KEY,
    id_photo INTEGER,
    FOREIGN KEY(id_photo) REFERENCES Photo(id_photo)
);

/*table des commentaires sur une discussion*/
CREATE TABLE Commentaire(
    id_commentaire INTEGER PRIMARY KEY,
    contenu VARCHAR(250) NOT NULL,
    id_discussion INTEGER,
    id_utilisateur INTEGER,
    FOREIGN KEY(id_commentaire) REFERENCES ContenuNumerique(id_contenu),
    FOREIGN KEY(id_discussion) REFERENCES Discussion(id_discussion),
    FOREIGN KEY(id_utilisateur) REFERENCES Utilisateur(id_utilisateur)
);


/*fin de la création de la base de données*/
