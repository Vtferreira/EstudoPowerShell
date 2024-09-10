#Get-ChildItem -Recurse -File | Select-Object Name
 gci -Recurse -File | Select-Object Name | Where-Object { $_-like "*_*"}