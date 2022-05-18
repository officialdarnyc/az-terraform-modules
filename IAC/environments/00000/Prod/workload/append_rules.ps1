$parser = New-Object Web.Script.Serialization.JavaScriptSerializer

function Read-Json([string] $source_file, [string] $default)
{
    try {
        $source_content = Get-Content $source_file
        $source_content = "{ `"content`" : $source_content } "
        return $parser.DeserializeObject($source_content).content
    } catch {
        Write-Host "Error occurred while processing ${source_file}. Returning default."
        $source_content = $default
        $source_content = "{ `"content`" : $source_content } "
        return $parser.DeserializeObject($source_content).content
    }
}

$key = $args[0]
$source_file = $args[1]
$target_file = $args[2]

$source_json = Read-Json $source_file "[]"
$target_json = Read-Json $target_file "{}"

if ($target_json.$key -eq $null)
{
    $target_json.Add($key, $source_json)
}
else
{
    $target_json.$key = $source_json
}

$parser.Serialize($target_json) | set-content $target_file
