Unit UnitRecord;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls,
    UnitInstruction;

Type
    TFormRecord = Class(TForm)
        MainMenu: TMainMenu;
        MMInstruction: TMenuItem;
        LabelModel: TLabel;
        EditModel: TEdit;
        LabelCountry: TLabel;
        EditCountry: TEdit;
        LabelYear: TLabel;
        EditYear: TEdit;
        LabelPrice: TLabel;
        EditPrice: TEdit;
        ButtonSave: TButton;
        ButtonCancel: TButton;
        PopupMenu: TPopupMenu;

        Procedure MMInstructionClick(Sender: TObject);
        Procedure EditOnChange(Sender: TObject);
        Procedure EditModelKeyDown(Sender: TObject; Var Key: Word;
          Shift: TShiftState);
        Procedure EditModelKeyPress(Sender: TObject; Var Key: Char);
        Procedure EditCountryKeyDown(Sender: TObject; Var Key: Word;
          Shift: TShiftState);
        Procedure EditCountryKeyPress(Sender: TObject; Var Key: Char);
        Procedure EditYearKeyDown(Sender: TObject; Var Key: Word;
          Shift: TShiftState);
        Procedure EditYearKeyPress(Sender: TObject; Var Key: Char);
        Procedure EditYearExit(Sender: TObject);
        Procedure EditPriceKeyDown(Sender: TObject; Var Key: Word;
          Shift: TShiftState);
        Procedure EditPriceKeyPress(Sender: TObject; Var Key: Char);
        Procedure EditPriceExit(Sender: TObject);
        Procedure ClearEdits();
        Procedure ChangeRecord(Index: Integer);
        Procedure ButtonCancelClick(Sender: TObject);
        Procedure ButtonSaveClick(Sender: TObject);
        Procedure FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
        Procedure FormKeyDown(Sender: TObject; Var Key: Word;
          Shift: TShiftState);
        Procedure FormShow(Sender: TObject);
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    FormRecord: TFormRecord;
    IsRecordChanging: Boolean;

Implementation

{$R *.dfm}

Uses UnitMain;

Const
    LATINLETTERS = ['A' .. 'Z', 'a' .. 'z'];
    NUMBERS = ['0' .. '9'];
    SPACE = ' ';
    HYPHEN = '-';
    NULL = #0;
    BACKSPACE = #8;

Var
    IsChanged: Boolean;

Procedure TFormRecord.MMInstructionClick(Sender: TObject);
Begin
    FormInstruction.ShowModal;
End;

Function IsNumCorrect(NumStr: String; Const MINNUM, MAXNUM: Integer): Boolean;
Var
    Num: Integer;
    IsCorrect: Boolean;
Begin
    IsCorrect := True;
    If Not TryStrToInt(NumStr, Num) Then
    Begin
        IsCorrect := False;
        Application.MessageBox
          ('Значения года и цены должны быть целыми числами!', 'Ошибка',
          MB_OK + MB_ICONERROR);
    End
    Else If ((Num > MAXNUM) Or (Num < MINNUM)) Then
    Begin
        IsCorrect := False;
        Application.MessageBox
          ('Значение года и/или цены не попадает в диапазон!', 'Ошибка',
          MB_OK + MB_ICONERROR);
    End;
    IsNumCorrect := IsCorrect;
End;

Procedure NumEditKeyPress(SelStart, Len: Integer; EditText: String;
  Var Key: Char);
Begin
    If Not CharInSet(Key, NUMBERS) And (Key <> BACKSPACE) Then
        Key := NULL
    Else If (SelStart = 0) And (Key = '0') And (Len > 0) Then
        Key := NULL
    Else If (EditText = '0') And (SelStart = Len) And (Key <> BACKSPACE) Then
        Key := NULL;
End;

Procedure StringEditKeyPress(Edit: TEdit; Var Key: Char);
Var
    Len, SelStart: Integer;
    EditText: String;
Begin
    EditText := Edit.Text;
    Len := Length(EditText);
    SelStart := Edit.SelStart;
    If (Len = MAXLENGTH) And (Key <> BACKSPACE) Then
        Key := NULL
    Else If ((Key < 'А') Or (Key > 'я')) And
      Not CharInSet(Key, [SPACE, HYPHEN, BACKSPACE]) And
      Not CharInSet(Key, LATINLETTERS) Then
        Key := NULL
    Else If (SelStart = 0) And CharInSet(Key, [SPACE, HYPHEN]) Then
        Key := NULL
    Else If CharInSet(Key, [SPACE, HYPHEN]) And (Len > 0) And
      ((SelStart < Len) And CharInSet(EditText[SelStart + 1], [SPACE, HYPHEN])
      Or CharInSet(EditText[SelStart], [SPACE, HYPHEN])) Then
        Key := NULL;
End;

Procedure TFormRecord.EditCountryKeyDown(Sender: TObject; Var Key: Word;
  Shift: TShiftState);
Begin
    If Key = VK_DOWN Then
        EditYear.SetFocus
    Else If Key = VK_UP Then
        EditModel.SetFocus
    Else If Key = VK_CONTROL Then
        Key := Ord(NULL);
End;

Procedure TFormRecord.EditCountryKeyPress(Sender: TObject; Var Key: Char);
Begin
    StringEditKeyPress(EditCountry, Key);
End;

Procedure TFormRecord.EditModelKeyDown(Sender: TObject; Var Key: Word;
  Shift: TShiftState);
Begin
    If Key = VK_DOWN Then
        EditCountry.SetFocus
    Else If Key = VK_UP Then
        EditPrice.SetFocus
    Else If Key = VK_CONTROL Then
        Key := Ord(NULL);
End;

Procedure TFormRecord.EditModelKeyPress(Sender: TObject; Var Key: Char);
Begin
    StringEditKeyPress(EditModel, Key);
End;

Procedure EditOnExit(Var Edit: TEdit; Const MINNUM, MAXNUM: Integer);
Begin
    If (Edit.Text <> '') And Not(IsNumCorrect(Edit.Text, MINNUM, MAXNUM)) Then
        Edit.Text := '';
End;

Procedure TFormRecord.EditYearKeyDown(Sender: TObject; Var Key: Word;
  Shift: TShiftState);
Begin
    If Key = VK_DOWN Then
        EditPrice.SetFocus
    Else If Key = VK_UP Then
        EditCountry.SetFocus;
End;

Procedure TFormRecord.EditYearExit(Sender: TObject);
Begin
    EditOnExit(EditYear, MINYEAR, MAXYEAR);
End;

Procedure TFormRecord.EditYearKeyPress(Sender: TObject; Var Key: Char);
Var
    SelStart, Len: Integer;
    EditText: String;
Begin
    SelStart := EditYear.SelStart;
    EditText := EditYear.Text;
    Len := Length(EditText);
    NumEditKeyPress(SelStart, Len, EditText, Key);
    If (Len = 4) And (Key <> BACKSPACE) Then
        Key := NULL
    Else If (SelStart = 0) And Not CharInSet(Key, ['1', '2', BACKSPACE]) Then
        Key := NULL
    Else If (Len > 0) And (SelStart = 0) And
      ((Key = '1') And (EditText[1] <> '9') Or (Key = '2') And
      (EditText[1] <> '0')) Then
        Key := NULL
    Else If (Len > 0) And (SelStart = 1) And
      ((EditText[1] = '1') And (Key <> '9') Or (EditText[1] = '2') And
      (Key <> '0')) And (Key <> BACKSPACE) Then
        Key := NULL
    Else If (Len > 1) And (SelStart = 2) And (EditText[1] = '2') And
      Not CharInSet(Key, [BACKSPACE, '0' .. '2']) Then
        Key := NULL
    Else If (EditText = '202') And
      Not CharInSet(Key, ['0' .. '4', BACKSPACE]) Then
        Key := NULL;
End;

Procedure TFormRecord.EditPriceKeyDown(Sender: TObject; Var Key: Word;
  Shift: TShiftState);
Begin
    If Key = VK_DOWN Then
        EditModel.SetFocus
    Else If Key = VK_UP Then
        EditYear.SetFocus;
End;

Procedure TFormRecord.EditPriceKeyPress(Sender: TObject; Var Key: Char);
Var
    SelStart, Len: Integer;
    EditText: String;
Begin
    SelStart := EditPrice.SelStart;
    EditText := EditPrice.Text;
    Len := Length(EditText);
    NumEditKeyPress(SelStart, Len, EditText, Key);
    If (Len > 8) And ((StrToInt(EditText) > MAXYEAR Div 10) Or
      (StrToInt(EditText) = MAXYEAR)) And (Key <> BACKSPACE) Then
        Key := NULL;
End;

Procedure TFormRecord.EditPriceExit(Sender: TObject);
Begin
    EditOnExit(EditPrice, MINPRICE, MAXPRICE);
End;

Procedure TFormRecord.EditOnChange(Sender: TObject);
Begin
    ButtonSave.Enabled := (EditModel.Text <> '') And (EditCountry.Text <> '')
      And (EditYear.Text <> '') And (EditPrice.Text <> '');
    IsChanged := True;
End;

Procedure TFormRecord.ClearEdits();
Begin
    EditModel.Text := '';
    EditCountry.Text := '';
    EditYear.Text := '';
    EditPrice.Text := '';
End;

Procedure TFormRecord.ChangeRecord(Index: Integer);
Begin
    With MainList[Index] Do
    Begin
        Model := EditModel.Text;
        Country := EditCountry.Text;
        Year := StrToInt(EditYear.Text);
        Price := StrToInt(EditPrice.Text);
    End;
End;

Procedure TFormRecord.ButtonCancelClick(Sender: TObject);
Begin
    Close;
End;

Procedure TFormRecord.ButtonSaveClick(Sender: TObject);
Begin
    If IsRecordChanging Then
    Begin
        ChangeRecord(SelectedIndex);
        MainForm.ChangeListViewItem(MainForm.MainListView, MainList);
    End
    Else
    Begin
        SetLength(MainList, Length(MainList) + 1);
        ChangeRecord(High(MainList));
        MainForm.AddItemToListView(MainForm.MainListView, MainList);
    End;
    IsChanged := False;
    Close;
End;

Procedure TFormRecord.FormClose(Sender: TObject; Var Action: TCloseAction);
Begin
    ClearEdits();
End;

Procedure TFormRecord.FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
Var
    ButtonSelected: Integer;
Begin
    If IsChanged Then
    Begin
        ButtonSelected := Application.MessageBox
          ('Вы уверены, что хотите отменить ввод записи?', 'Отмена',
          MB_YESNO + MB_ICONQUESTION);
        If ButtonSelected = MrYes Then
            CanClose := True
        Else
            CanClose := False;
    End
    Else
        CanClose := True;
End;

Procedure TFormRecord.FormKeyDown(Sender: TObject; Var Key: Word;
  Shift: TShiftState);
Begin
    If Key = VK_F1 Then
        FormInstruction.ShowModal
    Else If (Key = 13) And (ButtonSave.Enabled) Then
        If Not IsNumCorrect(EditYear.Text, MINYEAR, MAXYEAR) Then
            EditYear.Text := ''
        Else If Not IsNumCorrect(EditPrice.Text, MINPRICE, MAXPRICE) Then
            EditPrice.Text := ''
        Else
            ButtonSave.Click
    Else If Key = VK_ESCAPE Then
        Close;
End;

Procedure TFormRecord.FormShow(Sender: TObject);
Begin
    EditModel.SetFocus;
    If IsRecordChanging Then
    Begin
        FormRecord.Caption := 'Редактировать запись';
        ButtonSave.Caption := 'Сохранить';
        With MainList[SelectedIndex] Do
        Begin
            EditModel.Text := Model;
            EditCountry.Text := Country;
            EditYear.Text := IntToStr(Year);
            EditPrice.Text := IntToStr(Price);
        End;
    End
    Else
    Begin
        FormRecord.Caption := 'Добавить запись';
        ButtonSave.Caption := 'Добавить';
    End;
    IsChanged := False;
End;

End.
