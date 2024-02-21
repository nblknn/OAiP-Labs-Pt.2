object FormTask: TFormTask
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1047#1072#1076#1072#1085#1080#1077
  ClientHeight = 271
  ClientWidth = 318
  Color = clBtnFace
  Constraints.MaxHeight = 330
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
  object LabelTask: TLabel
    Left = 24
    Top = 8
    Width = 270
    Height = 30
    Caption = 
      #1042#1099#1074#1077#1089#1090#1080' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1102' '#1086#1073' '#1072#1074#1090#1086#1084#1086#1073#1080#1083#1103#1093' '#1074#1099#1087#1091#1089#1082#1072' '#1087#1088#1086#1096#1083#1086#1075#1086' '#1075#1086#1076#1072' '#1074' '#1087#1086#1088#1103#1076#1082 +
      #1077' '#1091#1073#1099#1074#1072#1085#1080#1103' '#1094#1077#1085'.'
    WordWrap = True
  end
  object TaskListView: TListView
    Left = 8
    Top = 47
    Width = 305
    Height = 190
    Columns = <
      item
        Caption = #8470
        Width = 30
      end
      item
        Caption = #1052#1072#1088#1082#1072
        Width = 70
      end
      item
        AutoSize = True
        Caption = #1043#1086#1089#1091#1076#1072#1088#1089#1090#1074#1086
      end
      item
        Caption = #1043#1086#1076
        Width = 45
      end
      item
        Caption = #1062#1077#1085#1072
        Width = 70
      end>
    HideSelection = False
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
  end
  object ButtonClose: TButton
    Left = 120
    Top = 243
    Width = 75
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 0
    OnClick = ButtonCloseClick
  end
  object MainMenu: TMainMenu
    Left = 174
    Top = 78
    object MMFile: TMenuItem
      Caption = #1060#1072#1081#1083
      object MMSaveFile: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        ShortCut = 16467
        OnClick = MMSaveFileClick
      end
      object MMSeparator: TMenuItem
        Caption = '-'
      end
      object MMClose: TMenuItem
        Caption = #1047#1072#1082#1088#1099#1090#1100' '#1086#1082#1085#1086
        OnClick = MMCloseClick
      end
    end
    object MMInstruction: TMenuItem
      Caption = #1048#1085#1089#1090#1088#1091#1082#1094#1080#1103
      OnClick = MMInstructionClick
    end
  end
end
