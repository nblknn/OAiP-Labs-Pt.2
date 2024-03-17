program LAB5_2;

uses
  Vcl.Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  DevInfoUnit in 'DevInfoUnit.pas' {DevInfoForm},
  InstructionUnit in 'InstructionUnit.pas' {InstructionForm},
  AddNodeUnit in 'AddNodeUnit.pas' {AddNodeForm},
  Vcl.Themes,
  Vcl.Styles,
  TreeUnit in 'TreeUnit.pas' {TreeForm},
  TaskUnit in 'TaskUnit.pas' {TaskForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Glow');
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TDevInfoForm, DevInfoForm);
  Application.CreateForm(TInstructionForm, InstructionForm);
  Application.CreateForm(TAddNodeForm, AddNodeForm);
  Application.CreateForm(TTreeForm, TreeForm);
  Application.CreateForm(TTaskForm, TaskForm);
  Application.Run;
end.
