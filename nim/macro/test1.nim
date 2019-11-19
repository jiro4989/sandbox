import macros

type
  User = object
    name: string
    age: int

macro startLog*(body: untyped): untyped =
  ## コンパイル時にうんこと出力する。
  ## キャッシュが効くと出力されなくなる。
  echo "うんこ"
  result = body
  result.nnkStmtList.nnkProcdef.add(nnkCommand.newTree(newIdentNode("echo"), newLit("うんこ")))

dumpAstGen:
  proc readUsers(): seq[User] {.startLog.} =
    echo "ログイン済み"
    echo "DBとコネクションをはる"
    echo "SELECT name, age FROM users WHERE id = 1;"
    echo "DBコネクションクローズ"
    echo "レスポンス"

  discard readUsers()
