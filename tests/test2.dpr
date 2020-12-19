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

procedure buscarUltimaPalabra(palabras:string;raiz:TTrie; var ultimaPalabra:string);
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
writeln(ultimaPalabra);
end;


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
a,b,c,d,e,f,g:boolean;
ultimaPalabra:string;

begin
//for j:=1 to 27 do write(', ',ord(char(96+j))-96);

inicializarTrie(r);
///////////////////////////////////////////////////////////////////////////////
writeln('Test procedimientos InsertarPalabra y BuscarPalabra:');
writeln('');
InsertarPalabra('perro',r);
writeln('insertar perro');
a:=BuscarPalabra('perro',r);
writeln('se inserto perro en el trie: ',a);
writeln('');
InsertarPalabra('pero',r);
writeln('insertar pero');
b:=BuscarPalabra('pero',r);
writeln('se inserto pero en el trie: ',b);
writeln('');
InsertarPalabra('perenne',r);
writeln('insertar perenne');
c:=BuscarPalabra('perenne',r);
writeln('se inserto perenne en el trie: ',c);
writeln('');
InsertarPalabra('perra',r);
writeln('insertar perra');
d:=BuscarPalabra('perra',r);
writeln('se inserto perra en el trie: ',d);
writeln('');
InsertarPalabra('hola',r);
writeln('insertar hola');
e:=BuscarPalabra('hola',r);
writeln('se inserto hola en el trie: ',e);
writeln('');
InsertarPalabra('holanda',r);
writeln('insertar holanda');
f:=BuscarPalabra('holanda',r);
writeln('se inserto holanda en el trie: ',f);
writeln('');
InsertarPalabra('holandes',r);
writeln('insertar holandes');
g:=BuscarPalabra('holandes',r);
writeln('se inserto holandes en el trie: ',g);
writeln('');
writeln('-------------------------------------------------------');
writeln('Test procedimiento mostrarTrie:');
writeln('');
mostrarTrie('',r);
writeln('-------------------------------------------------------');
writeln('');
writeln('Test procedimiento BuscarPorPref');
writeln('Palabras con el prefijo ( ho ) ');
writeln('');
BuscarPorPref('ho',r);
writeln('');
writeln('Palabras con el prefijo ( perr ) ');
BuscarPorPref('perr',r);
writeln('');
writeln('Palabras con el prefijo ( ar ) ');
writeln('');
BuscarPorPref('ar',r);
writeln('');
writeln('-------------------------------------------------------');
writeln('');
writeln('Test procedimiento buscarUltimaPalabra');
writeln('');
writeln('Texto ingresado: ''prueba ultima palabra''');
write('Resultado: ');buscarUltimaPalabra('prueba ultima palabra',r,ultimaPalabra);
writeln('');
writeln('-------------------------------------------------------');
readln;


end.
