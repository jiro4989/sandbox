// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
// クラス定義
// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

var GmailUtil = (function() {

  var LF = '\n';
  var LFLF = LF + LF;

  var GmailUtil = function() { }
  var g = GmailUtil.prototype;

  g.mkTo = function(mailAddresses) {
    var to = mailAddresses
      .split(',')
      .filter( function(value) { return value != ''; })
      .join(',');
    return to;
  }

  g.mkContents = function(cells, col, rows, formatter) {
    var contents = [];
    for (var i=0; i<rows.length; i++) {
      var text = formatter.fmtText(cells[rows[i]][col - 1], cells[rows[i]][col]);
      contents.push(text);
    }
    return contents.join(LFLF);
  }

  g.mkBody = function(before, contents, after) {
    var body = [before, contents, after].join(LFLF);
    return body;
  }

  return GmailUtil;
})();

var TextFormatter = (function() {
  var TextFormatter = function(sb, eb) {
    this.sb = sb;
    this.eb = eb;
  }

  var f = TextFormatter.prototype;

  f.fmtText = function(title, contents) {
    return this.sb + title + this.eb + '\n' + contents;
  }

  return TextFormatter;
})();

var Util = (function() {
  var Util = function() { }
  var u = Util.prototype;

  u.mkTextFile = function(filename, content) {
    var mimetype = 'text/plain';
    var charset = 'utf-8'
    var blob = Utilities.newBlob('', mimetype, filename);
    blob.setDataFromString(content, charset);
    return blob;
  }

  u.mkNowText = function() {
    var now = new Date();
    var timetext = [
      now.getFullYear() + this.paddingZero(now.getMonth() + 1) + this.paddingZero(now.getDate())
      , this.paddingZero(now.getHours()) + this.paddingZero(now.getMinutes()) + this.paddingZero(now.getSeconds())
    ].join('_')
    return timetext;
  }

  u.mkNowTextFile = function(filePrefix, content) {
    var filename = filePrefix + this.mkNowText() + '.txt';
    return this.mkTextFile(filename, content);
  }

  u.paddingZero = function(num) {
    return ('0' + num).slice(-2);
  }

  return Util;
})();

// <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
// クラス定義ここまで
// <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
// 関数定義
// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

/**
 * 相談シートのメールを送る。
 */
function sendMailSodan() {

  var COLUMN_INDEX     = 2;
  var TO_INDEX         = 2;
  var SUBJECT_INDEX    = TO_INDEX         + 2;
  var BEFORE_INDEX     = SUBJECT_INDEX    + 1;
  var CONTENT1_INDEX   = BEFORE_INDEX     + 1;
  var CONTENT2_INDEX   = CONTENT1_INDEX   + 1;
  var CONTENT3_INDEX   = CONTENT2_INDEX   + 1;
  var AFTER_INDEX      = CONTENT3_INDEX   + 1;
  var SOURCECODE_INDEX = AFTER_INDEX      + 4;
  var ERRORCODE_INDEX  = SOURCECODE_INDEX + 1;

  var sheet = SpreadsheetApp.getActiveSheet();

  // データの格納されている範囲をAPIで取得
  // 何度もAPIでセルの値を取得する場合より高速になる。
  var cells = sheet.getDataRange().getValues();

  var gmailUtil = new GmailUtil();
  var util = new Util();

  var mailAddresses = cells[TO_INDEX][COLUMN_INDEX]
  var to = gmailUtil.mkTo(mailAddresses);
  var subject = cells[SUBJECT_INDEX][COLUMN_INDEX];

  var ROWS = [CONTENT1_INDEX, CONTENT2_INDEX, CONTENT3_INDEX];
  var contents = gmailUtil.mkContents(
    cells
    , COLUMN_INDEX
    , ROWS
    , new TextFormatter('', '')
  );

  var htmlContents = gmailUtil.mkContents(
    cells
    , COLUMN_INDEX
    , ROWS
    , new TextFormatter('<b>', '</b>')
  );

  var body     = gmailUtil.mkBody(cells[BEFORE_INDEX][COLUMN_INDEX], contents, cells[AFTER_INDEX][COLUMN_INDEX]);
  var htmlBody = gmailUtil.mkBody(cells[BEFORE_INDEX][COLUMN_INDEX], htmlContents, cells[AFTER_INDEX][COLUMN_INDEX]).replace(/\r?\n/g, '<br/>');

  var attachments = [];

  var srccode = cells[SOURCECODE_INDEX][COLUMN_INDEX];
  var errcode = cells[ERRORCODE_INDEX][COLUMN_INDEX];

  if (srccode !== '') { attachments.push(util.mkNowTextFile('src', srccode)); }
  if (errcode !== '') { attachments.push(util.mkNowTextFile('err', errcode)); }

  Logger.log(to);

  // メールの送信
  GmailApp.sendEmail(
    to
    , subject
    , body
    , { htmlBody : htmlBody, attachments : attachments }
  );
}

// <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
// 関数定義ここまで
// <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

