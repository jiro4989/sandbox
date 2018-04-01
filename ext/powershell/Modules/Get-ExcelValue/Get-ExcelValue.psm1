<#
.SYNOPSIS
Excelの指定のセルから値を取り出す

.DESCRIPTION
Excelの指定のセルから値を取り出す

.PARAMETER excelFilePath
対象Excelファイルパス

.PARAMETER sheetName
対象Excelの対象シート名

.PARAMETER rangeText
対象セル

.EXAMPLE
Get-ExcelValue -excelFilePath "foo.xlsx" -sheetName "Sheet1" -rangeText "A1"

.NOTES
General notes
#>
function Get-ExcelValue {
  param(
    [Parameter(ValueFromPipeline=$true,Mandatory=$true)]
    [string[]] $excelFilePath
    , [string[]] $sheetName
    , [string[]] $rangeText
  )

  try {
    $excel = New-Object -ComObject Excel.Application
    $excelFile = Get-Item $excelFilePath
    $book = $excel.Workbooks.Open($excelFile)
    $sheet = $book.Sheets($sheetName)
    $value = $sheet.Range($rangeText).Text
  } catch {
    Write-Output "Failed Get-ExcelValue"
    Write-Output $Error[0]
  } finally {
    $book.Close()
    $excel.Quit()
    [gc]::Collect()
  }

  return [string]$value
}
