#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd "$DIR/../webmail"
DIRWEBMAIL="$( pwd )"

# Roundcube Mél init repo
ln -sf "$DIRWEBMAIL/../../github/Roundcube-Mel/config" "$DIRWEBMAIL/config"
ln -sf "$DIRWEBMAIL/../../github/Roundcube-Mel/plugins" "$DIRWEBMAIL/plugins"
ln -sf "$DIRWEBMAIL/../../github/Roundcube-Mel/program" "$DIRWEBMAIL/program"
ln -sf "$DIRWEBMAIL/../../github/Roundcube-Mel/skins" "$DIRWEBMAIL/skins"
ln -sf "$DIRWEBMAIL/../../github/Roundcube-Mel/vendor" "$DIRWEBMAIL/vendor"
ln -sf "$DIRWEBMAIL/../../github/Roundcube-Mel/index.php" "$DIRWEBMAIL/index.php"
ln -sf "$DIRWEBMAIL/../../github/Roundcube-Mel/version.php" "$DIRWEBMAIL/version.php"

# Roundcube Mél plugins init repo
ln -sf "$DIRWEBMAIL/../../github/Roundcube-plugins-Mel/aide" "$DIRWEBMAIL/aide"

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