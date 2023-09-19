/*A MODIFIER PAS FINI*/
/*A MODIFIER PAS FINI*/
/*A MODIFIER PAS FINI*/
/*A MODIFIER PAS FINI*/
/*A MODIFIER PAS FINI*/
/*A MODIFIER PAS FINI*/
/*A MODIFIER PAS FINI*/
/*A MODIFIER PAS FINI*/
/*A MODIFIER PAS FINI*/


/*creation de la base de données*/

/*suppression des tables si elles existent*/
DROP TABLE IF EXISTS Appareil;
DROP TABLE IF EXISTS Licence;
DROP TABLE IF EXISTS Date_Lieu;
DROP TABLE IF EXISTS Utilisateur;
DROP TABLE IF EXISTS Abonne;
DROP TABLE IF EXISTS Configuration;
DROP TABLE IF EXISTS CollectionPhotos;
DROP TABLE IF EXISTS Album;
DROP TABLE IF EXISTS Galerie;
DROP TABLE IF EXISTS ContenuNumerique;
DROP TABLE IF EXISTS Photo;
DROP TABLE IF EXISTS Balise;
DROP TABLE IF EXISTS Tag;
DROP TABLE IF EXISTS MotCle;
DROP TABLE IF EXISTS Photo_Collection;
DROP TABLE IF EXISTS Aimer;
DROP TABLE IF EXISTS Discussion;
DROP TABLE IF EXISTS Commentaire;

/*creation des tables*/


/*table des appareils*/
CREATE TABLE Appareil{
    id_appareil INTEGER PRIMARY KEY AUTOINCREMENT,
    marque STRING,
    modele STRING
}

/*enumération des licences*/
CREATE TABLE Licence{
    id_licence INTEGER PRIMARY KEY AUTOINCREMENT,
    nom STRING,
    description STRING
}


/*table pour la date et le lieu*/
CREATE TABLE Date_Lieu{
    date DATE NOT NULL,
    lieu STRING NOT NULL
}

/*table des utilisateurs*/
CREATE TABLE Utilisateur{
    id_utilisateur INTEGER PRIMARY KEY AUTOINCREMENT,
    nom STRING,
    prenom STRING,
    email STRING,
    mot_de_passe STRING
}

/*table des abonnements*/
CREATE TABLE Abonne{
    id_utilisateur1 INTEGER NOT NULL,
    id_utilisateur2 INTEGER NOT NULL,
    PRIMARY KEY(id_utilisateur1, id_utilisateur2),
    FOREIGN KEY(id_utilisateur1) REFERENCES Utilisateur(id_utilisateur),
    FOREIGN KEY(id_utilisateur2) REFERENCES Utilisateur(id_utilisateur)
}

/*table des configurations*/
CREATE TABLE Configuration{
    id_configuration INTEGER PRIMARY KEY AUTOINCREMENT,
    ouverture_focale float,
    temps_exposition float,
    flash bool,
    distance_focale float
}

/*tables des Collections*/
CREATE TABLE Collection{
    id_collection INTEGER PRIMARY KEY AUTOINCREMENT,
}

/*table des Albums*/
CREATE TABLE Album{
    id_album INTEGER PRIMARY KEY AUTOINCREMENT,
    id_utilisateur INTEGER,
    FOREIGN KEY(id_album) REFERENCES id_collection(Collection),
    FOREIGN KEY(id_utilisateur) REFERENCES Utilisateur(id_utilisateur)
}

/*table des Galeries*/
CREATE TABLE Galerie{
    id_galerie INTEGER PRIMARY KEY AUTOINCREMENT,
    id_utilisateur INTEGER,
    FOREIGN KEY(id_galerie) REFERENCES id_collection(Collection),
    FOREIGN KEY(id_utilisateur) REFERENCES Utilisateur(id_utilisateur)

}

/*table des contenus numériques*/
CREATE TABLE ContenuNumerique{
    id_contenu INTEGER PRIMARY KEY AUTOINCREMENT
}

/*table des photos*/
CREATE TABLE Photo{
    id_photo INTEGER PRIMARY KEY AUTOINCREMENT,
    resolution STRING,
    id_utilisateur INTEGER,
    id_licence INTEGER,
    id_appareil INTEGER,
    id_lieu INTEGER,
    id_configuration INTEGER,
    FOREIGN KEY(id_photo) REFERENCES ContenuNumerique(id_contenu),
    FOREIGN KEY(id_utilisateur) REFERENCES Utilisateur(id_utilisateur),
    FOREIGN KEY(id_appareil) REFERENCES Appareil(id_appareil),
    FOREIGN KEY(id_licence) REFERENCES Licence(id_licence),
    FOREIGN KEY(id_date_lieu) REFERENCES Date_Lieu(id_date_lieu),
    FOREIGN KEY(id_configuration) REFERENCES Configuration(id_configuration)
}

/*table des balises*/
CREATE TABLE Balise{
    id_balise INTEGER PRIMARY KEY AUTOINCREMENT
}

/*table des tags*/
CREATE TABLE Tag{
    id_tag INTEGER PRIMARY KEY AUTOINCREMENT
    tag STRING NOT NULL,
    id_photo INTEGER,
    FOREIGN KEY(id_tag) REFERENCES Balise(id_balise),
    FOREIGN KEY(id_photo) REFERENCES Photo(id_photo) 
}

/*table des mots clés*/
CREATE TABLE MotCle{
    id_mot_cle INTEGER PRIMARY KEY AUTOINCREMENT
    mot_cle STRING NOT NULL,
    id_photo INTEGER,
    FOREIGN KEY(id_mot_cle) REFERENCES Balise(id_balise),
    FOREIGN KEY(id_photo) REFERENCES Photo(id_photo)
}

/*table des photos dans les collections*/
CREATE TABLE Photo_Collection{
    id_photo INTEGER,
    id_collection INTEGER,
    PRIMARY KEY(id_photo, id_collection),
    FOREIGN KEY(id_photo) REFERENCES Photo(id_photo),
    FOREIGN KEY(id_collection) REFERENCES Collection(id_collection)
}

/*table des photos aimées par un utilisateur*/
CREATE TABLE Aimer{
    id_photo INTEGER,
    id_utilisateur INTEGER,
    PRIMARY KEY(id_photo, id_utilisateur),
    FOREIGN KEY(id_photo) REFERENCES Photo(id_photo),
    FOREIGN KEY(id_utilisateur) REFERENCES Utilisateur(id_utilisateur)
}

/*table des discussions sur une photo*/
CREATE TABLE Discussion{
    id_discussion INTEGER PRIMARY KEY AUTOINCREMENT,
    id_photo INTEGER,
    FOREIGN KEY(id_photo) REFERENCES Photo(id_photo)
}

/*table des commentaires sur une discussion*/
CREATE TABLE Commentaire{
    id_commentaire INTEGER PRIMARY KEY,
    id_discussion INTEGER,
    id_utilisateur INTEGER,
    contenu STRING NOT NULL,
    FOREIGN KEY(id_commentaire) REFERENCES ContenuNumerique(id_contenu),
    FOREIGN KEY(id_discussion) REFERENCES Discussion(id_discussion)
    FOREIGN KEY(id_utilisateur) REFERENCES Utilisateur(id_utilisateur)
}

/*fin de la création de la base de données*/

/*insertion des données*/
INSERT INTO Appareil(marque, modele) VALUES('Canon', 'EOS 5D Mark IV');
INSERT INTO Appareil(marque, modele) VALUES('Nikon', 'D750');
INSERT INTO Appareil(marque, modele) VALUES('Sony', 'ILCE-7M3');
INSERT INTO Appareil(marque, modele) VALUES('Panasonic', 'Lumix GH5');


INSERT INTO Licence(nom, description) VALUES(01, 'tous droits réservés');
INSERT INTO Licence(nom, description) VALUES(02, 'utilisation commerciale autorisée');
INSERT INTO Licence(nom, description) VALUES(03, 'modifications de l`image autorisées');

INSERT INTO Date_Lieu(date, lieu) VALUES('2020-01-01', 'Paris');
INSERT INTO Date_Lieu(date, lieu) VALUES('2023-01-02', 'Montpellier');
INSERT INTO Date_Lieu(date, lieu) VALUES('2019-09-03', 'Montpellier');
INSERT INTO Date_Lieu(date, lieu) VALUES('2023-01-04', 'Marseille');


INSERT INTO Utilisateur(nom, prenom, email, mot_de_passe) VALUES('Gilles', 'Eric', 'eric.gilles@etu.umontpellier.fr', '123456');
INSERT INTO Utilisateur(nom, prenom, email, mot_de_passe) VALUES('Navel', 'Morgan', 'morgan.navel@etu.umontpellier.fr', 'ceciestunmdp');
INSERT INTO Utilisateur(nom, prenom, email, mot_de_passe) VALUES('Nemard', 'Jean', 'jean.nemard@etu.umontpellier.fr', 'azerty');
INSERT INTO Utilisateur(nom, prenom, email, mot_de_passe) VALUES('Zeblouse', 'Agathe', 'agathe.zeblouse@etu.umontpellier.fr', 'motdepasse');

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

INSERT INTO Album(id_album, id_utilisateur) VALUES(1, 1);
INSERT INTO Album(id_album, id_utilisateur) VALUES(2, 2);

INSERT INTO Galerie(id_galerie, id_utilisateur) VALUES(1, 1);
INSERT INTO Galerie(id_galerie, id_utilisateur) VALUES(2, 2);

INSERT INTO ContenuNumerique(id_contenu) VALUES(1);
INSERT INTO ContenuNumerique(id_contenu) VALUES(2);
INSERT INTO ContenuNumerique(id_contenu) VALUES(3);
INSERT INTO ContenuNumerique(id_contenu) VALUES(4);

INSERT INTO Photo(id_photo, resolution, id_utilisateur, id_licence, id_appareil, id_lieu, id_configuration) VALUES(1, '1280x720', 1, 01, 1, 1, 1);
INSERT INTO Photo(id_photo, resolution, id_utilisateur, id_licence, id_appareil, id_lieu, id_configuration) VALUES(2, '1280x720', 2, 02, 2, 2, 2);
INSERT INTO Photo(id_photo, resolution, id_utilisateur, id_licence, id_appareil, id_lieu, id_configuration) VALUES(3, '1280x720', 3, 02, 3, 3, 3);
INSERT INTO Photo(id_photo, resolution, id_utilisateur, id_licence, id_appareil, id_lieu, id_configuration) VALUES(4, '1280x720', 4, 03, 4, 4, 4);

INSERT INTO Balise(id_balise) VALUES(1);
INSERT INTO Balise(id_balise) VALUES(2);
INSERT INTO Balise(id_balise) VALUES(3);
INSERT INTO Balise(id_balise) VALUES(4);
INSERT INTO Balise(id_balise) VALUES(5);


INSERT INTO Tag(id_tag, id_photo) VALUES(1, 1);
INSERT INTO Tag(id_tag, id_photo) VALUES(2, 2);
INSERT INTO Tag(id_tag, id_photo) VALUES(3, 3);


INSERT INTO MotCle(id_mot_cle, id_photo) VALUES(1, 1);
INSERT INTO MotCle(id_mot_cle, id_photo) VALUES(2, 2);


INSERT INTO Photo_Collection(id_photo, id_collection) VALUES(1, 1);
INSERT INTO Photo_Collection(id_photo, id_collection) VALUES(2, 2);

INSERT INTO Aimer(id_photo, id_utilisateur) VALUES(1, 1);
INSERT INTO Aimer(id_photo, id_utilisateur) VALUES(2, 2);

INSERT INTO Discussion(id_discussion, id_photo) VALUES(1, 1);
INSERT INTO Discussion(id_discussion, id_photo) VALUES(2, 2);

INSERT INTO Commentaire(id_commentaire, id_discussion, id_utilisateur, contenu) VALUES(1, 1, 1, 'Super photo !');
INSERT INTO Commentaire(id_commentaire, id_discussion, id_utilisateur, contenu) VALUES(2, 2, 2, 'Magnifique !');
INSERT INTO Commentaire(id_commentaire, id_discussion, id_utilisateur, contenu) VALUES(3, 1, 3, 'Complétement incohérente, je ne comprends pas commment cette photo a été prise. Travaillez votre cadrage ! ');


/*fin de l'insertion des données*/

/*fin de la création de la base de données*/



/*Requêtes*/
/*requete 1: les photos de Montpellier*/
SELECT * FROM Photo
JOIN Date_Lieu ON Photo.id_lieu = Date_Lieu.id_lieu
WHERE lieu = "Montpellier";

/*requete 2: les utilisateurs qui sont abonnés à un utilisateur et qui ont pris une photo avec un Canon*/
SELECT * FROM Utilisateur
JOIN Abonne ON Utilisateur.id_utilisateur = Abonne.id_utilisateur1
JOIN Photo ON Abonne.id_utilisateur2 = Photo.id_utilisateur
JOIN Appareil ON Photo.id_appareil = Appareil.id_appareil
WHERE Appareil.marque = "Canon";


/*requete 3: le nombre de Commentaires d'une photo qui a le tag "#summer" */
SELECT COUNT(*) FROM Commentaire
JOIN Photo ON Commentaire.id_photo = Photo.id_photo
JOIN Tag ON Commentaire.id_tag = Tag.id_tag
WHERE Tag.tag = "#summer";

/*requete 4: les photos les plus appréciées avec la licence de distribution ’tous droits réservés’.*/
SELECT * FROM Photo
JOIN Photo_Collection ON Photo.id_photo = Photo_Collection.id_photo
JOIN Licence ON Photo.id_licence = Licence.id_licence
JOIN Aimer ON Photo.id_photo = Aimer.id_photo
WHERE Licence.licence LIKE "tous droits réservés"
GROUP BY Photo.id_photo
HAVING COUNT(*) >= ALL (
    SELECT COUNT(*) FROM Photo P1
    JOIN Licence ON Photo.id_licence = Licence.id_licence
    JOIN Aimer ON Photo.id_photo = Aimer.id_photo
    WHERE Licence.licence LIKE "tous droits réservés"
    GROUP BY Photo.id_photo
    );

/*requete 5: les photos incluses dans le plus grande nombre de galeries*/
SELECT * FROM Photo
JOIN Photo_Collection ON Photo.id_photo = Photo_Collection.id_photo
JOIN Galerie ON Photo_Collection.id_collection= Galerie.id_galerie
GROUP BY Photo.id_photo
HAVING COUNT(*) >= ALL (
    SELECT COUNT(*) FROM Photo P1
    JOIN Photo_Collection ON Photo.id_photo = Photo_Collection.id_photo
    JOIN Galerie ON Photo_Collection.id_collection = Galerie.id_galerie
    GROUP BY Photo.id_photo
    );