###############################################################################
## OCSINVENTORY-NG
## Copyleft Léa DROGUET 2020
## Web : http://www.ocsinventory-ng.org
##
## Exemple repris et modifié par Yoann LECLERC pour le plugin WUSTATE
## This code is open source and may be copied and modified as long as the source
## code is always made freely available.
## Please refer to the General Public Licence http://www.gnu.org/ or Licence.txt
################################################################################

package Apache::Ocsinventory::Plugins::Dcustate::Map;
 
use strict;
 
use Apache::Ocsinventory::Map;
$DATA_MAP{dcustate} = {
   mask => 0,
   multi => 1,
   auto => 1,
   delOnReplace => 1,
   sortBy => 'DATE',
   writeDiff => 0,
   cache => 0,
   fields => {
      DATE => {},
      TYPE => {},
      NAME => {},
      URGENCY => {}
	}
};
1;