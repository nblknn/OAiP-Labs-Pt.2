Unit UnitInstruction;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

Type
    TFormInstruction = Class(TForm)
        LabelInstruction: TLabel;
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
    FormInstruction: TFormInstruction;

Implementation

{$R *.dfm}

Procedure TFormInstruction.ButtonCloseClick(Sender: TObject);
Begin
    Close;
End;

Procedure TFormInstruction.FormCreate(Sender: TObject);
Begin
    LabelInstruction.Caption :=
      'ИЗМЕНЕНИЕ СПИСКА:'#13#10'1. Для добавления записи, нажмите на кнопку "Новая запись" и введите данные в новом окне.'#13#10'2. Для изменения записи, нажмите на нужную запись 2 раза.'#13#10'3. Для удаления, выберите нужную запись и нажмите на кнопку "Удалить".'#13#10#13#10
      + 'ДАННЫЕ:'#13#10'1. Максимальная длина данных о марке и государстве-производителе - 20 символов.'#13#10'2. Год выпуска и цена - целые числа.'#13#10'3. Диапазон года выпуска: 1900..2024.'#13#10'4. Диапазон цены: 0..999999999.'#13#10'5. Максимальное количество записей - 30.'#13#10#13#10
      + 'ФАЙЛЫ:'#13#10'1. Открываемый/сохраняемый файл должен быть формата *.carlist.'#13#10'2. При сохранении данные указанного файла перезаписываются.'#13#10#13#10;
    LabelInstruction.Width := 500;
    LabelInstruction.Left := (ClientWidth - LabelInstruction.Width) Div 2;
End;

Procedure TFormInstruction.FormKeyDown(Sender: TObject; Var Key: Word;
  Shift: TShiftState);
Begin
    If Key = VK_ESCAPE Then
        Close;
End;

End.
