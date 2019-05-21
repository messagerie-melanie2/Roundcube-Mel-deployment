Roundcube Mél déploiement
=========================
Ce dépot a pour but de faciliter le déploiement de Roundcube Mél. Il aller récupérer [Roundcube Mél][roundcube-mel] et [Roundcube plugin Mél][roundcube-plugins-mel] depuis Github et ensuite générer un répertoire webmail/ contenant tous les fichiers nécessaires au bon fonctionnement du Webmail. Les fichiers de configurations sont récupérés du répertoire [deploiement/init][deploiement-init].


Mise en place
-------------
Les scripts de ce dépot utilisent plusieurs répertoires pré-définis pour générer les archives.

 - [deploiement/][deploiement] : Ce répertoire doit contenir les différentes configuration de déploiement. La configuration [deploiement/init][deploiement-init] est obligatoire et doit au minimum être initialisé avec le [fichier de configuration][deploiement-init-config] de Roundcube Mél. L'arborence de chaque dossier de déploiement doit donc être identique à l'arborescence de Roundcube Mél (exemple: Roundcube-Mel/config/config.inc.php -> deploiement/init/config/config.inc.php). Il est possible d'utiliser d'autre répertoires de déploiement par exemple [dev][deploiement-dev] ou [prod][deploiement-prod] (le nom étant libre), ils pourront être utilisés par le script [bin/archive.sh][bin-archive].
 - [modules/][modules] : Ce répertoire va permettre de rajouter des modules à Roundcube Mél (par exemple une page d'aide). Ces modules ne sont pas forçement liés à Roundcube Mél et peuvent être totalement indépendants.
 - [plugins/][plugins] : Ce répertoire permet de rajouter des plugins Roundcube non directement liés à l'instance Mél et non présents dans le dépot [Roundcube plugin Mél][roundcube-plugins-mel]
 - [skins/][skins] : Ce répertoire permet de rajouter des skins Roundcube non directement liées à l'instance Mél et non présentes dans le dépot [Roundcube plugin Mél][roundcube-plugins-mel]


Utilisation
-----------
#### Initialisation
Utiliser le script [bin/init.sh][bin-init] pour lancer l'initialisation des dépots et de la génération du répertoire webmail/. Une fois fait vous pouvez configurer votre virtual host Apache/Nginx pour utiliser le répertoire.

#### Mise a jour
Si jamais une mise a jour des fichiers est nécessaire, vous pouvez utiliser le script [bin/update.sh][bin-update], il va permettre de refaire la gestion des liens. Il est aussi possible de supprimer le répertoire webmail/ et de relancer le script [bin/init.sh][bin-init]

#### Archive
Pour générer une archive, il faut utiliser le script [bin/archive.sh][bin-archive] suivi d'un paramètre _<nom de déploiement>_. Une archive va alors être générée dans le répertoire [archives/][archives] contenant une instance de Roundcube Mél avec la configuration répérée du dossier deploiement/_<nom de déploiement>_


LICENSE
-------
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License (**with exceptions
for skins & plugins**) as published by the Free Software Foundation,
either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see [www.gnu.org/licenses/][gpl].

This file forms part of the Roundcube Webmail Software for which the
following exception is added: Plugins and Skins which merely make
function calls to the Roundcube Webmail Software, and for that purpose
include it by reference shall not be considered modifications of
the software.

If you wish to use this file in another project or create a modified
version that will not be part of the Roundcube Webmail Software, you
may remove the exception above and use this source code under the
original version of the license.

[gpl]:          		http://www.gnu.org/licenses/
[deploiement]: 				deploiement
[deploiement-init]: 		deploiement/init
[deploiement-init-config]: 	deploiement/init/config/config.inc.php
[deploiement-prod]: 		deploiement/prod
[deploiement-dev]: 			deploiement/dev
[modules]: 					modules
[plugins]: 					plugins
[skins]: 					skins
[archives]: 				archives
[bin-init]: 				bin/init.sh
[bin-update]: 				bin/update.sh
[bin-archive]: 				bin/archive.sh
[roundcube-mel]: 			https://github.com/messagerie-melanie2/Roundcube-Mel
[roundcube-plugins-mel]: 	https://github.com/messagerie-melanie2/Roundcube-plugins-Mel