unit UNodo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

const LETRAS =27; //sin contar la �, 27 es para el espacio

type
     TPnodo = ^Tnodo;
     TLetras = array [1..LETRAS] of TPnodo;
     Tnodo = record
                FDP:boolean;
                hijos:TLetras;
                end;

procedure crearNodo(FDPaux:boolean;var nodo:TPnodo);

implementation

procedure crearNodo(FDPaux:boolean;var nodo:TPnodo);
var i:integer;
begin
    new(nodo);
    nodo^.FDP:=FDPaux;
    for i:=1 to LETRAS do
      nodo^.hijos[i]:=nil;
end;



end.
