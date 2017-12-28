import java.awt.*
import java.awt.datatransfer.*
import java.awt.image.BufferedImage as BImg
import java.io.File
import java.io.File.separator as sep
import java.text.SimpleDateFormat as SDF
import java.util.Date
import javax.imageio.*

fun main(args : Array<String>) {
  val clip = Toolkit.getDefaultToolkit().getSystemClipboard()
  try {
    // クリップボードから画像を取得
    val image = clip.getData(DataFlavor.imageFlavor) as BImg

    // 画像保存先ディレクトリを取得
    val home = System.getProperty("user.home")
    val pictDir = "${home}${sep}Pictures${sep}ss"

    // 現在のタイムスタンプを取得
    val now = SDF("yyyyMMdd-HHmmss").format(Date())
    val ymd = now.split("-")[0]
    val hms = now.split("-")[1]

    // 日付でフォルダを作成
    // フォルダが既存でも実行されるけれど
    // 特にException吐くわけでもないし気にしない(なげやり)
    val dateDir = "${pictDir}${sep}$ymd"
    var dateDirFile = File(dateDir)
    dateDirFile.mkdir()

    // 画像の保存
    val imageFileName = "${dateDir}${sep}$hms.png"
    val imageFile = File(imageFileName)
    ImageIO.write(image, "png", imageFile)
    println("[success] save $imageFileName")
  } catch (e: UnsupportedFlavorException) {
    // クリップボードから画像を取得しようとしてるのに
    // クリップボードに画像以外のデータが保存されてるときに吐くException
    e.printStackTrace()
  } catch (e: Exception) {
    // その他のなんらかのException
    e.printStackTrace()
  }
}
