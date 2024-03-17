Unit InstructionUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

Type
    TInstructionForm = Class(TForm)
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
      'ИЗМЕНЕНИЕ СТЕКА:'#13#10'1. Можно удалить только последний добавленный в стек элемент.'#13#10'2. Элементы стека - целые числа в диапазоне -999999..999999.'#13#10'3. Максимальное количество элементов в стеке - 30.'#13#10#13#10
      + 'ФАЙЛЫ:'#13#10'1. Открываемый/сохраняемый файл должен быть формата *.txt.'#13#10'2. В открываемом файле должно быть записано только 1 число, которое добавится в стек.'#13#10'3. При сохранении данные указанного файла перезаписываются.';
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
