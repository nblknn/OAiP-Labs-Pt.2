Unit MainUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls, Vcl.StdCtrls,
    Vcl.ComCtrls, StackElementUnit, InstructionUnit, DevInfoUnit;

Const
    MAXELEMENTS = 30;
    MINNUM = -999999;
    MAXNUM = 999999;

Type
    TMainForm = Class(TForm)
        ButtonCreate: TButton;
        ButtonDestroy: TButton;
        ButtonPop: TButton;
        ButtonPush: TButton;
        LabelProgramInfo: TLabel;
        ListViewStack: TListView;
        MainMenu: TMainMenu;
        MMFile: TMenuItem;
        MMOpenFile: TMenuItem;
        MMSaveFile: TMenuItem;
        MMSeparator: TMenuItem;
        MMExit: TMenuItem;
        MMInstruction: TMenuItem;
        MMDevInfo: TMenuItem;
        OpenDialog: TOpenDialog;
        SaveDialog: TSaveDialog;
        Procedure ButtonCreateClick(Sender: TObject);
        Procedure ButtonDestroyClick(Sender: TObject);
        Procedure ButtonPopClick(Sender: TObject);
        Procedure ButtonPushClick(Sender: TObject);
        Procedure AddItemToListView(ListView: TListView; Element: Integer);
        Procedure ClearListView(ListView: TListView);
        Procedure ListViewOnChange(Num: Integer);
        Procedure ListViewStackChange(Sender: TObject; Item: TListItem;
          Change: TItemChange);
        Procedure ListViewStackDeletion(Sender: TObject; Item: TListItem);
        Procedure EnableComponents(IsEnabled: Boolean);
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
        Procedure FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
        Procedure FormCreate(Sender: TObject);
        Procedure FormResize(Sender: TObject);
        Function FormHelp(Command: Word; Data: NativeInt;
          Var CallHelp: Boolean): Boolean;
        Procedure MMDevInfoClick(Sender: TObject);
        Procedure MMExitClick(Sender: TObject);
        Procedure MMInstructionClick(Sender: TObject);
        Procedure MMOpenFileClick(Sender: TObject);
        Procedure MMSaveFileClick(Sender: TObject);
    End;

Var
    MainForm: TMainForm;
    IsSaved, IsCreated: Boolean;

Implementation

{$R *.dfm}
Procedure CreateStack(); External 'LIBRARY5_1.dll';

Procedure StackPush(Num: Integer); External 'LIBRARY5_1.dll';

Procedure StackPop(); External 'LIBRARY5_1.dll';

Procedure DestroyStack(); External 'LIBRARY5_1.dll';

Procedure TMainForm.ButtonCreateClick(Sender: TObject);
Begin
    If IsCreated Then
    Begin
        DestroyStack();
        ClearListView(ListViewStack);
    End;
    CreateStack();
    IsSaved := True;
    IsCreated := True;
    EnableComponents(True);
    ButtonPush.SetFocus;
    ClientHeight := 360;
End;

Procedure TMainForm.ButtonDestroyClick(Sender: TObject);
Var
    ButtonSelected: Integer;
Begin
    ButtonSelected := Application.MessageBox
      ('Вы уверены, что хотите уничтожить стек?', 'Уничтожение стека',
      MB_YESNO + MB_ICONQUESTION);
    If ButtonSelected = MrYes Then
    Begin
        DestroyStack();
        IsCreated := False;
        ClearListView(ListViewStack);
        EnableComponents(False);
        ButtonCreate.SetFocus;
        ClientHeight := 150;
    End
End;

Procedure TMainForm.ButtonPopClick(Sender: TObject);
Var
    ButtonSelected: Integer;
Begin
    ButtonSelected := Application.MessageBox
      ('Вы уверены, что хотите удалить элемент?', 'Удаление элемента',
      MB_YESNO + MB_ICONQUESTION);
    If ButtonSelected = MrYes Then
    Begin
        StackPop();
        ListViewStack.Items[0].Delete;
    End
End;

Procedure TMainForm.ButtonPushClick(Sender: TObject);
Begin
    StackElementForm.ShowModal;
End;

Procedure TMainForm.AddItemToListView(ListView: TListView; Element: Integer);
Var
    NewItem: TListItem;
Begin
    NewItem := ListView.Items.Insert(0);
    NewItem.Caption := IntToStr(ListView.Items.Count);
    NewItem.SubItems.Insert(0, IntToStr(Element));
End;

Procedure TMainForm.ClearListView(ListView: TListView);
Var
    I: Integer;
Begin
    For I := ListView.Items.Count - 1 DownTo 0 Do
        ListView.Items[I].Delete;
End;

Procedure TMainForm.ListViewOnChange(Num: Integer);
Begin
    ButtonPush.Enabled := ListViewStack.Items.Count < MAXELEMENTS + Num;
    ButtonPop.Enabled := ListViewStack.Items.Count > Num;
    MMSaveFile.Enabled := ButtonPop.Enabled;
    MMOpenFile.Enabled := ButtonPush.Enabled;
    IsSaved := False;
End;

Procedure TMainForm.ListViewStackChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
Begin
    ListViewOnChange(0);
End;

Procedure TMainForm.ListViewStackDeletion(Sender: TObject; Item: TListItem);
Begin
    ListViewOnChange(1);
End;

Procedure TMainForm.EnableComponents(IsEnabled: Boolean);
Begin
    ListViewStack.Visible := IsEnabled;
    ListViewStack.Enabled := IsEnabled;
    ButtonPush.Enabled := IsEnabled;
    ButtonDestroy.Enabled := IsEnabled;
    MMOpenFile.Enabled := IsEnabled;
End;

Procedure TMainForm.FormClose(Sender: TObject; Var Action: TCloseAction);
Begin
    If Not IsCreated Then
        DestroyStack();
End;

Procedure TMainForm.FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
Var
    ButtonSelected: Integer;
Begin
    If MMSaveFile.Enabled And Not IsSaved Then
    Begin
        ButtonSelected := Application.MessageBox
          ('Желаете сохранить стек в файл?', 'Выход',
          MB_YESNOCANCEL + MB_ICONQUESTION);
        If ButtonSelected = MrYes Then
        Begin
            MMSaveFile.Click;
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

Procedure TMainForm.FormCreate(Sender: TObject);
Begin
    ClientHeight := 150;
    IsCreated := False;
End;

Function TMainForm.FormHelp(Command: Word; Data: NativeInt;
  Var CallHelp: Boolean): Boolean;
Begin
    InstructionForm.ShowModal;
    CallHelp := False;
End;

Procedure TMainForm.FormResize(Sender: TObject);
Begin
    Left := (Screen.Width - Width) Div 2;
    Top := (Screen.Height - Height) Div 2;
End;

Procedure TMainForm.MMDevInfoClick(Sender: TObject);
Begin
    DevInfoForm.ShowModal;
End;

Procedure TMainForm.MMExitClick(Sender: TObject);
Begin
    Close;
End;

Procedure TMainForm.MMInstructionClick(Sender: TObject);
Begin
    InstructionForm.ShowModal;
End;

Function IsFilePathCorrect(Path: String): Boolean;
Var
    IsCorrect: Boolean;
Begin
    IsCorrect := True;
    If ExtractFileExt(Path) <> '.txt' Then
    Begin
        Application.MessageBox('Файл должен иметь разрешение .txt!', 'Ошибка',
          MB_OK + MB_ICONERROR);
        IsCorrect := False;
    End;
    IsFilePathCorrect := IsCorrect;
End;

Procedure TMainForm.MMOpenFileClick(Sender: TObject);
Var
    I, NewElement: Integer;
    IsCorrect: Boolean;
    FIn: TextFile;
Begin
    IsCorrect := OpenDialog.Execute And IsFilePathCorrect(OpenDialog.FileName);
    If IsCorrect Then
        Try
            Try
                IsCorrect := True;
                AssignFile(FIn, OpenDialog.FileName);
                Reset(FIn);
                Read(FIn, NewElement);
                If (NewElement < MINNUM) Or (NewElement > MAXNUM) Then
                Begin
                    IsCorrect := False;
                    Application.MessageBox
                      ('Число в файле не соответствует диапазону!', 'Ошибка',
                      MB_ICONERROR);
                End
                Else If Not Eof(FIn) Then
                Begin
                    IsCorrect := False;
                    Application.MessageBox
                      ('В файле некорректное количество строк!', 'Ошибка',
                      MB_ICONERROR);
                End;
            Finally
                CloseFile(FIn);
            End;
        Except
            IsCorrect := False;
            Application.MessageBox('В файле некорректные данные!', 'Ошибка',
              MB_ICONERROR);
        End;
    If IsCorrect Then
    Begin
        StackPush(NewElement);
        AddItemToListView(ListViewStack, NewElement);
        IsSaved := False;
    End;
End;

Procedure TMainForm.MMSaveFileClick(Sender: TObject);
Var
    I: Integer;
    IsCorrect: Boolean;
    FOut: TextFile;
Begin
    IsCorrect := SaveDialog.Execute And IsFilePathCorrect(SaveDialog.FileName);
    If IsCorrect Then
        Try
            Try
                AssignFile(FOut, SaveDialog.FileName);
                Rewrite(FOut);
                Writeln(FOut, 'Стек:');
                With ListViewStack Do
                    For I := 0 To Items.Count - 1 Do
                        Writeln(FOut, Items[I].SubItems.Text, '--------');
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

End.
