# BLONK! — système d'exploitation éducatif

Écrire chaque partie depuis zéro, dans l'optique de comprendre au maximum les
_quoi_, _pourquoi_, _comment_. Pas de GRUB, pas de système de fichier existant,
pas de libc prête à l'emploi.

Chaque version de BLONK! doit fonctionner dans l'émulateur Qemu **et** sur
trois ordinateurs physiques dont je dispose pour les tests : un laptop de
2016, un laptop de 2014, et un desktop de 2006. Qemu est parfait pour
tester rapidement des idées, mais l'objectif final est bien de faire tourner
BLONK! "en vrai".

L'OS sera proche d'un ordinosaure. Affichage texte, clavier,
interpréteur de commande minimal : juste ce qu'il faut pour gérer les fichiers
(liste, suppression, renommage, copie) et lancer quelques petits programmes.

## Spécifications de BLONK!

La liste qui suit est l'objectif à atteindre. On en est encore loin.

- Installation sur disque dur
- Booter à partir d'une clé USB (pas de disquette — obsolète —, pas de CD-ROM)
- 32 bits
- 4 Mo de mémoire requis (mais n'en gère pas plus)
- Multitâche (2 c'est déjà multi)
- Cross-compilation : l'assemblage et/ou la compilation se passe ailleurs
- Ne connait pas le multiboot
- Gère un seul et unique disque dur (sa taille maximum n'est pas claire)
- Système de fichier sans dossiers
- Pas de son, pas de souris
- Support du layout AZERTY uniquement

## Dépendances

- nasm

## Release(s)

### Build

    nasm message.nasm -f bin -o message
    nasm boot.nasm -f bin -o boot
    cat boot message > kernel

### Dans l'émulateur

    qemu-system-i386 -hda kernel

### Sur un ordinateur physique

Copier l'image de l'OS au début d'une clé USB :

    sudo cp image /dev/sdx

Remplacer sdx par votre clé USB (`fdisk -l` pour la trouver).
Puis booter votre ordinateur de test avec cette clé USB.
