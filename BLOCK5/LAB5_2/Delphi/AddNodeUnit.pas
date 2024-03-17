Unit AddNodeUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls,
    InstructionUnit;

Type
    TAddNodeForm = Class(TForm)
        MainMenu: TMainMenu;
        MMInstruction: TMenuItem;
        EditValue: TEdit;
        LabelValue: TLabel;
        ButtonAdd: TButton;
        ButtonCancel: TButton;
        PopupMenu: TPopupMenu;
        Procedure AddValueToTree(Value: Integer);
        Procedure ButtonAddClick(Sender: TObject);
        Procedure ButtonCancelClick(Sender: TObject);
        Procedure EditValueChange(Sender: TObject);
        Procedure EditValueKeyPress(Sender: TObject; Var Key: Char);
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
        Procedure FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
        Procedure FormKeyDown(Sender: TObject; Var Key: Word;
          Shift: TShiftState);
        Procedure FormShow(Sender: TObject);
        Function FormHelp(Command: Word; Data: NativeInt;
          Var CallHelp: Boolean): Boolean;
        Procedure MMInstructionClick(Sender: TObject);
    End;

Var
    AddNodeForm: TAddNodeForm;

Implementation

{$R *.dfm}

Uses MainUnit;

Const
    NUMBERS = ['0' .. '9'];
    MINUS = '-';
    NULL = #0;
    BACKSPACE = #8;

Var
    IsEditChanged: Boolean;

Procedure AddNode(Value: Integer); External 'LIBRARY5_2.dll';
Procedure CreateTree(RootValue: Integer); External 'LIBRARY5_2.dll';

Procedure TAddNodeForm.AddValueToTree(Value: Integer);
Begin
    If Not IsTreeCreated Then
    Begin
        CreateTree(Value);
        IsTreeCreated := True;
        MainForm.ButtonShowTree.Enabled := True;
        MainForm.MMSaveFile.Enabled := True;
    End
    Else
        AddNode(Value);
    IsSaved := False;
End;

Procedure TAddNodeForm.ButtonAddClick(Sender: TObject);
Var
    Value: Integer;
    Error: TError;
Begin
    Value := StrToInt(EditValue.Text);
    Error := MainForm.CheckNodeValue(Value);
    If Error = Correct Then
        AddValueToTree(Value)
    Else
        MainForm.ShowErrorMessage(Error);
    IsEditChanged := False;
    Close;
End;

Procedure TAddNodeForm.ButtonCancelClick(Sender: TObject);
Begin
    Close;
End;

Procedure TAddNodeForm.EditValueChange(Sender: TObject);
Begin
    ButtonAdd.Enabled := (EditValue.Text <> '') And (EditValue.Text <> MINUS);
    IsEditChanged := ButtonAdd.Enabled;
End;

Procedure TAddNodeForm.EditValueKeyPress(Sender: TObject; Var Key: Char);
Var
    SelStart, Len: Integer;
    EditText: String;
Begin
    SelStart := EditValue.SelStart;
    EditText := EditValue.Text;
    Len := Length(EditText);
    If Not CharInSet(Key, NUMBERS) And
      Not CharInSet(Key, [BACKSPACE, MINUS]) Then
        Key := NULL
    Else If (Selstart > 0) And (Key = MINUS) Then
        Key := NULL
    Else If (SelStart = 0) And (Len > 0) And (EditText[1] = MINUS) And
      (Key = MINUS) Then
        Key := NULL
    Else If (Len > 2) And ((Abs(StrToInt(EditText)) > MAXVALUE Div 10) Or
      (Abs(StrToInt(EditText)) = MAXVALUE)) And
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

Procedure TAddNodeForm.FormClose(Sender: TObject; Var Action: TCloseAction);
Begin
    EditValue.Text := '';
End;

Procedure TAddNodeForm.FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
Var
    ButtonSelected: Integer;
Begin
    If IsEditChanged Then
    Begin
        ButtonSelected := Application.MessageBox
          ('Вы уверены, что хотите отменить добавление узла?', 'Отмена',
          MB_YESNO + MB_ICONQUESTION);
        If ButtonSelected = MrYes Then
            CanClose := True
        Else
            CanClose := False;
    End
    Else
        CanClose := True;
End;

Function TAddNodeForm.FormHelp(Command: Word; Data: NativeInt;
  Var CallHelp: Boolean): Boolean;
Begin
    InstructionForm.ShowModal;
    CallHelp := False;
End;

Procedure TAddNodeForm.FormKeyDown(Sender: TObject; Var Key: Word;
  Shift: TShiftState);
Begin
    If Key = VK_ESCAPE Then
        Close
    Else If (Key = 13) And ButtonAdd.Enabled Then
        ButtonAdd.Click
    Else If Key = VK_INSERT Then
        Key := Ord(NULL);
End;

Procedure TAddNodeForm.FormShow(Sender: TObject);
Begin
    IsEditChanged := False;
End;

Procedure TAddNodeForm.MMInstructionClick(Sender: TObject);
Begin
    InstructionForm.ShowModal;
End;

End.
