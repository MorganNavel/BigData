/*Insertion des données TP1*/
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

INSERT INTO Configuration(id_configuration, ouverture_focale, temps_exposition, flash, distance_focale) VALUES(1, 1.8, 1/100, 'N', 50);
INSERT INTO Configuration(id_configuration, ouverture_focale, temps_exposition, flash, distance_focale) VALUES(2, 2.8, 1/200, 'Y', 100);
INSERT INTO Configuration(id_configuration, ouverture_focale, temps_exposition, flash, distance_focale) VALUES(3, 3.5, 1/400, 'N', 200);


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

INSERT INTO Photo(id_photo, resolution, date_photo, lieu, licence, id_utilisateur, id_appareil, id_configuration) VALUES(1, '1280x720', TO_DATE('2023-06-03','YYYY-MM-DD'),'Montpellier','TousDroitsReserves', 1, 1, 1);
INSERT INTO Photo(id_photo, resolution, date_photo, lieu, licence, id_utilisateur, id_appareil, id_configuration) VALUES(2, '1280x720', TO_DATE('2023-08-03','YYYY-MM-DD'),'Paris','UtilisationCommercialeAutorisee', 2, 2, 2);
INSERT INTO Photo(id_photo, resolution, date_photo, lieu, licence, id_utilisateur, id_appareil, id_configuration) VALUES(3, '1280x720', TO_DATE('2023-12-03','YYYY-MM-DD'),'Los Angeles','ModificationImageAutorisee', 3, 2, 3);
INSERT INTO Photo(id_photo, resolution, date_photo, lieu, licence, id_utilisateur, id_appareil, id_configuration) VALUES(4, '1280x720', TO_DATE('2023-04-03','YYYY-MM-DD'),'Incheon','TousDroitsReserves', 3, 3, 3);


INSERT INTO Balise(id_balise) VALUES(1);
INSERT INTO Balise(id_balise) VALUES(2);
INSERT INTO Balise(id_balise) VALUES(3);
INSERT INTO Balise(id_balise) VALUES(4);
INSERT INTO Balise(id_balise) VALUES(5);


INSERT INTO Tag(id_tag,tag) VALUES(1,'#summer');
INSERT INTO Tag(id_tag,tag) VALUES(2,'#view');
INSERT INTO Tag(id_tag,tag) VALUES(3,'#montpellier');


INSERT INTO MotCle(id_mot_cle,mot_cle) VALUES(4,'Korea');
INSERT INTO MotCle(id_mot_cle,mot_cle) VALUES(5,'Baguette');

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

INSERT INTO Vues(id_photo, id_utilisateur) VALUES(1, 1);
INSERT INTO Vues(id_photo, id_utilisateur) VALUES(1, 2);
INSERT INTO Vues(id_photo, id_utilisateur) VALUES(1, 3);
INSERT INTO Vues(id_photo, id_utilisateur) VALUES(2, 1);
INSERT INTO Vues(id_photo, id_utilisateur) VALUES(2, 4);
INSERT INTO Vues(id_photo, id_utilisateur) VALUES(3, 1);
INSERT INTO Vues(id_photo, id_utilisateur) VALUES(3, 3);
/*fin de l'insertion des données*/