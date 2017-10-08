import java.awt.*;
import java.awt.datatransfer.*;

public class SaveClipImage {
  public static void main(String... args) throws Exception {
    Clipboard clip = Toolkit.getDefaultToolkit().getSystemClipboard();
    Image img = (Image) clip.getData(DataFlavor.imageFlavor);
    System.out.println(img);
  }
}

