<#
   Add left padding and top padding
#>
function Get-ShapeArray {
    param (
        [ValidateSet('Circle','Rectangle')]
        [Parameter(Mandatory = $true)]
        [string] $Type,

        [ValidateRange(3,120)]
        [Parameter(Mandatory = $false)]
        [int16] $Height = 10,

        [ValidateRange(3,120)]
        [Parameter(Mandatory = $false)]
        [int16] $Width = 10,

        [ValidateRange(0,120)]
        [Parameter(Mandatory = $false)]
        [int16] $MarginTop = 0,

        [ValidateRange(0,100)]
        [Parameter(Mandatory = $false)]
        [int16] $MarginLeft = 0,

        [Parameter(Mandatory = $false)]
        [string] $ShapeChar = '*'

    )
    if ($Type -eq 'Rectangle') {
        (' ' * $MarginLeft) + $ShapeChar * $Width
        for ($i = 1; $i -lt ($Height - 1); $i++) {
            (' ' * $MarginLeft) + $ShapeChar + (' ' * ($Width - 2)) + $ShapeChar
        }
        (' ' * $MarginLeft) + $ShapeChar * $Width
    }
}

function Join-ShapeArray {
    param (
        [array] $Left,
        [array] $Right,
        [int16] $Spacing = 1
    )
    
    $biggerIndex = [Math]::Max($Left.count, $Right.Count)
    for ($i = 0; $i -lt $biggerIndex; $i++) {
        $Left[$i] + (' ' * $Spacing) + $Right[$i]
    }
}