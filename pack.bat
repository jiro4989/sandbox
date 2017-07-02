@echo off

set target_dir=actor019
set outname=%target_dir%_R_%%03d
set facename=%target_dir%_face%%03d
set img="%target_dir%\img"

if exist "%target_dir%\" (
  python layover_image.py "%img%\image_layer.json" %outname% -o right
  python flippicts.py "%img%"
  mkdir "%img%\face"
  python trim4mv.py "%img%\face" %facename%
  python pyzip.py "%img%" -n "%target_dir%" -x "%target_dir%\src" "%img%\src" "%img%\image_layer.json"
  echo bat処理が終了しました。
) else (
  echo 指定したディレクトリ%target_dir%は存在しません。
)

pause
