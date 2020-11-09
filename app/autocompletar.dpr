program autocompletar;

uses
  Forms,
  UPrincipal in 'UPrincipal.pas' {Form1},
  UTrie in 'UTrie.pas',
  UNodo in 'UNodo.pas';


{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
