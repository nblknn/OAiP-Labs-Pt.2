Unit MainUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls, Vcl.StdCtrls,
    Vcl.ComCtrls, InstructionUnit, DevInfoUnit, AddNodeUnit,
    Vcl.Imaging.Pngimage, TreeUnit, TaskUnit;

Const
    MAXHEIGHT = 7;
    MINVALUE = -999;
    MAXVALUE = 999;

Type
    TError = (Correct, ErrNodeInTree, ErrMaxHeight, ErrIncorrectFileExt,
      ErrCantOpenFile, ErrCantSaveFile, ErrIncorrectData);

    TMainForm = Class(TForm)
        LabelProgramInfo: TLabel;
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
        ImageTree: TImage;
        ButtonAddNode: TButton;
        ButtonShowTree: TButton;
        ButtonTask: TButton;
        Procedure ShowErrorMessage(Error: TError);
        Function CheckNodeValue(Value: Integer): TError;
        Procedure ButtonAddNodeClick(Sender: TObject);
        Procedure ButtonShowTreeClick(Sender: TObject);
        Procedure ButtonTaskClick(Sender: TObject);
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
        Procedure FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
        Function FormHelp(Command: Word; Data: NativeInt;
          Var CallHelp: Boolean): Boolean;
        Procedure MMDevInfoClick(Sender: TObject);
        Procedure MMExitClick(Sender: TObject);
        Procedure MMInstructionClick(Sender: TObject);
        Procedure MMOpenFileClick(Sender: TObject);
        Procedure MMSaveFileClick(Sender: TObject);
        Procedure FormResize(Sender: TObject);
    End;

Const
    ERRORMESSAGES: Array [Low(TError) .. High(TError)
      ] Of PWideChar = ('', 'Узел с таким значением уже есть в дереве!',
      'Достигнута максимальная высота дерева!',
      'Файл должен иметь разрешение .txt!',
      'Произошла ошибка при открытии файла!',
      'Произошла ошибка при записи в файл!', 'Проверьте корректность данных!');

Var
    MainForm: TMainForm;
    IsSaved: Boolean;
    IsTreeCreated: Boolean = False;

Implementation

{$R *.dfm}
Function IsValueInTree(Value: Integer): Boolean; External 'LIBRARY5_2.dll';
Function FindNodeHeight(Value: Integer): Integer; External 'LIBRARY5_2.dll';
Procedure DestroyTree(); External 'LIBRARY5_2.dll';
Procedure WriteTreeToFile(Var FOut: TextFile); External 'LIBRARY5_2.dll';

Procedure TMainForm.ShowErrorMessage(Error: TError);
Begin
    Application.MessageBox(ERRORMESSAGES[Error], 'Ошибка', MB_ICONERROR);
End;

Function TMainForm.CheckNodeValue(Value: Integer): TError;
Var
    Error: TError;
Begin
    Error := Correct;
    If (Value > MAXVALUE) Or (Value < MINVALUE) Then
        Error := ErrIncorrectData
    Else If IsValueInTree(Value) Then
        Error := ErrNodeInTree
    Else If FindNodeHeight(Value) > MAXHEIGHT Then
        Error := ErrMaxHeight;
    CheckNodeValue := Error;
End;

Procedure TMainForm.ButtonAddNodeClick(Sender: TObject);
Begin
    AddNodeForm.ShowModal;
End;

Procedure TMainForm.ButtonShowTreeClick(Sender: TObject);
Begin
    TreeForm.ShowModal;
End;

Procedure TMainForm.ButtonTaskClick(Sender: TObject);
Begin
    TaskForm.ShowModal;
End;

Procedure TMainForm.FormClose(Sender: TObject; Var Action: TCloseAction);
Begin
    If IsTreeCreated Then
        DestroyTree();
End;

Procedure TMainForm.FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
Var
    ButtonSelected: Integer;
Begin
    If MMSaveFile.Enabled And Not IsSaved Then
    Begin
        ButtonSelected := Application.MessageBox
          ('Желаете сохранить дерево в файл?', 'Выход',
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

Function CheckFileExtension(Path: String): TError;
Var
    Error: TError;
Begin
    Error := Correct;
    If ExtractFileExt(Path) <> '.txt' Then
        Error := ErrIncorrectFileExt;
    CheckFileExtension := Error;
End;

Procedure TMainForm.MMOpenFileClick(Sender: TObject);
Var
    Value: Integer;
    Error: TError;
    FIn: TextFile;
Begin
    If OpenDialog.Execute Then
    Begin
        Error := CheckFileExtension(OpenDialog.FileName);
        If Error = Correct Then
            Try
                Try
                    AssignFile(FIn, OpenDialog.FileName);
                    Reset(FIn);
                    If Eof(FIn) Then
                        Error := ErrCantOpenFile;
                    If Error = Correct Then
                    Begin
                        Read(FIn, Value);
                        Error := CheckNodeValue(Value);
                        If Not Eof(FIn) Then
                            Error := ErrCantOpenFile;
                    End;
                Finally
                    CloseFile(FIn);
                End;
            Except
                Error := ErrCantOpenFile;
            End;
        If Error <> Correct Then
            ShowErrorMessage(Error)
        Else
            AddNodeForm.AddValueToTree(Value);
    End;
End;

Procedure TMainForm.MMSaveFileClick(Sender: TObject);
Var
    Error: TError;
    FOut: TextFile;
Begin
    If SaveDialog.Execute Then
    Begin
        Error := CheckFileExtension(SaveDialog.FileName);
        If Error = Correct Then
            Try
                Try
                    AssignFile(FOut, SaveDialog.FileName);
                    Rewrite(FOut);
                    WriteTreeToFile(FOut);
                Finally
                    CloseFile(FOut);
                End;
            Except
                Error := ErrCantSaveFile;
            End;
        If Error <> Correct Then
            ShowErrorMessage(Error)
        Else
            IsSaved := True;
    End;
End;

End.
