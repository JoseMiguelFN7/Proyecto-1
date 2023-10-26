program teleferico;
{$codepage UTF8} //Permite usar acentos y ñ en consola.
uses crt, sysutils;
var
validNumDoc, validEdad, TAB, TBC, TCD, TDE: boolean;
op, estacion, tramo, tBoleto, otro: char;
nombre, apellido, tDoc, numDoc, nBoletosStr, edad: string;
i, j, numDocInt, edadInt, precioBoleto, FprecioTotalCompra, ventaTotal, nBoletos, error, bVendidosAB, bVendidosBC, bVendidosCD, bVendidosDE, nBGeneralVendidos, nBTEdadNVendidos, nBExoneradosVendidos, aDisponiblesAB, aDisponiblesBC, aDisponiblesCD, aDisponiblesDE, FnBGeneralAB, FnBTEdadNAB, FnBExoneradosAB, FnBGeneralBC, FnBTEdadNBC, FnBExoneradosBC, FnBGeneralCD, FnBTEdadNCD, FnBExoneradosCD, FnBGeneralDE, FnBTEdadNDE, FnBExoneradosDE, generalAB, tEdadNAB, exoneradoAB, generalBC, tEdadNBC, exoneradoBC, generalCD, tEdadNCD, exoneradoCD, generalDE, tEdadNDE, exoneradoDE: integer;
const
precioGeneral: integer = 20;
precioTEdadN: integer = 12;
precioExonerado: integer = 0;

begin
    clrscr;
    writeln('Bienvenido al sistema de teleférico de Mérida!');
    //La cantidad de boletos totales vendidos en todos los tramos inicia siendo cero.
    bVendidosAB:=0;
    bVendidosBC:=0;
    bVendidosCD:=0;
    bVendidosDE:=0;
    //La cantidad de tipos de boletos totales vendidos inicia siendo cero.
    nBGeneralVendidos:=0;
    nBTEdadNVendidos:=0;
    nBExoneradosVendidos:=0;
    //La cantidad de tipos de boletos vendidos POR TRAMO inicia siendo cero.
    generalAB:=0;
    tEdadNAB:=0;
    exoneradoAB:=0;
    generalBC:=0;
    tEdadNBC:=0;
    exoneradoBC:=0;
    generalCD:=0;
    tEdadNCD:=0;
    exoneradoCD:=0;
    generalDE:=0;
    tEdadNDE:=0;
    exoneradoDE:=0;
    //Los asientos disponibles en cada tramo empiezan siendo 60;
    aDisponiblesAB:=60;
    aDisponiblesBC:=60;
    aDisponiblesCD:=60;
    aDisponiblesDE:=60;
    //El monto de la venta total de los boletos inicia siendo cero.
    ventaTotal:=0;
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
                    //INGRESAR NOMBRE Y APELLIDO
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
                    val(numDoc, numDocInt, error);
                    if ((error<>0) or (numDoc[1]='0') or (numDocInt<=0)) then
                    begin
                        writeln('El dato ingresado no es válido.');
                        delay(2000);
                    end;
                until ((error=0) and (numDoc[1]<>'0') and (numDocInt>0)); //Sale del loop cuando se ingrese un numero sin letras ni caracteres especiales y que no empiece por o sea cero.
                ///////////////////// Valores iniciales de los datos para la factura
                FprecioTotalCompra:=0;
                FnBGeneralAB:=0;
                FnBTEdadNAB:=0;
                FnBExoneradosAB:=0;
                FnBGeneralBC:=0;
                FnBTEdadNBC:=0;
                FnBExoneradosBC:=0;
                FnBGeneralCD:=0;
                FnBTEdadNCD:=0;
                FnBExoneradosCD:=0;
                FnBGeneralDE:=0;
                FnBTEdadNDE:=0;
                FnBExoneradosDE:=0;
                TAB:=false;
                TBC:=false;
                TCD:=false;
                TDE:=false;
                repeat
                    ////////////////////////////////////////////////////////////////////////////////ESTACION Y TRAMO
                    clrscr;
                    writeln('Por favor, indique la estación para la que quiere comprar boleto:'); //Pide la estacion.
                    writeln('1. Barinitas.');
                    writeln('2. La Montaña.');
                    writeln('3. La Aguada.');
                    writeln('4. Loma Redonda.');
                    writeln('5. Pico Espejo.');
                    estacion:=readkey;
                    case (estacion) of //Pide el tramo en base a la estacion ingresada.
                        /////////////////////////////////////////////////////////////////////////////////// BARINITAS.
                        '1': begin
                            clrscr;
                            writeln('El único tramo disponible para esta estación es Barinitas - La Montaña.'); //AB
                            delay(2000);
                        end;
                        ////////////////////////////////////////////////////////////////////////////////// LA MONTAÑA.
                        '2': begin
                            repeat
                                clrscr;
                                writeln('Por favor, indique el tramo para el que quiere comprar boleto:');
                                writeln('1. Barinitas - La Montaña.'); //AB
                                writeln('2. La Montaña - La Aguada.'); //BC
                                tramo:=readkey;
                                case (tramo) of
                                    '1': begin //Tramo AB.
                                        if (aDisponiblesAB>0) then
                                        begin
                                            repeat
                                                clrscr;
                                                write('¿Cuántos boletos desea comprar? (Quedan ',aDisponiblesAB,' disponibles): ');
                                                readln(nBoletosStr);
                                                val(nBoletosStr, nBoletos, error); //Para validar si es un dato valido.
                                                if ((error<>0) or (nBoletos<=0) or (aDisponiblesAB<nBoletos)) then
                                                begin
                                                    writeln('El dato ingresado no es válido.');
                                                    delay(2000);
                                                end;
                                            until ((error=0) and (nBoletos>0) and (aDisponiblesAB>nBoletos));
                                            for i:=1 to nBoletos do
                                            begin
                                                repeat
                                                    clrscr;
                                                    writeln('Datos necesarios para la compra del boleto ', i, ':');
                                                    writeln('¿La persona que usará este boleto es un niño/a o persona de la tercera edad?:');
                                                    writeln('1. Niño/a.');
                                                    writeln('2. Persona de la tercera edad.');
                                                    writeln('3. Ninguno de los dos.');
                                                    tBoleto:=readkey;
                                                    case (tBoleto) of
                                                        '1': begin
                                                            repeat
                                                                write('Por favor, ingrese la edad del niño/a: ');
                                                                readln(edad);
                                                                validEdad:=true;
                                                                val(edad, edadInt, error);
                                                                if ((error<>0) or (edad[1]='0')) then
                                                                begin
                                                                    writeln('El dato ingresado no es válido.');
                                                                    delay(2000);
                                                                end;
                                                            until ((error=0) and (edad[1]<>'0'));
                                                            if (edadInt<3) then
                                                            begin
                                                                precioBoleto:=precioExonerado;
                                                                exoneradoAB+=1;
                                                                FnBExoneradosAB+=1;
                                                            end
                                                            else begin
                                                                if (edadInt<=12) then
                                                                begin
                                                                    precioBoleto:=precioTEdadN;
                                                                    tEdadNAB+=1;
                                                                    FnBTEdadNAB+=1;
                                                                end
                                                                else begin
                                                                    precioBoleto:=precioGeneral;
                                                                    generalAB+=1;
                                                                    FnBGeneralAB+=1;
                                                                end;
                                                            end;
                                                        end;
                                                        '2': begin
                                                            precioBoleto:=precioTEdadN;
                                                            tEdadNAB+=1;
                                                            FnBTEdadNAB+=1;
                                                        end;
                                                        '3': begin
                                                            precioBoleto:=precioGeneral;
                                                            generalAB+=1;
                                                            FnBGeneralAB+=1;
                                                        end
                                                        else begin
                                                            writeln('El dato ingresado no es válido.');
                                                            delay(2000);
                                                        end;
                                                    end;
                                                until (tBoleto in ['1', '2', '3']);
                                                FprecioTotalCompra+= precioBoleto;
                                                writeln('¡Boleto confirmado!');
                                                delay(1000);
                                            end;
                                            aDisponiblesAB-=nBoletos;
                                            TAB:=true;
                                        end
                                        else begin
                                            writeln('Este tramo no tiene asientos disponibles.');
                                            delay(2000);
                                            clrscr;
                                        end;
                                    end;
                                    '2': begin //Tramo BC.
                                        ///////////////////////////////
                                    end
                                    else begin
                                        writeln('El dato ingresado no es válido.');
                                        delay(2000);
                                    end;
                                end;
                            until (tramo in ['1', '2']);
                        end;
                        /////////////////////////////////////////////////////////////////////////////////// LA AGUADA.
                        '3': begin
                            repeat
                                clrscr;
                                writeln('Por favor, indique el tramo para el que quiere comprar boleto:');
                                writeln('1. La Montaña - La Aguada.'); //BC
                                writeln('2. La Aguada - Loma Redonda.'); //CD
                                tramo:=readkey;
                                case (tramo) of
                                    '1': begin
                                        ///////////////////////////////
                                    end;
                                    '2': begin
                                        ///////////////////////////////
                                    end
                                    else begin
                                        writeln('El dato ingresado no es válido.');
                                        delay(2000);
                                    end;
                                end;
                            until (tramo in ['1', '2']);
                        end;
                        ////////////////////////////////////////////////////////////////////////////////LOMA REDONDA.
                        '4': begin
                            repeat
                                clrscr;
                                writeln('Por favor, indique el tramo para el que quiere comprar boleto:');
                                writeln('1. La Aguada - Loma Redonda.'); //CD
                                writeln('2. Loma Redonda - Pico Espejo.'); //DE
                                tramo:=readkey;
                                case (tramo) of
                                    '1': begin
                                        ///////////////////////////////
                                    end;
                                    '2': begin
                                        ///////////////////////////////
                                    end
                                    else begin
                                        writeln('El dato ingresado no es válido.');
                                        delay(2000);
                                    end;
                                end;
                            until (tramo in ['1', '2']);
                        end;
                        //////////////////////////////////////////////////////////////////////////////// PICO ESPEJO.
                        '5': begin
                            clrscr;
                            writeln('El unico tramo disponible para esta estación es Loma Redonda - Pico Espejo.'); //DE
                            delay(2000);
                        end
                        else begin
                            writeln('El dato ingresado no es válido.');
                            delay(2000);
                        end;
                    end;
                    if (estacion in ['1', '2', '3', '4', '5']) then
                    begin
                        repeat
                            clrscr;
                            writeln('¿Desea comprar otro boleto? (S/N)');
                            otro:=readkey;
                            if not (otro in ['S', 's', 'N', 'n']) then
                            begin
                                writeln('El dato ingresado no es válido.');
                                delay(2000);
                            end;
                        until (otro in ['S', 's', 'N', 'n']);
                    end;
                until ((estacion in ['1', '2', '3', '4', '5']) and (otro in ['N', 'n']));
                clrscr;
            end;
            //////////////////////////////////////////////////////////////////////////////////////////// VER SISTEMA.
            '2': begin
                clrscr;
                ////////////////////////////VER SISTEMA.
            end;
            ////////////////////////////////////////////////////////////////////////////////////////////////// SALIR.
            '3': begin //El usuario podra salir del sistema.
                clrscr;
                writeln('Gracias por usar el sistema! Vuelva pronto.');
            end
            else begin
                writeln('El dato ingresado no es válido.');
                delay(2000);
                clrscr;
            end;
        end;
    until op='3'; //Sale del loop una vez la condicion para salir sea true.
    readkey;
end.