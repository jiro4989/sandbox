@echo off

set target_dir=actor019
set outname=%target_dir%_R_%%03d
set img="%target_dir%\img"

if exist "%target_dir%\" (
  python layover_image.py "%img%\image_layer.json" %outname% -o right
  python flippicts.py "%img%"
  python pyzip.py "%img%" -n "%target_dir%" -x "%target_dir%\src" "%img%\src" "%img%\image_layer.json"
  echo bat�������I�����܂����B
) else (
  echo �w�肵���t�H���_%target_dir%�͑��݂��܂���B
)

pause
