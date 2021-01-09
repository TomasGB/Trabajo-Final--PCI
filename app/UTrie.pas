unit UTrie;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UNodo;

type
    TTrie = TPnodo;

    procedure inicializarTrie(var raiz:TTrie);
    procedure InsertarPalabra(palabra:String;raiz:TTrie);
    function BuscarPalabra(palabra:String;raiz:TTrie):Boolean;
    procedure agregarPalabraEnDiccionario(palabra:string;var diccionario:Text);

implementation

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

procedure agregarPalabraEnDiccionario(palabra:string;var diccionario:Text);
begin
    assign(diccionario,'diccionario.txt' );
    append(diccionario);
    writeLn(diccionario,palabra);
    close(diccionario);
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
            {if palabra[i] = 'ñ' then pos:=27
            else }pos:= Ord(palabra[i])-96;

            if palabra[i] = palabra[long] then FDPaux:=True;

            crearNodo(FDPaux,nuevoNodo);

            if (raiz^.hijos[pos] = Nil) then
            begin
                raiz^.hijos[pos]:=nuevoNodo;
                raiz:=raiz^.hijos[pos];
            end
            else raiz:=raiz^.hijos[pos];
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
         { if  palabra[i] = 'ñ' then indice :=27
          else }indice:=ord(palabra[i])-96;

          if(raiz^.hijos[indice] = nil)  then bool:=False
          else
            begin
                {if (palabra[i]= 'ñ') then raiz:=raiz^.hijos[indice]
                else }
                raiz:=raiz^.hijos[indice];
            end;
    end;
    BuscarPalabra:=bool;
end;


end.
