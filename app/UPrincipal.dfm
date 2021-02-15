object Form1: TForm1
  Left = 559
  Top = 104
  Width = 675
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
  object Label1: TLabel
    Left = 48
    Top = 24
    Width = 564
    Height = 20
    Caption = 
      'Trabajo Final PCI    Tom'#225's Agust'#237'n Gomez Bermudez, Primer Cuatri' +
      'mestre 2020'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 16
    Top = 88
    Width = 625
    Height = 21
    TabOrder = 0
  end
  object Memo1: TMemo
    Left = 16
    Top = 120
    Width = 257
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
    Top = 464
    Width = 89
    Height = 41
    Caption = 'Mostrar diccionario'
    TabOrder = 2
    WordWrap = True
    OnClick = btnMostrarDiccionarioClick
  end
  object btnAgregarAlDiccionario: TButton
    Left = 352
    Top = 464
    Width = 89
    Height = 41
    Caption = 'Agregar al diccionario'
    TabOrder = 3
    WordWrap = True
    OnClick = btnAgregarAlDiccionarioClick
  end
  object BtnClearMemo: TButton
    Left = 72
    Top = 464
    Width = 91
    Height = 41
    Caption = 'Clear Memo'
    TabOrder = 4
    OnClick = BtnClearMemoClick
  end
  object ListBox1: TListBox
    Left = 376
    Top = 120
    Width = 241
    Height = 337
    ItemHeight = 13
    TabOrder = 5
    OnClick = ListBox1Click
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 520
    Top = 472
  end
  object OpenDialog1: TOpenDialog
    Left = 560
    Top = 472
  end
end
