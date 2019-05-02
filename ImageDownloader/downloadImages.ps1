$image_formats = @(".png", ".jpg", ".jpeg")
$urls = @()
$url = ""

$eh_arquivo = Read-Host -Prompt "Para digitar urls digite [u], para apontar um arquivo digite [a] (U|a)"
if ($eh_arquivo -eq "a"){
    $arquivo = Read-Host -Prompt "caminho do arquivo."
    $urls = Get-Content $arquivo
}else{
    Write-Host "Digite uma url e precione [enter], para terminar a lista precione [q]"
    while($true){
        $url = Read-Host -Prompt 'URL.'
        if ($url -eq "q"){
            break;
        }
        $urls+= $url
    }
}
$image_name = ""
foreach($url in $urls){
    $url_parts = $url.Split("/")
    foreach($url_part in $url_parts){
        foreach($image_format in $image_formats){
            if ($url_part.Contains($image_format)){
                $image_name = $url_part
            }
        }
    }
    if ($image_name -eq ""){
        Write-Host "Nome da imagem nao localizado na url"
        continue
    }
    Invoke-WebRequest $url -OutFile $image_name -ErrorAction SilentlyContinue
    Write-Host $image_name
}