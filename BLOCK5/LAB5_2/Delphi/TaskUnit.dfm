object TaskForm: TTaskForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1047#1072#1076#1072#1085#1080#1077
  ClientHeight = 259
  ClientWidth = 306
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 15
  object LabelTask: TLabel
    Left = 16
    Top = 8
    Width = 282
    Height = 45
    Caption = 
      #1042#1099#1074#1077#1089#1090#1080' '#1085#1086#1084#1077#1088#1072' '#1074#1077#1088#1096#1080#1085', '#1091' '#1082#1086#1090#1086#1088#1099#1093' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1086#1090#1086#1084#1082#1086#1074' '#1074' '#1083#1077#1074#1086#1084' '#1087#1086#1076 +
      #1076#1077#1088#1077#1074#1077' '#1085#1077' '#1088#1072#1074#1085#1086' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1091' '#1087#1086#1090#1086#1084#1082#1086#1074' '#1074' '#1087#1088#1072#1074#1086#1084' '#1087#1086#1076#1076#1077#1088#1077#1074#1077'. '
    WordWrap = True
  end
  object ListViewNodes: TListView
    Left = 8
    Top = 59
    Width = 289
    Height = 169
    Columns = <
      item
        Caption = #1042#1077#1088#1096#1080#1085#1072
        MinWidth = 70
        Width = 70
      end
      item
        Caption = #1051#1077#1074#1099#1077' '#1087#1086#1090#1086#1084#1082#1080
        MinWidth = 90
        Width = 105
      end
      item
        Caption = #1055#1088#1072#1074#1099#1077' '#1087#1086#1090#1086#1084#1082#1080
        MinWidth = 100
        Width = 110
      end>
    TabOrder = 1
    ViewStyle = vsReport
  end
  object ButtonClose: TButton
    Left = 112
    Top = 234
    Width = 75
    Height = 25
    Cursor = crHandPoint
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 0
    OnClick = ButtonCloseClick
  end
end
