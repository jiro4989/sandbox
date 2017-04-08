#!/usr/bin/python
#coding: UTF-8

################################################################################
u"""Make TableView Database
JavaFXのTableViewで使用するデータベースクラスを作成するためのスクリプト。
@param argv[1]       - ソースファイルの属するパッケージ名
@param argv[2]       - ソースファイルのクラス名
@param argv[3..size] - 可変長引数。定義したいプロパティの名前と型を : で区切る
"""
################################################################################

import sys

class DB:
    def __init__(self,
            package_name = ''
            , class_name = ''
            , dictionary = []
            ):
        self.package_name = package_name
        self.class_name   = class_name
        self.dictionary   = dictionary

class Dict:
    def __init__(self, arg_var, arg_type, prop_var, prop_type):
        self.arg_var   = arg_var
        self.arg_type  = arg_type
        self.prop_var  = prop_var
        self.prop_type = prop_type

u"""省略形の型を正式な名称に変換する。
@param var_type: str - 型文字列
@return          str - Javaの型文字列
"""
def convert_type(var_type):
    v = ''
    if var_type == 'i':
        v = 'int'
    elif var_type == 's':
        v = 'String'
    elif var_type == 'b':
        v = 'boolean'
    else:
        print(u"指定された型が不正です。")
        exit()
    return v

def convert_beans_type(var_type):
    v = ''
    if var_type == 'i':
        v = 'IntegerProperty'
    elif var_type == 's':
        v = 'StringProperty'
    elif var_type == 'b':
        v = 'BooleanProperty'
    else:
        print(u"指定された型が不正です。")
        exit()
    return v

def out_console(db):
    print('package %s;' % db.package_name)
    print('')
    print('import javafx.beans.property.*;')
    print('')
    print('public class %s {' % db.class_name)
    for dct in db.dictionary:
        print('  private final %s %s;' % (dct.prop_type, dct.arg_var))

    print('')
    print('  public %s(' % db.class_name)
    print(mk_constructor_args_string(db.dictionary))
    print('    )')
    print('  {')
    for dct in db.dictionary:
        print('    this.%s = new Simple%s(%s);' % (dct.arg_var, dct.prop_type,
            dct.arg_var))

    print('  }')
    print('')
    print('  // ************************************************************')
    print('  // getter')
    print('  // ************************************************************')
    for dct in db.dictionary:
        print('')
        print('  public %s %s() {' % (dct.prop_type, dct.prop_var))
        print('    return this.%s;' % dct.arg_var)
        print('  }')

    for dct in db.dictionary:
        var = dct.arg_var
        var = var[0].upper() + var[1:]
        print('')
        print('  public %s get%s() {' % (dct.arg_type, var))
        print('    return this.%s.get();' % dct.arg_var)
        print('  }')

    print('')
    print('  // ************************************************************')
    print('  // setter')
    print('  // ************************************************************')
    for dct in db.dictionary:
        var = dct.prop_var
        var = var[0].upper() + var[1:]
        print('')
        print('  public void set%s(%s %s) {' % (var, dct.arg_type, dct.arg_var))
        print('    this.%s.set(%s);' % (dct.arg_var, dct.arg_var))
        print('  }')

    print('}')

def mk_constructor_args_string(dictionary):
    str = ''
    length = len(dictionary)
    for (i, dct) in zip(range(length), dictionary):
        str += '    %s, %s' % (dct.arg_type, dct.arg_var)
        if i < length - 1:
            str += \
                    """,
"""
    return str

if __name__ == '__main__':
    args = sys.argv
    args_len = len(args)

    if args_len < 3:
        exit()
    else:
        db = DB()
        db.package_name = args[1]
        db.class_name = args[2]

        for (i, arg) in zip(range(args_len), args):
            if 3 <= i:
                sp = arg.split(':')
                name = sp[0]
                t    = sp[1]

                db.dictionary.append(
                        Dict(
                            name             , convert_type(t),
                            name + 'Property', convert_beans_type(t)
                            )
                        )

        out_console(db)

