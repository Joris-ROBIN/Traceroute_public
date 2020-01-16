Guide d'utilisation script traceroute

Vous pouvez retrouver tout les documents a tout moment avec ce lien git:
https://github.com/praimmfaya/Traceroute_public.git


NB: ATTENTION le lancement du script create_dot.sh ou clean.sh va entrainer la 
commande "rm *.txt" pour empecher ca, commentez la dernière ligne de
create_dot.sh

I ) Fonctionnement

Le script fonctionne en 3 partie, 
create_dot.sh est le script général;
traceroute.sh est le script qui va réaliser l'arbre pour un site donné.
clean.sh qui va supprimer les fichiers tiers


II ) Lancement 
Pour lancer le script merci de lancer create_dot.sh sans argument
Pour lancer uniquement le script traceroute.sh ajouter en premier argument 
le site choisi et en second argument une couleur (en anglais)


III ) Les outputs 
Le programme global crée des fichiers 0.txt 1.txt 2.txt... Un pour chaque site 
utilisé.
Il crée aussi un final.txt qui regroupe tout les n.txt.
Et enfin le traceroute.pdf qui est l'arbre final.
Le programme traceroute.sh va créé un fichier www.exemple.com.txt au nom du 
site donné.

Vous pourrez retrouver un exemple de ces fichiers dans le dossier "fichier 
tiers".
Si vous voulez conserver les fichiers tiers lors de l'exécution du programme 
commentez la dernière ligne du script create_dot.pdf

IV ) Sources 
Pour les couleurs et l'utilisation de dot j'ai utilisé ce pdf :
https://www.graphviz.org/pdf/dotguide.pdf

Pour l'utilisation de traceroute j'ai principalement utilisé le man traceroute 
retrouvable ici :
https://linux.die.net/man/8/traceroute








