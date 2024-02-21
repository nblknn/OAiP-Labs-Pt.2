Unit UnitMain;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.ExtDlgs,
    UnitRecord, UnitInstruction, UnitTask,
    Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Imaging.Pngimage;

Const
    MINYEAR = 1900;
    MAXYEAR = 2024;
    MINPRICE = 0;
    MAXPRICE = 999999999;
    MAXLENGTH = 20;
    LASTYEAR = 2023;
    MAXRECORDS = 30;

Type
    TCar = Record
        Model: String[MAXLENGTH];
        Country: String[MAXLENGTH];
        Year: MINYEAR .. MAXYEAR;
        Price: MINPRICE .. MAXPRICE;
    End;

    TCarList = Array Of TCar;
    TCarListFile = File Of TCar;

    TMainForm = Class(TForm)
        MainMenu: TMainMenu;
        MMFile: TMenuItem;
        MMOpenFile: TMenuItem;
        MMExit: TMenuItem;
        MMSeparator: TMenuItem;
        MMInstruction: TMenuItem;
        MMDevInfo: TMenuItem;
        OpenDialog: TOpenDialog;
        LabelDescription: TLabel;
        SaveDialog: TSaveDialog;
        MMSaveFile: TMenuItem;
        ButtonAddRecord: TButton;
        ButtonDeleteRecord: TButton;
        ButtonDoTask: TButton;
        MainListView: TListView;
        ImageGarage: TImage;

        Procedure AddItemToListView(ListView: TListView; List: TCarList);
        Procedure ChangeListViewItem(ListView: TListView; List: TCarList);
        Procedure DeleteFromList(DeleteIndex: Integer; Var List: TCarList;
          ListView: TListView);
        Procedure ClearList(ListView: TListView; Var List: TCarList);
        Procedure MainListViewChange(Sender: TObject; Item: TListItem;
          Change: TItemChange);
        Procedure MainListViewDblClick(Sender: TObject);
        Procedure MainListViewSelectItem(Sender: TObject; Item: TListItem;
          Selected: Boolean);
        Procedure OnCloseQuery(List: TCarList;
          Var IsFileSaved, CanClose: Boolean);
        Procedure FormKeyDown(Sender: TObject; Var Key: Word;
          Shift: TShiftState);
        Procedure FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
        Procedure ButtonAddRecordClick(Sender: TObject);
        Procedure ButtonDeleteRecordClick(Sender: TObject);
        Procedure ButtonDoTaskClick(Sender: TObject);
        Procedure SaveFile(List: TCarList; Var IsFileSaved: Boolean);
        Procedure MMOpenFileClick(Sender: TObject);
        Procedure MMSaveFileClick(Sender: TObject);
        Procedure MMExitClick(Sender: TObject);
        Procedure MMInstructionClick(Sender: TObject);
        Procedure MMDevInfoClick(Sender: TObject);
        Procedure FormResize(Sender: TObject);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    MainForm: TMainForm;
    MainList: TCarList;
    SelectedIndex: Integer;

Implementation

{$R *.dfm}

Var
    IsSaved: Boolean;

Procedure TMainForm.AddItemToListView(ListView: TListView; List: TCarList);
Var
    NewItem: TListItem;
    Index: Integer;
Begin
    NewItem := ListView.Items.Add;
    NewItem.Caption := IntToStr(ListView.Items.Count);
    Index := ListView.Items.Count - 1;
    With NewItem.SubItems Do
    Begin
        Add(List[Index].Model);
        Add(List[Index].Country);
        Add(IntToStr(List[Index].Year));
        Add(IntToStr(List[Index].Price));
    End;
End;

Procedure TMainForm.ChangeListViewItem(ListView: TListView; List: TCarList);
Begin
    With ListView.Items[SelectedIndex] Do
    Begin
        SubItems[0] := List[SelectedIndex].Model;
        SubItems[1] := List[SelectedIndex].Country;
        SubItems[2] := IntToStr(List[SelectedIndex].Year);
        SubItems[3] := IntToStr(List[SelectedIndex].Price);
    End;
End;

Procedure TMainForm.DeleteFromList(DeleteIndex: Integer; Var List: TCarList;
  ListView: TListView);
Var
    I: Integer;
Begin
    For I := DeleteIndex + 1 To High(List) Do
        List[I - 1] := List[I];
    SetLength(List, Length(List) - 1);
    For I := DeleteIndex To High(List) Do
        ListView.Items[I].Caption := IntToStr(I + 1);
End;

Procedure TMainForm.ClearList(ListView: TListView; Var List: TCarList);
Var
    I: Integer;
Begin
    For I := ListView.Items.Count - 1 DownTo 0 Do
        ListView.Items[I].Delete;
    List := Nil;
End;

Procedure TMainForm.MainListViewChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
Begin
    MMSaveFile.Enabled := MainListView.Items.Count > 0;
    ButtonAddRecord.Enabled := MainListView.Items.Count < MAXRECORDS;
    IsSaved := False;
End;

Procedure TMainForm.MainListViewDblClick(Sender: TObject);
Begin
    SelectedIndex := StrToInt(MainListView.Selected.Caption) - 1;
    IsRecordChanging := True;
    FormRecord.ShowModal;
End;

Procedure TMainForm.MainListViewSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
Begin
    ButtonDeleteRecord.Enabled := Selected;
End;

Procedure TMainForm.ButtonAddRecordClick(Sender: TObject);
Begin
    IsRecordChanging := False;
    FormRecord.ShowModal;
End;

Procedure TMainForm.ButtonDeleteRecordClick(Sender: TObject);
Var
    DeleteIndex, ButtonSelected: Integer;
Begin
    ButtonSelected := Application.MessageBox
      ('Вы уверены, что хотите удалить выделенную запись?', 'Удаление записи',
      MB_YESNO + MB_ICONQUESTION);
    If ButtonSelected = MrYes Then
    Begin
        DeleteIndex := StrToInt(MainListView.Selected.Caption) - 1;
        MainListView.Selected.Delete;
        DeleteFromList(DeleteIndex, MainList, MainListView);
        MMSaveFile.Enabled := MainListView.Items.Count > 0;
    End
    Else
        MainListView.ClearSelection;
End;

Function IsLastYearInList(List: TCarList): Boolean;
Var
    I: Integer;
    IsLastYear: Boolean;
Begin
    IsLastYear := False;
    I := 0;
    While (I < Length(List)) And Not IsLastYear Do
    Begin
        If List[I].Year = LASTYEAR Then
            IsLastYear := True;
        Inc(I);
    End;
    IsLastYearInList := IsLastYear;
End;

Procedure TMainForm.ButtonDoTaskClick(Sender: TObject);
Begin
    If IsLastYearInList(MainList) Then
        FormTask.ShowModal
    Else
        Application.MessageBox
          ('Вывести информацию об автомобилях выпуска прошлого года в порядке убывания цен.'#13#10#13#10'В списке нет автомобилей, выпущенных в прошлом году.',
          'Задание', MB_OK);
End;

Procedure TMainForm.OnCloseQuery(List: TCarList;
  Var IsFileSaved, CanClose: Boolean);
Var
    ButtonSelected: Integer;
Begin
    If MMSaveFile.Enabled And Not IsFileSaved Then
    Begin
        ButtonSelected := Application.MessageBox
          ('Желаете сохранить список в файл?', 'Выход',
          MB_YESNOCANCEL + MB_ICONQUESTION);
        If ButtonSelected = MrYes Then
        Begin
            SaveFile(List, IsFileSaved);
            If Not IsFileSaved Then
                OnCloseQuery(List, IsFileSaved, CanClose);
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

Procedure TMainForm.FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
Begin
    OnCloseQuery(MainList, IsSaved, CanClose);
End;

Procedure TMainForm.FormKeyDown(Sender: TObject; Var Key: Word;
  Shift: TShiftState);
Begin
    If Key = VK_F1 Then
        FormInstruction.ShowModal
    Else If ButtonDeleteRecord.Enabled And (Key = VK_DELETE) Then
        ButtonDeleteRecord.Click;
End;

Procedure TMainForm.FormResize(Sender: TObject);
Begin
    Left := (Screen.Width - Width) Div 2;
    Top := (Screen.Height - Height) Div 2;
End;

Function IsFilePathCorrect(Path: String): Boolean;
Var
    IsCorrect: Boolean;
Begin
    IsCorrect := True;
    If ExtractFileExt(Path) <> '.carlist' Then
    Begin
        Application.MessageBox('Файл должен иметь разрешение .carlist!',
          'Ошибка', MB_OK);
        IsCorrect := False;
    End;
    IsFilePathCorrect := IsCorrect;
End;

Procedure TMainForm.SaveFile(List: TCarList; Var IsFileSaved: Boolean);
Var
    I: Integer;
    IsCorrect: Boolean;
    FOut: TCarListFile;
Begin
    IsCorrect := SaveDialog.Execute And IsFilePathCorrect(SaveDialog.FileName);
    If IsCorrect Then
        Try
            Try
                IsCorrect := True;
                AssignFile(FOut, SaveDialog.FileName);
                Rewrite(FOut);
                For I := 0 To High(List) Do
                    Write(FOut, List[I]);
            Finally
                CloseFile(FOut);
            End;
        Except
            IsCorrect := False;
            Application.MessageBox('Произошла ошибка при записи в файл!',
              'Ошибка', MB_ICONERROR);
        End;
    IsFileSaved := IsCorrect;
End;

Procedure TMainForm.MMOpenFileClick(Sender: TObject);
Var
    I: Integer;
    IsCorrect: Boolean;
    TempList: TCarList;
    FIn: TCarListFile;
Begin
    IsCorrect := OpenDialog.Execute And IsFilePathCorrect(OpenDialog.FileName);
    If IsCorrect Then
        Try
            Try
                IsCorrect := True;
                AssignFile(FIn, OpenDialog.FileName);
                Reset(FIn);
                SetLength(TempList, FileSize(FIn));
                For I := 0 To High(TempList) Do
                    Read(FIn, TempList[I]);
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
        ClearList(MainListView, MainList);
        MainList := Copy(TempList);
        For I := 0 To High(MainList) Do
            AddItemToListView(MainListView, MainList);
    End;
    IsSaved := IsCorrect;
End;

Procedure TMainForm.MMSaveFileClick(Sender: TObject);
Begin
    SaveFile(MainList, IsSaved);
End;

Procedure TMainForm.MMExitClick(Sender: TObject);
Begin
    MainForm.Close;
End;

Procedure TMainForm.MMInstructionClick(Sender: TObject);
Begin
    FormInstruction.ShowModal;
End;

Procedure TMainForm.MMDevInfoClick(Sender: TObject);
Begin
    Application.MessageBox('Городко Ксения Евгеньвна'#13#10'351005 группа',
      'О разработчике', MB_OK);
End;

End.
