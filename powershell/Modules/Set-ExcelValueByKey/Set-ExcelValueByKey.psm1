<#
.SYNOPSIS
Excel�ɃL�[�ƂȂ�e�L�X�g�ōs�ԍ����擾���ăZ���ɒl���Z�b�g����B

.DESCRIPTION
Excel�ɃL�[�ƂȂ�e�L�X�g�ōs�ԍ����擾���ăZ���ɒl���Z�b�g����B

.PARAMETER excelFilePath
�Ώ�Excel�t�@�C���p�X

.PARAMETER sheetName
�Ώ�Excel�̑ΏۃV�[�g��

.PARAMETER key
�s����肷�郆�j�[�N�ȃL�[

.PARAMETER colIndex
�l���Z�b�g����Z���̗�ԍ�

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
