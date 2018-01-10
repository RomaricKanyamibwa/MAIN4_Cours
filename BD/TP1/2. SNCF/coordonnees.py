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

# # Recuperation des coordonnees d ’ une gare a partir
# # d ’ une connexion a la base et du nom de la gare
def get_gare_info ( database_cursor , gare_name ):
	# interrogation de la base pour obtenir
	# la latitude et la longitude de la gare

	query = 'SELECT longitude,latitude FROM Gare WHERE intitule="'+gare_name+'"'

	## Exécution de la requête
	c.execute(query)

	## Parcours des résultats
	L=c.fetchall()
	latitude=L[0][1]
	longitude=L[0][0]
	print(latitude,longitude)
	#( latitude , longitude )
	#print '{} : {}'.format(longitude,latitude)

	return ( latitude , longitude )
	## Requête avec un résultat attendu de plusieurs lignes


get_gare_info(c,sys.argv[1])

#     ## Requête avec un résultat attendu d'une seule ligne
# query = 'SELECT COUNT(*) FROM Gare WHERE departement="Aude"'

# ## Exécution de la requête
# c.execute(query)

# ## Récupération du résultat
# (count,) = c.fetchone()

# print('\nNombre total de Gare : {}'.format(count))