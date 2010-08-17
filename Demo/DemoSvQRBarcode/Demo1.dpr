program Demo1;

uses
  Forms,
  Demo1U1 in 'Demo1U1.pas' {Form1},
  Demo1U2 in 'Demo1U2.pas' {QR1: TQuickRep};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TQR1, QR1);
  Application.Run;
end.
