# Script d'importation des utilisateurs pour l'exercice AD

# 1. Variables
$csvPath = "C:\users.csv"
$domain = "laplateforme.io"
# Mot de passe sécurisé imposé par l'énoncé
$password = ConvertTo-SecureString "Azerty_2025!" -AsPlainText -Force

# 2. Lecture du CSV
Write-Host "Lecture du fichier CSV en cours..." -ForegroundColor Cyan
$users = Import-Csv -Path $csvPath -Delimiter "," -Encoding Default

foreach ($user in $users) {
    # 3. Construction des attributs
    # Login format: p.nom (ex: m.alexandre)
    $samAccountName = ($user.prénom.Substring(0,1) + "." + $user.nom).ToLower()
    $fullName = $user.prénom + " " + $user.nom
    $upn = "$samAccountName@$domain"

    # 4. Création de l'utilisateur
    try {
        # L'option -ChangePasswordAtLogon $true force le changement au 1er login
        New-ADUser -Name $fullName `
                   -SamAccountName $samAccountName `
                   -GivenName $user.prénom `
                   -Surname $user.nom `
                   -UserPrincipalName $upn `
                   -AccountPassword $password `
                   -Enabled $true `
                   -ChangePasswordAtLogon $true `
                   -Path "CN=Users,DC=laplateforme,DC=io" `
                   -ErrorAction Stop
        
        Write-Host "[OK] Utilisateur créé : $fullName ($samAccountName)" -ForegroundColor Green
    }
    catch {
        Write-Host "[INFO] L'utilisateur $fullName existe déjà ou erreur." -ForegroundColor Yellow
    }

    # 5. Gestion des groupes (Colonnes groupe1 à groupe6)
    $groups = @($user.groupe1, $user.groupe2, $user.groupe3, $user.groupe4, $user.groupe5, $user.groupe6)
    
    foreach ($g in $groups) {
        if (-not [string]::IsNullOrWhiteSpace($g)) {
            # Créer le groupe s'il n'existe pas
            try {
                if (-not (Get-ADGroup -Filter {Name -eq $g})) {
                    New-ADGroup -Name $g -GroupScope Global -Path "CN=Users,DC=laplateforme,DC=io"
                    Write-Host "   -> Groupe créé : $g" -ForegroundColor Cyan
                }
                # Ajouter l'utilisateur au groupe
                Add-ADGroupMember -Identity $g -Members $samAccountName -ErrorAction SilentlyContinue
                Write-Host "   -> Ajouté au groupe $g"
            }
            catch {
                Write-Host "   -> Erreur sur le groupe $g" -ForegroundColor Red
            }
        }
    }
}
Write-Host "Terminé !" -ForegroundColor Green