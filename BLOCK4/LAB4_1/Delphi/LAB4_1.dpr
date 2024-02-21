program LAB4_1;

uses
  Vcl.Forms,
  UnitMain in 'UnitMain.pas' {MainForm},
  Vcl.Themes,
  Vcl.Styles,
  UnitRecord in 'UnitRecord.pas' {FormRecord},
  UnitTask in 'UnitTask.pas' {FormTask},
  UnitInstruction in 'UnitInstruction.pas' {FormInstruction};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Onyx Blue');
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TFormRecord, FormRecord);
  Application.CreateForm(TFormTask, FormTask);
  Application.CreateForm(TFormInstruction, FormInstruction);
  Application.Run;
end.
