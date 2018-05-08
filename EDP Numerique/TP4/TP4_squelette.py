"""
SQUELETTE de script pour un schema EF pour l'equation de Poisson 1D

 - u'' = f            sur [0,1]     (Poisson)
   
   u(0) = u(1) = 0                  (cond. Dirichlet homogenes sur le bord)
"""

import numpy
import pylab
import os

import scipy.sparse as sparse
import scipy.sparse.linalg

import matplotlib.pyplot as plt

fig = plt.figure()

# domaine spatial et maillage
x_min = 0
x_max = 1
Nx = 200        # nb de mailles 
grid, h = numpy.linspace(x_min, x_max, Nx+1, endpoint=True, retstep=True)

# fonctions de base: 
def phi(i,x):
    """
    i-eme fonction nodale sur la grille, affine par morceaux
    """
    assert i in range(0,Nx+1)  # i*h doit etre un point de la grille
    return max(1-abs(x/h-i), 0)
    

dim_Vh = Nx -1                          ## ??

# evaluation d'une fonction dans l'espace V_h d'elements finis affines: 
def eval_vh(v_coefs,x):
    val = 0
    for i in range(dim_Vh):
        val += v_coefs[i]*phi(i+1,x)
    return val

# source discrete: 
print "on assemble la source discrete b_h..."
vector_size = Nx                     ## ??? 
b = numpy.zeros(vector_size)
for i in range(vector_size):
    b[i] = phi(i,1./3.)                      ## ??? 
print "ok."

# sol exacte
def u_ex_func(x):    
    val = 2./3*x*(0<=x<=1/3)+(1/3<x<=1)*(-1./3*x+1./3)                         ## ?? 
    return val
        
# assemblage de la matrice d'elements finis
print "on assemble la matrice A_h..."
row = list()
col = list()
data = list()
matrix_size = Nx                     ## ?? 
for i in range(0, matrix_size):
    for j in range(0, matrix_size):

        coef = 0
        if i == j:                  ## ?? 
            coef = 2/h                ## ?? 
        if i == j+1:
            coef = -1/h
        if i == j-1:
            coef = -1/h
    
        if coef != 0:
            row.append((i)) 
            col.append((j))        
            data.append(coef)

row = numpy.array(row)
col = numpy.array(col)
data = numpy.array(data)      
Ah = (sparse.coo_matrix((data, (row, col)), shape=(matrix_size, matrix_size))).tocsr()
print "ok."

def plot_vh(v_coefs, N_points_plot=200, filename="solution.png", plot_sol_ex=False):
    """
    plot a discrete function, given its coefs in the array v_coefs
    """
    plot_grid = numpy.linspace(x_min, x_max, N_points_plot, endpoint=True)
    plot_vals = [eval_vh(v_coefs, xi) for xi in plot_grid]
    fig = plt.figure()
    plt.clf()
    plt.xlabel('x')
    plt.plot(plot_grid, plot_vals, '-', color='b', label="discrete function")    
    if plot_sol_ex:
        print "on trace aussi la solution de reference qu'on a indiquee dans le programme ..."
        plot_vals = [u_ex_func(xi) for xi in plot_grid]
        plt.plot(plot_grid, plot_vals, '-', color='r', label="reference solution")    
    plt.legend(loc='upper right')
    fig.savefig(filename)

#u = numpy.zeros(Nx-1)

# resolution de l'equation matricielle  M u = b
print "on calcule la solution approchee u_h..."
u = sparse.linalg.spsolve(Ah, b)
print "ok."

# on trace la solution approchee
print "on trace u_h..."
plot_vh(u, filename='plot_poisson.png', plot_sol_ex=True)
print "ok."
