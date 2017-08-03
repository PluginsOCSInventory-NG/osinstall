<?php
function plugin_version_osinstall()
{
return array('name' => 'osinstall',
'version' => '1.0',
'author'=> 'Stephane PAUTREL',
'license' => 'GPLv2',
'verMinOcs' => '2.2');
}

function plugin_init_osinstall()
{
$object = new plugins;
$object -> add_cd_entry("osinstall","software");

// Osinstall table creation

$object -> sql_query("CREATE TABLE IF NOT EXISTS `osinstall` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `HARDWARE_ID` INT(11) NOT NULL,
  `INSTDATE` VARCHAR(255) DEFAULT NULL,
  `BUILDVER` VARCHAR(255) DEFAULT NULL,
  `CODESET` VARCHAR(255) DEFAULT NULL,
  `COUNTRYCODE` VARCHAR(255) DEFAULT NULL,
  `OSLANGUAGE` VARCHAR(255) DEFAULT NULL,
  `CURTIMEZONE` VARCHAR(255) DEFAULT NULL,
  `LOCALE` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY  (`ID`,`HARDWARE_ID`)
) ENGINE=INNODB ;");

}

function plugin_delete_osinstall()
{
$object = new plugins;
$object -> del_cd_entry("osinstall");

$object -> sql_query("DROP TABLE `osinstall`;");

}

?>