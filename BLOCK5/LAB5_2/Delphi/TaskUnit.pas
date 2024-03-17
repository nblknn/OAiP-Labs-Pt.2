Unit TaskUnit;

Interface

Uses
    Winapi.Windows, System.Classes, Vcl.Forms, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Controls;

Type
    TTaskForm = Class(TForm)
        LabelTask: TLabel;
        ListViewNodes: TListView;
        ButtonClose: TButton;
        Procedure ButtonCloseClick(Sender: TObject);
        Procedure FormShow(Sender: TObject);
        Procedure FormKeyDown(Sender: TObject; Var Key: Word;
          Shift: TShiftState);
    End;

Var
    TaskForm: TTaskForm;

Implementation

{$R *.dfm}
Procedure ShowUnequalNodes(ListView: TListView); External 'LIBRARY5_2.dll';

Procedure TTaskForm.ButtonCloseClick(Sender: TObject);
Begin
    Close;
End;

Procedure TTaskForm.FormKeyDown(Sender: TObject; Var Key: Word;
  Shift: TShiftState);
Begin
    If Key = VK_ESCAPE Then
        Close;
End;

Procedure TTaskForm.FormShow(Sender: TObject);
Begin
    ShowUnequalNodes(ListViewNodes);
End;

End.
