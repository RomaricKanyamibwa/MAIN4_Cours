USE sncf;

DROP TABLE IF EXISTS `Regularite`;
DROP TABLE IF EXISTS `Gare`;
DROP TABLE IF EXISTS `Axe`;

CREATE TABLE `Gare` (
  `code_UIC` VARCHAR(10) PRIMARY KEY,
  `intitule` TEXT,
  `code_postal` TEXT,
  `commune` TEXT,
  `departement` TEXT,
  `region` TEXT,
  `longitude` FLOAT,
  `latitude` FLOAT
);


CREATE TABLE `Axe` (
  `id` INTEGER PRIMARY KEY,
  `nom` TEXT
);


CREATE TABLE `Regularite` (
  `id` INTEGER PRIMARY KEY AUTO_INCREMENT,
  `mois` TEXT,
  `axe_id` INTEGER,
  `depart` VARCHAR(10),
  `arrivee` VARCHAR(10),
  `trains_programmes` INTEGER,
  `trains_annules` INTEGER,
  `trains_retardes` INTEGER,
  `type_train` ENUM('TGV', 'Intercités'),
  `commentaire` TEXT,
  FOREIGN KEY(`axe_id`) REFERENCES `Axe`(`id`),
  FOREIGN KEY(`depart`) REFERENCES `Gare`(`code_UIC`),
  FOREIGN KEY(`arrivee`) REFERENCES `Gare`(`code_UIC`)
);

