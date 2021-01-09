unit UPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,UTrie, UNodo, ExtCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Memo1: TMemo;
    btnMostrarDiccionario: TButton;
    btnAgregarAlDiccionario: TButton;
    Timer1: TTimer;
    OpenDialog1: TOpenDialog;
    BtnClearMemo: TButton;
    procedure Timer1Timer(Sender: TObject);
    procedure btnAgregarAlDiccionarioClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnMostrarDiccionarioClick(Sender: TObject);
    procedure BtnClearMemoClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  raiz:TTrie;
  lista:Tstringlist;
  ultimaPalabra:string;
  diccionario:Text;


implementation

{$R *.dfm}

///////////////////////////////////////////////////////////////////////////////

procedure MostrarTrie(pref:string;raiz:TTrie;memo:TMemo);
var i:integer;
    p:String;

begin
    for i:=1 to letras do
    begin
        if raiz^.hijos[i] <> nil then
        begin
            p:=pref+chr(ord(i+96));

            if (raiz^.hijos[i].FDP = true)then
            begin
                memo.Lines.BeginUpdate;
                memo.lines.add(p);
                memo.lines.add('');
                memo.Lines.EndUpdate;
            end
            else MostrarTrie(p,raiz^.hijos[i],memo);
        end;
    end;

end;
////////////////////////////////////////////////////////////////////////////////

procedure BuscarPorPref(pref:string;raiz:TTrie;memo:TMemo);
var long,i:integer;
    check:boolean;
begin
    long:= length(pref);
    check:=True;
    for i:=1 to long do
    begin
        if raiz^.hijos[ord(pref[i])-96] = nil then
            begin
                check:=False;

            end
        else raiz:=raiz^.hijos[ord(pref[i])-96] end;

    if check = True then mostrarTrie(pref,raiz,memo)
    else memo.lines.add('no existe la palabra: '+ pref);
end;


procedure parsearUltimaPalabra(palabras:string;raiz:TTrie; var ultimaPalabra:string);
var i:integer;
    esUltimaPalabra:boolean;
begin

esUltimaPalabra:=False;
ultimaPalabra:='';
i:=1;

while not esUltimaPalabra do
begin
    while (palabras[i]<>' ') and (i < length(palabras)) do
        begin
            ultimaPalabra:=ultimaPalabra+palabras[i];
            i:=i+1;
        end;

    if (palabras[i]<> ' ') and (i <> length(palabras)) then
        begin
            esUltimaPalabra:=False;
            ultimaPalabra:='';
            i:=i+1;
        end
    else
        begin
            if i < length(palabras) then
                begin
                    esUltimaPalabra:=False;
                    ultimaPalabra:='';
                    i:=i+1;
                end
            else
                begin
                    ultimaPalabra:=ultimaPalabra+palabras[i];
                    esUltimaPalabra:=True;
                end;
            end;
    end;
end;


procedure TForm1.Timer1Timer(Sender: TObject);
begin

    if edit1.text <> '' then
    begin
        memo1.clear;
        Timer1.Enabled := True;
        Timer1.Interval := 500;
        parsearUltimaPalabra(edit1.text,raiz,ultimaPalabra);
        BuscarPorPref(ultimaPalabra,raiz,memo1);
    end;

end;

procedure TForm1.btnAgregarAlDiccionarioClick(Sender: TObject);
var esta:boolean;
begin
esta:= BuscarPalabra(edit1.Text,raiz);

if esta then showMessage('Esta palabra ya esta en el diccionario')
else
    begin
        parsearUltimaPalabra(edit1.text,raiz,ultimaPalabra);
        InsertarPalabra(ultimaPalabra,raiz);
        agregarPalabraEnDiccionario(ultimaPalabra,diccionario);
    end;
end;

procedure CargarDiccionario(lista:Tstringlist;raiz:TTrie);
var i:integer;
begin

Lista:= TStringList.Create;
Lista.LoadFromFile('diccionario.txt');

for i:=0 to lista.count-1 do
begin
    InsertarPalabra(Lista.Strings[i],raiz);
end;

end;


procedure TForm1.FormCreate(Sender: TObject);
begin
    memo1.Clear;
    inicializarTrie(raiz);
    CargarDiccionario(lista,raiz);

end;

procedure mostrarDiccionario(lista:Tstringlist;memo:TMemo);
var i:integer;
begin
    Lista:= TStringList.Create;
    Lista.LoadFromFile('diccionario.txt');

    for i:=0 to lista.count-1 do
    begin
        memo.lines.add(Lista.Strings[i]);
    end;

end;

procedure TForm1.btnMostrarDiccionarioClick(Sender: TObject);
begin
mostrarDiccionario(lista,memo1);

end;

procedure TForm1.BtnClearMemoClick(Sender: TObject);
begin
    memo1.Clear;
end;

end.
