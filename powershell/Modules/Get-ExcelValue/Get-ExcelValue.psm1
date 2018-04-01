<#
.SYNOPSIS
Excel�̎w��̃Z������l�����o��

.DESCRIPTION
Excel�̎w��̃Z������l�����o��

.PARAMETER excelFilePath
�Ώ�Excel�t�@�C���p�X

.PARAMETER sheetName
�Ώ�Excel�̑ΏۃV�[�g��

.PARAMETER rangeText
�ΏۃZ��

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
