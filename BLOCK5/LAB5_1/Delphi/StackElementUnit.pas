Unit StackElementUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls,
    InstructionUnit, DevInfoUnit;

Type
    TStackElementForm = Class(TForm)
        MainMenu: TMainMenu;
        MMInstruction: TMenuItem;
        MMDevInfo: TMenuItem;
        EditElement: TEdit;
    LabelElement: TLabel;
        ButtonPush: TButton;
        ButtonCancel: TButton;
    PopupMenu: TPopupMenu;
        Procedure ButtonCancelClick(Sender: TObject);
        Procedure ButtonPushClick(Sender: TObject);
        Procedure MMInstructionClick(Sender: TObject);
        Procedure MMDevInfoClick(Sender: TObject);
        Procedure EditElementKeyPress(Sender: TObject; Var Key: Char);
        Procedure EditElementChange(Sender: TObject);
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
        Procedure FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
        Procedure FormKeyDown(Sender: TObject; Var Key: Word;
          Shift: TShiftState);
        Procedure FormShow(Sender: TObject);
    End;

Var
    StackElementForm: TStackElementForm;

Implementation

{$R *.dfm}

Uses MainUnit;

Const
    NUMBERS = ['0' .. '9'];
    MINUS = '-';
    NULL = #0;
    BACKSPACE = #8;

Var
    IsEmpty: Boolean;

Procedure StackPush(Num: Integer); External 'LIBRARY5_1.dll';

Procedure TStackElementForm.ButtonCancelClick(Sender: TObject);
Begin
    Close;
End;

Procedure TStackElementForm.ButtonPushClick(Sender: TObject);
Begin
    StackPush(StrToInt(EditElement.Text));
    MainForm.AddItemToListView(MainForm.ListViewStack,
      StrToInt(EditElement.Text));
    IsEmpty := True;
    Close;
End;

Procedure TStackElementForm.EditElementChange(Sender: TObject);
Begin
    ButtonPush.Enabled := (EditElement.Text <> '') And
      (EditElement.Text <> MINUS);
    IsEmpty := Not ButtonPush.Enabled;
End;

Procedure TStackElementForm.EditElementKeyPress(Sender: TObject; Var Key: Char);
Var
    SelStart, Len: Integer;
    EditText: String;
Begin
    SelStart := EditElement.SelStart;
    EditText := EditElement.Text;
    Len := Length(EditText);
    If Not CharInSet(Key, NUMBERS) And
      Not CharInSet(Key, [BACKSPACE, MINUS]) Then
        Key := NULL
    Else If (Selstart > 0) And (Key = MINUS) Then
        Key := NULL
    Else If (SelStart = 0) And (Len > 0) And (EditText[1] = MINUS) And
      (Key = MINUS) Then
        Key := NULL
    Else If (Len > 5) And ((Abs(StrToInt(EditText)) > MAXNUM Div 10) Or
      (Abs(StrToInt(EditText)) = MAXNUM)) And
      Not CharInSet(Key, [BACKSPACE, MINUS]) Then
        Key := NULL
    Else If (Key = '0') And (Len > 0) And
      ((SelStart = 0) Or (SelStart = 1) And (EditText[1] = MINUS)) Then
        Key := NULL
    Else If (EditText = '0') Then
        If (SelStart = Len) And (Key <> BACKSPACE) Then
            Key := NULL
        Else If (SelStart = 0) And (Key = MINUS) Then
            Key := NULL;
End;

Procedure TStackElementForm.FormClose(Sender: TObject;
  Var Action: TCloseAction);
Begin
    EditElement.Text := '';
End;

Procedure TStackElementForm.FormCloseQuery(Sender: TObject;
  Var CanClose: Boolean);
Var
    ButtonSelected: Integer;
Begin
    If Not IsEmpty Then
    Begin
        ButtonSelected := Application.MessageBox
          ('Вы уверены, что хотите отменить ввод элемента?', 'Отмена',
          MB_YESNO + MB_ICONQUESTION);
        If ButtonSelected = MrYes Then
            CanClose := True
        Else
            CanClose := False;
    End
    Else
        CanClose := True;
End;

Procedure TStackElementForm.FormKeyDown(Sender: TObject; Var Key: Word;
  Shift: TShiftState);
Begin
    If Key = VK_ESCAPE Then
        Close
    Else If (Key = 13) And ButtonPush.Enabled Then
        ButtonPush.Click;
End;

Procedure TStackElementForm.FormShow(Sender: TObject);
Begin
    IsEmpty := True;
End;

Procedure TStackElementForm.MMDevInfoClick(Sender: TObject);
Begin
    DevInfoForm.ShowModal;
End;

Procedure TStackElementForm.MMInstructionClick(Sender: TObject);
Begin
    InstructionForm.ShowModal;
End;

End.
