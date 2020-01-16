#!/bin/bash
couleur=("blue" "green" "red" "pink" "purple" "brown" "yellow" "orange" "grey" "darkgoldenrod" "black" # On crée une liste de couleur compatible qui permet de rendre plus lisible les arbres du pdf final
"midnightblue"  "orchid2" "maroon2" "lightskyblue1" "chartreuse1" "cadetblue1" "darkolivegreen" "deeppink1" "forestgreen"


)
address=(           #On entre les adresses que va rechercher le script !ATTENTION! il faut au moins autant de couleur que d'adresses
"www.iut-blagnac.fr"
"www.borelly.net"
"www.facerias.org"
"www.iut-lannion.fr"
"www.iut-larochelle.fr"
"www.iut-valence.fr"
"www.iutbeziers.fr"
"www.iut.fr"
"https://echanges-etudiants.bci-qc.ca/"
"www.clap.ca"
"www.canadiantire.ca"
"www.ulaval.ca"
"www.peps.ulaval.ca"
)


taille=${#address[@]}     #On calcule le nombre d'adresses a traiter
i=0
while [ $i != $taille ]   #Une boucle permettant de lire les adresses une par une
do
  echo "site en cours : ${address[$i]}"
  ./script_10.sh ${address[$i]} ${couleur[$i]}     #On invoque le script 10 qui nous crée un .txt
  tr -d '\n' < ${address[$i]}.txt > $i.txt     #On supprime les retour chariots et créons un nouveau fichier tiers
  ((i=i+1))
  if [ $i != $taille ];then         #Si on à finit on affiche un petit message
    echo "prochain site !"
  fi

done
echo "digraph trace {" > final.txt    #Mise en forme du fichier final sur lequel on utilisera dot

i=0
while [ $i != $taille  ]    #Boucle pour traiter tout les fichiers 1 par 1
do

  echo "" >> final.txt    #Retour a la ligne pour séparer les différentes entrée
  cat $i.txt >> final.txt  #On écrit la ligne
  ((i=i+1))
done
echo "" >> final.txt    #
echo "}" >> final.txt   # On termine la mise en forme
dot -Tpdf final.txt -o Traceroute.pdf   #On exécute la commande dot pour créer un pdf final
echo "Script fini"
beep
beep    #Petit son permettant d'être prévenu de la fin du programme
beep
./clean.sh
