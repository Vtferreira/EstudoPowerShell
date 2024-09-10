#Get-ChildItem -Recurse -File | Select-Object Name
#gci -Recurse -File | Select-Object Name | Where-Object { $_-like "*_*"}
#gci -Recurse -File | Where-Object Name -Like "*_*" | Select-Object Name, Length

#400055594 / 1024 / 1024 / 1024
#400055594 / 1GB
#(400055594 / 1GB).GetType().Name
#(400055594 / 1GB).ToString("N2")
#(4000555946768678 / 1GB).ToString("N2") + "GB"

#"{0:N2} GB" -f (400055594 / 1GB)

#Usando script Blocks com Selecto Object
gci -Recurse -File | Where-Object Name -Like "*_*" | Select-Object Name, { "{0:N2}KB" -f ($_.Length / 1KB)}
# Usando Alias e Quebrando linhas usando backchick `
gci -Recurse -File `
| ? Name -Like "*_*" `
| select `
    Name, `
     { "{0:N2}KB" -f ($_.Length / 1KB)} 

$nameExpr = "Name"
$lengthExpr = {"{0:N2}KB" -f ($_.Length / 1KB)}
$params = $nameExpr, $lengthExpr

gci -Recurse -File |
    ? Name -Like "*_*" |
    select $params

# Aqui criamos um hashtable para a coluna de nome
$nameExpr = @{
    Label = "Nome";
    Expression = { $_.Name}
}

$lengthExpr = @{
    Label = "Tamanho";
    Expression = { "{0:N2}KB" -f ($_.Length / 1KB) }
}

$params = $nameExpr, $lengthExpr

gci -Recurse -File |
    ? Name -Like "*.exe" |
    select $params