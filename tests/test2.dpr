program test2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

const LETRAS =26; //sin contar la ñ

type
    TPnodo = ^Tnodo;
    TLetras = array [1..LETRAS] of TPnodo;
    Tnodo = record
                FDP:boolean;
                hijos:TLetras;
                end;

    TTrie = TPnodo;

var raiz:TTrie;


procedure inicializarTrie(var raiz:TTrie);
var i:Integer;
begin
    new(raiz);
    for i:=1 to LETRAS do
      begin
            raiz^.FDP:=False;
            raiz^.hijos[i]:=Nil;
      end;
end;

procedure crearNodo(FDPaux:boolean;var nodo:TPnodo);
var i:integer;
begin
    new(nodo);
    nodo^.FDP:=FDPaux;
    for i:=1 to LETRAS do
      nodo^.hijos[i]:=nil;
end;

procedure InsertarPalabra(palabra:String;raiz:TTrie);
var i,long,pos:Integer;
    FDPaux:Boolean;
    nuevoNodo:TPnodo;
begin
    FDPaux:=False;
    long:=Length(palabra);

    for i:=1 to long do
        begin
            pos:= Ord(palabra[i])-96;
            if palabra[i] = palabra[long] then FDPaux:=True;

            crearNodo(FDPaux,nuevoNodo);

            if raiz^.hijos[pos] = Nil then
            begin
                raiz^.hijos[pos]:=nuevoNodo;
                raiz:=raiz^.hijos[pos];
            end
            else
                begin
                    raiz:=raiz^.hijos[pos]
                end;

        end;
end;

function BuscarPalabra(palabra:String;raiz:TTrie):Boolean;
var i,long,pos,indice:integer;
    bool:boolean;

begin
    long:=Length(palabra);
    bool:=True;
    for i:=1 to long do
    begin
          indice:=ord(palabra[i])-96;
          if raiz^.hijos[indice] = nil then bool:=False
          else
            begin
                raiz:=raiz^.hijos[indice];
            end;
    end;
    BuscarPalabra:=bool;
end;
///////////////////////////////////////////////////////////////////////////////

procedure MostrarTrie(pref:string;raiz:TTrie);
var i,j,pos,long:integer;
    p,acum:String;
begin
    long:=length(pref);
    pos:=ord(pref[long])-96;
    p:='';
    for i:=1 to letras do
    begin

        if raiz^.hijos[i] <> nil then
        begin

            p:=pref+chr(ord(i+96));
            MostrarTrie(p,raiz^.hijos[i]);

            if raiz^.hijos[i]^.FDP = true then
            begin
                Write(p);
                writeln('');
            end;
        end;
    end;

end;

 {
 procedure MostrarTrie(pref:string;raiz:TTrie); // falta sacar el backtracking y que se pueda poner prefijos
var i,j,k,long:integer;
    p,acum:String;
begin

    for i:=1 to letras do
    begin
        p:='';
        if raiz^.hijos[i] <> nil then
        begin
            p:=pref+chr(ord(i+96));
            MostrarTrie(p,raiz^.hijos[i]);

            if raiz^.hijos[i]^.FDP = true then
            begin
                WriteLn(p);
                writeln('---------');
            end;
        end;
    end;
end;}



var r:TTrie;
    p:String;
    j:integer;
    a,b,c,d,e:boolean;

begin
//for j:=1 to 27 do write(', ',ord(char(96+j))-96);

inicializarTrie(r);

InsertarPalabra('perro',r);
writeln('se inserto, perro');
InsertarPalabra('pero',r);
writeln('se inserto, pero');
InsertarPalabra('perenne',r);
writeln('se inserto, perenne');
InsertarPalabra('perrera',r);
writeln('se inserto, perrera');
InsertarPalabra('hola',r);
writeln('se inserto, hola');

writeln('---------');

a:=BuscarPalabra('perro',r);
writeln('esta (perro) en el trie: ',a);
b:=BuscarPalabra('pero',r);
writeln('esta (pero) en el trie: ',b);
c:=BuscarPalabra('perenne',r);
writeln('esta (perenne) en el trie: ',c);
e:=BuscarPalabra('hola',r);
writeln('esta (hola) en el trie: ',e);
d:=BuscarPalabra('holi',r);
writeln('esta (holi) en el trie: ',d);

writeln('---------');

mostrarTrie('pe',r);

readln;


//readln;
end.
