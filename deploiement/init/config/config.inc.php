<?php

/*
 +-----------------------------------------------------------------------+
 | Local configuration for the Roundcube Webmail installation.           |
 |                                                                       |
 | This is a sample configuration file only containing the minumum       |
 | setup required for a functional installation. Copy more options       |
 | from defaults.inc.php to this file to override the defaults.          |
 |                                                                       |
 | This file is part of the Roundcube Webmail client                     |
 | Copyright (C) 2005-2013, The Roundcube Dev Team                       |
 |                                                                       |
 | Licensed under the GNU General Public License version 3 or            |
 | any later version with exceptions for skins & plugins.                |
 | See the README file for a full license statement.                     |
 +-----------------------------------------------------------------------+
*/

$config = array();

// List of active plugins (in plugins/ directory)
$config['plugins'] = array(
    'mel_logs',
    'mel',
    'mel_ldap_auth', 
    'mel_mobile',
);

// skin name: folder from skins/
$config['skin'] = 'mel_larry';

// system error reporting, sum of: 1 = log; 4 = show, 8 = trace
$config['debug_level'] = 1;
