/*Requêtes TP1*/

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

/*Fin des requetes*/