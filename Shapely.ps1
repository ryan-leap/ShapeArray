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
        [string] $TextEmbed,

        [ValidateSet('Left','Right','Center')]
        [Parameter(ParameterSetName='Embed',Mandatory=$false)]
        [string] $TextJustify = 'Left'

    )

    if ($TextEmbed) {
        [int16] $centerFromTop = [math]::Ceiling($Height / 2)
    }
    # Top Margin
    for ($i = 0; $i -lt $MarginTop; $i++) {
        @(' ' * $Width)
    }

    # Draw Shape
    (' ' * $MarginLeft) + $ShapeChar * $Width
    for ($i = 0; $i -lt ($Height-2); $i++) {
        if ($TextEmbed -and ($i -eq ($centerFromTop-2))) {
            switch ($TextJustify) {
                'Left'   { (' ' * $MarginLeft) + $ShapeChar + ' ' + $TextEmbed + (' ' * ($Width - $TextEmbed.Length - 3)) + $ShapeChar }
                'Right'  { (' ' * $MarginLeft) + $ShapeChar + (' ' * ($Width - $TextEmbed.Length - 3)) + $TextEmbed + ' ' + $ShapeChar }
                'Center' {
                    [bool] $oddWidth = $Width % 2
                    [bool] $oddTextLength = $TextEmbed.Length % 2
                    [int16] $insideShapeWidth = $Width - 2
                    $paddingTotal = $insideShapeWidth - $TextEmbed.Length
                    $paddingOnEachSide = [math]::Floor($paddingTotal /2)
                    $paddingLeft = ' ' * $paddingOnEachSide
                    if ($oddWidth) {
                        if ($oddTextLength) {
                            $paddingRight = ' ' * $paddingOnEachSide
                        }
                        else {
                            $paddingRight = ' ' * ($paddingOnEachSide + 1)
                        }
                    }
                    else {
                        if ($oddTextLength) {
                            $paddingRight = ' ' * ($paddingOnEachSide + 1)
                        }
                        else {
                            $paddingRight = ' ' * $paddingOnEachSide
                        }
                    }
                    (' ' * $MarginLeft) + $ShapeChar + $paddingLeft + $TextEmbed + $paddingRight + $ShapeChar
                }
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