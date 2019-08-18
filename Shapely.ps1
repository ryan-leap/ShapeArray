<#
   Add top, middle, bottom
   Add fill character
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

        [ValidateLength(1,1)]
        [Parameter(Mandatory = $false)]
        [string] $EdgeChar = '*',

        [ValidateLength(1,1)]
        [Parameter(Mandatory = $false)]
        [string] $FillChar = ' ',

        [ValidateLength(1,115)]
        [Parameter(ParameterSetName='Embed',Mandatory=$true)]
        [string] $TextEmbed,

        [ValidateSet('Left','Right','Center')]
        [Parameter(ParameterSetName='Embed',Mandatory=$false)]
        [string] $TextJustify = 'Center'

    )

    if ($TextEmbed) {
        [int16] $centerFromTop = [math]::Ceiling($Height / 2)
    }
    # Top Margin
    for ($i = 0; $i -lt $MarginTop; $i++) {
        @(' ' * $Width)
    }

    # Draw Shape
    (' ' * $MarginLeft) + $EdgeChar * $Width
    for ($i = 0; $i -lt ($Height-2); $i++) {
        if ($TextEmbed -and ($i -eq ($centerFromTop-2))) {
            switch ($TextJustify) {
                'Left'   { (' ' * $MarginLeft) + $EdgeChar + $FillChar + $TextEmbed + ($FillChar * ($Width - $TextEmbed.Length - 3)) + $EdgeChar }
                'Right'  { (' ' * $MarginLeft) + $EdgeChar + ($FillChar * ($Width - $TextEmbed.Length - 3)) + $TextEmbed + $FillChar + $EdgeChar }
                'Center' {
                    [bool] $oddWidth = $Width % 2
                    [bool] $oddTextLength = $TextEmbed.Length % 2
                    [int16] $insideShapeWidth = $Width - 2
                    $paddingTotal = $insideShapeWidth - $TextEmbed.Length
                    $paddingOnEachSide = [math]::Floor($paddingTotal /2)
                    $paddingLeft = $FillChar * $paddingOnEachSide
                    if ($oddWidth) {
                        if ($oddTextLength) {
                            $paddingRight = $FillChar * $paddingOnEachSide
                        }
                        else {
                            $paddingRight = $FillChar * ($paddingOnEachSide + 1)
                        }
                    }
                    else {
                        if ($oddTextLength) {
                            $paddingRight = $FillChar * ($paddingOnEachSide + 1)
                        }
                        else {
                            $paddingRight = $FillChar * $paddingOnEachSide
                        }
                    }
                    (' ' * $MarginLeft) + $EdgeChar + $paddingLeft + $TextEmbed + $paddingRight + $EdgeChar
                }
            }
            
        }
        else {
            (' ' * $MarginLeft) + $EdgeChar + ($FillChar * ($Width - 2)) + $EdgeChar
        }
    }
    (' ' * $MarginLeft) + $EdgeChar * $Width

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
        if ($i -ge $Left.Count) {
            (' ' * $Left[0].Length) + (' ' * $Spacing) + $Right[$i]
        }
        else {
            $Left[$i] + (' ' * $Spacing) + $Right[$i]
        }
    }
}