Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# フォームの作成
$form = New-Object System.Windows.Forms.Form
$form.Text = "タイマー通知"
$form.Size = New-Object System.Drawing.Size(260,180)
$form.StartPosition = "CenterScreen"
$form.MaximizeBox = $false
$form.MinimizeBox = $false

# OKボタンの設定
$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Point(40,100)
$OKButton.Size = New-Object System.Drawing.Size(75,30)
$OKButton.Text = "OK"
$OKButton.DialogResult = "OK"

# ラベルの設定
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,30)
$label.Size = New-Object System.Drawing.Size(250,20)
$label.Text = "時間になりました！"

# 最前面に表示：する
$form.Topmost = $True

# OKボタンを選択した状態にする
$form.Add_Shown({$OKButton.Select()})

# キーとボタンの関係
$form.AcceptButton = $OKButton

# ボタン等をフォームに追加
$form.Controls.Add($OKButton)
$form.Controls.Add($label)

# フォームを表示
$form.ShowDialog()

