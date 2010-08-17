program Demo2;

uses
  madExcept,
  madLinkDisAsm,
  madScreenShot,
  Forms,
  Demo2U1 in 'Demo2U1.pas' {Form1},
  Demo2U2 in 'Demo2U2.pas' {QR1: TQuickRep};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TQR1, QR1);
  Application.Run;
end.
