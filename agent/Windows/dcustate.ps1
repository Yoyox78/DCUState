# !!!!! ATTENTION !!!!!! Pour pouvoir utiliser le script, il faut installer le programme dell command update, pas la version universelle car elle ne contient pas le cli

# variable dossier temp
$tempfolder = "C:\OCSPluginTemp"

# Il existe 2 chemin possible, je verifie les deux et si aucun n'existe je quitte le script, l'utilisateur n'a pas DCU 
if(Test-Path 'C:\Program Files (x86)\Dell\CommandUpdate')
{
    $chemin = "C:\Program Files (x86)\Dell\CommandUpdate"
}
elseif(Test-Path 'C:\Program Files\Dell\CommandUpdate')
{
    $chemin = "C:\Program Files\Dell\CommandUpdate"
}
else
{
    Exit
}

# Je recupere le process si il est en cours
$process = Get-Process -Name DellCommandUpdate -ErrorAction SilentlyContinue

# Je le kill sinon je ne pourrais pas lancer la commande
if ($process -ne $null)
{
    stop-process -id $process.id
}

#dans tous les cas je crée le dossier temps
#New-Item $tempfolder -itemType Directory -Confirm:$false -ErrorAction SilentlyContinue 

# je lance la commande DCU pour voir tous les telechargement en attente, je le fais avec invoke-expression car comme DCU lance une nouvelle fenetre le client ocs noté tout dans le fichier, ce qui empecher le retour du xml de fonctionner
# avec invoke-expression le resultat est mis dans la variable $null, ca on veut pas le retour de DCU
# Pour faire simple le client ocs note dans le fichier xml tout ce qui peut paraitre dans la console lors de l'execution, il faut donc bien faire attention
#cd $chemin ; .\dcu-cli.exe /scan -report="$tempfolder" 
#Start-Process -FilePath "$chemin\dcu-cli.exe" -ArgumentList "/scan -report=${tempfolder}" -Wait -LoadUserProfile:$false -WindowStyle Hidden| Out-Null
$null = Invoke-Expression " & '$chemin\dcu-cli.exe' /scan -report=${tempfolder}"

# Je met le resultat dans une variable XML
[xml]$xmldata = Get-Content -Path "$tempfolder\DCUApplicableUpdates.xml"

# Je vais dans la partie des MAJ
$xmldatatab = $xmldata.updates.update

# Je nettoie la variable
clear-variable -Name "xml" -ErrorAction SilentlyContinue

#Je déclare la variable vide
$xml = ""

# Si il n'y a pas de MAJ alors on crée un tableau vide, cela permet de voir qu'il n'y en a pas,  pour ne pas pensez qu'il y a un problème
if ( $xmldatatab -eq $null )
{
    $xml = "<DCUSTATE>`n"
    $xml += "<DATE>$(Get-Date -Format "dd/MM/yyyy_HH:mm")</DATE>`n"
    $xml += "<TYPE></TYPE>`n"
    $xml += "<NAME></NAME>`n"
    $xml += "<URGENCY></URGENCY>`n"
    $xml += "</DCUSTATE>`n"
}
else
{
    #je crée le XML avec les donnees
    foreach($i in $xmldatatab)
    {
        $xml += "<DCUSTATE>`n"
        $xml += "<DATE>$(Get-Date -Format "dd/MM/yyyy_HH:mm")</DATE>`n"
        $xml += "<TYPE>" + $i.type + "</TYPE>`n"
        $xml += "<NAME>" + $i.name + "</NAME>`n"
        $xml += "<URGENCY>" + $i.urgency + "</URGENCY>`n"
        $xml += "</DCUSTATE>`n"
    }
}

# Je renvoi le contenue du XML dans la console 
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::WriteLine($xml)

Remove-Item -Path "$tempfolder\DCUApplicableUpdates.xml" -Force -Confirm:$false