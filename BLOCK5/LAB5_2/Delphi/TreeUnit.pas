Unit TreeUnit;

Interface

Uses
    Winapi.Windows, System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms,
    Vcl.ExtCtrls, Vcl.StdCtrls, AddNodeUnit, TaskUnit;

Type
    TTreeForm = Class(TForm)
        ScrollBox: TScrollBox;
        ImageTree: TImage;
        ButtonAddNode: TButton;
        ButtonTask: TButton;
        Procedure FormShow(Sender: TObject);
        Procedure ButtonAddNodeClick(Sender: TObject);
        Procedure ButtonTaskClick(Sender: TObject);
        Procedure FormKeyDown(Sender: TObject; Var Key: Word;
          Shift: TShiftState);
    End;

Var
    TreeForm: TTreeForm;

Implementation

{$R *.dfm}
Procedure VisualizeTree(Image: TImage); External 'LIBRARY5_2.dll';

Procedure TTreeForm.ButtonAddNodeClick(Sender: TObject);
Begin
    AddNodeForm.ShowModal;
    VisualizeTree(ImageTree);
End;

Procedure TTreeForm.ButtonTaskClick(Sender: TObject);
Begin
    TaskForm.ShowModal;
End;

Procedure TTreeForm.FormKeyDown(Sender: TObject; Var Key: Word;
  Shift: TShiftState);
Begin
    If Key = VK_ESCAPE Then
        Close;
End;

Procedure TTreeForm.FormShow(Sender: TObject);
Begin
    VisualizeTree(ImageTree);
End;

End.
