
-- Insérer des utilisateurs
INSERT INTO USER (id_user, prenom, nom) VALUES(1, 'John', 'Doe');
INSERT INTO USER (id_user, prenom, nom) VALUES(2, 'Alice', 'Johnson');
INSERT INTO USER (id_user, prenom, nom) VALUES(3, 'Bob', 'Smith');
INSERT INTO USER (id_user, prenom, nom) VALUES(4, 'Emma', 'Williams');
INSERT INTO USER (id_user, prenom, nom) VALUES(5, 'Michael', 'Brown');


-- Insérer des appareils photo
INSERT INTO APPAREIL_PHOTO (id_appareil, nom) VALUES(1, 'Canon EOS 5D');
INSERT INTO APPAREIL_PHOTO (id_appareil, nom) VALUES(2, 'Nikon D850');
INSERT INTO APPAREIL_PHOTO (id_appareil, nom) VALUES(3, 'Sony Alpha A7 III');
INSERT INTO APPAREIL_PHOTO (id_appareil, nom) VALUES(4, 'Fujifilm X-T4');
INSERT INTO APPAREIL_PHOTO (id_appareil, nom) VALUES(5, 'Panasonic Lumix GH5');


-- Insérer des configurations
INSERT INTO CONFIGURATION (id_configuration, ouverture_focale, temps_exposition, flash, distance_focale) VALUES(1, 2.8, 1/1000, TRUE, 50);
INSERT INTO CONFIGURATION (id_configuration, ouverture_focale, temps_exposition, flash, distance_focale) VALUES(2, 1.4, 1/2000, FALSE, 35);
INSERT INTO CONFIGURATION (id_configuration, ouverture_focale, temps_exposition, flash, distance_focale) VALUES(3, 3.5, 1/500, TRUE, 85);
INSERT INTO CONFIGURATION (id_configuration, ouverture_focale, temps_exposition, flash, distance_focale) VALUES(4, 2.0, 1/8000, FALSE, 50);
INSERT INTO CONFIGURATION (id_configuration, ouverture_focale, temps_exposition, flash, distance_focale) VALUES(5, 4.0, 1/250, TRUE, 135);




-- Insérer des photos
INSERT INTO PHOTO (id_photo, nom, resolution, license, id_user, id_appareil, coordonnées, date, id_configuration) VALUES (1, 'Sunset in Paris', '1920x1080', 'utilisation commerciale autorisée', 1, 1, '48.8566, 2.3522', '2023-08-01', 1);
INSERT INTO PHOTO (id_photo, nom, resolution, license, id_user, id_appareil, coordonnées, date, id_configuration) VALUES (2, 'Portrait of Alice', '2560x1440', "modifications de l'image autorisées", 2, 2, '40.7128, -74.0060', '2023-08-02', 2);
INSERT INTO PHOTO (id_photo, nom, resolution, license, id_user, id_appareil, coordonnées, date, id_configuration) VALUES (3, 'Mountains in Japan', '3840x2160', 'tous droits réservés', 3, 3, '35.682839, 139.759455', '2023-08-03', 3);
INSERT INTO PHOTO (id_photo, nom, resolution, license, id_user, id_appareil, coordonnées, date, id_configuration) VALUES (4, 'Beach Sunset', '1920x1080', 'utilisation commerciale autorisée', 4, 4, '-33.865143, 151.209900', '2023-08-04', 4);
INSERT INTO PHOTO (id_photo, nom, resolution, license, id_user, id_appareil, coordonnées, date, id_configuration) VALUES (5, 'City Lights', '1280x720', 'tous droits réservés', 5, 5, '47.6062, -122.3321', '2023-08-05', 5);
INSERT INTO PHOTO (id_photo, nom, resolution, license, id_user, id_appareil, coordonnées, date, id_configuration) VALUES (6, 'Night Montpellier', '1920x1080', 'utilisation commerciale autorisée', 1, 1, '48.8566, 2.3522', '2023-08-06', 5);


