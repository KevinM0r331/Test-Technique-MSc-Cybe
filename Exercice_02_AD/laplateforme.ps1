# 1. Installation des outils AD DS
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

# 2. Création de la forêt (Promotion du serveur)
# On définit le mot de passe de restauration (DSRM)
$password = ConvertTo-SecureString "Azerty_2025!" -AsPlainText -Force

Install-ADDSForest -DomainName "laplateforme.io" `
                   -DomainNetbiosName "LAPLATEFORME" `
                   -InstallDns:$true `
                   -SafeModeAdministratorPassword $password `
                   -Force:$true