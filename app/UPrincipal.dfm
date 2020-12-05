object Form1: TForm1
  Left = 552
  Top = 116
  Width = 706
  Height = 568
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
    Width = 625
    Height = 21
    TabOrder = 0
  end
  object Memo1: TMemo
    Left = 16
    Top = 64
    Width = 625
    Height = 329
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    ParentShowHint = False
    ReadOnly = True
    ScrollBars = ssVertical
    ShowHint = False
    TabOrder = 1
    WordWrap = False
  end
  object btnMostrarDiccionario: TButton
    Left = 208
    Top = 408
    Width = 89
    Height = 41
    Caption = 'Mostrar diccionario'
    TabOrder = 2
    WordWrap = True
  end
  object btnAgregarAlDiccionario: TButton
    Left = 352
    Top = 408
    Width = 89
    Height = 41
    Caption = 'Agregar al diccionario'
    TabOrder = 3
    WordWrap = True
    OnClick = btnAgregarAlDiccionarioClick
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 192
    Top = 464
  end
  object OpenDialog1: TOpenDialog
    Left = 232
    Top = 464
  end
end
