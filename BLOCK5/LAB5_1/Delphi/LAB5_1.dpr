program LAB5_1;

uses
  Vcl.Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  Vcl.Themes,
  Vcl.Styles,
  StackElementUnit in 'StackElementUnit.pas' {StackElementForm},
  InstructionUnit in 'InstructionUnit.pas' {InstructionForm},
  DevInfoUnit in 'DevInfoUnit.pas' {DevInfoForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Glow');
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TStackElementForm, StackElementForm);
  Application.CreateForm(TInstructionForm, InstructionForm);
  Application.CreateForm(TDevInfoForm, DevInfoForm);
  Application.Run;
end.
