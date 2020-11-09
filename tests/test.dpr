program test;

{$APPTYPE CONSOLE}

uses
  SysUtils;

type
    TPTrieNode = ^TrieNode;
    TrieNode = record
                    letra:string;
                    FDP:boolean; //fin de palabra
                    hijos, hermanos: TPTrieNode;
                end;

var Raiz,hijo,inicio: TPTrieNode;
    palabra, palabra2: string;

{procedure InsertarNodo(l:string; var raiz,hijo:TPTrieNode);
begin
new(hijo);
hijo^.hijos:=nil;
hijo^.letra:=l;
raiz^.hijos:=hijo;
end;}

procedure InsertarPalabra(p:string;raiz:TPTrieNode);
var i,j:integer;
    l:string;
begin
    j:=length(palabra);

    for i:=1 to j do
    begin
         l:= palabra[i];
         new(hijo);
         hijo^.hijos:=nil;
         hijo^.letra:=l;

         while (raiz^.hijos<>nil) do
            begin
                raiz:=raiz^.hijos;
                if raiz^.letra <> l then
                begin
                    raiz^.hijos:=raiz^.hermanos;
                    raiz^.hermanos:=hijo;

                end;
            end;

         raiz^.hijos:=hijo;
         writeln(raiz^.letra);

    end;
    writeln(raiz^.hijos^.letra);
    raiz^.FDP:=True;
    //writeln(raiz^.hijos^.letra);
    writeln('termino el for');
    //raiz:=inicio;
end;

begin
  { TODO -oUser -cConsole Main : Insert code here }
palabra:='perrera';
new(raiz);
InsertarPalabra(palabra, raiz);
palabra2:= 'perro';
InsertarPalabra(palabra2, raiz);
while raiz^.hijos <> nil do
begin
    writeln(raiz^.letra);
    raiz:=raiz^.hijos;
end;
writeln(raiz^.letra);

readln;

end.
