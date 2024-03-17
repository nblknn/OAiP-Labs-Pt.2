object InstructionForm: TInstructionForm
  Left = 0
  Top = 0
  Cursor = crHelp
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1048#1085#1089#1090#1088#1091#1082#1094#1080#1103
  ClientHeight = 214
  ClientWidth = 427
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  TextHeight = 15
  object LabelInstruction: TLabel
    Left = 184
    Top = 8
    Width = 85
    Height = 15
    Caption = 'LabelInstruction'
    WordWrap = True
  end
  object ButtonClose: TButton
    Left = 184
    Top = 184
    Width = 75
    Height = 25
    Cursor = crHandPoint
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 0
    OnClick = ButtonCloseClick
  end
end
