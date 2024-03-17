object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '351005 '#1043#1086#1088#1086#1076#1082#1086' '#1083#1072#1073'. 5.1'
  ClientHeight = 289
  ClientWidth = 314
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnHelp = FormHelp
  OnResize = FormResize
  TextHeight = 15
  object LabelProgramInfo: TLabel
    Left = 40
    Top = 8
    Width = 238
    Height = 20
    Caption = #1055#1088#1086#1075#1088#1072#1084#1084#1072' '#1076#1083#1103' '#1088#1072#1073#1086#1090#1099' '#1089#1086' '#1089#1090#1077#1082#1086#1084
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object ListViewStack: TListView
    Left = 8
    Top = 119
    Width = 298
    Height = 162
    Columns = <
      item
        Caption = #8470
        MaxWidth = 100
        MinWidth = 30
        Width = 70
      end
      item
        Caption = #1069#1083#1077#1084#1077#1085#1090
        MaxWidth = 280
        MinWidth = 200
        Width = 250
      end>
    HideSelection = False
    RowSelect = True
    TabOrder = 4
    ViewStyle = vsReport
    Visible = False
    OnChange = ListViewStackChange
    OnDeletion = ListViewStackDeletion
  end
  object ButtonCreate: TButton
    Left = 8
    Top = 81
    Width = 129
    Height = 25
    Cursor = crHandPoint
    Caption = #1057#1086#1079#1076#1072#1090#1100' '#1087#1091#1089#1090#1086#1081' '#1089#1090#1077#1082
    TabOrder = 2
    OnClick = ButtonCreateClick
  end
  object ButtonPush: TButton
    Left = 8
    Top = 42
    Width = 129
    Height = 25
    Cursor = crHandPoint
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1101#1083#1077#1084#1077#1085#1090
    Enabled = False
    TabOrder = 0
    OnClick = ButtonPushClick
  end
  object ButtonDestroy: TButton
    Left = 177
    Top = 81
    Width = 129
    Height = 25
    Cursor = crHandPoint
    Caption = #1059#1085#1080#1095#1090#1086#1078#1080#1090#1100' '#1089#1090#1077#1082
    Enabled = False
    TabOrder = 3
    OnClick = ButtonDestroyClick
  end
  object ButtonPop: TButton
    Left = 177
    Top = 42
    Width = 129
    Height = 25
    Cursor = crHandPoint
    Caption = #1059#1076#1072#1083#1080#1090#1100' '#1101#1083#1077#1084#1077#1085#1090
    Enabled = False
    TabOrder = 1
    OnClick = ButtonPopClick
  end
  object MainMenu: TMainMenu
    Left = 225
    Top = 201
    object MMFile: TMenuItem
      Caption = #1060#1072#1081#1083
      object MMOpenFile: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100'...'
        Enabled = False
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
      ShortCut = 112
      OnClick = MMInstructionClick
    end
    object MMDevInfo: TMenuItem
      Caption = #1054' '#1088#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082#1077
      OnClick = MMDevInfoClick
    end
  end
  object OpenDialog: TOpenDialog
    DefaultExt = '*.txt'
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1092#1072#1081#1083#1099' (*.txt)|*.txt'
    Left = 104
    Top = 200
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '*.txt'
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1092#1072#1081#1083#1099' (*.txt)|*.txt'
    Left = 152
    Top = 168
  end
end
