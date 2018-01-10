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


## Requête avec un résultat attendu de plusieurs lignes
query = 'SELECT code_UIC,intitule FROM Gare WHERE departement="Aude"'

## Exécution de la requête
c.execute(query)

## Parcours des résultats
for (id,nom) in c.fetchall():
    print '{} : {}'.format(id, nom.encode('utf-8'))


    ## Requête avec un résultat attendu d'une seule ligne
query = 'SELECT COUNT(*) FROM Gare WHERE departement="Aude"'

## Exécution de la requête
c.execute(query)

## Récupération du résultat
(count,) = c.fetchone()

print('\nNombre total de Gare : {}'.format(count))