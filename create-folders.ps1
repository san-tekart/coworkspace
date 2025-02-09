# Set the path to create the folders
$basePath = (Get-Location).Path


# Define the folder structure
$folders = @(
    "01_Personal",
    "01_Personal\Goals",
    "01_Personal\Journal",
    "02_\Projects",
    "02_\Projects\ProjectA",
    "03_Learning",
    "03_Learning\Programming",
    "03_Learning\Programming\Python",
    "03_Learning\Languages",
    "03_Learning\Languages\English",
    "03_Learning\Languages\Japanese",
    "Templates",
    "Archive"
)

# Create the folders
foreach ($folder in $folders) {
    $fullPath = Join-Path -Path $basePath -ChildPath $folder

    if (-not (Test-Path -Path $fullPath)) {
        New-Item -Path $fullPath -ItemType Directory | Out-Null
        Write-Host "Created folder: $fullPath"
    } else {
        Write-Host "Folder already exists: $fullPath"
    }
}

Write-Host "Folder structure created."
