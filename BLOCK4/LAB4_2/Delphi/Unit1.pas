Unit Unit1;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.ExtDlgs;

Type
    TMainForm = Class(TForm)
        LabelCondition: TLabel;
        LabelX: TLabel;
        EditX: TEdit;
        LabelEps: TLabel;
        EditEps: TEdit;
        ButtonResult: TButton;
        EditY: TEdit;
        LabelY: TLabel;
        MainMenu: TMainMenu;
        MMFile: TMenuItem;
        MMOpenFile: TMenuItem;
        MMSaveFile: TMenuItem;
        MMExit: TMenuItem;
        MMSeparator: TMenuItem;
        MMInstruction: TMenuItem;
        MMDevInfo: TMenuItem;
        OpenTextFileDialog: TOpenTextFileDialog;
        SaveTextFileDialog: TSaveTextFileDialog;
        PopupMenu: TPopupMenu;
        Procedure ButtonResultClick(Sender: TObject);
        Procedure EditXKeyPress(Sender: TObject; Var Key: Char);
        Procedure EditEpsKeyPress(Sender: TObject; Var Key: Char);
        Procedure EditXKeyDown(Sender: TObject; Var Key: Word;
          Shift: TShiftState);
        Procedure EditEpsKeyDown(Sender: TObject; Var Key: Word;
          Shift: TShiftState);
        Procedure EditChange(Sender: TObject);
        Procedure EditXExit(Sender: TObject);
        Procedure EditEpsExit(Sender: TObject);
        Procedure MMOpenFileClick(Sender: TObject);
        Procedure MMSaveFileClick(Sender: TObject);
        Procedure MMExitClick(Sender: TObject);
        Procedure MMDevInfoClick(Sender: TObject);
        Procedure MMInstructionClick(Sender: TObject);
        Procedure FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
        Procedure FormKeyDown(Sender: TObject; Var Key: Word;
          Shift: TShiftState);
    End;

Var
    MainForm: TMainForm;
    IsSaved: Boolean;

Implementation

{$R *.dfm}

Const
    NULL = #0;
    BACKSPACE = #8;
    COMMA = ',';
    MIN = 0;
    MAX_EPS = 1;
    MAX_X = 100000;

Function CalcSquareRoot(X, Eps, Prev: Real): Real;
Var
    Y, Delta: Real;
Begin
    Y := 1 / 2 * (Prev + X / Prev);
    Delta := Abs(Y - Prev);
    If Delta > Eps Then
        CalcSquareRoot := CalcSquareRoot(X, Eps, Y)
    Else
        CalcSquareRoot := Y;
End;

Function IsNumCorrect(NumStr: String; Const MAXNUM: Integer): Boolean;
Var
    Num: Extended;
    IsCorrect: Boolean;
Begin
    IsCorrect := True;
    If Not TryStrToFloat(NumStr, Num) Then
    Begin
        IsCorrect := False;
        Application.MessageBox('Значения должны быть вещественными числами!',
          'Ошибка', MB_OK + MB_ICONERROR);
    End;
    If IsCorrect And ((Num > MAXNUM) Or (Num < MIN)) Then
    Begin
        IsCorrect := False;
        Application.MessageBox('Значение не попадает в диапазон!', 'Ошибка',
          MB_OK + MB_ICONERROR);
    End;
    IsNumCorrect := IsCorrect;
End;

Function IsNumEqualZero(NumStr: String): Boolean;
Var
    IsEqualZero: Boolean;
Begin
    IsEqualZero := False;
    If StrToFloat(NumStr) = MIN Then
    Begin
        IsEqualZero := True;
        Application.MessageBox('Значение не должно быть равно 0!', 'Ошибка',
          MB_OK + MB_ICONERROR);
    End;
    IsNumEqualZero := IsEqualZero;
End;

Function IsCommaInEdit(Txt: String): Boolean;
Var
    I, Len: Integer;
    IsCommaFound: Boolean;
Begin
    Len := Length(Txt);
    IsCommaFound := False;
    I := 1;
    While (I < Len + 1) And Not IsCommaFound Do
    Begin
        If Txt[I] = COMMA Then
            IsCommaFound := True;
        Inc(I);
    End;
    IsCommaInEdit := IsCommaFound;
End;

Function LengthBeforeComma(Txt: String): Integer;
Var
    I: Integer;
Begin
    I := 1;
    While Txt[I] <> COMMA Do
        Inc(I);
    LengthBeforeComma := I;
End;

Procedure EditKeyPress(SelStart, Len: Integer; EditText: String; Var Key: Char);
Begin
    If Not CharInSet(Key, ['0' .. '9', COMMA, BACKSPACE]) Then
        Key := NULL
    Else If IsCommaInEdit(EditText) And (Len - LengthBeforeComma(EditText) = 10)
      And (Key <> BACKSPACE) Then
        Key := NULL
    Else If (Len > 0) Then
        If (SelStart = 0) And (Key = '0') Then
            Key := NULL
        Else If (EditText = '0') And (SelStart = Len) And
          Not CharInSet(Key, [BACKSPACE, COMMA]) Then
            Key := NULL
        Else If (Key = COMMA) And
          (IsCommaInEdit(EditText) Or (SelStart = 0)) Then
            Key := NULL;
End;

Procedure TMainForm.ButtonResultClick(Sender: TObject);
Var
    X, Y, Eps: Real;
Begin
    If IsNumEqualZero(EditX.Text) Then
        EditX.Text := ''
    Else If IsNumEqualZero(EditEps.Text) Then
        EditEps.Text := ''
    Else
    Begin
        X := StrToFloat(EditX.Text);
        Eps := StrToFloat(EditEps.Text);
        Y := 1;
        Y := CalcSquareRoot(X, Eps, Y);
        EditY.Text := FormatFloat('0.##########', Y);
        EditY.Enabled := True;
        MMSaveFile.Enabled := True;
    End;
End;

Procedure TMainForm.EditEpsExit(Sender: TObject);
Begin
    If (EditEps.Text <> '') And (Not IsNumCorrect(EditEps.Text, MAX_X) Or
      IsNumEqualZero(EditEps.Text)) Then
        EditEps.Text := '';
End;

Procedure TMainForm.EditEpsKeyDown(Sender: TObject; Var Key: Word;
  Shift: TShiftState);
Begin
    If Key = VK_UP Then
        EditX.SetFocus
    Else If Key = VK_DOWN Then
        If ButtonResult.Enabled Then
            ButtonResult.SetFocus
        Else
            EditX.SetFocus;
End;

Procedure TMainForm.EditEpsKeyPress(Sender: TObject; Var Key: Char);
Var
    SelStart, Len: Integer;
    EditText: String;
Begin
    SelStart := EditEps.SelStart;
    EditText := EditEps.Text;
    Len := Length(EditText);
    EditKeyPress(SelStart, Len, EditText, Key);
    If (SelStart = 0) And Not(CharInSet(Key, ['0', BACKSPACE]) Or
      ((Key = '1') And (Len = 0))) Then
        Key := NULL
    Else If (EditText = '1') And (Key <> BACKSPACE) Then
        Key := NULL;
End;

Procedure TMainForm.EditChange(Sender: TObject);
Begin
    If (EditX.Text <> '') And Not IsNumCorrect(EditX.Text, MAX_X) Then
        EditX.Text := '';
    If (EditEps.Text <> '') And Not IsNumCorrect(EditEps.Text, MAX_EPS) Then
        EditEps.Text := '';
    ButtonResult.Enabled := (EditX.Text <> '') And (EditEps.Text <> '');
    EditY.Enabled := False;
    EditY.Text := '';
    IsSaved := False;
    MMSaveFile.Enabled := False;
End;

Procedure TMainForm.EditXExit(Sender: TObject);
Begin
    If (EditX.Text <> '') And (Not IsNumCorrect(EditX.Text, MAX_X) Or
      IsNumEqualZero(EditX.Text)) Then
        EditX.Text := '';
End;

Procedure TMainForm.EditXKeyDown(Sender: TObject; Var Key: Word;
  Shift: TShiftState);
Begin
    If Key = VK_DOWN Then
        EditEps.SetFocus
    Else If Key = VK_UP Then
        If ButtonResult.Enabled Then
            ButtonResult.SetFocus
        Else
            EditEps.SetFocus;
End;

Procedure TMainForm.EditXKeyPress(Sender: TObject; Var Key: Char);
Var
    SelStart, Len: Integer;
    EditText: String;
Begin
    SelStart := EditX.SelStart;
    EditText := EditX.Text;
    Len := Length(EditText);
    EditKeyPress(SelStart, Len, EditText, Key);
    If (Len > 4) And (Not IsCommaInEdit(EditText) Or
      (SelStart < LengthBeforeComma(EditText))) And
      ((StrToFloat(EditText) > MAX_X Div 10) And Not CharInSet(Key,
      [BACKSPACE, COMMA]) Or ((StrToFloat(EditText) = MAX_X Div 10) And
      Not CharInSet(Key, [BACKSPACE, COMMA, '0']))) Then
        Key := NULL;
    If (Len > 0) And (StrToFloat(EditText) = MAX_X) And (Key <> BACKSPACE) Then
        Key := NULL;
End;

Function IsFilePathCorrect(Path: String): Boolean;
Var
    IsCorrect: Boolean;
Begin
    IsCorrect := True;
    If ExtractFileExt(Path) <> '.txt' Then
    Begin
        Application.MessageBox('Файл не является текстовым!', 'Ошибка', MB_OK);
        IsCorrect := False;
    End;
    IsFilePathCorrect := IsCorrect;
End;

Procedure TMainForm.MMOpenFileClick(Sender: TObject);
Var
    XStr, EpsStr: String;
    IsCorrect: Boolean;
    FIn: TextFile;
Begin
    If OpenTextFileDialog.Execute And
      IsFilePathCorrect(OpenTextFileDialog.FileName) Then
    Begin
        Try
            Try
                IsCorrect := True;
                AssignFile(FIn, OpenTextFileDialog.FileName);
                Reset(FIn);
                Readln(FIn, XStr);
                IsCorrect := IsNumCorrect(XStr, MAX_X) And
                  Not IsNumEqualZero(XStr);
                If IsCorrect Then
                Begin
                    Readln(FIn, EpsStr);
                    IsCorrect := IsNumCorrect(EpsStr, MAX_EPS) And
                      Not IsNumEqualZero(EpsStr);
                    If Not Eof(FIn) Then
                    Begin
                        IsCorrect := False;
                        Application.MessageBox
                          ('В файле некорректное количество строк!', 'Ошибка',
                          MB_ICONERROR);
                    End;
                End;
            Finally
                CloseFile(FIn);
            End;
        Except
            IsCorrect := False;
            Application.MessageBox('Файл недоступен для чтения!', 'Ошибка',
              MB_ICONERROR);
        End;
        If IsCorrect Then
        Begin
            EditX.Text := XStr;
            EditEps.Text := EpsStr;
        End;
    End;
End;

Procedure TMainForm.MMSaveFileClick(Sender: TObject);
Var
    IsCorrect: Boolean;
    FOut: TextFile;
Begin
    IsCorrect := SaveTextFileDialog.Execute And
      IsFilePathCorrect(SaveTextFileDialog.FileName);
    If IsCorrect Then
        Try
            Try
                IsCorrect := True;
                AssignFile(FOut, SaveTextFileDialog.FileName);
                Rewrite(FOut);
                Writeln(FOut, 'Квадратный корень из ', EditX.Text,
                  ' с точностью ', EditEps.Text, ' равен ', EditY.Text);
            Finally
                CloseFile(FOut);
            End;
        Except
            IsCorrect := False;
            Application.MessageBox('Произошла ошибка при записи в файл!',
              'Ошибка', MB_ICONERROR);
        End;
    IsSaved := IsCorrect;
End;

Procedure TMainForm.FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
Var
    ButtonSelected: Integer;
Begin
    If MMSaveFile.Enabled And Not IsSaved Then
    Begin
        ButtonSelected := Application.MessageBox
          ('Желаете сохранить результат в файл?', 'Выход',
          MB_YESNOCANCEL + MB_ICONQUESTION);
        If ButtonSelected = MrYes Then
        Begin
            MMSaveFileClick(Sender);
            If Not IsSaved Then
                Close;
        End
        Else If ButtonSelected = MrNo Then
            CanClose := True
        Else
            CanClose := False;
    End
    Else
    Begin
        ButtonSelected := Application.MessageBox
          ('Вы уверены, что хотите выйти?', 'Выход',
          MB_YESNO + MB_ICONQUESTION);
        If ButtonSelected = MrYes Then
            CanClose := True
        Else
            CanClose := False;
    End;
End;

Procedure TMainForm.FormKeyDown(Sender: TObject; Var Key: Word;
  Shift: TShiftState);
Begin
    If (Key = VK_RETURN) And ButtonResult.Enabled Then
        ButtonResult.Click
    Else If Key = VK_F1 Then
        MMInstruction.Click;
End;

Procedure TMainForm.MMDevInfoClick(Sender: TObject);
Begin
    Application.MessageBox('Городко Ксения Евгеньевна'#13#10'351005 группа',
      'О разработчике', MB_OK);
End;

Procedure TMainForm.MMExitClick(Sender: TObject);
Begin
    MainForm.Close;
End;

Procedure TMainForm.MMInstructionClick(Sender: TObject);
Begin
    Application.MessageBox
      ('1. Х и Eps должны быть вещественными числами.'#13#10'2. Диапазон Х - (0, 100000); диапазон Eps - (0, 1].'#13#10'3. В файле должно быть 2 строки: первая со значением X, вторая - с Eps.',
      'Инструкция', MB_OK);
End;

End.
