#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import sqlite3
from config import SQLITE_DATABASE

## Connexion à la base
conn = sqlite3.connect(SQLITE_DATABASE)
c = conn.cursor()

## Requête avec un résultat attendu de plusieurs lignes
query = 'SELECT * FROM Axe'

## Exécution de la requête
c.execute(query)

## Parcours des résultats
for (id,nom) in c.fetchall():
    print 'Axe {} : {}'.format(id, nom.encode('utf-8'))

## Requête avec un résultat attendu d'une seule ligne
query = 'SELECT COUNT(*) FROM Axe'

## Exécution de la requête
c.execute(query)

## Récupération du résultat
(count,) = c.fetchone()

print('\nNombre total d\'Axe : {}'.format(count))

