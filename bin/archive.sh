#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Check webmail folder
if [ ! -d "$DIR/../webmail" ]; then
	echo "Le dossier webmail n'existe pas, vous devez d'abord initialiser le projet avec le script init.sh"
	exit 3
fi

# Check archives folder
if [ ! -d "$DIR/../archives" ]; then
	mkdir "$DIR/../archives"
fi

if [ "$#" != "1" ]; then
	echo "Usage $0 <deploiement>"
  	exit 1
fi

if ! type composer > /dev/null; then
	echo "Cette commande nécessite composer (voir https://getcomposer.org/download/)"
	exit 2  
fi

TYPE=$1
MY_PATH="`dirname \"$0\"`"              # relative
MY_PATH="`( cd \"$MY_PATH/..\" && pwd )`"  # absolutized and normalized
VERSION="`./bin/read_version.php`" # read version from php
if [ -z "$MY_PATH" ] ; then
	# error; for some reason, the path is not accessible
	# to the script (e.g. permissions re-evaled after suid)
	echo "Le chemin $MY_PATH n'existe pas"
	exit 3  # fail
fi

mkdir "$MY_PATH"/archives/webmail_"$TYPE"_"$VERSION"
cp -Lr "$MY_PATH"/webmail "$MY_PATH"/archives/webmail_"$TYPE"_"$VERSION"/webmail
cp -R "$MY_PATH"/deploiement/"$TYPE"/* "$MY_PATH"/archives/webmail_"$TYPE"_"$VERSION"/webmail/
cd "$MY_PATH"/archives/webmail_"$TYPE"_"$VERSION"/webmail/

# For github remove all config files
if [ "$TYPE" == "github" ]; then
	find . -type f -name "config.inc.php" -exec rm -f {} \;
	rm -rf aide
	rm -rf changepassword
	rm -rf fic
	rm -rf public
	rm -rf services
	rm -f google6f1323955b991ee1.html
	rm -f robots.txt
fi

composer install --no-dev --optimize-autoloader

cd ..
tar zcf "$MY_PATH"/archives/webmail_"$TYPE"_"$VERSION".tar.gz webmail/
rm -rf "$MY_PATH"/archives/webmail_"$TYPE"_"$VERSION"
cd "$MY_PATH"
git tag -a archive_"$TYPE"_"$VERSION" -m "Archive $TYPE Version $VERSION Build $MY_DATE"

exit 0