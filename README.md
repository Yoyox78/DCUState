Wustate

C'est un plugin permettant de remonter les kb qui non pas encore était installé avec un message OK ou NOK pour simplifier la recherche dans le multicritère et indique si le poste à besoin de restart ou non

1er colonne : date

2eme colonne : 
OK: si aucune KB n'est trouvé
NOK: si des KB sont trouvé

3eme colone :
reboot
true : en attente de reboot
false : n'est pas en attente de reboot

4eme colonne : 
les KB concernées en attente d'installation ou de download et installation


Je supprime les doublons pour eviter d'avoir la même KB affichées plusieurs fois
Je me base sur le plugin WindowsUpdate de powershell galaxy

**Webconsole related files :**

The following files allow a new extension to be displayed on the web console, creating the corresponding table(s), hooks, and functionalities.

* install.php > Creates a new plugin table in OCS database / destroys it on removal of the plugin.
* infos.json > Stores general informations about plugin, such as name, author, version, etc. These will be displayed on https://plugins.ocsinventory-ng.org/.
* hook.xml > Creates a new hook which lets OCS know a new plugin has been installed and new data should be displayed on the web console. It can create computer details entries or menu / sub-menu. Languages are also managed from there.
* cd_xxxxx > Naming convention requires the file's name to begin with "cd_" ("cd" stands for "computer details"). Detailed informations can be found in hook.xml.
* ms_xxxxx > Naming convention requires the file's name to begin with "ms_" ("ms" stands for "main section"). Detailed informations can be found in hook.xml.


**Communication server related files :**

These files are required when something is needed from the agent (e.g. reporting of new data), they can be omitted if the extension doesn't require anything from the agent.

* APACHE > Map.pm > Link file between communication server and database.
* APACHE > plugin_ex.conf > Require the server to load Map.pm file from plugin

**Misc :** 

Other files such as README, license, agent files ...

* agent > This folder is only used to store the agent scripts, it is not required on the server's side. 

