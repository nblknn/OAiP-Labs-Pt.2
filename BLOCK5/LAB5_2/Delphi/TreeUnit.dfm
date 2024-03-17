object TreeForm: TTreeForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1044#1077#1088#1077#1074#1086
  ClientHeight = 414
  ClientWidth = 546
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
  object ScrollBox: TScrollBox
    Left = 16
    Top = 47
    Width = 513
    Height = 359
    TabOrder = 0
    object ImageTree: TImage
      Left = -2
      Top = -2
      Width = 417
      Height = 252
    end
  end
  object ButtonAddNode: TButton
    Left = 16
    Top = 8
    Width = 209
    Height = 25
    Cursor = crHandPoint
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074#1077#1088#1096#1080#1085#1091
    TabOrder = 1
    OnClick = ButtonAddNodeClick
  end
  object ButtonTask: TButton
    Left = 320
    Top = 8
    Width = 209
    Height = 25
    Cursor = crHandPoint
    Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1087#1086' '#1079#1072#1076#1072#1085#1080#1102
    TabOrder = 2
    OnClick = ButtonTaskClick
  end
end
