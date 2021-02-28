program chat;

uses
  Forms,
  UPrincipal in 'UPrincipal.pas' {Form1},
  UTrie in 'UTrie.pas';


{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
