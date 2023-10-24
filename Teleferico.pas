program teleferico;
uses crt, sysutils;
var
conExit: boolean;
op, estation, tramo: char;
nombre, apellido, tdoc: string;
begin
    clrscr;
    writeln('Bienvenido al sistema de teleferico de Merida!');
    conExit:=false;
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
                    if not (tdoc[1] in ['V', 'E', 'J', 'G']) then
                    begin
                        writeln('El dato ingresado no es valido.');
                        delay(2000);
                    end;
                until (tdoc[1] in ['V', 'E', 'J', 'G']);
            end;
            '2': begin
                clrscr;
                ////////////////////////////
            end;
            '3': begin
                clrscr;
                conExit:=true;
                writeln('Gracias por usar el sistema! Vuelva pronto.');
            end
            else begin
                writeln('El dato ingresado no es valido.');
                delay(2000);
                clrscr;
            end;
        end;
    until conExit;
    readkey;
end.