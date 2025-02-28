-- DEVELLOPPEUMENT 
v0.01.0 -> Définir le nombre de pixel ainsi que leur couleur
v0.01.1 -> Afficher la quantité de pixel selon la couleur
v0.01.2 -> Reflexion nom de variable
v0.01.3 -> Reflexion boucle
v0.02.0 -> Refonte des fondations, on commence par la grille
v0.03.0 -> SUCCESS : Grille, Couleur, légende de couleur
v0.04.0 -> SUCCESS : lorsque le puzzle est fini, il est mis en valeur
v0.05.0 -> SUCCESS : selectionner un pixel de couleur
v0.06.0 -> SUCCESS : changement de logique, comparer deux tableau et changer les valeur du tableau vierge pour être completer au tableau final
v0.07.0 -> SUCCESS : choix des couleurs en prenant une piece sur la droite puis la poser sur la grille
v0.08.0 -> SUCCESS : mini dessin afficher à gauche pour guider le joueur
v0.09.0 -> SUCCESS : Modifier le changement de couleur en cliquant sur le bouton droit
v0.09.1 -> UPGRADE : réglage d'un bug où la couleur ne correspondait pas à l'indexColor
v0.09.2 -> UPGRADE : Ajout du flèche pour IU
v0.10.0 -> ACTUALLY : ajout la feature retirer un pixel placer dans la grille
v0.10.1 -> ACTUALLY : Icone delete finis, feature en codage
v0.10.2 -> ACTUALLY : lorsque l'icone delete est activé, retirer le carre de couleur en remplaçant la variable par 99
v0.11.0 -> SUCCESS : Feature Delete pixel 
v0.12.1 -> ACTUALLY : Mis en place du dialogue selection
v0.12.2 -> ACTUALLY : preparatif pour changer la couleur si on survole la souris
v0.13.0 -> SUCCESS : Boucle de endgame "Refaire le puzzle" où "Quitter en remerciant"
v0.14.0 -> SUCCESS : Indiquez le nombre de pixel restant et le nombre de pixel total

-- ALPHA

v1.00.0 -> ACTUALLY : corriger la description et metadonné du jeu pour l'hébergeur TIC-80
v1.01.0 -> ACTUALLY : les pixels mal placé devienne blanc avec la touche Q
v1.01.1 -> SUCCESS : changement de couleur des pixel mal placé, bordure animé en arc-en-ciel
v1.01.2 -> FAIL : indiquer le nombre de couleur maximum, reprendre la soutraction pour obtenir le nombre dans GRID
v1.01.3 -> ACTUALLY : clean du code pour réutilisé le mode soluce 
v1.01.4 -> ACTUALLY : clean du code pour une meilleur lisibilité des variable globale
v1.01.5 -> SUCCESS : Ajoute d'un seconde puzzle
v1.01.5.1 -> HOTFIX : corrigé le nombre de pixel selon le puzzle
v1.01.5.2 -> SUCCESS : corrigé le nombre de pixel selon le puzzle
v1.01.6 -> SUCCESS : icone carre du mode soluce
v1.02.0 -> SUCCESS : Changer la taille de la grille selon le puzzle
v1.03.0 -> SUCCESS : lancement aléatoire d'un puzzle
v1.03.1 -> ACTUALLY : la progression du puzzle bug lors d'un changement de puzzle
v1.03.2 -> HOTFIX : changement de phase + progression
v1.03.3 -> FAIL : Condition de victoire jamais réparé !! A REVENIR !!
v1.03.4 -> SUCCESS : IU selection de puzzle
v1.03.5 -> ACTUALLY : préparation à l'algo pour dessiner les puzzle dans la selection
v1.03.6 -> SUCCESS : Afficher les puzzles dispobible dans la collection !! A REVENIR SUR LES PUZZLES DE GRAND TAILLE !!
v1.03.7 -> UPGRADE : Nouvelle puzzle ajouter, modification des paramètres du mini-puzzle, taille du mini-puzzle ajouté dans le tableau selecMap
v1.03.8 -> UPGRADE : IU Building, déplacement du nom et numéro de puzzle, la progression du puzzle ainsi que l'icone delete
v1.03.9 -> SUCCESS : Bordure rouge lorsque la souris survole un élement pour choisir un puzzle + changer de page
v1.03.10 -> HOTFIX : Bordure rouge lorsque la souris survole un élement pour choisir un puzzle + changer de page
v1.04.0 -> SUCCESS : Choisir un puzzle parmi une sélection
v1.04.1 -> FAIL : Réduire la taille de la mini grille pour les grands puzzle, impossible de récupérer la valeur false/true de infoMAP[i][10] !! A REVENIR !!
EN COURS : 

A FAIRE : 
- Mode Soluce pour indiquer les pixel mal placé
           Besoin de remttre la feature nombre de pixel par couleur -> soustraire par le nombre de variable dans GRID
           Une icone loupe apparaît s'il reste peut de pixel à placer
           le mode soluce reste actif 5 seconde affiche le décompte
           usage limiter une toutes les 10 secondes affiche le décompte
           si activé icone loupe devient arc-en-ciel 
- musique et animation
- reprendre la documention du doc via gitbook
- Affichez le niveau de difficulter du puzzle
- limité les pixel 

REFAIRE ABSOLUMENT : 
- bug sur la condition de victoire, en cheat mode ça fonction mais pas jouant normalement
    revoir watchEqual() et endPuzzle

-- A TESTER : 

REFONTE :
- Prendre un pixel disponible puis le glisser sur la grille 
feature : afficher tous les pixel en bazar puis les placer sur la grille
probleme : UX désastreux car très pénible prendre et mettre les plieces une par une du bazar à la grille, sensation de répétition
solution : afficher les pixel de couleur disponible pour cliquer une fois dessus pour placer plusieur pixel de mettre couleur

- Activé le mode soluce selon la quantité de pièce restant par couleur
feature : mettre un décompteur sur les pixel présent dans le tableau GRID
probleme : trop de temps perdu, je cherche une autre condition d'activé le mode soluce
solution : au bout de X temps après le début de la partie, le mode soluce s'active réfléchir à 1mn selon le temps moyen de résolution

- nombre de pixel restant par couleur
feature : pixel de couleur limité par le nombre sur le puzzle
probleme : UX personnel erroné, assiste trop le joueur, reduit la reflexion du joueur et l'impact de récompense.
            bien au contraire, ajoute de la difficulté, a intégré en derniers
solution : m'y remettre la tête frais

ABONDONNE : 