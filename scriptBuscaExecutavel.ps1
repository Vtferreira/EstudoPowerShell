param($tipoDeExportacao)
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

$resultado = 
gci -Recurse -File |
  ? Name -Like "*.exe" |
  select $params


if ($tipoDeExportacao -eq "HTML") {
  <# Action to perform if the condition is true #>
  $estilos = Get-Content styles.css
  #$styleTag = "<style>" + $estilos + "</style>"
  $styleTag = "<style> $estilos </style>" 
  $tituloPagina = "Relatorio de Executáveis"
  $tituloBody = "<h1> $tituloPagina </h1>"

  $resultado | 
      ConvertTo-Html -Head $styleTag -Title $tituloPagina -Body $tituloBody|
      Out-File relatorio.html
} elseif ($tipoDeExportacao -eq "JSON") {
  $resultado |
    ConvertTo-Json |
    Out-File relatorio.json
  <# Action when this condition is true #>
} elseif ($tipoDeExportacao -eq "CSV") {
  $resultado |
    ConvertTo-Csv -NoTypeInformation -Delimiter "1"|
    Out-File relatorio.csv
  <# Action when this condition is true #>
}
