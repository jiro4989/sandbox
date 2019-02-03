import java.awt.Toolkit;
import java.awt.datatransfer.*;

/**
 * クリップボードのMarkdownテキストの表題から目次の文字列を生成する。
 */
public class CreateMarkdownMenu {
  public static void main(String... args) {
    final String CR = System.lineSeparator();
    String text = getClipText();
    for (String line : text.split(CR, -1)) {
      System.out.println(line);
    }
  }

  private static String getClipText() {
    Toolkit kit = Toolkit.getDefaultToolkit();
    Clipboard clip = kit.getSystemClipboard();

    try {
      return (String) clip.getData(DataFlavor.stringFlavor);
    } catch (Exception e) {
      return null;
    }
  }
}

