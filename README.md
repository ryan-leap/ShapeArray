# ShapeArray
Creates an array whose arrangement of characters resembles a shape when displayed to the console.  Specifically, ```New-ShapeRectangle``` produces
a rectangularly shaped array which can optionally have embedded text justified to your needs.  This is intended to be used for displaying nicely
formatted messages to the end-user of your tool/script.

## Installing
#### Download from GitHub repository

* Download the repository from https://github.com/ryan-leap/ShapeArray
* Unblock the zip file ((on Windows) Right Click -> Properties -> [v/] Unblock)

## Usage
```powershell
# Dot-source the file to bring the function in scope
. .\ShapeArray.ps1

# Get help
Get-Help New-ShapeArray

Get-Help Join-Shape
```

## Examples
### Produces an empty rectangle and rectangles with embedded text
```powershell
PS C:\> New-ShapeRectangle

  *********************************************************************************************************
  *                                                                                                       *
  *                                                                                                       *
  *                                                                                                       *
  *                                                                                                       *
  *********************************************************************************************************

PS C:\> New-ShapeRectangle -TextEmbed "Hello World!"

  *********************************************************************************************************
  *                                                                                                       *
  *                                             Hello World!                                              *
  *                                                                                                       *
  *                                                                                                       *
  *********************************************************************************************************

PS C:\> New-ShapeRectangle -Height 8 -TextEmbed 'Hello World!' -TextAlignHorizontal Left -TextAlignVertical Bottom

  *********************************************************************************************************
  *                                                                                                       *
  *                                                                                                       *
  *                                                                                                       *
  *                                                                                                       *
  * Hello World!                                                                                          *
  *                                                                                                       *
  *********************************************************************************************************

PS C:\> $header = New-ShapeRectangle -Height 5 -TextEmbed "The Title"
PS C:\> $body = New-ShapeRectangle -Height 10 -EdgeChar ' ' -TextEmbed "The Content"
PS C:\> $footer = New-ShapeRectangle -Height 5 -TextEmbed "The End!"
PS C:\> $header; $body; $footer
  *********************************************************************************************************
  *                                                                                                       *
  *                                               The Title                                               *
  *                                                                                                       *
  *********************************************************************************************************






                                                 The Content







  *********************************************************************************************************
  *                                                                                                       *
  *                                               The End!                                                *
  *                                                                                                       *
  *********************************************************************************************************
```
### Combines two shape arrays into a single shape array
```powershell
PS C:\> Join-Shape -Left (New-ShapeRectangle -Width 20) -Right (New-ShapeRectangle -Width 50)

  ********************   **************************************************
  *                  *   *                                                *
  *                  *   *                                                *
  *                  *   *                                                *
  *                  *   *                                                *
  ********************   **************************************************

```
## Author(s)

* **Ryan Leap** - *Initial work*

## License

Licensed under the MIT License.  See [LICENSE](LICENSE.md) file for details.

