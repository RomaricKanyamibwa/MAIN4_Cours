--3
-- SELECT id,mois,trains_programmes,trains_retardes,trains_annules,(100*
-- 	(1-(trains_retardes*1.0+trains_annules)/trains_programmes)) as Taux_regularite
--  FROM Regularite  WHERE trains_programmes>0 order by Taux_regularite limit 10;

--4

SELECT * FROM (SELECT mois,G1.intitule as Depart,G.intitule as Arrivee,trains_programmes,trains_annules,trains_retardes
FROM (Regularite as R INNER JOIN Gare
ON depart=code_UIC) as G1 INNER JOIN Gare as G ON arrivee=G.code_UIC )WHERE Arrivee="Paris Gare de Lyon" ORDER BY mois limit 10;

SELECT *,(100.0*Total_annul/Total_prog) AS pourc_Tot_annul,(100.0*Total_ret/Total_prog) AS pourc_Tot_ret,100*(1-(Total_ret*1.0+ Total_annul)/Total_prog) as Taux_regularite
FROM
(SELECT SUM(trains_annules) AS Total_annul,SUM(trains_programmes) AS Total_prog,SUM(trains_retardes) AS Total_ret
FROM (SELECT mois,trains_retardes,trains_programmes,trains_annules
,G1.intitule as Depart,G.intitule as Arrivee,trains_programmes,trains_annules,trains_retardes
FROM (Regularite as R INNER JOIN Gare
ON depart=code_UIC) as G1 INNER JOIN Gare as G ON arrivee=G.code_UIC )WHERE Arrivee="Paris Gare de Lyon" ORDER BY mois);
	