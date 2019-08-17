<#
   Add left padding and top padding
#>
function Get-ShapeRectangle {
    [CmdletBinding(DefaultParameterSetName='Standard',PositionalBinding=$false)]
    param (
        [ValidateRange(3,120)]
        [Parameter(Mandatory = $false)]
        [int16] $Height = 5,

        [ValidateRange(3,120)]
        [Parameter(Mandatory = $false)]
        [int16] $Width = 50,

        [ValidateRange(0,120)]
        [Parameter(Mandatory = $false)]
        [int16] $MarginTop = 0,

        [ValidateRange(0,120)]
        [Parameter(Mandatory = $false)]
        [int16] $MarginBottom = 0,

        [ValidateRange(0,100)]
        [Parameter(Mandatory = $false)]
        [int16] $MarginLeft = 0,

        [Parameter(Mandatory = $false)]
        [string] $ShapeChar = '*',

        [ValidateLength(1,115)]
        [Parameter(ParameterSetName='Embed',Mandatory=$true)]
        [string] $EmbedText,

        [ValidateSet('Left','Right','Center')]
        [Parameter(ParameterSetName='Embed',Mandatory=$false)]
        [string] $JustifyText = 'Left'

    )

    if ($EmbedText) {
        [int16] $centerFromTop = [math]::Round($Height / 2)
    }
    # Top Margin
    for ($i = 0; $i -lt $MarginTop; $i++) {
        @(' ' * $Width)
    }

    # Draw Shape
    (' ' * $MarginLeft) + $ShapeChar * $Width
    for ($i = 1; $i -lt ($Height - 1); $i++) {
        if ($EmbedText -and ($i -eq $centerFromTop)) {
            switch ($JustifyText) {
                'Left'  { (' ' * $MarginLeft) + $ShapeChar + ' ' + $EmbedText + (' ' * ($Width - $EmbedText.Length - 3)) + $ShapeChar }
                'Right' { (' ' * $MarginLeft) + $ShapeChar + (' ' * ($Width - $EmbedText.Length - 3)) + $EmbedText + ' ' + $ShapeChar }
                Default {}
            }
            
        }
        else {
            (' ' * $MarginLeft) + $ShapeChar + (' ' * ($Width - 2)) + $ShapeChar
        }
    }
    (' ' * $MarginLeft) + $ShapeChar * $Width

    # Bottom Margin
    for ($i = 0; $i -lt $MarginBottom; $i++) {
        @(' ' * $Width)
    }
}

function Join-Shape {
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