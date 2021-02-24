object Form1: TForm1
  Left = 138
  Top = 64
  Width = 1113
  Height = 599
  Caption = 'Aplicaci'#243'n de teclado predictivo'
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
  object Label2: TLabel
    Left = 88
    Top = 56
    Width = 79
    Height = 24
    Caption = 'Usuario 1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 456
    Top = 56
    Width = 79
    Height = 24
    Caption = 'Usuario 2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 8
    Top = 440
    Width = 313
    Height = 21
    TabOrder = 0
  end
  object Memo1: TMemo
    Left = 680
    Top = 24
    Width = 409
    Height = 417
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
  end
  object btnMostrarDiccionario: TButton
    Left = 832
    Top = 448
    Width = 89
    Height = 41
    Caption = 'Mostrar diccionario'
    TabOrder = 2
    WordWrap = True
    OnClick = btnMostrarDiccionarioClick
  end
  object btnAgregarAlDiccionario: TButton
    Left = 944
    Top = 448
    Width = 89
    Height = 41
    Caption = 'Agregar al diccionario'
    TabOrder = 3
    WordWrap = True
    OnClick = btnAgregarAlDiccionarioClick
  end
  object BtnClear: TButton
    Left = 720
    Top = 448
    Width = 91
    Height = 41
    Caption = 'Clear'
    TabOrder = 4
    OnClick = BtnClearClick
  end
  object ListBox1: TListBox
    Left = 8
    Top = 112
    Width = 313
    Height = 321
    Cursor = crHandPoint
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 20
    ParentFont = False
    TabOrder = 5
    OnClick = ListBox1Click
  end
  object Edit2: TEdit
    Left = 344
    Top = 440
    Width = 313
    Height = 21
    TabOrder = 6
  end
  object ListBox2: TListBox
    Left = 344
    Top = 112
    Width = 313
    Height = 321
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 20
    ParentFont = False
    TabOrder = 7
    OnClick = ListBox2Click
  end
  object ButtonEnviar1: TButton
    Left = 8
    Top = 481
    Width = 313
    Height = 25
    Caption = 'Enviar'
    TabOrder = 8
    OnClick = ButtonEnviar1Click
  end
  object ButtonEnviar2: TButton
    Left = 344
    Top = 481
    Width = 313
    Height = 25
    Caption = 'Enviar'
    TabOrder = 9
    OnClick = ButtonEnviar2Click
  end
  object Edit3: TEdit
    Left = 8
    Top = 522
    Width = 145
    Height = 21
    TabOrder = 10
  end
  object ButtonEliminar: TButton
    Left = 168
    Top = 522
    Width = 153
    Height = 25
    Caption = 'Eliminar palabra'
    TabOrder = 11
    OnClick = ButtonEliminarClick
  end
  object ButtonGuardarChat: TButton
    Left = 720
    Top = 496
    Width = 89
    Height = 41
    Caption = 'Guardar Chat'
    TabOrder = 12
    OnClick = ButtonGuardarChatClick
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 832
    Top = 504
  end
  object OpenDialog1: TOpenDialog
    Left = 912
    Top = 504
  end
  object Timer2: TTimer
    OnTimer = Timer2Timer
    Left = 872
    Top = 504
  end
  object SaveDialog1: TSaveDialog
    Left = 952
    Top = 504
  end
end
