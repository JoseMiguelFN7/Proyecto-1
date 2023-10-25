program teleferico;
{$codepage UTF8} //Permite usar acentos y ñ en consola.
uses crt, sysutils;
var
conExit, validNumDoc, validEstacion, validTramo: boolean;
op, estacion, tramo: char;
nombre, apellido, tDoc, numDoc: string;
i, precio: integer;
const
precioGeneral: integer = 20;
precioTEdadN: integer = 12;
begin
    clrscr;
    writeln('Bienvenido al sistema de teleférico de Mérida!');
    conExit:=false; //Booleano que se hara true cuando el usuario quiera salir del sistema.
    repeat
        writeln('Por favor, indique la opción que desea realizar.');
        writeln('1. Comprar boleto.');
        writeln('2. Ver sistema.');
        writeln('3. Salir.');
        op:=readkey;
        case (op) of
            '1': begin
                repeat
                    clrscr;
                    writeln('Por favor, indique el tipo de documento (V/E/J/G): ');
                    tdoc:=UpperCase(readkey);
                    if not (tdoc[1] in ['V', 'E', 'J', 'G']) then //Si el caracter ingresado no es ninguno de los solicitados, el sistema lo rechazara.
                    begin
                        writeln('El dato ingresado no es válido.');
                        delay(2000);
                    end;
                until (tdoc[1] in ['V', 'E', 'J', 'G']); //Sale del loop cuando se ingresa un caracter valido.
                repeat
                    clrscr;
                    write('Por favor, indique el número del documento sin puntos ni espacios: ');
                    readln(numDoc);
                    validNumDoc:=true;
                    for i:=1 to length(numDoc) do
                    begin
                        if not(numDoc[i] in ['0'..'9']) then //Si la entrada contiene algo que no es un numero, sera rechazado.
                        begin
                            validNumDoc:=false;
                            writeln('El dato ingresado no es válido.');
                            delay(2000);
                            break; //Si consigue un valor invalido, no es necesario chequear el resto.
                        end;
                    end;
                until validNumDoc; //Sale del loop cuando se ingrese un numero sin letras ni caracteres especiales.
                repeat
                    clrscr;
                    writeln('Por favor, indique la estación para la que quiere comprar boleto:'); //Pide la estacion.
                    writeln('1. Barinitas.');
                    writeln('2. La Montaña.');
                    writeln('3. La Aguada.');
                    writeln('4. Loma Redonda.');
                    writeln('5. Pico Espejo.');
                    estacion:=readkey;
                    validEstacion:=true;
                    case (estacion) of //Pide el tramo en base a la estacion ingresada.
                        '1': begin
                            clrscr;
                            writeln('El unico tramo disponible para esta estación es Barinitas - La Montaña.');
                            delay(2000);
                        end;
                        '2': begin
                            repeat
                                clrscr;
                                writeln('Por favor, indique el tramo para el que quiere comprar boleto:');
                                writeln('1. Barinitas - La Montaña.');
                                writeln('2. La Montaña - La Aguada.');
                                tramo:=readkey;
                                validTramo:=true;
                                case (tramo) of
                                    '1': begin
                                        ///////////////////////////////
                                    end;
                                    '2': begin
                                        ///////////////////////////////
                                    end
                                    else begin
                                        validTramo:=false;
                                        writeln('El dato ingresado no es válido.');
                                        delay(2000);
                                    end;
                                end;
                            until validTramo;
                        end;
                        '3': begin
                            repeat
                                clrscr;
                                writeln('Por favor, indique el tramo para el que quiere comprar boleto:');
                                writeln('1. La Montaña - La Aguada.');
                                writeln('2. La Aguada - Loma Redonda.');
                                tramo:=readkey;
                                tramo:=readkey;
                                validTramo:=true;
                                case (tramo) of
                                    '1': begin
                                        ///////////////////////////////
                                    end;
                                    '2': begin
                                        ///////////////////////////////
                                    end
                                    else begin
                                        validTramo:=false;
                                        writeln('El dato ingresado no es válido.');
                                        delay(2000);
                                    end;
                                end;
                            until validTramo;
                        end;
                        '4': begin
                            repeat
                                clrscr;
                                writeln('Por favor, indique el tramo para el que quiere comprar boleto:');
                                writeln('1. La Aguada - Loma Redonda.');
                                writeln('2. Loma Redonda - Pico Espejo.');
                                tramo:=readkey;
                                validTramo:=true;
                                case (tramo) of
                                    '1': begin
                                        ///////////////////////////////
                                    end;
                                    '2': begin
                                        ///////////////////////////////
                                    end
                                    else begin
                                        validTramo:=false;
                                        writeln('El dato ingresado no es válido.');
                                        delay(2000);
                                    end;
                                end;
                            until validTramo;
                        end;
                        '5': begin
                            clrscr;
                            writeln('El unico tramo disponible para esta estación es Loma Redonda - Pico Espejo.');
                            delay(2000);
                        end
                        else begin
                            validEstacion:=false;
                            writeln('El dato ingresado no es válido.');
                            delay(2000);
                        end;
                    end;
                until validEstacion;
            end;
            '2': begin
                clrscr;
                ////////////////////////////VER SISTEMA.
            end;
            '3': begin
                clrscr;
                conExit:=true; //El usuario ahora podra salir del sistema.
                writeln('Gracias por usar el sistema! Vuelva pronto.');
            end
            else begin
                writeln('El dato ingresado no es válido.');
                delay(2000);
                clrscr;
            end;
        end;
    until conExit; //Sale del loop una vez la condicion para salir sea true.
    readkey;
end.