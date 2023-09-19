
/*creation de la base de données*/

/*suppression des tables si elles existent*/
DROP TABLE IF EXISTS Appareil;
DROP TABLE IF EXISTS Utilisateur;
DROP TABLE IF EXISTS Abonne;
DROP TABLE IF EXISTS Configuration;
DROP TABLE IF EXISTS CollectionPhotos;
DROP TABLE IF EXISTS Album;
DROP TABLE IF EXISTS Galerie;
DROP TABLE IF EXISTS ContenuNumerique;
DROP TABLE IF EXISTS PhotoBalises;
DROP TABLE IF EXISTS Photo;
DROP TABLE IF EXISTS Balise;
DROP TABLE IF EXISTS Tag;
DROP TABLE IF EXISTS MotCle;
DROP TABLE IF EXISTS PhotoCollection;
DROP TABLE IF EXISTS Aimer;
DROP TABLE IF EXISTS Discussion;
DROP TABLE IF EXISTS Commentaire;

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
    ouverture_focale float,
    temps_exposition float,
    flash int, /*0 ou 1*/
    distance_focale float
);

/*tables des Collections*/
CREATE TABLE Collection(
    id_collection INTEGER PRIMARY KEY
);


/*table des Albums*/
CREATE TABLE Album(
    id_album INTEGER PRIMARY KEY,
    id_utilisateur INTEGER,
    FOREIGN KEY(id_album) REFERENCES Collection(id_collection),
    FOREIGN KEY(id_utilisateur) REFERENCES Utilisateur(id_utilisateur)
);

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
    date DATE NOT NULL,
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
    contenu VARCHAR(50) NOT NULL,
    id_discussion INTEGER,
    id_utilisateur INTEGER,
    FOREIGN KEY(id_commentaire) REFERENCES ContenuNumerique(id_contenu),
    FOREIGN KEY(id_discussion) REFERENCES Discussion(id_discussion),
    FOREIGN KEY(id_utilisateur) REFERENCES Utilisateur(id_utilisateur)
);


/*fin de la création de la base de données*/

/*insertion des données*/
INSERT INTO Appareil(id_appareil,marque, modele) VALUES(1,'Canon', 'EOS 5D Mark IV');
INSERT INTO Appareil(id_appareil,marque, modele) VALUES(2,'Nikon', 'D750');
INSERT INTO Appareil(id_appareil,marque, modele) VALUES(3,'Sony', 'ILCE-7M3');
INSERT INTO Appareil(id_appareil,marque, modele) VALUES(4,'Panasonic', 'Lumix GH5');


INSERT INTO Utilisateur(id_utilisateur, nom, prenom) VALUES(1, 'Gilles', 'Eric');
INSERT INTO Utilisateur(id_utilisateur, nom, prenom) VALUES(2, 'Navel', 'Morgan');
INSERT INTO Utilisateur(id_utilisateur, nom, prenom) VALUES(3, 'Nemard', 'Jean');
INSERT INTO Utilisateur(id_utilisateur, nom, prenom) VALUES(4, 'Zeblouse', 'Agathe');

INSERT INTO Abonne(id_utilisateur1, id_utilisateur2) VALUES(1, 2);
INSERT INTO Abonne(id_utilisateur1, id_utilisateur2) VALUES(1, 3);
INSERT INTO Abonne(id_utilisateur1, id_utilisateur2) VALUES(1, 4);
INSERT INTO Abonne(id_utilisateur1, id_utilisateur2) VALUES(2, 1);
INSERT INTO Abonne(id_utilisateur1, id_utilisateur2) VALUES(2, 3);
INSERT INTO Abonne(id_utilisateur1, id_utilisateur2) VALUES(4, 3);

INSERT INTO Configuration(ouverture_focale, temps_exposition, flash, distance_focale) VALUES(1.8, 1/100, 0, 50);
INSERT INTO Configuration(ouverture_focale, temps_exposition, flash, distance_focale) VALUES(2.8, 1/200, 1, 100);
INSERT INTO Configuration(ouverture_focale, temps_exposition, flash, distance_focale) VALUES(3.5, 1/400, 0, 200);


INSERT INTO Collection(id_collection) VALUES(1);
INSERT INTO Collection(id_collection) VALUES(2);
INSERT INTO Collection(id_collection) VALUES(3);
INSERT INTO Collection(id_collection) VALUES(4);


INSERT INTO Album(id_album, id_utilisateur) VALUES(1, 1);
INSERT INTO Album(id_album, id_utilisateur) VALUES(2, 2);

INSERT INTO Galerie(id_galerie, id_utilisateur) VALUES(3, 3);
INSERT INTO Galerie(id_galerie, id_utilisateur) VALUES(4, 4);


INSERT INTO ContenuNumerique(id_contenu) VALUES(1);
INSERT INTO ContenuNumerique(id_contenu) VALUES(2);
INSERT INTO ContenuNumerique(id_contenu) VALUES(3);
INSERT INTO ContenuNumerique(id_contenu) VALUES(4);

INSERT INTO Photo(id_photo, resolution, date, lieu, licence, id_utilisateur, id_appareil, id_configuration) VALUES(1, '1280x720', "2023-06-03","Montpellier","TousDroitsReserves", 1, 1, 1);
INSERT INTO Photo(id_photo, resolution, date, lieu, licence, id_utilisateur, id_appareil, id_configuration) VALUES(2, '1280x720', "2023-08-03","Paris","UtilisationCommercialeAutorisee", 2, 2, 2);
INSERT INTO Photo(id_photo, resolution, date, lieu, licence, id_utilisateur, id_appareil, id_configuration) VALUES(3, '1280x720', "2023-012-03","Los Angeles","ModificationImageAutorisee", 3, 2, 3);
INSERT INTO Photo(id_photo, resolution, date, lieu, licence, id_utilisateur, id_appareil, id_configuration) VALUES(4, '1280x720', "2023-04-03","Incheon","TousDroitsReserves", 4, 3, 4);

INSERT INTO Balise(id_balise) VALUES(1);
INSERT INTO Balise(id_balise) VALUES(2);
INSERT INTO Balise(id_balise) VALUES(3);
INSERT INTO Balise(id_balise) VALUES(4);
INSERT INTO Balise(id_balise) VALUES(5);


INSERT INTO Tag(id_tag,tag) VALUES(1,"#summer");
INSERT INTO Tag(id_tag,tag) VALUES(2,"#view");
INSERT INTO Tag(id_tag,tag) VALUES(3,"#montpellier");


INSERT INTO MotCle(id_mot_cle,mot_cle) VALUES(4,"Korea");
INSERT INTO MotCle(id_mot_cle,mot_cle) VALUES(5,"Baguette");

INSERT INTO PhotoBalises(id_photo,id_balise) VALUES(1,1);
INSERT INTO PhotoBalises(id_photo,id_balise) VALUES(2,5);
INSERT INTO PhotoBalises(id_photo,id_balise) VALUES(3,2);
INSERT INTO PhotoBalises(id_photo,id_balise) VALUES(4,4);
INSERT INTO PhotoBalises(id_photo,id_balise) VALUES(1,3);



INSERT INTO PhotoCollection(id_photo, id_collection) VALUES(1, 1);
INSERT INTO PhotoCollection(id_photo, id_collection) VALUES(2, 2);
INSERT INTO PhotoCollection(id_photo, id_collection) VALUES(3, 3);
INSERT INTO PhotoCollection(id_photo, id_collection) VALUES(3, 4);


INSERT INTO Aimer(id_photo, id_utilisateur) VALUES(1, 1);
INSERT INTO Aimer(id_photo, id_utilisateur) VALUES(1, 2);
INSERT INTO Aimer(id_photo, id_utilisateur) VALUES(1, 3);
INSERT INTO Aimer(id_photo, id_utilisateur) VALUES(1, 4);
INSERT INTO Aimer(id_photo, id_utilisateur) VALUES(2, 2);
INSERT INTO Aimer(id_photo, id_utilisateur) VALUES(3, 3);
INSERT INTO Aimer(id_photo, id_utilisateur) VALUES(4, 1);


INSERT INTO Discussion(id_discussion, id_photo) VALUES(1, 1);
INSERT INTO Discussion(id_discussion, id_photo) VALUES(3, 1);
INSERT INTO Discussion(id_discussion, id_photo) VALUES(2, 2);



INSERT INTO Commentaire(id_commentaire, id_discussion, id_utilisateur, contenu) VALUES(1, 1, 1, 'Super photo !');
INSERT INTO Commentaire(id_commentaire, id_discussion, id_utilisateur, contenu) VALUES(2, 2, 2, 'Magnifique !');
INSERT INTO Commentaire(id_commentaire, id_discussion, id_utilisateur, contenu) VALUES(3, 1, 3, 'Complétement incohérente, je ne comprends pas commment cette photo a été prise. Travaillez votre cadrage ! ');
INSERT INTO Commentaire(id_commentaire, id_discussion, id_utilisateur, contenu) VALUES(4, 1, 4, "Rien qu'en regardant l'image ça me donne chaud ! ");


/*fin de l'insertion des données*/

/*fin de la création de la base de données*/



/*Requêtes*/
/*requete 1: les photos de Montpellier*/
SELECT * FROM Photo
WHERE lieu = "Montpellier";

/*requete 2: les utilisateurs qui sont abonnés à un utilisateur et qui ont pris une photo avec un Canon*/
SELECT * FROM Utilisateur
JOIN Abonne ON Utilisateur.id_utilisateur = Abonne.id_utilisateur1
JOIN Photo ON Abonne.id_utilisateur2 = Photo.id_utilisateur
JOIN Appareil ON Photo.id_appareil = Appareil.id_appareil
WHERE Appareil.marque = "Canon";


/*requete 3: le nombre de Commentaires d'une photo qui a le tag "#summer" */
SELECT COUNT(*) FROM Commentaire
JOIN Discussion ON Commentaire.id_discussion = Discussion.id_discussion
JOIN PhotoBalises ON  Discussion.id_photo = PhotoBalises.id_photo
JOIN Tag ON PhotoBalises.id_balise = Tag.id_tag
WHERE Tag.tag = "#summer";

/*requete 4: les photos les plus appréciées avec la licence de distribution ’tous droits réservés’.*/
SELECT * FROM Photo
JOIN PhotoCollection ON Photo.id_photo = PhotoCollection.id_photo
JOIN Aimer ON Photo.id_photo = Aimer.id_photo
WHERE Photo.licence LIKE "TousDroitsReserves"
GROUP BY Photo.id_photo
HAVING COUNT(*) >= ALL (
    SELECT COUNT(*) FROM Photo P1
    JOIN Aimer ON P1.id_photo = Aimer.id_photo
    WHERE P1.licence LIKE "TousDroitsReserves"
    GROUP BY P1.id_photo
    );


/*requete 5: les photos incluses dans le plus grande nombre de galeries*/
SELECT * FROM Photo
JOIN PhotoCollection ON Photo.id_photo = PhotoCollection.id_photo
JOIN Galerie ON PhotoCollection.id_collection = Galerie.id_galerie
GROUP BY Photo.id_photo
HAVING COUNT(*) >= ALL (
    SELECT COUNT(*) FROM Photo P1
    JOIN PhotoCollection ON P1.id_photo = PhotoCollection.id_photo
    JOIN Galerie ON PhotoCollection.id_collection = Galerie.id_galerie
    GROUP BY P1.id_photo
    );