Unit UnitInstruction;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

Type
    TFormInstruction = Class(TForm)
        LabelInstruction: TLabel;
        ButtonClose: TButton;
        Procedure FormCreate(Sender: TObject);
        Procedure ButtonCloseClick(Sender: TObject);
        Procedure FormKeyDown(Sender: TObject; Var Key: Word;
          Shift: TShiftState);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    FormInstruction: TFormInstruction;

Implementation

{$R *.dfm}

Procedure TFormInstruction.ButtonCloseClick(Sender: TObject);
Begin
    Close;
End;

Procedure TFormInstruction.FormCreate(Sender: TObject);
Begin
    LabelInstruction.Caption :=
      '��������� ������:'#13#10'1. ��� ���������� ������, ������� �� ������ "����� ������" � ������� ������ � ����� ����.'#13#10'2. ��� ��������� ������, ������� �� ������ ������ 2 ����.'#13#10'3. ��� ��������, �������� ������ ������ � ������� �� ������ "�������".'#13#10#13#10
      + '������:'#13#10'1. ������������ ����� ������ � ����� � �����������-������������� - 20 ��������.'#13#10'2. ��� ������� � ���� - ����� �����.'#13#10'3. �������� ���� �������: 1900..2024.'#13#10'4. �������� ����: 0..999999999.'#13#10'5. ������������ ���������� ������� - 30.'#13#10#13#10
      + '�����:'#13#10'1. �����������/����������� ���� ������ ���� ������� *.carlist.'#13#10'2. ��� ���������� ������ ���������� ����� ����������������.'#13#10#13#10;
    LabelInstruction.Width := 500;
    LabelInstruction.Left := (ClientWidth - LabelInstruction.Width) Div 2;
End;

Procedure TFormInstruction.FormKeyDown(Sender: TObject; Var Key: Word;
  Shift: TShiftState);
Begin
    If Key = VK_ESCAPE Then
        Close;
End;

End.
