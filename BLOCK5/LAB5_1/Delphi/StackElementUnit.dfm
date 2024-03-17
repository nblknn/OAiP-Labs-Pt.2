object StackElementForm: TStackElementForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1101#1083#1077#1084#1077#1085#1090#1072
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
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 15
  object LabelElement: TLabel
    Left = 8
    Top = 19
    Width = 111
    Height = 15
    Caption = #1047#1085#1072#1095#1077#1085#1080#1077' '#1101#1083#1077#1084#1077#1085#1090#1072':'
  end
  object EditElement: TEdit
    Left = 132
    Top = 16
    Width = 145
    Height = 23
    Hint = '-999999..999999'
    ParentShowHint = False
    PopupMenu = PopupMenu
    ShowHint = True
    TabOrder = 0
    TextHint = '-999999..999999'
    OnChange = EditElementChange
    OnKeyPress = EditElementKeyPress
  end
  object ButtonPush: TButton
    Left = 36
    Top = 58
    Width = 93
    Height = 25
    Cursor = crHandPoint
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    Enabled = False
    TabOrder = 1
    OnClick = ButtonPushClick
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
    object MMDevInfo: TMenuItem
      Caption = #1054' '#1088#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082#1077
      OnClick = MMDevInfoClick
    end
  end
  object PopupMenu: TPopupMenu
    Left = 8
    Top = 48
  end
end
