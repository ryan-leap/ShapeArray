function New-ShapeRectangle {
<#
.SYNOPSIS
  Produces an array that when displayed to the console is shaped like a rectangle.
.DESCRIPTION
  Creates an array whose arrangement of characters resembles a rectangle when displayed to the console.
  Intended to be used for fun or displaying nicely formatted messages to an end user.
.PARAMETER Height
  Specifies the height (array count) of the rectangle.
.PARAMETER Width
  Specifies the width (string length) of the rectangle.
.PARAMETER MarginTop
  Specifies the number of blank lines above the rectangle.
.PARAMETER MarginBottom
  Specifies the number of blank lines below the rectangle.
.PARAMETER MarginLeft
  Specifies the number of blank columns to the left of the rectangle.
.PARAMETER EdgeChar
  Specifies the character to be used to draw the edges of the rectangle.
.PARAMETER FillChar
  Specifies the character to be used to fill the contents of the rectangle.
.PARAMETER TextEmbed
  Specifies a string to place inside the rectangle
.PARAMETER AlignHorizontal
  Specifies the horizontal alignment of the text embedded in the rectangle
.PARAMETER AlignVertical
  Specifies the vertical alignment of the text embedded in the rectangle
.EXAMPLE
  New-ShapeRectangle
.NOTES
   Author: Ryan Leap
   Email: ryan.leap@gmail.com
#>
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
        [string] $AlignHorizontal = 'Center',

        [ValidateSet('Top','Bottom','Middle')]
        [Parameter(ParameterSetName='Embed',Mandatory=$false)]
        [string] $AlignVertical = 'Middle'


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
            switch ($AlignHorizontal) {
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