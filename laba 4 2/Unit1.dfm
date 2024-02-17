object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '351005 '#1043#1086#1088#1086#1076#1082#1086' '#1083#1072#1073'. 4.2'
  ClientHeight = 202
  ClientWidth = 240
  Color = clBtnFace
  Constraints.MaxHeight = 261
  Constraints.MaxWidth = 252
  Constraints.MinHeight = 202
  Constraints.MinWidth = 240
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnKeyDown = FormKeyDown
  TextHeight = 15
  object LabelCondition: TLabel
    Left = 8
    Top = 8
    Width = 233
    Height = 60
    Caption = 
      #1057' '#1087#1086#1084#1086#1097#1100#1102' '#1088#1077#1082#1091#1088#1089#1080#1074#1085#1086#1081' '#1092#1091#1085#1082#1094#1080#1080' '#1085#1072#1081#1090#1080' '#1089' '#1079#1072#1076#1072#1085#1085#1086#1081' '#1090#1086#1095#1085#1086#1089#1090#1100#1102' Eps '#1082#1074#1072 +
      #1076#1088#1072#1090#1085#1099#1081' '#1082#1086#1088#1077#1085#1100' Y = '#8730'X, '#1074#1086#1089#1087#1086#1083#1100#1079#1086#1074#1072#1074#1096#1080#1089#1100' '#1080#1090#1077#1088#1072#1094#1080#1086#1085#1085#1086#1081' '#1092#1086#1088#1084#1091#1083#1086#1081' '#1053#1100 +
      #1102#1090#1086#1085#1072'.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object LabelX: TLabel
    Left = 32
    Top = 88
    Width = 18
    Height = 15
    Caption = 'X ='
  end
  object LabelEps: TLabel
    Left = 21
    Top = 117
    Width = 29
    Height = 15
    Caption = 'Eps ='
  end
  object LabelY: TLabel
    Left = 32
    Top = 174
    Width = 18
    Height = 15
    Caption = 'Y ='
  end
  object EditX: TEdit
    Left = 56
    Top = 85
    Width = 121
    Height = 23
    ParentShowHint = False
    PopupMenu = PopupMenu
    ShowHint = False
    TabOrder = 0
    TextHint = '(0, 100000]'
    OnChange = EditChange
    OnExit = EditXExit
    OnKeyDown = EditXKeyDown
    OnKeyPress = EditXKeyPress
  end
  object EditEps: TEdit
    Left = 56
    Top = 114
    Width = 121
    Height = 23
    PopupMenu = PopupMenu
    TabOrder = 1
    TextHint = '(0, 1]'
    OnChange = EditChange
    OnExit = EditEpsExit
    OnKeyDown = EditEpsKeyDown
    OnKeyPress = EditEpsKeyPress
  end
  object ButtonResult: TButton
    Left = 56
    Top = 143
    Width = 121
    Height = 25
    Cursor = crHandPoint
    Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1088#1077#1079#1091#1083#1100#1090#1072#1090
    Enabled = False
    TabOrder = 2
    OnClick = ButtonResultClick
  end
  object EditY: TEdit
    Left = 56
    Top = 171
    Width = 121
    Height = 23
    Enabled = False
    ReadOnly = True
    TabOrder = 3
  end
  object MainMenu: TMainMenu
    Left = 192
    Top = 152
    object MMFile: TMenuItem
      Caption = #1060#1072#1081#1083
      object MMOpenFile: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100'...'
        ShortCut = 16463
        OnClick = MMOpenFileClick
      end
      object MMSaveFile: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        Enabled = False
        ShortCut = 16467
        OnClick = MMSaveFileClick
      end
      object MMSeparator: TMenuItem
        Caption = '-'
      end
      object MMExit: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        OnClick = MMExitClick
      end
    end
    object MMInstruction: TMenuItem
      Caption = #1048#1085#1089#1090#1088#1091#1082#1094#1080#1103
      OnClick = MMInstructionClick
    end
    object MMDevInfo: TMenuItem
      Caption = #1054' '#1088#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082#1077
      OnClick = MMDevInfoClick
    end
  end
  object OpenTextFileDialog: TOpenTextFileDialog
    DefaultExt = 'txt'
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1081' '#1092#1072#1081#1083' (*.txt)|*.txt'
    Left = 197
    Top = 118
  end
  object SaveTextFileDialog: TSaveTextFileDialog
    DefaultExt = '*.txt'
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1081' '#1092#1072#1081#1083' (*.txt)|*.txt'
    Top = 140
  end
  object PopupMenu: TPopupMenu
    Left = 202
    Top = 60
  end
end
