program test2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

const LETRAS =27; //sin contar la ñ

type
    TPnodo = ^Tnodo;
    TLetras = array [1..LETRAS] of TPnodo;
    Tnodo = record
                FDP:boolean;
                hijos:TLetras;
                end;

    TTrie = TPnodo;

//var raiz:TTrie;


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
            if palabra[i] = ' ' then pos:=27
            else pos:= Ord(palabra[i])-96;

            if palabra[i] = palabra[long] then FDPaux:=True;

            crearNodo(FDPaux,nuevoNodo);

            if (raiz^.hijos[pos] = Nil){ and (pos <> (-64))}then
            begin
                raiz^.hijos[pos]:=nuevoNodo;
                raiz:=raiz^.hijos[pos];
            end
            else
                {if (pos =(-64))and(raiz^.hijos[27] = Nil)then
                    begin
                        raiz^.hijos[27]:=nuevoNodo;
                        raiz:=raiz^.hijos[27];
                    end
                else
                    if  (pos =(-64))and(raiz^.hijos[27] <> Nil) then raiz:=raiz^.hijos[27]
                    else }raiz:=raiz^.hijos[pos];
        end;

end;


function BuscarPalabra(palabra:String;raiz:TTrie):Boolean;
var i,long,indice:integer;
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
{Falta sacar el backtrack}

procedure MostrarTrie(pref:string;raiz:TTrie);
var i:integer;
    p:String;
begin
    for i:=1 to letras do
    begin
        if raiz^.hijos[i] <> nil then
        begin
            if chr(ord(i+96)) = '{' then p:=pref+' '
            else p:=pref+chr(ord(i+96));
            MostrarTrie(p,raiz^.hijos[i]);
            if (raiz^.hijos[i].FDP = true)then
            begin
                Write(p,'  ',raiz^.hijos[i]^.FDP);
                writeln('');
            end;

        end;
    end;

end;
////////////////////////////////////////////////////
procedure BuscarPorPref(pref:string;raiz:TTrie);
var long,i:integer;
    check:boolean;
begin
    long:= length(pref);
    check:=True;
    for i:=1 to long do
    begin
        if raiz^.hijos[ord(pref[i])-96] = nil then check:=False
        else raiz:=raiz^.hijos[ord(pref[i])-96] end;

    if check = True then mostrarTrie(pref,raiz)
    else writeln('no existe la palabra: ',pref);
end;



//variables globales
var r:TTrie;
a,b,c{,d,e,f}:boolean;

begin
//for j:=1 to 27 do write(', ',ord(char(96+j))-96);

inicializarTrie(r);

InsertarPalabra('perro',r);
writeln('se inserto, perro');
InsertarPalabra('pero',r);
writeln('se inserto, pero');
InsertarPalabra('perenne',r);
writeln('se inserto, perenne');
InsertarPalabra('perra',r);
writeln('se inserto, perra');
InsertarPalabra('hola',r);
writeln('se inserto, hola');
InsertarPalabra('holanda',r);
writeln('se inserto, holanda');
InsertarPalabra('holandes',r);
writeln('se inserto, holandes');
InsertarPalabra('parapente',r);
writeln('se inserto, parapente');
InsertarPalabra('tomas',r);
writeln('se inserto, tomas');
InsertarPalabra('juez',r);
writeln('se inserto, juez');
InsertarPalabra('juez federal',r);
writeln('se inserto, juez federal');
InsertarPalabra('juez penal',r);
writeln('se inserto, juez penal');
writeln('---------');

a:=BuscarPalabra('perro',r);
writeln('esta (perro) en el trie: ',a);
b:=BuscarPalabra('pero',r);
writeln('esta (pero) en el trie: ',b);
c:=BuscarPalabra('perenne',r);
writeln('esta (perenne) en el trie: ',c);

writeln('---------');
writeln('Trie entero');
writeln('');
mostrarTrie('',r);
writeln('---------');
writeln('Buscar por pref');
writeln('');
BuscarPorPref('ho',r);

writeln('---------');
writeln('Buscar por pref, cuando no hay palabra');
writeln('');
BuscarPorPref('ju',r);
readln;



end.
