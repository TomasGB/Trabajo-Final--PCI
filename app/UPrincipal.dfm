object Form1: TForm1
  Left = 880
  Top = 129
  Width = 306
  Height = 450
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 16
    Top = 32
    Width = 257
    Height = 21
    TabOrder = 0
  end
  object Memo1: TMemo
    Left = 16
    Top = 80
    Width = 257
    Height = 217
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object btnMostrarDiccionario: TButton
    Left = 24
    Top = 320
    Width = 89
    Height = 41
    Caption = 'Mostrar diccionario'
    TabOrder = 2
    WordWrap = True
  end
  object btnAgregarAlDiccionario: TButton
    Left = 168
    Top = 320
    Width = 89
    Height = 41
    Caption = 'Agregar al diccionario'
    TabOrder = 3
    WordWrap = True
    OnClick = btnAgregarAlDiccionarioClick
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 8
    Top = 376
  end
end
