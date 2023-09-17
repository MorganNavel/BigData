CREATE TABLE UTILISATEUR(
    id_user INT NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    nom VARCHAR(50) NOT NULL,
    PRIMARY KEY(id_user)
);

CREATE TABLE APPAREIL_PHOTO(
    id_appareil INT NOT NULL,
    nom VARCHAR(50) NOT NULL,
    PRIMARY KEY(id_appareil)
);

CREATE TABLE CONFIGURATION(
    id_configuration INT NOT NULL,
    ouverture_focale FLOAT NOT NULL,
    temps_exposition FLOAT NOT NULL,
    flash BOOLEAN NOT NULL,
    distance_focale FLOAT NOT NULL,
    PRIMARY KEY(id_configuration)
);

CREATE TABLE PHOTO(
    id_photo INT NOT NULL,
    nom VARCHAR(50),
    resolution VARCHAR(100),
    license DATE NOT NULL,
    id_user INT NOT NULL,
    id_appareil INT NOT NULL,
    coordonnées VARCHAR(50) NOT NULL,
    date DATE NOT NULL,
    id_configuration INT NOT NULL,
    PRIMARY KEY(id_photo),
    FOREIGN KEY(id_user) REFERENCES USER(id_user),
    FOREIGN KEY(id_appareil) REFERENCES APPAREIL_PHOTO(id_appareil),
    FOREIGN KEY(id_configuration) REFERENCES CONFIGURATION(id_configuration),
    CHECK(license IN ("tous droits réservés","utilisation commerciale autorisée","modifications de l'image autorisées"))
);
--Index pour améliorer les performances lors de jointures--
CREATE INDEX idx_id_user ON PHOTO (id_user);

CREATE INDEX idx_id_appareil ON PHOTO (id_appareil);

CREATE INDEX idx_id_configuration ON PHOTO (id_configuration);
