unit UTrie;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

const LETRAS =27;

type
    TPnodo = ^Tnodo;
    TLetras = array [1..LETRAS] of TPnodo;
    Tnodo = record
                FDP:boolean;
                hijos:TLetras;
                end;
    TTrie = TPnodo;

    procedure crearNodo(FDPaux:boolean;var nodo:TPnodo);
    procedure destruirNodo(FDPaux:boolean;var nodo:TPnodo);
    procedure inicializarTrie(var raiz:TTrie);
    procedure InsertarPalabra(palabra:String;raiz:TTrie);
    function BuscarPalabra(palabra:String;raiz:TTrie):Boolean;


implementation

procedure crearNodo(FDPaux:boolean;var nodo:TPnodo);
var i:integer;
begin
    new(nodo);
    nodo^.FDP:=FDPaux;
    for i:=1 to LETRAS do
      nodo^.hijos[i]:=nil;
end;

procedure destruirNodo(FDPaux:boolean;var nodo:TPnodo);
var i:integer;
begin
    nodo.FDP:=False;
    for i:=1 to letras do
    begin
         dispose(nodo.hijos[i]);
         nodo.hijos[i]:=nil;
    end;
end;

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



procedure InsertarPalabra(palabra:String;raiz:TTrie);
var i,long,pos:Integer;
    FDPaux:Boolean;
    nuevoNodo:TPnodo;
begin
    long:=Length(palabra);

    for i:=1 to long do
        begin
            if palabra[i] = 'ñ' then pos:=27
            else pos:= Ord(palabra[i])-96;

            if i = long then FDPaux:=True
            else FDPaux:=False;

            if (raiz^.hijos[pos] = Nil) then
            begin
                crearNodo(FDPaux,nuevoNodo);
                raiz^.hijos[pos]:=nuevoNodo;
                raiz:=raiz^.hijos[pos];
            end
            else
                begin
                    if (i=long) then
                        begin
                            raiz:=raiz^.hijos[pos];
                            raiz^.FDP := FDPaux;
                        end
                    else raiz:=raiz^.hijos[pos];
                end;
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
         if palabra[i] = 'ñ' then indice:=27
         else indice:=ord(palabra[i])-96;

          if(raiz^.hijos[indice] = nil)  then bool:=False
          else
              begin
                    if char(indice+96) = palabra[i] then
                        begin
                            if (i = long) and (raiz^.FDP = False) then bool:=False
                            else bool:=True;
                        end
                    else raiz:=raiz^.hijos[indice];
              end;
    end;
    BuscarPalabra:=bool;
end;




end.
