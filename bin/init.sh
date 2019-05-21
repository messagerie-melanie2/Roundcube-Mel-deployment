#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Check webmail folder
if [ -d "$DIR/../webmail" ]; then
	echo "Le dossier webmail existe, le projet est probablement déjà initialisé"
	echo "Si besoin, supprimer le dossier webmail et relancer la commande"
	echo "Pour faire une mise a jour des liens, utiliser le script update.sh"
	exit 1
fi

mkdir "$DIR/../webmail"
cd "$DIR/../webmail"
DIRWEBMAIL="$( pwd )"
GITHUBFOLDER="$DIRWEBMAIL/../../github"

# Check github folder
if [ ! -d "$GITHUBFOLDER" ]; then
	mkdir "$GITHUBFOLDER"
fi

# Check Roundcube Mel folder
if [ ! -d "$GITHUBFOLDER/Roundcube-Mel" ]; then
	cd "$GITHUBFOLDER"
	git clone https://github.com/messagerie-melanie2/Roundcube-Mel.git
	cd "$DIRWEBMAIL"
fi

# Check Roundcube Mel plugins folder
if [ ! -d "$GITHUBFOLDER/Roundcube-plugins-Mel" ]; then
	cd "$GITHUBFOLDER"
	git clone https://github.com/messagerie-melanie2/Roundcube-plugins-Mel.git
	cd "$DIRWEBMAIL"
fi

# Roundcube Mél init repo
ln -sf "$GITHUBFOLDER/Roundcube-Mel/config" "$DIRWEBMAIL/config"
ln -sf "$GITHUBFOLDER/Roundcube-Mel/plugins" "$DIRWEBMAIL/plugins"
ln -sf "$GITHUBFOLDER/Roundcube-Mel/program" "$DIRWEBMAIL/program"
ln -sf "$GITHUBFOLDER/Roundcube-Mel/skins" "$DIRWEBMAIL/skins"
ln -sf "$GITHUBFOLDER/Roundcube-Mel/vendor" "$DIRWEBMAIL/vendor"
ln -sf "$GITHUBFOLDER/Roundcube-Mel/index.php" "$DIRWEBMAIL/index.php"
ln -sf "$GITHUBFOLDER/Roundcube-Mel/version.php" "$DIRWEBMAIL/version.php"

# Roundcube Mél plugins init repo
ln -sf "$GITHUBFOLDER/Roundcube-plugins-Mel/aide" "$DIRWEBMAIL/aide"

# Plugins
for plugin in $(ls $GITHUBFOLDER/Roundcube-plugins-Mel/plugins)
do
    ln -sf "$GITHUBFOLDER/Roundcube-plugins-Mel/plugins/$plugin" "$DIRWEBMAIL/plugins/"
done


# Skins
for skin in $(ls $GITHUBFOLDER/Roundcube-plugins-Mel/skins)
do
    ln -sf "$GITHUBFOLDER/Roundcube-plugins-Mel/skins/$skin" "$DIRWEBMAIL/skins/"
done

# Roundcube Mél Déploiement repo

# Modules
for module in $(ls $DIRWEBMAIL/../modules)
do
    ln -sf "$DIRWEBMAIL/../modules/$module" "$DIRWEBMAIL/"
done

# Plugins
for plugin in $(ls $DIRWEBMAIL/../plugins)
do
    ln -sf "$DIRWEBMAIL/../plugins/$plugin" "$DIRWEBMAIL/"
done

# Skins
for skin in $(ls $DIRWEBMAIL/../skins)
do
    ln -sf "$DIRWEBMAIL/../skins/$skin" "$DIRWEBMAIL/"
done

# Init conf
for file in $(find $DIRWEBMAIL/../deploiement/init -type f)
do
	NEW="$DIRWEBMAIL${file#$DIRWEBMAIL/../deploiement/init}";
	ln -sf "$file" "$NEW"
done

echo "Le projet est créé, vous pouvez faire pointer votre vhost vers $DIRWEBMAIL"
exit 0