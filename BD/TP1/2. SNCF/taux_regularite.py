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
query = 'SELECT mois,id,(100*(1-(trains_retardes*1.0+trains_annules)/trains_programmes)) as Taux_regularite FROM Regularite  WHERE trains_programmes>0 order by Taux_regularite limit 10'

## Exécution de la requête
c.execute(query)

## Parcours des résultats
for (mois,ligne,Taux_regularite) in c.fetchall():
    print 'Mois:{} ,ligne:{} ,Taux de regularite:{}'.format(mois,ligne,Taux_regularite)

