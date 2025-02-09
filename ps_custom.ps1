function tcdp { 
    $path = Join-Path -Path $PSScriptRoot -ChildPath "../projects/python"
    Set-Location $path
}

function venv {
    $venvPath = Join-Path -Path $PSScriptRoot -ChildPath "./venv/Scripts/Activate.ps1" 
    if (Test-Path $venvPath) {
        . $venvPath
    }
}

function show_tree {
    param (
        [string]$Path = ".",
        [string[]]$ExcludeExtensions = @(".ps1", ".psd1", ".psm1"),
        [string[]]$ExcludeDirectories = @("node_modules", ".git", "bin", "obj", "__pycache__", 
        ".github", ".mypy_cache", ".pytest_cache", ".vscode", "build", "dist", "docs", "logs", "tests")
    )

    # Display the starting path
    Write-Output $Path

    # Declare the internal recursive function: Accept the current path and prefix to output the tree structure
    function Write-Tree {
        param (
            [string]$CurrentPath,
            [string]$Prefix
        )

        # Get the items of the current directory (include directories and files)
        $items = Get-ChildItem -LiteralPath $CurrentPath | `
                 Sort-Object -Property @{Expression = {$_.PSIsContainer}; Descending = $true}, Name

        # Filter the items to exclude: Apply ExcludeDirectories to directories, and ExcludeExtensions to files
        $filteredItems = $items | Where-Object {
            if ($_.PSIsContainer) {
                -not ($ExcludeDirectories -contains $_.Name)
            } else {
                -not ($ExcludeExtensions -contains $_.Extension)
            }
        }

        $count = $filteredItems.Count
        for ($i = 0; $i -lt $count; $i++) {
            $item   = $filteredItems[$i]
            $isLast = ($i -eq $count - 1)
            $branch = if ($isLast) { "└── " } else { "├── " }
            
            # Use the subexpression $($item.Name) to correctly output the file/directory name
            Write-Output "$Prefix$branch$($item.Name)"

            if ($item.PSIsContainer) {
                # Set the prefix for the next level: Add a vertical line for the last item, and add a space for the other items
                $newPrefix = if ($isLast) { "$Prefix    " } else { "$Prefix│   " }
                Write-Tree -CurrentPath $item.FullName -Prefix $newPrefix
            }
        }
    }

    Write-Tree -CurrentPath $Path -Prefix ""
}
