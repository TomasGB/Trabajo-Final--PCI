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


implementation

{$R *.dfm}

///////////////////////////////////////////////////////////////////////////////
{Falta sacar el backtrack}

procedure MostrarTrie(pref:string;raiz:TTrie;memo:TMemo);
var i:integer;
    p:String;
begin
    for i:=1 to letras do
    begin
        if raiz^.hijos[i] <> nil then
        begin
            if (chr(ord(i+96)) = '{') or (chr(ord(i+96)) = ' ') then  p:=pref+' '
            else p:=pref+chr(ord(i+96));

            if (raiz^.hijos[i].FDP = true)then
            begin
                memo.lines.add(p);
                memo.lines.add('');
            end;
            MostrarTrie(p,raiz^.hijos[i],memo);
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
    else memo.lines.add({'no existe la palabra: '+ }pref);
end;


procedure TForm1.Timer1Timer(Sender: TObject);
begin

    if edit1.text <> '' then
    begin
         memo1.clear;
        Timer1.Enabled := True;
        Timer1.Interval := 500;
        BuscarPorPref(edit1.text,raiz,memo1);
    end;

end;

procedure TForm1.btnAgregarAlDiccionarioClick(Sender: TObject);
var esta:boolean;
begin
esta:= BuscarPalabra(edit1.Text,raiz);

if esta then showMessage('Esta palabra ya esta en el diccionario')
else
    begin
    InsertarPalabra(edit1.text,raiz);
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

procedure TForm1.btnMostrarDiccionarioClick(Sender: TObject);
begin
mostrarTrie('',raiz,memo1);
end;

procedure TForm1.BtnClearMemoClick(Sender: TObject);
begin
memo1.Clear;
end;

end.
