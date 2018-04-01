# PowerShellModules
独自に実装したPowerShellのモジュール(コマンドレット)

## 追加方法
### PowerShellModulesの配置パスを確認
下記のコマンドを実行する。  
`echo $env:PSModulePath`

大抵は`~/Documents/WindowsPowerShell/Modules`が含まれているはず。
含まれていなければ、上記ディレクトリを作成する。

### 作成したいコマンドレットと、そのモジュールファイルを作成する
上記のModulesディレクトリ配下に作成したいコマンドレット名のディレクトリと、その
名前のpsm1ファイルを作成する。

foobarの場合は
foobar/foobar.psm1
を作成する。

※このディレクトリ名とスクリプト名は完全一致させる必要がある。
