Unit DevInfoUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.Pngimage,
    Vcl.StdCtrls;

Type
    TDevInfoForm = Class(TForm)
        ImageDev: TImage;
        LabelDevInfo: TLabel;
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

Procedure TDevInfoForm.FormKeyDown(Sender: TObject; Var Key: Word;
  Shift: TShiftState);
Begin
    If Key = VK_ESCAPE Then
        Close;
End;

End.
