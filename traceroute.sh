#!/bin/bash
#----------------------------------Initialisation----------------------------#
site=$1
lignes=$(traceroute -w 2 $site | wc -l)
i=1
nb=0
options=("" "-I" "-T" "-p 80" "-p 86" "-p 443" "-p 520" "-T -p80" "-p 86 -T" "-p 443 -T" "-p 520 -T" "-w 10" "fin") #Initialise les différentes options a tester pour éviter les *
nb_res=0
#--------------------------------TRACROUTE-----------------------------------#
 while [ $i != $lignes ] #Première boucle pour changer de lignes et aller au hop suivant
 do
   test=0
   while [ $test == 0 ] #Seconde boucle pour avancer dans le tableau des options
    do

      reponse=([$nb_res]=$(traceroute  -f $i ${options[$nb]} -w 1 -m $i -n $site  | tail -n 1 | awk '{print($2)}')) #Premier essai de la commande
      if [ "${reponse[$nb_res]}" != "*" ]; then         #Si l'on obtient une adresses
        if [ "${reponse[$nb_res]}" == "$double" ]; then #qui est la même que la précedente
          i=$lignes                                     #alors
          ((i=i-1))                                     #le script s'arrete
          break                                         #
        else
          if [ $i != 1 ];then                           #Si ce n'est pas la première ligne
            echo "->" >> $1.txt                         #ajout du symbole ->
          fi                                            #servant pour la commande dot

          double=${reponse[$nb_res]}
          reponse=([$nb_res]=$(traceroute  -f $i ${options[$nb]}  -m $i -n $site -A  | tail -n 1 | awk '{print($2,$3)}'))   #Récupération de la réponse final au format : "@_ip routeur AS_routeur"

          if [ "${reponse[$nb_res]}" != "*" ];then                                                      #s'il n'y a pas de problèmes
            echo "\"$i " "${reponse[$nb_res]}\""                                                        #
            echo "\"$i " "${reponse[$nb_res]}\"" >> $1.txt                                              #afficher et écrire le résultat
          else
            reponse=([$nb_res]=$(traceroute  -f $i ${options[$nb]}   -m $i -n $site -A  | tail -n 1 | awk '{print($3,$4)}'))       #Sinon                                                                                                                    #
            echo "\"$i " "${reponse[$nb_res]}\""                                                                                   #
            echo "\"$i " "${reponse[$nb_res]}\"" >> $1.txt                                                                         #afficher et écrire le résultat

          fi
          break
        fi
      else
        ((nb=nb+1))                #Si le if ligne 20 n'a pas réussi, la commande a donc renvoyé une * il faut donc incrémenter l'option pour se déplacer dans le tableau

        if [ "${options[$nb]}" == "fin" ]; then                          #Si le tableau est arrivé à l'option fin c'est que le routeur ne veux pas donner d'informations
          echo \"Router $i vers $site introuvable\"                      #donc
          echo " -> \"Router $i vers $site introuvable\"" >> $1.txt      #on affiche et écrit un résultat raté
          break
        fi
      fi
    done
  nb=0        #On remet le tableau des options a 0

  ((i=i+1))             #On passe a la ligne suivante
  ((nb_res=nb_res+1))   #
done

#refaire la commande en attendant un peu plus le résultat
                                         #puis l'afficher et l'écrire



#---------------------------------Mise en forme du fichier résultat-----------------------------------------------#



echo "-> \"$site\" [color=$2];" >> $1.txt        #On écrit un ; pour le format du fichier .dot
