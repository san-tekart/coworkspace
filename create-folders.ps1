# Set the path to create the folders
$basePath = (Get-Location).Path


# Define the folder structure
$folders = @(
    "docs",
    "notes\01_Personal",
    "notes\01_Personal\Goals",
    "notes\01_Personal\Journal",
    "notes\03_Learning",
    "notes\03_Learning\Programming",
    "notes\03_Learning\Programming\Python",
    "notes\03_Learning\Languages",
    "notes\03_Learning\Languages\English",
    "notes\03_Learning\Languages\Japanese",
    "notes\templates",
    "notes\archive",
    "projects",
    "projects\ProjectA"
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
