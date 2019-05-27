#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd "$DIR/../webmail"
DIRWEBMAIL="$( pwd )"

# Roundcube Mél init repo
ln -sf "$DIRWEBMAIL/../../github/Roundcube-Mel/config" "$DIRWEBMAIL/"
ln -sf "$DIRWEBMAIL/../../github/Roundcube-Mel/plugins" "$DIRWEBMAIL/"
ln -sf "$DIRWEBMAIL/../../github/Roundcube-Mel/program" "$DIRWEBMAIL/"
ln -sf "$DIRWEBMAIL/../../github/Roundcube-Mel/skins" "$DIRWEBMAIL/"
ln -sf "$DIRWEBMAIL/../../github/Roundcube-Mel/vendor" "$DIRWEBMAIL/"
ln -sf "$DIRWEBMAIL/../../github/Roundcube-Mel/index.php" "$DIRWEBMAIL/index.php"
ln -sf "$DIRWEBMAIL/../../github/Roundcube-Mel/version.php" "$DIRWEBMAIL/version.php"

# Roundcube Mél plugins init repo
ln -sf "$DIRWEBMAIL/../../github/Roundcube-plugins-Mel/aide" "$DIRWEBMAIL/"
ln -sf "$DIRWEBMAIL/../../github/Roundcube-plugins-Mel/public" "$DIRWEBMAIL/"
ln -sf "$DIRWEBMAIL/../../github/Roundcube-plugins-Mel/services" "$DIRWEBMAIL/"
ln -sf "$DIRWEBMAIL/../../github/Roundcube-plugins-Mel/login.php" "$DIRWEBMAIL/login.php"

# Plugins
for plugin in $(ls $DIRWEBMAIL/../../github/Roundcube-plugins-Mel/plugins)
do
    ln -sf "$DIRWEBMAIL/../../github/Roundcube-plugins-Mel/plugins/$plugin" "$DIRWEBMAIL/plugins/"
done


# Skins
for skin in $(ls $DIRWEBMAIL/../../github/Roundcube-plugins-Mel/skins)
do
    ln -sf "$DIRWEBMAIL/../../github/Roundcube-plugins-Mel/skins/$skin" "$DIRWEBMAIL/skins/"
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

echo "Le projet est mise a jour, vous pouvez faire pointer votre vhost vers $DIRWEBMAIL"
exit 0