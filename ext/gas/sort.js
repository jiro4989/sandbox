/**
 * タグ情報でソートする。
 */
function sort() {
  var spreadsheet = SpreadsheetApp.getActiveSpreadsheet();
  var sheet = spreadsheet.getSheetByName('経過時間')
  var rng = sheet.getRange('A2:F');
  rng.sort([{column:6, ascending: true}])
}

