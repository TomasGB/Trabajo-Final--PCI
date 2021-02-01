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
    Label1: TLabel;
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

procedure MostrarTrie(pref:string;raiz:TTrie;memo:TMemo);
{
    Este procedimeinto se encarga de mostrar en el memo todas las posibles
    recomendaciones de palabras dado el prefijo de la ultima palabra que
    escribio el usuario.
}
var i:integer;
    p,letra:String;
                      
begin
    for i:=1 to letras do
    begin
        if raiz^.hijos[i] <> nil then
        begin
            if i=27 then letra:='ñ' // 164 es el codigo ascii de la ñ
            else letra:=chr(ord(i+96));

            p:=pref+letra;
            MostrarTrie(p,raiz^.hijos[i],memo);

            if (raiz^.hijos[i].FDP = true) then
            begin
                memo.Lines.BeginUpdate;
                memo.lines.add(p);
                memo.lines.add('');
                memo.Lines.EndUpdate;
            end;
        end
        else ;
    end;

end;


procedure BuscarPorPref(pref:string;raiz:TTrie;memo:TMemo);
{
    Este procedimeinto se encarga de buscar todas las posibles recomendaciones
    de palabras dado lo que escriba el usuario.
}
var long,i, pos:integer;
    check:boolean;
    {
    La variable check, se utiliza como 'flag' para saber si hay o no
    recomendaciones de palabras posibles.
    }

begin
    long:= length(pref);
    check:=True;
    for i:=1 to long do
    begin
        if pref[i]='ñ' then pos := 27
        else pos:=ord(pref[i])-96;

        if raiz^.hijos[pos] = nil then
            begin
                check:=False;
            end
        else
        begin
            if pref[i] = 'ñ' then raiz:=raiz^.hijos[27]
            else raiz:=raiz^.hijos[ord(pref[i])-96];
        end;
    end;

    if check = True then mostrarTrie(pref,raiz,memo)
    else memo.lines.add('No se encuentra la palabra: '+ pref);
end;


procedure parsearUltimaPalabra(palabras:string;raiz:TTrie; var ultimaPalabra:string);
{
    Este procedimiento se encarga de recorrer el string que ingresa el usuario,
    separando las palabras por espacios y retornando la ultima en la variable
    'ultimaPalabra'.
}
var i:integer;
    esUltimaPalabra:boolean;
begin

esUltimaPalabra:=False;
ultimaPalabra:='';
i:=1;

while not esUltimaPalabra do
begin
    while (palabras[i]<>' ') and (i < length(palabras)) do
    //Este bucle se utiliza para acumular la palabra.
        begin
            ultimaPalabra:=ultimaPalabra+palabras[i];
            i:=i+1;
        end;

    if (palabras[i]<> ' ') and (i <> length(palabras)) then
    //Esta condicion checkea si hay mas de una palabra en el string.
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

procedure agregarEnDiccionario(palabra:string;var diccionario:Text);
begin
    assign(diccionario,'diccionario.txt' );
    append(diccionario);
    writeLn(diccionario,palabra);
    close(diccionario);
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
        agregarEnDiccionario(UTF8Encode(ultimaPalabra),diccionario);
    end;
end;

procedure CargarDiccionario(lista:Tstringlist;raiz:TTrie);
var i:integer;
begin

Lista:= TStringList.Create;
Lista.LoadFromFile('diccionario.txt');

for i:=0 to lista.count-1 do
begin
    InsertarPalabra(Utf8Decode(Lista.Strings[i]),raiz);
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
        memo.lines.add(UTF8Decode(Lista.Strings[i]));
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
