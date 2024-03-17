Unit InstructionUnit;

Interface

Uses
    Winapi.Windows, System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms,
    Vcl.StdCtrls;

Type
    TInstructionForm = Class(TForm)
        LabelInstruction: TLabel;
        ButtonClose: TButton;
        Procedure FormCreate(Sender: TObject);
        Procedure ButtonCloseClick(Sender: TObject);
        Procedure FormKeyDown(Sender: TObject; Var Key: Word;
          Shift: TShiftState);
    End;

Var
    InstructionForm: TInstructionForm;

Implementation

{$R *.dfm}

Procedure TInstructionForm.ButtonCloseClick(Sender: TObject);
Begin
    Close;
End;

Procedure TInstructionForm.FormCreate(Sender: TObject);
Begin
    LabelInstruction.Caption :=
      '��������� ������:'#13#10'1. �������� ������ - ����� ����� � ��������� -999..999.'#13#10'2. �������� � ������ �� ����� �����������.'#13#10'3. ������������ ������ ������ - 7.'#13#10#13#10
      + '�����:'#13#10'1. �����������/����������� ���� ������ ���� ������� *.txt.'#13#10'2. � ����������� ����� ������ ���� �������� ������ 1 �����, ������� ��������� � ������.'#13#10'3. ��� ���������� ������ ���������� ����� ����������������.';
    LabelInstruction.Width := 500;
    LabelInstruction.Left := (ClientWidth - LabelInstruction.Width) Div 2;
End;

Procedure TInstructionForm.FormKeyDown(Sender: TObject; Var Key: Word;
  Shift: TShiftState);
Begin
    If Key = VK_ESCAPE Then
        Close;
End;

End.
