object FormRecord: TFormRecord
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
  ClientHeight = 153
  ClientWidth = 310
  Color = clBtnFace
  Constraints.MaxHeight = 212
  Constraints.MaxWidth = 330
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 15
  object LabelModel: TLabel
    Left = 128
    Top = 8
    Width = 39
    Height = 15
    Caption = #1052#1072#1088#1082#1072':'
  end
  object LabelCountry: TLabel
    Left = 8
    Top = 34
    Width = 159
    Height = 15
    Caption = #1043#1086#1089#1091#1076#1072#1088#1089#1090#1074#1086'-'#1087#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100':'
    WordWrap = True
  end
  object LabelYear: TLabel
    Left = 96
    Top = 60
    Width = 71
    Height = 15
    Caption = #1043#1086#1076' '#1074#1099#1087#1091#1089#1082#1072':'
  end
  object LabelPrice: TLabel
    Left = 102
    Top = 86
    Width = 65
    Height = 15
    Caption = #1062#1077#1085#1072' ('#1088#1091#1073'.):'
  end
  object EditModel: TEdit
    Left = 173
    Top = 5
    Width = 121
    Height = 23
    Hint = #1052#1072#1082#1089'. '#1076#1083#1080#1085#1072' - 20 '#1089#1080#1084#1074#1086#1083#1086#1074
    ParentShowHint = False
    PopupMenu = PopupMenu
    ShowHint = True
    TabOrder = 0
    OnChange = EditOnChange
    OnKeyDown = EditModelKeyDown
    OnKeyPress = EditModelKeyPress
  end
  object EditCountry: TEdit
    Left = 173
    Top = 31
    Width = 121
    Height = 23
    Hint = #1052#1072#1082#1089'. '#1076#1083#1080#1085#1072' - 20 '#1089#1080#1084#1074#1086#1083#1086#1074
    ParentShowHint = False
    PopupMenu = PopupMenu
    ShowHint = True
    TabOrder = 1
    OnChange = EditOnChange
    OnKeyDown = EditCountryKeyDown
    OnKeyPress = EditCountryKeyPress
  end
  object EditYear: TEdit
    Left = 173
    Top = 57
    Width = 121
    Height = 23
    Hint = '1900..2024'
    ParentShowHint = False
    PopupMenu = PopupMenu
    ShowHint = True
    TabOrder = 2
    TextHint = '1900..2024'
    OnChange = EditOnChange
    OnExit = EditYearExit
    OnKeyDown = EditYearKeyDown
    OnKeyPress = EditYearKeyPress
  end
  object EditPrice: TEdit
    Left = 173
    Top = 83
    Width = 121
    Height = 23
    Hint = '0..999999999'
    ParentShowHint = False
    PopupMenu = PopupMenu
    ShowHint = True
    TabOrder = 3
    TextHint = '0..999999999'
    OnChange = EditOnChange
    OnExit = EditPriceExit
    OnKeyDown = EditPriceKeyDown
    OnKeyPress = EditPriceKeyPress
  end
  object ButtonSave: TButton
    Left = 64
    Top = 120
    Width = 75
    Height = 25
    Cursor = crHandPoint
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    Enabled = False
    TabOrder = 4
    OnClick = ButtonSaveClick
  end
  object ButtonCancel: TButton
    Left = 173
    Top = 120
    Width = 75
    Height = 25
    Cursor = crHandPoint
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 5
    OnClick = ButtonCancelClick
  end
  object MainMenu: TMainMenu
    Left = 16
    Top = 56
    object MMInstruction: TMenuItem
      Caption = #1048#1085#1089#1090#1088#1091#1082#1094#1080#1103
      OnClick = MMInstructionClick
    end
  end
  object PopupMenu: TPopupMenu
    Left = 24
    Top = 8
  end
end
