<?php

/**
 * This function is called on installation and is used to create database schema for the plugin
 */
function extension_install_osinstall()
{
    $commonObject = new ExtensionCommon;

    $commonObject -> sqlQuery("CREATE TABLE IF NOT EXISTS `osinstall` (
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

/**
 * This function is called on removal and is used to destroy database schema for the plugin
 */
function extension_delete_osinstall()
{
    $commonObject = new ExtensionCommon;
    $commonObject -> sqlQuery("DROP TABLE `osinstall`;");
}

/**
 * This function is called on plugin upgrade
 */
function extension_upgrade_osinstall()
{

}
