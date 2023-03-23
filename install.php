<?php
/**
 * The following functions are used by the extension engine to generate a new table
 * for the plugin / destroy it on removal.
 */


/**
 * This function is called on installation and is used to 
 * create database schema for the plugin
 */
function extension_install_dcustate()
{
    $commonObject = new ExtensionCommon;
	$commonObject -> sqlQuery("DROP TABLE IF EXISTS `dcustate`;");
    $commonObject -> sqlQuery(
        "CREATE TABLE `dcustate` (
        `ID` INTEGER NOT NULL AUTO_INCREMENT, 
        `HARDWARE_ID` INTEGER NOT NULL,
		`DATE` VARCHAR(255) DEFAULT NULL,
        `TYPE` VARCHAR(255) DEFAULT NULL,
        `NAME` VARCHAR(255) DEFAULT NULL,
		`URGENCY` VARCHAR(255) DEFAULT NULL,
        PRIMARY KEY (`ID`, `HARDWARE_ID`)
        ) ENGINE=INNODB;"
    );
}

/**
 * This function is called on removal and is used to 
 * destroy database schema for the plugin
 */
function extension_delete_dcustate()
{
    $commonObject = new ExtensionCommon;
    $commonObject -> sqlQuery("DROP TABLE IF EXISTS `dcustate`");
}

/**
 * This function is called on plugin upgrade
 */
function extension_upgrade_dcustate()
{

}

?>