object AddNodeForm: TAddNodeForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1074#1077#1088#1096#1080#1085#1099
  ClientHeight = 99
  ClientWidth = 287
  Color = clBtnFace
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
  OnHelp = FormHelp
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 15
  object LabelValue: TLabel
    Left = 8
    Top = 19
    Width = 112
    Height = 15
    Caption = #1047#1085#1072#1095#1077#1085#1080#1077' '#1074#1077#1088#1096#1080#1085#1099':'
  end
  object EditValue: TEdit
    Left = 132
    Top = 16
    Width = 145
    Height = 23
    Hint = '-999..999'
    ParentShowHint = False
    PopupMenu = PopupMenu
    ShowHint = True
    TabOrder = 0
    TextHint = '-999..999'
    OnChange = EditValueChange
    OnKeyPress = EditValueKeyPress
  end
  object ButtonAdd: TButton
    Left = 36
    Top = 58
    Width = 93
    Height = 25
    Cursor = crHandPoint
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    Enabled = False
    TabOrder = 1
    OnClick = ButtonAddClick
  end
  object ButtonCancel: TButton
    Left = 156
    Top = 58
    Width = 93
    Height = 25
    Cursor = crHandPoint
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    TabOrder = 2
    OnClick = ButtonCancelClick
  end
  object MainMenu: TMainMenu
    Left = 194
    Top = 65532
    object MMInstruction: TMenuItem
      Caption = #1048#1085#1089#1090#1088#1091#1082#1094#1080#1103
      ShortCut = 112
      OnClick = MMInstructionClick
    end
  end
  object PopupMenu: TPopupMenu
    Left = 8
    Top = 48
  end
end
