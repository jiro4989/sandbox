#!/bin/bash

# play_game はRPGツクールMVのゲームを起動する。
# 引数で指定したプロジェクトを起動する。
# 引数で指定しなかった場合は番号で入力するプロンプトが表示される。
#
# 使い方
# 	play_game {project_name}
#
# 前提
# 	NW.jsを配置する。
#
# 引数
# 	プロジェクト名(ディレクトリ名)
#
# 参考
# 	https://kakurasan.blogspot.com/2017/02/rpgmv-games-on-linux.html


game=$1

# ゲームの指定がない場合はキー入力から選択
if [ "$game" = "" ]; then
	echo game list.
	echo

	# ゲーム一覧の取得
	cnt=0
	for d in *; do
		[ "$d" = "nw" ] && continue

		games[$cnt]=$d
		cnt=$((cnt + 1))
	done

	# ゲーム一覧の出力
	for ((i = 0; i < ${#games[@]}; i++)); do
		echo -e "\t$i)\t${games[$i]}"
	done

	echo

	# 数字でゲームを指定
	echo "enter number of game or q."
	printf "> "
	read -r num

	[ "$num" = "q" ] && exit 0

	game=${games[$num]}
fi

cd nw || exit 1
./nw "../$game"
