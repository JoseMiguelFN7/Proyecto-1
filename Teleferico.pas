program teleferico;
uses crt, sysutils;
var
conExit, validNumDoc: boolean;
op, estacion, tramo: char;
nombre, apellido, tDoc, numDoc: string;
i: integer;
begin
    clrscr;
    writeln('Bienvenido al sistema de teleferico de Merida!');
    conExit:=false; //Booleano que se hara true cuando el usuario quiera salir del sistema.
    repeat
        writeln('Por favor indique la opcion que desea realizar.');
        writeln('1. Comprar boleto.');
        writeln('2. ver Sistema.');
        writeln('3. Salir.');
        op:=readkey;
        case (op) of
            '1': begin
                repeat
                    clrscr;
                    writeln('Por favor indique el tipo de documento (V/E/J/G): ');
                    tdoc:=UpperCase(readkey);
                    if not (tdoc[1] in ['V', 'E', 'J', 'G']) then //Si el caracter ingresado no es ninguno de los solicitados, el sistema lo rechazara.
                    begin
                        writeln('El dato ingresado no es valido.');
                        delay(2000);
                    end;
                until (tdoc[1] in ['V', 'E', 'J', 'G']); //Sale del loop cuando se ingresa un caracter valido.
                repeat
                    clrscr;
                    write('Por favor indique el numero del documento sin puntos ni espacios: ');
                    readln(numDoc);
                    validNumDoc:=true;
                    for i:=1 to length(numDoc) do
                    begin
                        if not(numDoc[i] in ['0'..'9']) then //Si la entrada contiene algo que no es un numero, sera rechazado.
                        begin
                            validNumDoc:=false;
                            writeln('El dato ingresado no es valido.');
                            delay(2000);
                            break; //Si consigue un valor invalido, no es necesario chequear el resto.
                        end;
                    end;
                until validNumDoc; //Sale del loop cuando se ingrese un numero sin letras ni caracteres especiales.
            end;
            '2': begin
                clrscr;
                ////////////////////////////
            end;
            '3': begin
                clrscr;
                conExit:=true; //El usuario ahora podra salir del sistema.
                writeln('Gracias por usar el sistema! Vuelva pronto.');
            end
            else begin
                writeln('El dato ingresado no es valido.');
                delay(2000);
                clrscr;
            end;
        end;
    until conExit; //Sale del loop una vez la condicion para salir sea true.
    readkey;
end.