Unit DevInfoUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.Pngimage,
    Vcl.StdCtrls;

Type
    TDevInfoForm = Class(TForm)
        Image1: TImage;
        LabelDevInfo: TLabel;
        ButtonClose: TButton;
        Procedure FormCreate(Sender: TObject);
        Procedure ButtonCloseClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    DevInfoForm: TDevInfoForm;

Implementation

{$R *.dfm}

Procedure TDevInfoForm.ButtonCloseClick(Sender: TObject);
Begin
    Close;
End;

Procedure TDevInfoForm.FormCreate(Sender: TObject);
Begin
    LabelDevInfo.Caption := 'Городко Ксения Евгеньевна'#13#10'351005 группа';
    LabelDevInfo.Width := 200;
    LabelDevInfo.Left := (ClientWidth - LabelDevInfo.Width) Div 2;
End;

procedure TDevInfoForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key = VK_ESCAPE then
      Close;
end;

End.
