<#
.SYNOPSIS
Excelにキーとなるテキストで行番号を取得してセルに値をセットする。

.DESCRIPTION
Excelにキーとなるテキストで行番号を取得してセルに値をセットする。

.PARAMETER excelFilePath
対象Excelファイルパス

.PARAMETER sheetName
対象Excelの対象シート名

.PARAMETER key
行を特定するユニークなキー

.PARAMETER colIndex
値をセットするセルの列番号

.EXAMPLE
echo "hoge" | Set-ExcelValue -excelFilePath "foo.xlsx" -sheetName "Sheet1" -key "key" -colIndex 1

.NOTES
General notes
#>
function Set-ExcelValueByKey {
  param(
    [Parameter(ValueFromPipeline=$true,Mandatory=$true)]
    [string] $excelFilePath
    , [string] $sheetName
    , [string] $key
    , [int] $colIndex
  )

  begin {
    $excel = New-Object -ComObject Excel.Application
    $excelFile = Get-Item $excelFilePath
    $book = $excel.Workbooks.Open($excelFile)
    $sheet = $book.Sheets($sheetName)
  }

  process {
    try {
      $rowIndex = 0;
      @($sheet.Range($rangeText)) | % {
        $rowIndex++
        $cellValue = $cell.Text
        if ($cellValue -eq $key) {
          break
        }
      }
      $sheet.Cells.Item($colIndex, $rowIndex) = $input
    } catch {
      Write-Output "Failed Get-ExcelValue"
      Write-Output $Error[0]
    } finally {
      $book.Close()
      $excel.Quit()
      [gc]::Collect()
    }
  }
}
