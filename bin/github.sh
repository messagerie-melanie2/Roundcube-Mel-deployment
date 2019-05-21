#!/bin/bash
# Config

# Chemin relatif du dépot git Roundcube vers les dépots github
GITHUB_RELATIVE_PATH="../../../../../github"

# Liste des dossiers/fichiers Roundcube à pousser sur le dépot github
ROUNDCUBE_FILES_LIST=( bin config public program vendor index.php composer.json composer.json-dist composer.lock version.php )
ROUNDCUBE_PLUGINS_FILES_LIST=( acl additional_message_headers archive attachment_reminder autologon database_attachments debug_logger emoticons enigma example_addressbook filesystem_attachments help hide_blockquote http_authentication identicon identity_select jqueryui krb_authentication managesieve markasjunk newmail_notifier new_user_dialog new_user_identity password redundant_attachments show_additional_headers squirrelmail_usercopy subscriptions_option userinfo vcard_attachments virtuser_file virtuser_query zipdownload )

# Liste des plugins Melanie2 à mettre dans le dépot Roundcube-Plugins-Melanie2
MELANIE2_PLUGINS_LIST=( melanie2 melanie2_logs melanie2_acl )

# Liste des plugins qui ont directement un dépot github (plugin:depot_github)
#OTHERS_GITHUB_PLUGINS=( calendar:roundcube_calendar libcalendaring:Roundcube-Plugin-Libcalendaring )


# Checks
if [ "$#" != "0" ]; then
	echo "Usage $0"
	exit 1
fi

if ! type composer > /dev/null; then
	echo "Cette commande nécessite composer (voir https://getcomposer.org/download/)"
	exit 2  
fi


# Variables
MY_PATH="`dirname \"$0\"`"              # relative
MY_PATH="`( cd \"$MY_PATH/..\" && pwd )`"  # absolutized and normalized
VERSION="`./bin/read_version.php version`" # read version from php
BUILD="`./bin/read_version.php build`" # read build from php
if [ -z "$MY_PATH" ] ; then
	# error; for some reason, the path is not accessible
	# to the script (e.g. permissions re-evaled after suid)
	echo "Le chemin $MY_PATH n'existe pas"
	exit 3  # fail
fi

# Execution
echo "Création de "$MY_PATH"/archives/webmail_github_"$VERSION""
mkdir "$MY_PATH"/archives/webmail_github_"$VERSION"
cp -r "$MY_PATH"/webmail "$MY_PATH"/archives/webmail_github_"$VERSION"/
cd "$MY_PATH"/archives/webmail_github_"$VERSION"/webmail
ARCHIVE="$MY_PATH"/archives/webmail_github_"$VERSION"/webmail
composer install --no-dev --optimize-autoloader
# Supprimer les fichiers de configuration
find "$MY_PATH"/archives/webmail_github_"$VERSION" -name "config.inc.php" -delete

# Parcours les fichiers Roundcube
if [ -n "$ROUNDCUBE_FILES_LIST" ]; then
	echo "Traitement de Roundcube-Melanie2"
	for rcfile in ${ROUNDCUBE_FILES_LIST[@]}; do
		echo "Déplacement de "$ARCHIVE"/"$rcfile" vers "$GITHUB_RELATIVE_PATH"/Roundcube-Melanie2/""$rcfile"
		cp -rf "$ARCHIVE"/"$rcfile" "$ARCHIVE"/"$GITHUB_RELATIVE_PATH"/Roundcube-Melanie2/
	done
	for rcpluginsfile in ${ROUNDCUBE_PLUGINS_FILES_LIST[@]}; do
		echo "Déplacement de "$ARCHIVE"/plugins/"$rcpluginsfile" vers "$GITHUB_RELATIVE_PATH"/Roundcube-Melanie2/plugins/""$rcpluginsfile"
		cp -rf "$ARCHIVE"/plugins/"$rcpluginsfile" "$ARCHIVE"/"$GITHUB_RELATIVE_PATH"/Roundcube-Melanie2/plugins/
	done
	cd "$ARCHIVE"/"$GITHUB_RELATIVE_PATH"/Roundcube-Melanie2/
	git add -A
	git commit -a -m "Version $VERSION Build $BUILD"
	git tag -a v"$VERSION" -m "Version $VERSION Build $BUILD"
	cd "$MY_PATH"/archives/webmail_github_"$VERSION"/webmail
fi

# Parcours les plugins Melanie2
if [ -n "$MELANIE2_PLUGINS_LIST" ]; then
	echo "Traitement des plugins Melanie2"
	for m2plugin in ${MELANIE2_PLUGINS_LIST[@]}; do
		echo "Déplacement de "$ARCHIVE"/plugins/"$m2plugin" vers "$GITHUB_RELATIVE_PATH"/Roundcube-Plugins-Melanie2/""$m2plugin"
		cp -rf "$ARCHIVE"/plugins/"$m2plugin" "$ARCHIVE"/"$GITHUB_RELATIVE_PATH"/Roundcube-Plugins-Melanie2/
	done
	cd "$ARCHIVE"/"$GITHUB_RELATIVE_PATH"/Roundcube-Plugins-Melanie2/
	git add -A
	git commit -a -m "Version $VERSION Build $BUILD"
	git tag -a v"$VERSION" -m "Version $VERSION Build $BUILD"
	cd "$MY_PATH"/archives/webmail_github_"$VERSION"/webmail
fi

# Parcours les autres plugins github
if [ -n "$OTHERS_GITHUB_PLUGINS" ]; then
	echo "Traitement des autres plugins github"
	for github_plugin in ${OTHERS_GITHUB_PLUGINS[@]}; do
		arrIN=(${github_plugin//:/ })
		echo "Déplacement de "$ARCHIVE"/plugins/"${arrIN[0]}" vers "$GITHUB_RELATIVE_PATH"/""${arrIN[1]}"
		cp -R "$ARCHIVE"/plugins/"${arrIN[0]}"/* "$ARCHIVE"/"$GITHUB_RELATIVE_PATH"/"${arrIN[1]}"/
		cd "$ARCHIVE"/"$GITHUB_RELATIVE_PATH"/"${arrIN[1]}"/
		git add -A
		git commit -a -m "Version $VERSION Build $BUILD"
		git tag -a v"$VERSION" -m "Version $VERSION Build $BUILD"
	done
	cd "$MY_PATH"/archives/webmail_github_"$VERSION"/webmail
fi

# Fin de traitement
cd "$MY_PATH"
rm -rf "$MY_PATH"/archives/webmail_github_"$VERSION"/
echo "Done."
