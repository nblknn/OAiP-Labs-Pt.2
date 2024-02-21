Unit UnitTask;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Vcl.ComCtrls,
    UnitInstruction;

Type
    TFormTask = Class(TForm)
        MainMenu: TMainMenu;
        MMFile: TMenuItem;
        MMSaveFile: TMenuItem;
        MMSeparator: TMenuItem;
        MMClose: TMenuItem;
        MMInstruction: TMenuItem;
        LabelTask: TLabel;
        TaskListView: TListView;
        ButtonClose: TButton;
        Procedure ButtonCloseClick(Sender: TObject);
        Procedure FormShow(Sender: TObject);
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
        Procedure FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
        Procedure FormKeyDown(Sender: TObject; Var Key: Word;
          Shift: TShiftState);
        Procedure MMSaveFileClick(Sender: TObject);
        Procedure MMInstructionClick(Sender: TObject);
        Procedure MMCloseClick(Sender: TObject);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    FormTask: TFormTask;

Implementation

{$R *.dfm}

Uses UnitMain;

Var
    IsTaskSaved: Boolean;
    SortedTaskList: TCarList;

Procedure TFormTask.ButtonCloseClick(Sender: TObject);
Begin
    Close;
End;

Function CreateTaskList(): TCarList;
Var
    I: Integer;
    TaskList: TCarList;
Begin
    For I := 0 To High(MainList) Do
        If MainList[I].Year = LASTYEAR Then
        Begin
            SetLength(TaskList, Length(TaskList) + 1);
            TaskList[High(TaskList)] := MainList[I];
        End;
    CreateTaskList := TaskList;
End;

Procedure SwapElements(Var List: TCarList; I, J: Integer);
Var
    Temp: TCar;
Begin
    Temp := List[I];
    List[I] := List[J];
    List[J] := Temp;
End;

Function SortList(List: TCarList): TCarList;
Var
    I, J, MaxIndex: Integer;
Begin
    For I := 0 To High(List) - 1 Do
    Begin
        MaxIndex := I;
        For J := I + 1 To High(List) Do
            If List[J].Price > List[MaxIndex].Price Then
                MaxIndex := J;
        If MaxIndex <> I Then
            SwapElements(List, I, MaxIndex);
    End;
    SortList := List;
End;

Procedure TFormTask.FormClose(Sender: TObject; Var Action: TCloseAction);
Begin
    MainForm.ClearList(TaskListView, SortedTaskList);
End;

Procedure TFormTask.FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
Begin
    MainForm.OnCloseQuery(SortedTaskList, IsTaskSaved, CanClose);
End;

Procedure TFormTask.FormKeyDown(Sender: TObject; Var Key: Word;
Shift: TShiftState);
Begin
    If Key = VK_ESCAPE Then
        Close;
End;

Procedure TFormTask.FormShow(Sender: TObject);
Var
    I: Integer;
    TaskList: TCarList;
Begin
    IsTaskSaved := False;
    TaskList := CreateTaskList();
    SortedTaskList := SortList(TaskList);
    For I := 0 To High(SortedTaskList) Do
        MainForm.AddItemToListView(TaskListView, SortedTaskList);
End;

Procedure TFormTask.MMCloseClick(Sender: TObject);
Begin
    Close;
End;

Procedure TFormTask.MMInstructionClick(Sender: TObject);
Begin
    FormInstruction.ShowModal;
End;

Procedure TFormTask.MMSaveFileClick(Sender: TObject);
Begin
    MainForm.SaveFile(SortedTaskList, IsTaskSaved);
End;

End.
