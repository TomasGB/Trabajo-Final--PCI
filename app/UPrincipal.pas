unit UPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UTrie;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Memo1: TMemo;
    btnMostrarDiccionario: TButton;
    btnAgregarAlDiccionario: TButton;
    Timer1: TTimer;
    OpenDialog1: TOpenDialog;
    BtnClear: TButton;
    Label1: TLabel;
    ListBox1: TListBox;
    Edit2: TEdit;
    ListBox2: TListBox;
    ButtonEnviar1: TButton;
    ButtonEnviar2: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Timer2: TTimer;
    Edit3: TEdit;
    ButtonEliminar: TButton;
    ButtonGuardarChat: TButton;
    SaveDialog1: TSaveDialog;
    procedure Timer1Timer(Sender: TObject);
    procedure btnAgregarAlDiccionarioClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnMostrarDiccionarioClick(Sender: TObject);
    procedure BtnClearClick(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ButtonEnviar1Click(Sender: TObject);
    procedure ButtonEnviar2Click(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure ButtonEliminarClick(Sender: TObject);
    procedure ButtonGuardarChatClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  raiz:TTrie;
  lista,lista2:Tstringlist;
  ultimaPalabra, frase:string;
  diccionario,Chat:TextFile;


implementation

{$R *.dfm}

function calcularLetra(indice:integer):string;
begin
    if indice = 15 then calcularLetra:='ñ'
    else
    begin
        if indice < 15 then calcularLetra:=chr(ord(indice+96))
        else if indice > 15 then calcularLetra:=chr(indice+96-1);
    end;
end;

procedure MostrarTrie(pref:string;raiz:TTrie;ListBox:TListBox);
{
    Este procedimeinto se encarga de mostrar en el memo todas las posibles
    recomendaciones de palabras dado el prefijo de la ultima palabra que
    escribio el usuario.
}
var i:integer;
    p:String;
    letra:string;

begin
    for i:=1 to letras do
    begin
        if raiz^.hijos[i] <> nil then
        begin

            letra:=calcularLetra(i);
            p:=pref+letra;


            if (raiz^.hijos[i].FDP = true) then
            begin
                ListBox.Items.BeginUpdate;
                listbox.items.Append(p);
                ListBox.Items.EndUpdate;
            end;
            MostrarTrie(p,raiz^.hijos[i],ListBox);
        end
        else ;
    end;

end;

procedure BuscarPorPref(pref:string;raiz:TTrie;ListBox:TListBox);
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
        //255 es el ASCII de espacio
        if (ord(pref[i])= 255) then
        else pos:=calcularIndice(pref[i]);

        if raiz^.hijos[pos] = nil then
            begin
                check:=False;
            end
        else
        begin

            if pref[i] = 'ñ' then raiz:=raiz^.hijos[15]
            else
                if calcularIndice(pref[i]) <15 then raiz:=raiz^.hijos[ord(pref[i])-96]
                else raiz:=raiz^.hijos[ord(pref[i])-96+1];
        end;
    end;

    if check = True then mostrarTrie(pref,raiz,Listbox)
    else  ListBox.items.add('No se encuentra la palabra: '+ pref);
end;


procedure parsearUltimaPalabra(palabras:string;raiz:TTrie; var ultimaPalabra, frase:string);
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
frase:='';
i:=1;

while not esUltimaPalabra do
begin
    while (palabras[i]<>' ')and (i < length(palabras)) do
    //Este bucle se utiliza para acumular la palabra.
        begin
            ultimaPalabra:=ultimaPalabra+palabras[i];
            i:=i+1;
        end;

    if (palabras[i]<> ' ') and (i <> length(palabras)) then
    //Esta condicion checkea si hay mas de una palabra en el string.
        begin
            esUltimaPalabra:=False;
            frase:=frase+ultimaPalabra;
            ultimaPalabra:='';
            i:=i+1;
        end
    else
        begin
            if (i < length(palabras))then
                begin
                    esUltimaPalabra:=False;
                    frase:=frase+ultimaPalabra+' ';
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

    if (edit1.text <> '') and (edit1.text <> ' ')then
    begin
        ListBox1.Clear;
        Timer1.Enabled := True;
        Timer1.Interval := 500;
        parsearUltimaPalabra(lowercase(edit1.text),raiz,ultimaPalabra,frase);
        BuscarPorPref(ultimaPalabra,raiz,ListBox1);
    end
    else ;

end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin

    if (edit2.text <> '') and (edit2.text <> ' ')then
    begin
        ListBox2.Clear;
        Timer2.Enabled := True;
        Timer2.Interval := 500;
        parsearUltimaPalabra(lowercase(edit2.text),raiz,ultimaPalabra,frase);
        BuscarPorPref(ultimaPalabra,raiz,ListBox2);
    end
    else ;

end;


procedure actualizarDiccionario(pref:string;raiz:TTrie);
var i:integer;
    p:String;
    letra:string;

begin
    for i:=1 to letras do
    begin
        if raiz^.hijos[i] <> nil then
        begin

            letra:=calcularLetra(i);

            p:=pref+letra;


            if (raiz^.hijos[i].FDP = true) then
            begin
                append(diccionario);
                WriteLn(diccionario,p);
                CloseFile(diccionario);
            end;
            actualizarDiccionario(p,raiz^.hijos[i]);
        end
        else ;
    end;
end;


procedure agregarEnDiccionario(palabra:string;var diccionario:Text);
begin
    assign(diccionario,'diccionario.txt' );
    append(diccionario);
    writeLn(diccionario,palabra);
    close(diccionario);

    //Actualizacion del archivo diccionario.txt
    rewrite(diccionario,'diccionario.txt');
    append(diccionario);
    WriteLn(diccionario,'');
    CloseFile(diccionario);
    actualizarDiccionario('',raiz);
end;

procedure TForm1.btnAgregarAlDiccionarioClick(Sender: TObject);
var esta:boolean;
begin

//mira si hay el edit1 esta vacio o no
if (edit1.text = '') or (edit1.text = ' ') then
else
begin
    parsearUltimaPalabra(lowercase(edit1.text),raiz,ultimaPalabra,frase);
    esta:= BuscarPalabra(ultimaPalabra,raiz);

    if esta then showMessage('Esta palabra ya esta en el diccionario: '+ultimaPalabra)
    else
        begin
            InsertarPalabra(ultimaPalabra,raiz);
            agregarEnDiccionario(ultimaPalabra,diccionario);
        end;
end;

//mira si hay el edit2 esta vacio o no
if (edit2.text = '') or (edit2.text = ' ') then
else
begin
    parsearUltimaPalabra(lowercase(edit2.text),raiz,ultimaPalabra,frase);
    esta:= BuscarPalabra(ultimaPalabra,raiz);

    if esta then showMessage('Esta palabra ya esta en el diccionario: '+ultimaPalabra)
    else
        begin
            InsertarPalabra(ultimaPalabra,raiz);
            agregarEnDiccionario(ultimaPalabra,diccionario);
        end;

end;

end;

procedure CargarDiccionario(lista:Tstringlist;raiz:TTrie);
var i:integer;
begin

Lista := TStringList.Create;
Lista.LoadFromFile('diccionario.txt');

for i:=1 to lista.count-1 do
begin
    InsertarPalabra(Lista.Strings[i],raiz);
end;

end;


procedure TForm1.FormCreate(Sender: TObject);
begin
    memo1.Clear;
    ListBox1.Clear;
    inicializarTrie(raiz);
    CargarDiccionario(lista,raiz);
end;

procedure mostrarDiccionario(lista:Tstringlist;listbox:TListBox);
var i:integer;

begin
    Lista:= TStringList.Create;
    Lista.LoadFromFile('diccionario.txt');

    for i:=1 to lista.count-1 do
    begin
        listbox.items.Append(Lista.Strings[i]);
    end;
end;

procedure TForm1.btnMostrarDiccionarioClick(Sender: TObject);
begin
ListBox1.clear;
mostrarDiccionario(lista,ListBox1);

end;

procedure TForm1.BtnClearClick(Sender: TObject);
begin
    memo1.Clear;
    listbox1.Clear;
    listbox2.Clear;
    edit1.Clear;
    edit2.Clear;
end;


procedure TForm1.ListBox1Click(Sender: TObject);
begin
if edit1.text = '' then edit1.text:= ListBox1.Items[ListBox1.itemIndex]
else
    begin

        parsearUltimaPalabra(lowercase(edit1.text),raiz,ultimaPalabra,frase);
        // si no hay nada seleccionado el ItemIndex es -1
        if (ListBox1.ItemIndex >=0) then edit1.text:=frase + ListBox1.Items[ListBox1.itemIndex];
    end;
end;

procedure TForm1.ListBox2Click(Sender: TObject);
begin
parsearUltimaPalabra(lowercase(edit2.text),raiz,ultimaPalabra,frase);

if (ListBox2.ItemIndex >=0) then edit2.text:=frase + ListBox2.Items[ListBox2.itemIndex];

end;

procedure TForm1.ButtonEnviar1Click(Sender: TObject);
begin
memo1.lines.add(' '+formatdatetime('t', now)+'  Usuario 1: '+edit1.text);
memo1.lines.add('');
listBox1.Clear;
edit1.Clear;
end;

procedure TForm1.ButtonEnviar2Click(Sender: TObject);
begin

memo1.lines.add(' '+formatdatetime('t', now)+'  Usuario 2: '+edit2.text);
memo1.lines.add('');
listBox2.Clear;
edit2.Clear;
end;



procedure TForm1.ButtonEliminarClick(Sender: TObject);
begin
if (edit3.Text <>'') or (edit3.Text <>'')then
eliminarPalabra(lowercase(edit3.text),raiz);

//Para el espacio al iniciar el archivo
rewrite(diccionario,'diccionario.txt');
append(diccionario);
WriteLn(diccionario,'');
CloseFile(diccionario);

actualizarDiccionario('',raiz);
end;

procedure TForm1.ButtonGuardarChatClick(Sender: TObject);
var nombre:string;
    ListaChat:TStrings;
begin
    nombre:='chats\'+formatdatetime('dd-mm-yyyy', now)+'_'+formatdatetime('hh_nn_ss', now)+'.txt';
    ListaChat:=TStringList.Create;
    ListaChat.AddStrings(Memo1.Lines);
    ListaChat.SaveToFile(nombre);
    ListaChat.Free;
    showMessage('El chat se guardo correctamente');
end;

end.
