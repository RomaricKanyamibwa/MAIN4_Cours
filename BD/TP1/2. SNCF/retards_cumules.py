#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Created on Wed Dec  6 11:16:29 2017

@author: 3600594
"""

import sys
import sqlite3
from config import SQLITE_DATABASE



## Connexion à la base
conn = sqlite3.connect(SQLITE_DATABASE)
c = conn.cursor()

def retard(database_cursor , gare_name ):
	## Requête avec un résultat attendu de plusieurs lignes
	query = '''SELECT * FROM (SELECT mois,G1.intitule as Depart,G.intitule as Arrivee,trains_programmes,trains_annules,trains_retardes 
	FROM (Regularite as R INNER JOIN Gare 
	ON depart=code_UIC) as G1 INNER JOIN Gare as G ON arrivee=G.code_UIC ) WHERE Arrivee="'''+gare_name+'''" ORDER BY mois'''

	## Exécution de la requête
	database_cursor.execute(query)

	## Parcours des résultats
	for (mois,depart,arrivee,trains_programmes,trains_annules,trains_retardes) in database_cursor.fetchall():
	    print '{} {} -> {} :{} programmés,{} annulés, {} retardés,'.format(mois,depart.encode('utf-8'),arrivee.encode('utf-8'),trains_programmes,trains_annules,trains_retardes)

 #    query = 'SELECT COUNT(*) FROM (SELECT mois,G1.intitule as Depart,G.intitule as Arrivee,trains_programmes,trains_annules,trains_retardes FROM (Regularite as R INNER JOIN Gare ON depart=code_UIC) as G1 INNER JOIN Gare as G ON arrivee=G.code_UIC ) WHERE Arrivee="'+gare_name+'"'

	# ## Exécution de la requête
	# c.execute(query)

	# ## Récupération du résultat
	# (count,) = c.fetchone()

	# print('\nNombre total des informations : {}'.format(count))


def Total(database_cursor , gare_name ):
	query = '''
	SELECT *,100*(1-(Total_ret*1.0+ Total_annul)/Total_prog) as Taux_regularite,
	(100.0*Total_annul/Total_prog) AS pourc_Tot_annul,(100.0*Total_ret/Total_prog) AS pourc_Tot_ret
FROM
(SELECT SUM(trains_annules) AS Total_annul,SUM(trains_programmes) AS Total_prog,SUM(trains_retardes) AS Total_ret
FROM (SELECT mois,trains_retardes,trains_programmes,trains_annules
,G1.intitule as Depart,G.intitule as Arrivee,trains_programmes,trains_annules,trains_retardes
FROM (Regularite as R INNER JOIN Gare
ON depart=code_UIC) as G1 INNER JOIN Gare as G ON arrivee=G.code_UIC )WHERE Arrivee="'''+gare_name+'''" ORDER BY mois)
	'''


	## Exécution de la requête
	database_cursor.execute(query)
	print'\n \n '

	for (Total_annul,Total_prog,Total_ret,Taux_regularite,pourc_Tot_annul,pourc_Tot_ret) in database_cursor.fetchall():
	    print 'Total trains programmés : {}'.format(Total_prog)
	    print 'Total trains annulés : {} ({} %)'.format(Total_annul,pourc_Tot_annul)
	    print 'Total trains retardés : {} ({} %)'.format(Total_ret,pourc_Tot_ret)
	    print 'Taux de régularité:{} %'.format(Taux_regularite)


if len(sys.argv) ==1:
	print 'Error:No arguments passed!'
	print 'retard_cumules.py [gare_name]'
else:
	retard(c,sys.argv[1])
	Total(c,sys.argv[1])

