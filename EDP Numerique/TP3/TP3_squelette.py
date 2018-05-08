"""
test de schemas DF et visu
"""

import numpy
import os

import scipy.sparse as sparse
import scipy.sparse.linalg

import matplotlib.pyplot as plt
import matplotlib.animation as animation


### on veut approcher ici l'equation (modele tres simple de trafic routier)
#
# d_t u + d_x (u * v) = 0
#
# avec un flux f = u * v(u) donne, comme une fonction de u

# vitesse max km/h
v_max = 130

# densite max (nb de voitures/km)
u_max = 200


def vitesse(u_val):    
    if(0<u_val<u_max):
        return -0.65*u_val+130
    else:
        return 0

def flux(u_val):    
    return u_val*vitesse(u_val)


implicite = False

if implicite:
    dir_name = 'simu_implicite/'
else:
    dir_name = 'simu_explicite/'

do_movie = False
if do_movie:    
    movie_filename = dir_name+'movie.mp4'

# domaine spatial et maillage
X_min = 0
X_max = 1
Nx = 100
h = 1./Nx
X = numpy.zeros(Nx)

# domaine temporel
Temps_final = 1./60
Nt = 500
dt = Temps_final * 1./Nt
dt_over_h = dt/h

# nb d'images approx qu'on veut avoir
n_images = 100
periode_images = int(Nt*1./n_images)

# flux et solution approchee 
f = numpy.zeros(Nx)
u = numpy.zeros(Nx)
next_u = numpy.zeros(Nx)     

# fonction initiale
def u_ini(x):
    return 60+20*numpy.sin(2*numpy.pi*x)

for i in range(0,Nx):
    X[i] = X_min + i*h*(X_max-X_min)
    u[i] = u_ini(X[i])

# pour la visu:
Y_min = 0
Y_max = 1.1*max(v_max,u_max) 

# assemblage d'une matrice creuse M, etant donne le vecteur des vitesses au temps precedent
def assemble_M(some_u):
    assert implicite
    row = list()
    col = list()
    data = list()
    for i in range(0,Nx):

        # M_i,i
        row.append((i))
        col.append((i))
        data.append( 1 )   # mettre la bonne valeur
    
        # M_i,i-1
        j = numpy.mod(i-1,Nx) # modulo pour conditions periodiques
        row.append((i))
        col.append((j))  
        data.append( 0 )   # mettre la bonne valeur

        # M_i,i+1
        j = numpy.mod(i+1,Nx)  # modulo pour conditions periodiques
        row.append((i))
        col.append((j)) 
        data.append( 0 )   # mettre la bonne valeur

    row = numpy.array(row)
    col = numpy.array(col)
    data = numpy.array(data)      
    M = (sparse.coo_matrix((data, (row, col)), shape=(Nx, Nx))).tocsr()
    return M

if do_movie:
    ims = []
    print("using imagemagick...")
    Writer = animation.writers['imagemagick']  # ['ffmpeg']
    writer = Writer(fps=15, metadata=dict(artist='Me'), bitrate=1800)

fig = plt.figure()


def plot_sol(n):
    
    fig.clf()
    fname = dir_name+"out_"+repr(n)+".png"
    print "Plot sol in file ", fname, ", nt = ", n, ", min/max = ", min(u), "/", max(u)
    X_full = numpy.concatenate((X,[1.]),axis=0)
    u_full = numpy.concatenate((u,[u[0]]),axis=0)
    # trace aussi les vitesses:
    v = map(vitesse, u)
    v_full = numpy.concatenate((v,[v[0]]),axis=0)
    plt.xlim(X_min, X_max)
    plt.ylim(Y_min, Y_max)
    plt.xlabel('x')
    image = (plt.plot(X_full, u_full, '-', color='k'))
    image += (plt.plot(X_full, v_full, '-', color='b'))
    
    fig.savefig(fname)
    if do_movie:
        ims.append(image)

plot_sol(0)

## schema numerique       
for nt in range(0,Nt):               
    if implicite:
        M = assemble_M(u)
        next_u[:] = sparse.linalg.spsolve(M, u)

    else:
        for i in range(0,Nx):        
            next_u[i] =-dt_over_h*(flux(u[i])-flux(u[i-1]))+u[i]   # ecrire ici le schema explicite
            
    u[:] = next_u[:]
    if (nt+1)%periode_images == 0 or (nt+1) == Nt:
        plot_sol(nt+1)
    

if do_movie:
    im_ani = animation.ArtistAnimation(fig, ims, interval=50, repeat_delay=3000, blit=True)
    im_ani.save(movie_filename, writer=writer)

print "Done."
