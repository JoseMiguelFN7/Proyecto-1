program teleferico;
uses crt;
var
conExit: boolean;
op: char;
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
                ////////////////////////////
            end;
            '2': begin
                ////////////////////////////
            end;
            '3': begin
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