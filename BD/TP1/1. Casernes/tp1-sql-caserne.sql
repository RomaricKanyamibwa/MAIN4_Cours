--Partie 4.1
--1
--SELECT Nom_ville FROM Ville;

--2
-- SELECT prenom,nom FROM pompier;

--3
-- SELECT * FROM caserne WHERE Nom_ville="Shadok";

--4
-- SELECT Nom_ville FROM Protege WHERE Id_caserne=1;

--5
-- SELECT Nom_ville,Nb_hab FROM  Ville ORDER BY Nb_hab;

--6
-- SELECT camion.Id_caserne,camion.Id_camion,Nb_places,Modele FROM citerne INNER JOIN camion ON 
-- citerne.Id_camion=camion.Id_camion AND citerne.Id_caserne=camion.Id_caserne;

--7
-- SELECT DISTINCT(Protege.Id_caserne) FROM Protege INNER JOIN Adresse ON Protege.Nom_ville=Adresse.Nom_ville AND Protege.CP=Adresse.CP WHERE Protege.Nom_ville="Draguignan";

--8
	--	a
-- SELECT  COUNT(*) FROM citerne;
-- 	--b
-- SELECT MAX(contenance) FROM citerne;

--9 
-- SELECT Id_caserne,AVG(contenance) FROM citerne GROUP BY Id_caserne;

--10
-- SELECT COUNT(Nom_ville),Nom_ville AS NB_Caserne FROM Protege GROUP BY Nom_ville;

--11
-- SELECT Id_caserne,SUM(contenance) as Sum_Contenance FROM citerne GROUP BY Id_caserne HAVING Sum_Contenance>2000;

--12
-- SELECT nom,prenom FROM pompier WHERE nom LIKE "M%";

--Partie 4.2
--3 Contraintes
--INSERT INTO Caserne(Id_caserne,Capa_camions,Capa_pompiers,Num_rue,Nom_rue,Nom_ville,CP) VALUES(1,8,45,NULL,NULL,NULL,NULL);

--4 Requetes

--1

--SELECT COUNT(*) FROM caserne;

--2

--SELECT nom,prenom from caserne INNER JOIN pompier ON caserne.Id_caserne=pompier.Id_caserne WHERE caserne.Nom_ville="Draguignan";

--3
--SELECT P1.Id_caserne FROM Protege P1 INNER JOIN Protege P2 ON P1.Nom_ville="Le Luc" AND P2.Nom_ville="Draguignan"
--AND P1.Id_caserne=P2.Id_caserne;  

--4
-- SELECT pompier.Id_caserne,nom,prenom,pompier.Nom_ville,pompier.Nom_rue,pompier.Num_rue 
-- ,caserne.Nom_ville,Adresse.Nom_ville,Adresse.Nom_rue,Adresse.Num_rue,Adresse.proche_caserne,Adresse.Km
--  FROM (caserne INNER JOIN pompier ON caserne.Id_caserne=pompier.Id_caserne) as A
--  INNER JOIN Adresse ON pompier.Nom_ville= Adresse.Nom_ville  AND pompier.Nom_rue= Adresse.Nom_rue AND pompier.Num_rue= Adresse.Num_rue
--  WHERE pompier.Id_caserne=3 AND Adresse.Km>5;

--5
 -- SELECT nom,prenom,pompier.Nom_ville,Nb_hab FROM pompier INNER JOIN Ville ON pompier.Nom_ville=Ville.Nom_ville WHERE pompier.Nom_ville="Le Luc" OR Nb_hab>=20000;

--6
-- SELECT camion.Id_caserne,Fabricant.Nom_fabricant,Delai,Nom_modele,contenance FROM (Fabricant INNER JOIN Modele ON Fabricant.Nom_fabricant=Modele.Nom_fabricant)
-- INNER JOIN camion ON Modele.Nom_modele=camion.Modele
-- INNER JOIN citerne ON citerne.Id_camion=camion.Id_camion AND citerne.Id_caserne=camion.Id_caserne WHERE contenance<1000 ;

--7
-- SELECT camion.Id_caserne,AVG(Delai) as Delai_moy FROM (Fabricant INNER JOIN Modele ON Fabricant.Nom_fabricant=Modele.Nom_fabricant)
-- INNER JOIN camion ON Modele.Nom_modele=camion.Modele
-- GROUP BY camion.Id_caserne ORDER BY Delai_moy DESC;

--8
-- SELECT COUNT(Id_pompier) FROM pompier GROUP BY Id_caserne;

--9
-- SELECT * FROM (SELECT COUNT(Id_pompier) as NB,Id_caserne FROM pompier GROUP BY Id_caserne ) WHERE NB=1;

--10
-- SELECT Nom_ville,caserne.Id_caserne,MAX(contenance) FROM Caserne INNER JOIN citerne ON Caserne.Id_caserne=citerne.Id_caserne GROUP BY Nom_ville;

-- WITH MAXCont.contenance AS (SELECT MAX(contenance) FROM citerne ) FROM 
-- SELECT Nom_ville,caserne.Id_caserne,contenance FROM Caserne INNER JOIN citerne ON Caserne.Id_caserne=citerne.Id_caserne GROUP BY Nom_ville;

--11
-- SELECT caserne.Id_caserne,Capa_pompiers,NB_pompier FROM caserne JOIN 
-- (SELECT COUNT(Id_pompier) as NB_pompier,Id_caserne FROM pompier GROUP BY Id_caserne) AS P ON P.Id_caserne=caserne.Id_caserne
-- WHERE NB_pompier=Capa_pompiers ;


--12
 -- SELECT P.Id_caserne,P.nom,P.prenom,P.Nom_ville,C.Nom_ville as Caserne_ville FROM pompier as P INNER JOIN caserne as C on C.Id_caserne=P.Id_caserne
 -- WHERE P.Nom_ville!=C.Nom_ville;

 --13

 -- SELECT * FROM Ville INNER JOIN (SELECT Nom_ville,COUNT(CP) as NB_CP FROM Ville GROUP BY Nom_ville) AS Ville2 ON Ville.Nom_ville=Ville2.Nom_ville WHERE NB_CP >1;

 -- SELECT DISTINCT(v1.Nom_ville) FROM Ville v1 INNER JOIN Ville v2 on v1.CP=v2.CP WHERE v1.Nom_ville!=v2.Nom_ville; 

 --14
-- SELECT * FROM (SELECT Nom_fabricant,COUNT(Nom_fabricant) as Fab FROM (SELECT Nom_fabricant,C.Id_caserne,Modele FROM Modele as M INNER JOIN camion as C ON M.Nom_modele=C.Modele GROUP BY Nom_fabricant,Id_caserne) 
-- AS P GROUP BY Nom_fabricant) WHERE Fab=(SELECT COUNT(caserne.Id_caserne) FROM caserne) ;

--15
-- SELECT V.Nom_ville,COUNT(Type_habitation) as NB_Type_Hab FROM Adresse as A INNER JOIN Ville as V ON A.Nom_ville=V.Nom_ville AND A.CP=V.CP GROUP BY A.Nom_ville;

--16
--a
-- SELECT C.Id_caserne,COUNT(Id_pompier) as NB_pompier FROM Caserne as C INNER JOIN pompier as P on C.Id_caserne=P.Id_caserne GROUP BY C.Id_caserne ORDER BY NB_pompier DESC; 
-- --b
-- SELECT  Id_caserne,MAX(NB_pompier) FROM (SELECT C.Id_caserne,COUNT(Id_pompier) as NB_pompier FROM
--  Caserne as C INNER JOIN pompier as P on C.Id_caserne=P.Id_caserne GROUP BY C.Id_caserne ORDER BY NB_pompier DESC); 


--17
SELECT Cit.Id_caserne,SUM(contenance) AS Vol_Tot FROM citerne as Cit GROUP BY Id_caserne
UNION SELECT Id_caserne,0 FROM Caserne WHERE Id_caserne NOT IN (SELECT Id_caserne FROM citerne GROUP BY Id_caserne) ;