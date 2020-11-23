import java.io.File;
import javax.imageio.ImageIO;
import java.awt.geom.AffineTransform;
import java.awt.image.AffineTransformOp;
import java.awt.image.BufferedImage;

public class Scale {
  public static void main(String... args) throws Exception {
    // 画像ファイルのパス
    String inPath = args[0];
    // スケールサイズ (1.0, 2.0, 0.5 etc)
    double scale = Double.parseDouble(args[1]);

    // 画像ファイルの読み込み
    File inFile = new File(inPath);
    BufferedImage image = ImageIO.read(inFile);

    // 出力先画像の生成
    int w = image.getWidth();
    int h = image.getHeight();
    BufferedImage newImage = new BufferedImage((int)(w*scale), (int)(h*scale), BufferedImage.TYPE_INT_ARGB);

    // 拡大縮小
    AffineTransform at = new AffineTransform();
    at.scale(scale, scale);
    AffineTransformOp scaleOp = new AffineTransformOp(at, AffineTransformOp.TYPE_BICUBIC);
    newImage = scaleOp.filter(image, newImage);

    // 拡縮後の画像をファイル出力
    ImageIO.write(newImage, "png", new File("out."+inPath));
  }
}

