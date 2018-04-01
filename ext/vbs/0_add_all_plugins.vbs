' >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
' �v���O�C���̒ǉ����ꂪ�Ђǂ��ꍇ��
' ���L�̐��l��傫�����Ă݂Ă��������B
' >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

SHORT_WAIT = 20
LONG_WAIT = 200

' <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
' �����܂�
' <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<



' >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
' �ȍ~�͕ҏW����K�v�Ȃ�
' >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>




















set wshShell=Wscript.createObject("Wscript.Shell")

' >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
' �֐���`
' >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

' �t�@�C�����̐擪�̕����̐��𐔂��ĕԂ��B
' @param folder �����Ώۃt�H���_
' @param prefix1 ���ׂ�ړ���1
' @param prefix2 ���ׂ�ړ���2
' @return ������������
function getPrefixCounter(folder, prefix1, prefix2)
  dim tmp
  tmp = 0
  for each file in folder.files
    if left(file.name, 1) = prefix1 or left(file.name, 1) = prefix2 then
      tmp = tmp + 1
    end if
  next
  getPrefixCounter = tmp
end function

' �t�@�C���ꗗ����A�����œn����Ă�2�̃v���t�B�b�N�X�Ŏn�܂�
' �t�@�C���̐��𐔂��āA
' GUI���������Ƃ���sendKey���鎞�̃L�[�ƁA
' ���̌�Ɏg���񐔂̃y�A��ێ�����z���Ԃ�
' @param folder �����Ώۃt�H���_
' @param prefix1 ���ׂ�ړ���1
' @param prefix2 ���ׂ�ړ���2
' @return ["sendKey�̒l", �v���t�B�b�N�X�Ŏn�܂�t�@�C���̐�]
function getKeyMap(folder, prefix1, prefix2)
  dim keyMap(1)
  keyMap(0) = prefix1
  keyMap(1) = getPrefixCounter(folder, prefix1, prefix2)
  getKeyMap = keyMap
end function

' �A���t�@�x�b�g�L�[�Ƃ��̓o��񐔂̃y�A�ƂȂ���
' 2�����z���Ԃ��B
' @return [["a", 4], ["b", 1] ...]
function getAlphabetArray()
  ' �J�����g�p�X�̃t�@�C���ꗗ���猩�����t�@�C���̑������擾
  set fso = createObject("Scripting.FileSystemObject")
  set folder = fso.getFolder(".")
  dim fileCount
  fileCount = 0
  for each file in folder.files
    fileCount = fileCount + 1
  next 
  ' ���̃X�N���v�g���̂̐��������Ă��܂��̂ł��̕����Z
  fileCount = fileCount - 1

  ' �e�A���t�@�x�b�g�̃y�A��2�����z��̐���
  dim alphabets(25)
  alphabets(0)  = getKeyMap(folder, "a", "A")
  alphabets(1)  = getKeyMap(folder, "b", "B")
  alphabets(2)  = getKeyMap(folder, "c", "C")
  alphabets(3)  = getKeyMap(folder, "d", "D")
  alphabets(4)  = getKeyMap(folder, "e", "E")
  alphabets(5)  = getKeyMap(folder, "f", "F")
  alphabets(6)  = getKeyMap(folder, "g", "G")
  alphabets(7)  = getKeyMap(folder, "h", "H")
  alphabets(8)  = getKeyMap(folder, "i", "I")
  alphabets(9)  = getKeyMap(folder, "j", "J")
  alphabets(10) = getKeyMap(folder, "k", "K")
  alphabets(11) = getKeyMap(folder, "l", "L")
  alphabets(12) = getKeyMap(folder, "m", "M")
  alphabets(13) = getKeyMap(folder, "n", "N")
  alphabets(14) = getKeyMap(folder, "o", "O")
  alphabets(15) = getKeyMap(folder, "p", "P")
  alphabets(16) = getKeyMap(folder, "q", "Q")
  alphabets(17) = getKeyMap(folder, "r", "R")
  alphabets(18) = getKeyMap(folder, "s", "S")
  alphabets(19) = getKeyMap(folder, "t", "T")
  alphabets(20) = getKeyMap(folder, "u", "U")
  alphabets(21) = getKeyMap(folder, "v", "V")
  alphabets(22) = getKeyMap(folder, "w", "W")
  alphabets(23) = getKeyMap(folder, "x", "X")
  alphabets(24) = getKeyMap(folder, "y", "Y")
  alphabets(25) = getKeyMap(folder, "z", "Z")
  getAlphabetArray = alphabets
end function

' �����ꑼ�̉�ʂɑJ�ڂ�����A
' �v���O�������s���Ƀ��[�U�����̉�ʂ�I�������ꍇ�ɂ�
' �v���O�����������I������
' @param title �A�N�e�B�u���ǂ����𒲂ׂ�ΏۃE�B���h�E�̃^�C�g��
function checkActiveWindow(title)
  if not wshShell.appActivate(title) then
    msgBox("�A�N�e�B�u�E�B���h�E�����҂ƈقȂ��Ă��܂��B" & vbCR & "�X�N���v�g���I�����܂��B")
    WScript.quit 10
  end if
end function

' �v���O�����̃��C�����W�b�N
function main()

  if wshShell.appActivate("�v���O�C���Ǘ�") then

    dim alphabets
    alphabets = getAlphabetArray()

    ' ���X�g��ԉ��ɃJ�[�\�����ړ����đI��
    wshShell.sendKeys("{END}")

    for each alpha in alphabets

      ' �o���񐔂�0�̃A���t�@�x�b�g�͖���
      if 0 < alpha(1) then
        dim x
        for x = 1 to alpha(1)
          checkActiveWindow("�v���O�C���Ǘ�")
          ' �v���O�C����ʂ��J��
          wshShell.sendKeys("{ENTER}")
          WScript.sleep(LONG_WAIT)

          ' �A���t�@�x�b�g�L�[��send�ɂ����
          ' �v���t�B�b�N�X�Ŏn�܂�v���O�C���ʒu�ɃW�����v
          wshShell.sendKeys(alpha(0))
          WScript.sleep(SHORT_WAIT)

          for y = 1 to x
            ' �v���t�B�b�N�X���͎��_�őI������Ă���̂ŁA
            ' 1�̎���down�s�v
            if not y = 1 then
              wshShell.sendKeys("{DOWN}")
              WScript.sleep(SHORT_WAIT)
            end if
          next

          checkActiveWindow("�v���O�C��")
          ' �J�[�\���ʒu�̗v�f��I��
          wshShell.sendKeys("{ENTER}")
          WScript.sleep(LONG_WAIT)
        next
      end if

      ' �J�[�\���ʒu�̗v�f��I��
      wshShell.sendKeys("{ENTER}")
      ' �����͉�ʂ̕\���Ɏ��Ԃ�������ꍇ������̂Œ����X���[�v������
      WScript.sleep(LONG_WAIT)

      ' �v�f���v���O�C�����X�g�ɒǉ�
      wshShell.sendKeys("{ENTER}")
      WScript.sleep(SHORT_WAIT)
      checkActiveWindow("�v���O�C���Ǘ�")
    next

    msgBox("����ɃX�N���v�g���I�����܂����B")

  else
    msgBox("�v���O�C���Ǘ���ʂ�\�����Ă��������B")
  end if

end function

' <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

main()

