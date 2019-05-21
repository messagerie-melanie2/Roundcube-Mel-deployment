#!/usr/bin/env php
<?php

include __DIR__ . '/../webmail/version.php';

if (isset($argv) && count($argv) == 2) {
    if ($argv[1] == 'version') {
        echo Version::VERSION;
        exit;
    }
    else if ($argv[1] == 'build') {
        echo Version::BUILD;
        exit;
    }
    else if ($argv[1] == 'all') {
        echo Version::VERSION . '_' . Version::BUILD;
        exit;
    }
}
echo Version::VERSION . '_' . Version::BUILD;
exit;