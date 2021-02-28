program test;

{$APPTYPE CONSOLE}

uses
  SysUtils;

const LETRAS =27;

type
    TPnodo = ^Tnodo;
    TLetras = array [1..LETRAS] of TPnodo;
    Tnodo = record
                FDP:boolean;
                hijos:TLetras;
                end;

    TTrie = TPnodo;

// UTrie

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

function calcularIndice(letra:char):integer;
begin

    if letra = 'ñ' then calcularIndice:=15
    else
    begin
        if (Ord(letra)-96) < 15 then calcularIndice:=Ord(letra)-96
        else calcularIndice:=(Ord(letra)-96)+1;
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
            pos:=calcularIndice(palabra[i]);

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
          indice:=calcularIndice(palabra[i]);

          if raiz^.hijos[indice] = nil then bool:=False
          else
            begin
                raiz:=raiz^.hijos[indice];
                if (i=long) and (raiz.FDP = False) then bool:=False
                else bool:=True;
            end;
    end;
    BuscarPalabra:=bool;
end;

procedure eliminarPalabra(palabra:string;raiz:TTrie);
var i,j,k,long,indice:Integer;
    masPalabras:Boolean;

begin
    long:=Length(palabra);
    masPalabras:=False;
    j:=1;
    k:=long;

    // Este bucle lleva la raiz a la ultima letra
    for i:=1 to long do
    begin
        indice:=calcularIndice(palabra[i]);
        raiz:=raiz^.hijos[indice];
    end;

    while (k>=1) do
    begin

        // controla si el nodo de la ultima letra tiene hijos
        while masPalabras = False do
        begin
            if raiz^.hijos[j] <> Nil  then masPalabras:=True
            else
                begin
                    raiz.FDP:=False;
                end;
            j:=j+1;
        end;

        if masPalabras = False then destruirNodo(False,raiz);

       k:=k-1;
    end;

end;

// UPrincipal

function calcularLetra(indice:integer):string;
begin
    if indice = 15 then calcularLetra:='ñ'
    else
    begin
        if indice < 15 then calcularLetra:=chr(ord(indice+96))
        else if indice > 15 then calcularLetra:=chr(indice+96-1);
    end;
end;

procedure MostrarTrie(pref:string;raiz:TTrie);
var i:integer;
    p, letra:String;
begin
    for i:=1 to letras do
    begin
        if raiz^.hijos[i] <> nil then
        begin

            letra:=calcularLetra(i);
            p:=pref+letra;

            if (raiz.hijos[i].FDP = true)then
            begin
                Write(p,'  ');
                writeln('');
            end;
            MostrarTrie(p,raiz^.hijos[i]);
        end
        else ;
    end;

end;

procedure BuscarPorPref(pref:string;raiz:TTrie);
var long,i,pos:integer;
    check:boolean;
begin
    long:= length(pref);
    check:=True;

    for i:=1 to long do
    begin
        // 255 es el ASCII de espacio
        if (ord(pref[i])=255) then
        else pos:=calcularIndice(pref[i]);

        if raiz^.hijos[pos] = nil then check:=False
        else
        begin
            if pref[i] = 'ñ' then raiz:=raiz^.hijos[15]
            else
                if calcularIndice(pref[i]) <15 then raiz:=raiz^.hijos[ord(pref[i])-96]
                else raiz:=raiz^.hijos[ord(pref[i])-96+1];
        end;
    end;

    if check = True then mostrarTrie(pref,raiz)
    else writeln('No se encuentra la palabra: ',pref);
end;

procedure parsearUltimaPalabra(palabras:string;raiz:TTrie; var ultimaPalabra, frase:string);
var i:integer;
    esUltimaPalabra:boolean;
begin

esUltimaPalabra:=False;
ultimaPalabra:='';
frase:='';
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
    //Esta condicion controla si hay mas de una palabra en el string.
    begin
        esUltimaPalabra:=False;
        frase:=frase+ultimaPalabra;
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
writeln(ultimaPalabra);
end;

//variables globales
var r:TTrie;
a,b,c,d,e,f,g,h,i:boolean;
ultimaPalabra,frase:string;

begin

inicializarTrie(r);

///////////////////////////////////////////////////////////////////////////////
writeln('Test procedimientos InsertarPalabra y BuscarPalabra:');
writeln('');
InsertarPalabra('perro',r);
writeln('insertar perro');
a:=BuscarPalabra('perro',r);
writeln('se inserto perro en el trie?: ',a);
writeln('Resultado esperado: TRUE');
writeln('');
InsertarPalabra('pero',r);
writeln('insertar pero');
b:=BuscarPalabra('pero',r);
writeln('se inserto pero en el trie?: ',b);
writeln('Resultado esperado: TRUE');
writeln('');
InsertarPalabra('perrera',r);
writeln('insertar perrera');
c:=BuscarPalabra('perrera',r);
writeln('se inserto perrera en el trie?: ',c);
writeln('Resultado esperado: TRUE');
writeln('');
InsertarPalabra('perra',r);
writeln('insertar perra');
d:=BuscarPalabra('perra',r);
writeln('se inserto perra en el trie?: ',d);
writeln('Resultado esperado: TRUE');
writeln('');
InsertarPalabra('hola',r);
writeln('insertar hola');
e:=BuscarPalabra('hola',r);
writeln('se inserto hola en el trie?: ',e);
writeln('Resultado esperado: TRUE');
writeln('');
InsertarPalabra('holanda',r);
writeln('insertar holanda');
f:=BuscarPalabra('holanda',r);
writeln('se inserto holanda en el trie?: ',f);
writeln('Resultado esperado: TRUE');
writeln('');
InsertarPalabra('holandes',r);
writeln('insertar holandes');
g:=BuscarPalabra('holandes',r);
writeln('se inserto holandes en el trie?: ',g);
writeln('Resultado esperado: TRUE');
writeln('');
h:=BuscarPalabra('casa',r);
writeln('se inserto '+'casa '+'en el trie?: ',h);
writeln('Resultado esperado: FALSE');
writeln('');
writeln('-------------------------------------------------------');
writeln('Test procedimiento mostrarTrie:');
writeln('');
writeln('resultado esperado: hola, holanda, holandes, pero, perro, perra, perrera');
writeln('');
mostrarTrie('',r);
writeln('-------------------------------------------------------');
writeln('');
writeln('Test procedimiento BuscarPorPref');
writeln('');
writeln('Palabras con el prefijo ( ho ) ');
writeln('resultado esperado: hola, holanda, holandes');
writeln('');
BuscarPorPref('ho',r);
writeln('');
writeln('Palabras con el prefijo ( per ) ');
writeln('resultado esperado: pero, perro, perra, perrera');
writeln('');
BuscarPorPref('per',r);
writeln('');
writeln('Palabras con el prefijo ( perr ) ');
writeln('resultado esperado: perro, perra, perrera');
writeln('');
BuscarPorPref('perr',r);
writeln('');
writeln('Palabras con el prefijo ( ar ) ');
writeln('');
writeln('resultado esperado: No se encuentra la palabra: ar');
BuscarPorPref('ar',r);
writeln('');
writeln('-------------------------------------------------------');
writeln('');
writeln('Test procedimiento parsearUltimaPalabra');
writeln('');
writeln('Texto ingresado: ''prueba ultima palabra''');
writeln('Resultado esperado: palabra');
writeln('');
write('Resultado obtenido: ');parsearUltimaPalabra('prueba ultima palabra',r,ultimaPalabra,frase);
writeln('');
writeln('-------------------------------------------------------');
writeln('');
writeln('Test procedimiento eliminarPalabra');
writeln('');
mostrarTrie('',r);
writeln('');
i:=BuscarPalabra('holandes',r);
writeln('holandes esta en el Trie?: ',i);
writeln('');
writeln('Se elimino holandes');
eliminarPalabra('holandes',r);
writeln('');
i:=BuscarPalabra('holandes',r);
writeln('holandes esta en el Trie?: ',i);
writeln('');
writeln('resultado esperado: hola, holanda, pero, perra, perrera, perro');
writeln('');
write('resultado obtenido:');
writeln('');
mostrarTrie('',r);
readln;


end.
