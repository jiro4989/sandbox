import java.awt.*
import java.awt.image.BufferedImage as BImg
import java.awt.datatransfer.*
import java.io.File
import java.io.File.separator as sep
import javax.imageio.*

fun main(args : Array<String>) {
  val clip = Toolkit.getDefaultToolkit().getSystemClipboard()
  try {
    val image = clip.getData(DataFlavor.imageFlavor) as BImg
    val home = System.getProperty("user.home")
    val pictDir = "${home}${sep}Pictures${sep}ss"
    (1..1000).forEach {
      val imageFileName = "${pictDir}${sep}%04d.png".format(it)
      val imageFile = File(imageFileName)
      if (!imageFile.exists()) {
        ImageIO.write(image, "png", imageFile)
        println("[success] save $imageFileName")
        return
      }
    }
  } catch (e: Exception) {
    println("data of clipboard is not image.")
  }
}
