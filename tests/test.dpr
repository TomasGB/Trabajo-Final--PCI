program test;

{$APPTYPE CONSOLE}

uses
  SysUtils;

type TPnodo = ^ Tnodo;
     arregloPunteros = array [1..26] of TPnodo;
     subtrie = record
                letra:char;
                hijos:arregloPunteros;
                end;
     Tnodo = record
               IsEndOfWord :boolean;
               hijo:subtrie;
            end;

var palabra: string;


////////////////////////////////////////////////////////////////////////////////
{procedure insertarPalabra(p:string; raiz:TPnodo);
var i,j,k:integer;
    nuevoNodo,inicial: TPnodo;


begin
inicial:=raiz;
j:=length(p);

if raiz^.hijo.hijos = nil then
begin
    {Caso que el arbol este vacio}
    {for i:=1 to j do
    begin
       //crea el nuevo nodo
       new(nuevoNodo);
       nuevoNodo^.hijo.hijos:=nil;
       nuevoNodo^.hijo.letra:=p[i];
       //lo conecta
       raiz^.hijo.hijos:=nuevoNodo;
       raiz:=raiz^.hijo.hijos;
       write(raiz^.hijo.letra);
    end;
    raiz^.IsEndOfWord:=true;
    writeln('');
    writeln('FDP:',raiz^.IsEndOfWord,' ',raiz^.hijo.letra);
    raiz:=inicial;
    writeln('FDP:',raiz^.IsEndOfWord,' ',raiz^.hijo.hijos^.hijo.letra);
end
else
    {ya tenga palabras}
   { begin
        for i:=1 to j do
        begin
            if (raiz^.hijo.letra = p[i]) and (raiz^.hijo.hijos <> nil)  then
                raiz:=raiz^.hijo.hijos
            else
                begin
                    //crea el nuevo nodo
                    new(nuevoNodo);
                    nuevoNodo^.hijo.hijos:=nil;
                    nuevoNodo^.hijo.letra:=p[i];
                    //lo conecta
                    raiz^.hijo.hijos:=nuevoNodo;
                    raiz:=raiz^.hijo.hijos;
                    write(raiz^.hijo.letra);
                end;

    end;
    raiz^.IsEndOfWord:=true;
    writeln('');
    writeln('FDP:',raiz^.IsEndOfWord,' ',raiz^.hijo.letra);
    raiz:=inicial;
    writeln('FDP:',raiz^.IsEndOfWord,' ',raiz^.hijo.hijos^.hijo.letra);
end;
end;     }

procedure insertarPalabra(p:string; raiz:TPnodo);
var i,j,k:integer;
    nuevoNodo,inicial: TPnodo;


begin
inicial:=raiz;
j:=length(p);

if raiz^.hijo.hijos[1] = nil then
begin
    {Caso que el arbol este vacio}
    for i:=1 to j do
    begin
       //crea el nuevo nodo
       new(nuevoNodo);
       nuevoNodo^.hijo.hijos[ord(p[1])]:=nil;
       nuevoNodo^.hijo.letra:=p[i];
       //lo conecta
       raiz^.hijo.hijos[ord(p[1])]:=nuevoNodo;
       raiz:=raiz^.hijo.hijos[ord(p[1])];
       write(raiz^.hijo.letra);
    end;
    raiz^.IsEndOfWord:=true;
    writeln('');
    writeln('FDP:',raiz^.IsEndOfWord,' ',raiz^.hijo.letra);
    raiz:=inicial;
    writeln('FDP:',raiz^.IsEndOfWord,' ',raiz^.hijo.hijos[ord(p[1])]^.hijo.letra);
end
else
    {ya tenga palabras}
    begin
        for i:=1 to j do
        begin
            if (raiz^.hijo.letra = p[i]) and (raiz^.hijo.hijos[ord(p[i])] <> nil)  then
                raiz:=raiz^.hijo.hijos[ord(p[i])]
            else
                begin
                    //crea el nuevo nodo
                    new(nuevoNodo);
                    nuevoNodo^.hijo.hijos[ord(p[1])]:=nil;
                    nuevoNodo^.hijo.letra:=p[i];
                    //lo conecta
                    raiz^.hijo.hijos[ord(p[i])]:=nuevoNodo;
                    raiz:=raiz^.hijo.hijos[ord(p[i])];
                    write(raiz^.hijo.letra);
                end;

    end;
    raiz^.IsEndOfWord:=true;
    writeln('');
    writeln('FDP:',raiz^.IsEndOfWord,' ',raiz^.hijo.letra);
    raiz:=inicial;
    writeln('FDP:',raiz^.IsEndOfWord,' ',raiz^.hijo.hijos[ord(p[i])]^.hijo.letra);
end;
end;

////////////////////////////////////////////////////////////////////////////////
procedure printTrie(espacio:integer;raiz:TPnodo);
var i,j:integer;
    b:char;
begin
for i:=1 to 24 do
begin
writeln(raiz^.hijo.letra,':letra');

end;
raiz:= raiz^.hijo.hijos[i+1];
readln;
end;





//--------------------programa ppal-----------------------

var raiz:tpnodo;
    p,h,i,j,k,l,m,n:string;
begin
  { TODO -oUser -cConsole Main : Insert code here }

new(raiz);
p:='perro';
insertarPalabra(p, raiz);
writeln('--------------------------------');
h:='pera';
insertarPalabra(h, raiz);
writeln('--------------------------------');
{i:='perenne';
insertarPalabra(i, raiz);
writeln('--------------------------------');
j:='arbol';
insertarPalabra(j, raiz);
writeln('--------------------------------');
k:='arboleda';
insertarPalabra(k, raiz);
writeln('--------------------------------');
l:='12345';
insertarPalabra(l,raiz);
writeln('--------------------------------');
m:='1233';
insertarPalabra(m,raiz);
writeln('--------------------------------');
n:='1533';
insertarPalabra(n,raiz);
writeln('--------------------------------');}

printTrie(1,raiz);




readln;

end.
