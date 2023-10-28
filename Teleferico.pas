program teleferico;
{$codepage UTF8} //Permite usar acentos y ñ en consola.
uses crt, sysutils;
var
validNumDoc, validNombre, validApellido, TAB, TBC, TCD, TDE: boolean;
op, estacion, tramo, tBoleto, otro, systemOp: char;
nombre, apellido, tDoc, numDoc, nBoletosStr, edad: string;
i, edadInt, precioBoleto, FprecioTotalCompra, ventaTotal, nBoletos, error, nBGeneralVendidos, nBTEdadNVendidos, nBExoneradosVendidos, aDisponiblesAB, aDisponiblesBC, aDisponiblesCD, aDisponiblesDE, FnBGeneralAB, FnBTEdadNAB, FnBExoneradosAB, FnBGeneralBC, FnBTEdadNBC, FnBExoneradosBC, FnBGeneralCD, FnBTEdadNCD, FnBExoneradosCD, FnBGeneralDE, FnBTEdadNDE, FnBExoneradosDE, generalAB, tEdadNAB, exoneradoAB, generalBC, tEdadNBC, exoneradoBC, generalCD, tEdadNCD, exoneradoCD, generalDE, tEdadNDE, exoneradoDE, nBTotalVendidos, VentaGeneralAB, VentaTEdadNAB, VentaExoneradoAB, VentaGeneralBC, VentaTEdadNBC, VentaExoneradoBC, VentaGeneralCD, VentaTEdadNCD, VentaExoneradoCD, VentaGeneralDE, VentaTEdadNDE, VentaExoneradoDE, VentaGeneralTotal, VentaTEdadNTotal, VentaExoneradoTotal: integer;
const
precioGeneral: integer = 20;
precioTEdadN: integer = 12;
precioExonerado: integer = 0;

begin
    clrscr;
    writeln('Bienvenido al sistema de teleférico de Mérida!');
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
    //La cantidad total de boletos vendidos inicia siendo cero.
    nBTotalVendidos:=0;
    //Los asientos disponibles en cada tramo empiezan siendo 60;
    aDisponiblesAB:=60;
    aDisponiblesBC:=60;
    aDisponiblesCD:=60;
    aDisponiblesDE:=60;
    //Los montos totales de las ventas de tipo de boleto POR TRAMO inicia siendo cero.
    VentaGeneralAB:=0;
    VentaTEdadNAB:=0;
    VentaExoneradoAB:=0;
    VentaGeneralBC:=0;
    VentaTEdadNBC:=0;
    VentaExoneradoBC:=0;
    VentaGeneralCD:=0;
    VentaTEdadNCD:=0;
    VentaExoneradoCD:=0;
    VentaGeneralDE:=0;
    VentaTEdadNDE:=0;
    VentaExoneradoDE:=0;
    //El monto de las ventas de tipos de boletos totales inicia siendo cero.
    VentaGeneralTotal:=0;
    VentaTEdadNTotal:=0;
    VentaExoneradoTotal:=0;
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
                repeat //Solicita nombre del comprador.
                    clrscr;
                    write('Por favor, ingrese su primer nombre: ');
                    readln(nombre);
                    validNombre:=true;
                    if ((nombre='') or (not(nombre[1] in ['A'..'Z']))) then //Si la entrada es vacia o la primera letra no es mayuscula, no lo acepta.
                    begin
                        validNombre:=false;
                        writeln('El dato ingresado no es válido.');
                        delay(2000);
                    end
                    else begin
                        for i:=2 to length(nombre) do
                        begin
                            if not (nombre[i] in ['a'..'z']) then //Si la entrada tiene numeros, caracteres especiales o una mayuscula en el medio, no lo acepta.
                            begin
                                validNombre:=false;
                                writeln('El dato ingresado no es válido.');
                                delay(2000);
                                break; //Si consigue uno, no hace falta revisar el resto.
                            end;
                        end;
                    end;
                until validNombre;
                repeat //Solicita apellido del comprador.
                    clrscr;
                    write('Por favor, ingrese su primer apellido: ');
                    readln(apellido);
                    validApellido:=true;
                    if ((apellido='') or (not(apellido[1] in ['A'..'Z']))) then //Si la entrada es vacia o la primera letra no es mayuscula, no lo acepta.
                    begin
                        validApellido:=false;
                        writeln('El dato ingresado no es válido.');
                        delay(2000);
                    end
                    else begin
                        for i:=2 to length(apellido) do
                        begin
                            if not (apellido[i] in ['a'..'z']) then //Si la entrada tiene numeros, caracteres especiales o una mayuscula en el medio, no lo acepta.
                            begin
                                validApellido:=false;
                                writeln('El dato ingresado no es válido.');
                                delay(2000);
                                break; //Si consigue uno, no hace falta revisar el resto.
                            end;
                        end;
                    end;
                until validApellido;
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
                    if (numDoc[1]='0') or (numDoc='') then //Si la entrada es vacia, empieza por, o es cero, no sera aceptada.
                    begin
                        validNumDoc:=false;
                        writeln('El dato ingresado no es válido.');
                        delay(2000);
                    end
                    else begin
                        for i:=1 to length(numDoc) do
                        begin
                            if not(numDoc[i] in ['0'..'9']) then //Si la entrada contiene algo que no es un numero, sera rechazada.
                            begin
                                validNumDoc:=false;
                                writeln('El dato ingresado no es válido.');
                                delay(2000);
                                break; //Si consigue un valor invalido, no es necesario chequear el resto.
                            end;
                        end;
                    end;
                until validNumDoc; //Sale del loop cuando se ingrese un numero sin letras ni caracteres especiales y que no empiece por o sea cero o menor.
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
                            writeln('Presione cualquier tecla para continuar...');
                            readkey;
                            if (aDisponiblesAB>0) then
                            begin
                                repeat
                                    clrscr;
                                    write('¿Cuántos boletos desea comprar? (Quedan ',aDisponiblesAB,' disponibles): ');
                                    readln(nBoletosStr);
                                    val(nBoletosStr, nBoletos, error); //Para validar si es un dato valido.
                                    if ((error<>0) or (nBoletos<=0) or (aDisponiblesAB<nBoletos)) then //Si la entrada es int menor o igual a cero o si no hay asientos suficientes, no lo acepta.
                                    begin
                                        writeln('El dato ingresado no es válido.');
                                        delay(2000);
                                    end;
                                until ((error=0) and (nBoletos>0) and (aDisponiblesAB>nBoletos));
                                for i:=1 to nBoletos do
                                begin
                                    repeat
                                        clrscr;
                                        writeln('Datos necesarios para la compra del boleto ', i, ':'); //Para determinar el tipo de boleto que se comprara
                                        writeln('¿La persona que usará este boleto es un niño/a o persona de la tercera edad?:');
                                        writeln('1. Niño/a.');
                                        writeln('2. Persona de la tercera edad.');
                                        writeln('3. Ninguno de los dos.');
                                        tBoleto:=readkey;
                                        case (tBoleto) of
                                            '1': begin //Niño/a (Puede ser general o 3ra edad dependiendo de la edad ingresada.)
                                                repeat
                                                    clrscr;
                                                    write('Por favor, ingrese la edad del niño/a: ');
                                                    readln(edad);
                                                    val(edad, edadInt, error);
                                                    if ((error<>0) or (edad[1]='0') or (edadInt<=0)) then //Si el dato ingresado no es int, empieza o es cero, o es negativo, no lo acepta.
                                                    begin
                                                        writeln('El dato ingresado no es válido.');
                                                        delay(2000);
                                                    end;
                                                until ((error=0) and (edad[1]<>'0') and (edadInt>0));
                                                if (edadInt<3) then //Exonerado.
                                                begin
                                                    precioBoleto:=precioExonerado;
                                                    exoneradoAB+=1; //Contador general.
                                                    FnBExoneradosAB+=1; //Contador para factura.
                                                    writeln('Tipo de boleto adquirido: Exonerado.');
                                                    writeln('Precio: ', precioExonerado, '$.');
                                                end
                                                else begin
                                                    if ((edadInt<=12) or (edadInt>60)) then //Niño/a o Tercera edad.
                                                    begin
                                                        precioBoleto:=precioTEdadN;
                                                        tEdadNAB+=1; //Contador general.
                                                        FnBTEdadNAB+=1; //Contador para factura.
                                                        writeln('Tipo de boleto adquirido: Niños o tercera edad.');
                                                        writeln('Precio: ', precioTEdadN, '$.');
                                                    end
                                                    else begin //General.
                                                        precioBoleto:=precioGeneral;
                                                        generalAB+=1; //Contador general.
                                                        FnBGeneralAB+=1; //Contador para factura.
                                                        writeln('Tipo de boleto adquirido: General.');
                                                        writeln('Precio: ', precioGeneral, '$.');
                                                    end;
                                                end;
                                            end;
                                            '2': begin //Tercera edad.
                                                clrscr;
                                                precioBoleto:=precioTEdadN;
                                                tEdadNAB+=1; //Contador general.
                                                FnBTEdadNAB+=1; //Contador para factura.
                                                writeln('Tipo de boleto adquirido: Niños o tercera edad.');
                                                writeln('Precio: ', precioTEdadN, '$.');
                                            end;
                                            '3': begin //General.
                                                clrscr;
                                                precioBoleto:=precioGeneral;
                                                generalAB+=1; //Contador general.
                                                FnBGeneralAB+=1; //Contador para factura.
                                                writeln('Tipo de boleto adquirido: General.');
                                                writeln('Precio: ', precioGeneral, '$.');
                                            end
                                            else begin
                                                writeln('El dato ingresado no es válido.');
                                                delay(2000);
                                            end;
                                        end;
                                    until (tBoleto in ['1', '2', '3']);
                                    FprecioTotalCompra+= precioBoleto;
                                    delay(1000);
                                    writeln('¡Boleto confirmado!');
                                    writeln('Presione cualquier tecla para continuar...');
                                    readkey;
                                end;
                                aDisponiblesAB-=nBoletos;
                                if (not (TAB)) then
                                begin
                                    TAB:=true;
                                end;
                            end
                            else begin
                                writeln('Este tramo no tiene asientos disponibles.');
                                delay(2000);
                                clrscr;
                            end;
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
                                                    writeln('Datos necesarios para la compra del boleto ', i, ':'); //Para determinar el tipo de boleto que se comprara
                                                    writeln('¿La persona que usará este boleto es un niño/a o persona de la tercera edad?:');
                                                    writeln('1. Niño/a.');
                                                    writeln('2. Persona de la tercera edad.');
                                                    writeln('3. Ninguno de los dos.');
                                                    tBoleto:=readkey;
                                                    case (tBoleto) of
                                                        '1': begin //Niño/a (Puede ser general o 3ra edad dependiendo de la edad ingresada.)
                                                            repeat
                                                                clrscr;
                                                                write('Por favor, ingrese la edad del niño/a: ');
                                                                readln(edad);
                                                                val(edad, edadInt, error);
                                                                if ((error<>0) or (edad[1]='0') or (edadInt<=0)) then //Si el dato ingresado no es int, empieza o es cero, o es negativo, no lo acepta.
                                                                begin
                                                                    writeln('El dato ingresado no es válido.');
                                                                    delay(2000);
                                                                end;
                                                            until ((error=0) and (edad[1]<>'0') and (edadInt>0));
                                                            if (edadInt<3) then //Exonerado
                                                            begin
                                                                precioBoleto:=precioExonerado;
                                                                exoneradoAB+=1; //Contador general.
                                                                FnBExoneradosAB+=1; //Contador para factura.
                                                                writeln('Tipo de boleto adquirido: Exonerado.');
                                                                writeln('Precio: ', precioExonerado, '$.');
                                                            end
                                                            else begin
                                                                if ((edadInt<=12) or (edadInt>60)) then //Niño/a o tercera edad.
                                                                begin
                                                                    precioBoleto:=precioTEdadN;
                                                                    tEdadNAB+=1; //Contador general.
                                                                    FnBTEdadNAB+=1; //Contador para factura.
                                                                    writeln('Tipo de boleto adquirido: Niños o tercera edad.');
                                                                    writeln('Precio: ', precioTEdadN, '$.');
                                                                end
                                                                else begin //General.
                                                                    precioBoleto:=precioGeneral;
                                                                    generalAB+=1; //Contador general.
                                                                    FnBGeneralAB+=1; //Contador para factura.
                                                                    writeln('Tipo de boleto adquirido: General.');
                                                                    writeln('Precio: ', precioGeneral, '$.');
                                                                end;
                                                            end;
                                                        end;
                                                        '2': begin //Tercera edad.
                                                            clrscr;
                                                            precioBoleto:=precioTEdadN;
                                                            tEdadNAB+=1; //Contador general.
                                                            FnBTEdadNAB+=1; //Contador para factura.
                                                            writeln('Tipo de boleto adquirido: Niños o tercera edad.');
                                                            writeln('Precio: ', precioTEdadN, '$.');
                                                        end;
                                                        '3': begin //General.
                                                            clrscr;
                                                            precioBoleto:=precioGeneral;
                                                            generalAB+=1; //Contador general.
                                                            FnBGeneralAB+=1; //Contador para factura.
                                                            writeln('Tipo de boleto adquirido: General.');
                                                            writeln('Precio: ', precioGeneral, '$.');
                                                        end
                                                        else begin
                                                            writeln('El dato ingresado no es válido.');
                                                            delay(2000);
                                                        end;
                                                    end;
                                                until (tBoleto in ['1', '2', '3']);
                                                FprecioTotalCompra+= precioBoleto;
                                                delay(1000);
                                                writeln('¡Boleto confirmado!');
                                                writeln('Presione cualquier tecla para continuar...');
                                                readkey;
                                            end;
                                            aDisponiblesAB-=nBoletos;
                                            if (not (TAB)) then
                                            begin
                                                TAB:=true;
                                            end;
                                        end
                                        else begin
                                            writeln('Este tramo no tiene asientos disponibles.');
                                            delay(2000);
                                            clrscr;
                                        end;
                                    end;
                                    '2': begin //Tramo BC.
                                        if (aDisponiblesBC>0) then
                                        begin
                                            repeat
                                                clrscr;
                                                write('¿Cuántos boletos desea comprar? (Quedan ',aDisponiblesBC,' disponibles): ');
                                                readln(nBoletosStr);
                                                val(nBoletosStr, nBoletos, error); //Para validar si es un dato valido.
                                                if ((error<>0) or (nBoletos<=0) or (aDisponiblesBC<nBoletos)) then
                                                begin
                                                    writeln('El dato ingresado no es válido.');
                                                    delay(2000);
                                                end;
                                            until ((error=0) and (nBoletos>0) and (aDisponiblesBC>nBoletos));
                                            for i:=1 to nBoletos do
                                            begin
                                                repeat
                                                    clrscr;
                                                    writeln('Datos necesarios para la compra del boleto ', i, ':'); //Para determinar el tipo de boleto que se comprara
                                                    writeln('¿La persona que usará este boleto es un niño/a o persona de la tercera edad?:');
                                                    writeln('1. Niño/a.');
                                                    writeln('2. Persona de la tercera edad.');
                                                    writeln('3. Ninguno de los dos.');
                                                    tBoleto:=readkey;
                                                    case (tBoleto) of
                                                        '1': begin //Niño/a (Puede ser general o 3ra edad dependiendo de la edad ingresada.)
                                                            repeat
                                                                clrscr;
                                                                write('Por favor, ingrese la edad del niño/a: ');
                                                                readln(edad);
                                                                val(edad, edadInt, error);
                                                                if ((error<>0) or (edad[1]='0') or (edadInt<=0)) then //Si el dato ingresado no es int, empieza o es cero, o es negativo, no lo acepta.
                                                                begin
                                                                    writeln('El dato ingresado no es válido.');
                                                                    delay(2000);
                                                                end;
                                                            until ((error=0) and (edad[1]<>'0') and (edadInt>0));
                                                            if (edadInt<3) then //Exonerado.
                                                            begin
                                                                precioBoleto:=precioExonerado;
                                                                exoneradoBC+=1; //Contador general.
                                                                FnBExoneradosBC+=1; //Contador para factura.
                                                                writeln('Tipo de boleto adquirido: Exonerado.');
                                                                writeln('Precio: ', precioExonerado, '$.');
                                                            end
                                                            else begin
                                                                if ((edadInt<=12) or (edadInt>60)) then //Niño/a o Tercera edad.
                                                                begin
                                                                    precioBoleto:=precioTEdadN;
                                                                    tEdadNBC+=1; //Contador general.
                                                                    FnBTEdadNBC+=1; //Contador para factura.
                                                                    writeln('Tipo de boleto adquirido: Niños o tercera edad.');
                                                                    writeln('Precio: ', precioTEdadN, '$.');
                                                                end
                                                                else begin //General.
                                                                    precioBoleto:=precioGeneral;
                                                                    generalBC+=1; //Contador general.
                                                                    FnBGeneralBC+=1; //Contador para factura.
                                                                    writeln('Tipo de boleto adquirido: General.');
                                                                    writeln('Precio: ', precioGeneral, '$.');
                                                                end;
                                                            end;
                                                        end;
                                                        '2': begin //Tercera edad.
                                                            clrscr;
                                                            precioBoleto:=precioTEdadN;
                                                            tEdadNBC+=1; //Contador general.
                                                            FnBTEdadNBC+=1; //Contador para factura.
                                                            writeln('Tipo de boleto adquirido: Niños o tercera edad.');
                                                            writeln('Precio: ', precioTEdadN, '$.');
                                                        end;
                                                        '3': begin //General.
                                                            clrscr;
                                                            precioBoleto:=precioGeneral;
                                                            generalBC+=1; //Contador general.
                                                            FnBGeneralBC+=1; //Contador para factura.
                                                            writeln('Tipo de boleto adquirido: General.');
                                                            writeln('Precio: ', precioGeneral, '$.');
                                                        end
                                                        else begin
                                                            writeln('El dato ingresado no es válido.');
                                                            delay(2000);
                                                        end;
                                                    end;
                                                until (tBoleto in ['1', '2', '3']);
                                                FprecioTotalCompra+= precioBoleto;
                                                delay(1000);
                                                writeln('¡Boleto confirmado!');
                                                writeln('Presione cualquier tecla para continuar...');
                                                readkey;
                                            end;
                                            aDisponiblesBC-=nBoletos;
                                            if (not (TBC)) then
                                            begin
                                                TBC:=true;
                                            end;
                                        end
                                        else begin
                                            writeln('Este tramo no tiene asientos disponibles.');
                                            delay(2000);
                                            clrscr;
                                        end;
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
                                    '1': begin //Tramo BC
                                        if (aDisponiblesBC>0) then
                                        begin
                                            repeat
                                                clrscr;
                                                write('¿Cuántos boletos desea comprar? (Quedan ',aDisponiblesBC,' disponibles): ');
                                                readln(nBoletosStr);
                                                val(nBoletosStr, nBoletos, error); //Para validar si es un dato valido.
                                                if ((error<>0) or (nBoletos<=0) or (aDisponiblesBC<nBoletos)) then
                                                begin
                                                    writeln('El dato ingresado no es válido.');
                                                    delay(2000);
                                                end;
                                            until ((error=0) and (nBoletos>0) and (aDisponiblesBC>nBoletos));
                                            for i:=1 to nBoletos do
                                            begin
                                                repeat
                                                    clrscr;
                                                    writeln('Datos necesarios para la compra del boleto ', i, ':'); //Para determinar el tipo de boleto que se comprara
                                                    writeln('¿La persona que usará este boleto es un niño/a o persona de la tercera edad?:');
                                                    writeln('1. Niño/a.');
                                                    writeln('2. Persona de la tercera edad.');
                                                    writeln('3. Ninguno de los dos.');
                                                    tBoleto:=readkey;
                                                    case (tBoleto) of
                                                        '1': begin //Niño/a (Puede ser general o 3ra edad dependiendo de la edad ingresada.)
                                                            repeat
                                                                clrscr;
                                                                write('Por favor, ingrese la edad del niño/a: ');
                                                                readln(edad);
                                                                val(edad, edadInt, error);
                                                                if ((error<>0) or (edad[1]='0') or (edadInt<=0)) then //Si el dato ingresado no es int, empieza o es cero, o es negativo, no lo acepta.
                                                                begin
                                                                    writeln('El dato ingresado no es válido.');
                                                                    delay(2000);
                                                                end;
                                                            until ((error=0) and (edad[1]<>'0') and (edadInt>0));
                                                            if (edadInt<3) then //Exonerado.
                                                            begin
                                                                precioBoleto:=precioExonerado;
                                                                exoneradoBC+=1; //Contador general.
                                                                FnBExoneradosBC+=1; //Contador para factura.
                                                                writeln('Tipo de boleto adquirido: Exonerado.');
                                                                writeln('Precio: ', precioExonerado, '$.');
                                                            end
                                                            else begin
                                                                if ((edadInt<=12) or (edadInt>60)) then //Niño/a o Tercera edad.
                                                                begin
                                                                    precioBoleto:=precioTEdadN;
                                                                    tEdadNBC+=1; //Contador general.
                                                                    FnBTEdadNBC+=1; //Contador para factura.
                                                                    writeln('Tipo de boleto adquirido: Niños o tercera edad.');
                                                                    writeln('Precio: ', precioTEdadN, '$.');
                                                                end
                                                                else begin //General.
                                                                    precioBoleto:=precioGeneral;
                                                                    generalBC+=1; //Contador general.
                                                                    FnBGeneralBC+=1; //Contador para factura.
                                                                    writeln('Tipo de boleto adquirido: General.');
                                                                    writeln('Precio: ', precioGeneral, '$.');
                                                                end;
                                                            end;
                                                        end;
                                                        '2': begin //Tercera edad.
                                                            clrscr;
                                                            precioBoleto:=precioTEdadN;
                                                            tEdadNBC+=1; //Contador general.
                                                            FnBTEdadNBC+=1; //Contador para factura.
                                                            writeln('Tipo de boleto adquirido: Niños o tercera edad.');
                                                            writeln('Precio: ', precioTEdadN, '$.');
                                                        end;
                                                        '3': begin //General.
                                                            clrscr;
                                                            precioBoleto:=precioGeneral;
                                                            generalBC+=1; //Contador general.
                                                            FnBGeneralBC+=1; //Contador para factura.
                                                            writeln('Tipo de boleto adquirido: General.');
                                                            writeln('Precio: ', precioGeneral, '$.');
                                                        end
                                                        else begin
                                                            writeln('El dato ingresado no es válido.');
                                                            delay(2000);
                                                        end;
                                                    end;
                                                until (tBoleto in ['1', '2', '3']);
                                                FprecioTotalCompra+= precioBoleto;
                                                delay(1000);
                                                writeln('¡Boleto confirmado!');
                                                writeln('Presione cualquier tecla para continuar...');
                                                readkey;
                                            end;
                                            aDisponiblesBC-=nBoletos;
                                            if (not (TBC)) then
                                            begin
                                                TBC:=true;
                                            end;
                                        end
                                        else begin
                                            writeln('Este tramo no tiene asientos disponibles.');
                                            delay(2000);
                                            clrscr;
                                        end;
                                    end;
                                    '2': begin //Tramo CD.
                                        if (aDisponiblesCD>0) then
                                        begin
                                            repeat
                                                clrscr;
                                                write('¿Cuántos boletos desea comprar? (Quedan ',aDisponiblesCD,' disponibles): ');
                                                readln(nBoletosStr);
                                                val(nBoletosStr, nBoletos, error); //Para validar si es un dato valido.
                                                if ((error<>0) or (nBoletos<=0) or (aDisponiblesCD<nBoletos)) then
                                                begin
                                                    writeln('El dato ingresado no es válido.');
                                                    delay(2000);
                                                end;
                                            until ((error=0) and (nBoletos>0) and (aDisponiblesCD>nBoletos));
                                            for i:=1 to nBoletos do
                                            begin
                                                repeat
                                                    clrscr;
                                                    writeln('Datos necesarios para la compra del boleto ', i, ':'); //Para determinar el tipo de boleto que se comprara
                                                    writeln('¿La persona que usará este boleto es un niño/a o persona de la tercera edad?:');
                                                    writeln('1. Niño/a.');
                                                    writeln('2. Persona de la tercera edad.');
                                                    writeln('3. Ninguno de los dos.');
                                                    tBoleto:=readkey;
                                                    case (tBoleto) of
                                                        '1': begin //Niño/a (Puede ser general o 3ra edad dependiendo de la edad ingresada.)
                                                            repeat
                                                                clrscr;
                                                                write('Por favor, ingrese la edad del niño/a: ');
                                                                readln(edad);
                                                                val(edad, edadInt, error);
                                                                if ((error<>0) or (edad[1]='0') or (edadInt<=0)) then //Si el dato ingresado no es int, empieza o es cero, o es negativo, no lo acepta.
                                                                begin
                                                                    writeln('El dato ingresado no es válido.');
                                                                    delay(2000);
                                                                end;
                                                            until ((error=0) and (edad[1]<>'0') and (edadInt>0));
                                                            if (edadInt<3) then //Exonerado.
                                                            begin
                                                                precioBoleto:=precioExonerado;
                                                                exoneradoCD+=1; //Contador general.
                                                                FnBExoneradosCD+=1; //Contador para factura.
                                                                writeln('Tipo de boleto adquirido: Exonerado.');
                                                                writeln('Precio: ', precioExonerado, '$.');
                                                            end
                                                            else begin
                                                                if ((edadInt<=12) or (edadInt>60)) then //Niño/a o Tercera edad.
                                                                begin
                                                                    precioBoleto:=precioTEdadN;
                                                                    tEdadNCD+=1; //Contador general.
                                                                    FnBTEdadNCD+=1; //Contador para factura.
                                                                    writeln('Tipo de boleto adquirido: Niños o tercera edad.');
                                                                    writeln('Precio: ', precioTEdadN, '$.');
                                                                end
                                                                else begin //General
                                                                    precioBoleto:=precioGeneral;
                                                                    generalCD+=1; //Contador general.
                                                                    FnBGeneralCD+=1; //Contador para factura.
                                                                    writeln('Tipo de boleto adquirido: General.');
                                                                    writeln('Precio: ', precioGeneral, '$.');
                                                                end;
                                                            end;
                                                        end;
                                                        '2': begin //Tercera edad.
                                                            clrscr;
                                                            precioBoleto:=precioTEdadN;
                                                            tEdadNCD+=1; //Contador general.
                                                            FnBTEdadNCD+=1; //Contador para factura.
                                                            writeln('Tipo de boleto adquirido: Niños o tercera edad.');
                                                            writeln('Precio: ', precioTEdadN, '$.');
                                                        end;
                                                        '3': begin //General.
                                                            clrscr;
                                                            precioBoleto:=precioGeneral;
                                                            generalCD+=1; //Contador general.
                                                            FnBGeneralCD+=1; //Contador para factura.
                                                            writeln('Tipo de boleto adquirido: General.');
                                                            writeln('Precio: ', precioGeneral, '$.');
                                                        end
                                                        else begin
                                                            writeln('El dato ingresado no es válido.');
                                                            delay(2000);
                                                        end;
                                                    end;
                                                until (tBoleto in ['1', '2', '3']);
                                                FprecioTotalCompra+= precioBoleto;
                                                delay(1000);
                                                writeln('¡Boleto confirmado!');
                                                writeln('Presione cualquier tecla para continuar...');
                                                readkey;
                                            end;
                                            aDisponiblesCD-=nBoletos;
                                            if (not (TCD)) then
                                            begin
                                                TCD:=true;
                                            end;
                                        end
                                        else begin
                                            writeln('Este tramo no tiene asientos disponibles.');
                                            delay(2000);
                                            clrscr;
                                        end;
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
                                    '1': begin //Tramo CD
                                        if (aDisponiblesCD>0) then
                                        begin
                                            repeat
                                                clrscr;
                                                write('¿Cuántos boletos desea comprar? (Quedan ',aDisponiblesCD,' disponibles): ');
                                                readln(nBoletosStr);
                                                val(nBoletosStr, nBoletos, error); //Para validar si es un dato valido.
                                                if ((error<>0) or (nBoletos<=0) or (aDisponiblesCD<nBoletos)) then
                                                begin
                                                    writeln('El dato ingresado no es válido.');
                                                    delay(2000);
                                                end;
                                            until ((error=0) and (nBoletos>0) and (aDisponiblesCD>nBoletos));
                                            for i:=1 to nBoletos do
                                            begin
                                                repeat
                                                    clrscr;
                                                    writeln('Datos necesarios para la compra del boleto ', i, ':'); //Para determinar el tipo de boleto que se comprara
                                                    writeln('¿La persona que usará este boleto es un niño/a o persona de la tercera edad?:');
                                                    writeln('1. Niño/a.');
                                                    writeln('2. Persona de la tercera edad.');
                                                    writeln('3. Ninguno de los dos.');
                                                    tBoleto:=readkey;
                                                    case (tBoleto) of
                                                        '1': begin 
                                                            repeat
                                                                clrscr;
                                                                write('Por favor, ingrese la edad del niño/a: ');
                                                                readln(edad);
                                                                val(edad, edadInt, error);
                                                                if ((error<>0) or (edad[1]='0') or (edadInt<=0)) then //Si el dato ingresado no es int, empieza o es cero, o es negativo, no lo acepta.
                                                                begin
                                                                    writeln('El dato ingresado no es válido.');
                                                                    delay(2000);
                                                                end;
                                                            until ((error=0) and (edad[1]<>'0') and (edadInt>0));
                                                            if (edadInt<3) then //Exonerado.
                                                            begin
                                                                precioBoleto:=precioExonerado;
                                                                exoneradoCD+=1; //Contador general.
                                                                FnBExoneradosCD+=1; //Contador para factura.
                                                                writeln('Tipo de boleto adquirido: Exonerado.');
                                                                writeln('Precio: ', precioExonerado, '$.');
                                                            end
                                                            else begin
                                                                if ((edadInt<=12) or (edadInt>60)) then //Niño/a o Tercera edad.
                                                                begin
                                                                    precioBoleto:=precioTEdadN;
                                                                    tEdadNCD+=1; //Contador general.
                                                                    FnBTEdadNCD+=1; //Contador para factura.
                                                                    writeln('Tipo de boleto adquirido: Niños o tercera edad.');
                                                                    writeln('Precio: ', precioTEdadN, '$.');
                                                                end
                                                                else begin //General.
                                                                    precioBoleto:=precioGeneral;
                                                                    generalCD+=1; //Contador general.
                                                                    FnBGeneralCD+=1; //Contador para factura.
                                                                    writeln('Tipo de boleto adquirido: General.');
                                                                    writeln('Precio: ', precioGeneral, '$.');
                                                                end;
                                                            end;
                                                        end;
                                                        '2': begin //Tercera edad.
                                                            clrscr;
                                                            precioBoleto:=precioTEdadN;
                                                            tEdadNCD+=1; //Contador general.
                                                            FnBTEdadNCD+=1; //Contador para factura.
                                                            writeln('Tipo de boleto adquirido: Niños o tercera edad.');
                                                            writeln('Precio: ', precioTEdadN, '$.');
                                                        end;
                                                        '3': begin //General.
                                                            clrscr;
                                                            precioBoleto:=precioGeneral;
                                                            generalCD+=1; //Contador general.
                                                            FnBGeneralCD+=1; //Contador para factura.
                                                            writeln('Tipo de boleto adquirido: General.');
                                                            writeln('Precio: ', precioGeneral, '$.');
                                                        end
                                                        else begin
                                                            writeln('El dato ingresado no es válido.');
                                                            delay(2000);
                                                        end;
                                                    end;
                                                until (tBoleto in ['1', '2', '3']);
                                                FprecioTotalCompra+= precioBoleto;
                                                delay(1000);
                                                writeln('¡Boleto confirmado!');
                                                writeln('Presione cualquier tecla para continuar...');
                                                readkey;
                                            end;
                                            aDisponiblesCD-=nBoletos;
                                            if (not (TCD)) then
                                            begin
                                                TCD:=true;
                                            end;
                                        end
                                        else begin
                                            writeln('Este tramo no tiene asientos disponibles.');
                                            delay(2000);
                                            clrscr;
                                        end;
                                    end;
                                    '2': begin //Tramo DE
                                        if (aDisponiblesDE>0) then
                                        begin
                                            repeat
                                                clrscr;
                                                write('¿Cuántos boletos desea comprar? (Quedan ',aDisponiblesDE,' disponibles): ');
                                                readln(nBoletosStr);
                                                val(nBoletosStr, nBoletos, error); //Para validar si es un dato valido.
                                                if ((error<>0) or (nBoletos<=0) or (aDisponiblesDE<nBoletos)) then
                                                begin
                                                    writeln('El dato ingresado no es válido.');
                                                    delay(2000);
                                                end;
                                            until ((error=0) and (nBoletos>0) and (aDisponiblesDE>nBoletos));
                                            for i:=1 to nBoletos do
                                            begin
                                                repeat
                                                    clrscr;
                                                    writeln('Datos necesarios para la compra del boleto ', i, ':'); //Para determinar el tipo de boleto que se comprara
                                                    writeln('¿La persona que usará este boleto es un niño/a o persona de la tercera edad?:');
                                                    writeln('1. Niño/a.');
                                                    writeln('2. Persona de la tercera edad.');
                                                    writeln('3. Ninguno de los dos.');
                                                    tBoleto:=readkey;
                                                    case (tBoleto) of
                                                        '1': begin //Niño/a (Puede ser general o 3ra edad dependiendo de la edad ingresada.)
                                                            repeat
                                                                clrscr;
                                                                write('Por favor, ingrese la edad del niño/a: ');
                                                                readln(edad);
                                                                val(edad, edadInt, error);
                                                                if ((error<>0) or (edad[1]='0') or (edadInt<=0)) then //Si el dato ingresado no es int, empieza o es cero, o es negativo, no lo acepta.
                                                                begin
                                                                    writeln('El dato ingresado no es válido.');
                                                                    delay(2000);
                                                                end;
                                                            until ((error=0) and (edad[1]<>'0') and (edadInt>0));
                                                            if (edadInt<3) then //Exonerado.
                                                            begin
                                                                precioBoleto:=precioExonerado;
                                                                exoneradoDE+=1; //Contador general.
                                                                FnBExoneradosDE+=1; //Contador para factura.
                                                                writeln('Tipo de boleto adquirido: Exonerado.');
                                                                writeln('Precio: ', precioExonerado, '$.');
                                                            end
                                                            else begin
                                                                if ((edadInt<=12) or (edadInt>60)) then //Niño/a o Tercera edad.
                                                                begin
                                                                    precioBoleto:=precioTEdadN;
                                                                    tEdadNDE+=1; //Contador general.
                                                                    FnBTEdadNDE+=1; //Contador para factura.
                                                                    writeln('Tipo de boleto adquirido: Niños o tercera edad.');
                                                                    writeln('Precio: ', precioTEdadN, '$.');
                                                                end
                                                                else begin //General.
                                                                    precioBoleto:=precioGeneral;
                                                                    generalDE+=1; //Contador general.
                                                                    FnBGeneralDE+=1; //Contador para factura.
                                                                    writeln('Tipo de boleto adquirido: General.');
                                                                    writeln('Precio: ', precioGeneral, '$.');
                                                                end;
                                                            end;
                                                        end;
                                                        '2': begin //Tercera edad.
                                                            clrscr;
                                                            precioBoleto:=precioTEdadN;
                                                            tEdadNDE+=1; //Contador general.
                                                            FnBTEdadNDE+=1; //Contador para factura.
                                                            writeln('Tipo de boleto adquirido: Niños o tercera edad.');
                                                            writeln('Precio: ', precioTEdadN, '$.');
                                                        end;
                                                        '3': begin //General.
                                                            clrscr;
                                                            precioBoleto:=precioGeneral;
                                                            generalDE+=1; //Contador general.
                                                            FnBGeneralDE+=1; //Contador para factura.
                                                            writeln('Tipo de boleto adquirido: General.');
                                                            writeln('Precio: ', precioGeneral, '$.');
                                                        end
                                                        else begin
                                                            writeln('El dato ingresado no es válido.');
                                                            delay(2000);
                                                        end;
                                                    end;
                                                until (tBoleto in ['1', '2', '3']);
                                                FprecioTotalCompra+= precioBoleto;
                                                delay(1000);
                                                writeln('¡Boleto confirmado!');
                                                writeln('Presione cualquier tecla para continuar...');
                                                readkey;
                                            end;
                                            aDisponiblesDE-=nBoletos;
                                            if (not (TDE)) then
                                            begin
                                                TDE:=true;
                                            end;
                                        end
                                        else begin
                                            writeln('Este tramo no tiene asientos disponibles.');
                                            delay(2000);
                                            clrscr;
                                        end;
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
                            writeln('Presione cualquier tecla para continuar...');
                            readkey;
                            if (aDisponiblesDE>0) then //Tramo DE
                            begin
                                repeat
                                    clrscr;
                                    write('¿Cuántos boletos desea comprar? (Quedan ',aDisponiblesDE,' disponibles): ');
                                    readln(nBoletosStr);
                                    val(nBoletosStr, nBoletos, error); //Para validar si es un dato valido.
                                    if ((error<>0) or (nBoletos<=0) or (aDisponiblesDE<nBoletos)) then //Si la entrada es int menor o igual a cero o si no hay asientos suficientes, no lo acepta.
                                    begin
                                        writeln('El dato ingresado no es válido.');
                                        delay(2000);
                                    end;
                                until ((error=0) and (nBoletos>0) and (aDisponiblesDE>nBoletos));
                                for i:=1 to nBoletos do
                                begin
                                    repeat
                                        clrscr;
                                        writeln('Datos necesarios para la compra del boleto ', i, ':'); //Para determinar el tipo de boleto que se comprara
                                        writeln('¿La persona que usará este boleto es un niño/a o persona de la tercera edad?:');
                                        writeln('1. Niño/a.');
                                        writeln('2. Persona de la tercera edad.');
                                        writeln('3. Ninguno de los dos.');
                                        tBoleto:=readkey;
                                        case (tBoleto) of
                                            '1': begin //Niño/a (Puede ser general o 3ra edad dependiendo de la edad ingresada.)
                                                repeat
                                                    clrscr;
                                                    write('Por favor, ingrese la edad del niño/a: ');
                                                    readln(edad);
                                                    val(edad, edadInt, error);
                                                    if ((error<>0) or (edad[1]='0') or (edadInt<=0)) then //Si el dato ingresado no es int, empieza o es cero, o es negativo, no lo acepta.
                                                    begin
                                                        writeln('El dato ingresado no es válido.');
                                                        delay(2000);
                                                    end;
                                                until ((error=0) and (edad[1]<>'0') and (edadInt>0));
                                                if (edadInt<3) then //Exonerado.
                                                begin
                                                    precioBoleto:=precioExonerado;
                                                    exoneradoDE+=1; //Contador general.
                                                    FnBExoneradosDE+=1; //Contador para factura.
                                                    writeln('Tipo de boleto adquirido: Exonerado.');
                                                    writeln('Precio: ', precioExonerado, '$.');
                                                end
                                                else begin
                                                    if ((edadInt<=12) or (edadInt>60)) then //Niño/a o Tercera edad.
                                                    begin
                                                        precioBoleto:=precioTEdadN;
                                                        tEdadNDE+=1; //Contador general.
                                                        FnBTEdadNDE+=1; //Contador para factura.
                                                        writeln('Tipo de boleto adquirido: Niños o tercera edad.');
                                                        writeln('Precio: ', precioTEdadN, '$.');
                                                    end
                                                    else begin //General
                                                        precioBoleto:=precioGeneral;
                                                        generalDE+=1; //Contador general.
                                                        FnBGeneralDE+=1; //Contador para factura.
                                                        writeln('Tipo de boleto adquirido: General.');
                                                        writeln('Precio: ', precioGeneral, '$.');
                                                    end;
                                                end;
                                            end;
                                            '2': begin //Tercera edad.
                                                clrscr;
                                                precioBoleto:=precioTEdadN;
                                                tEdadNDE+=1; //Contador general.
                                                FnBTEdadNDE+=1; //Contador para factura.
                                                writeln('Tipo de boleto adquirido: Niños o tercera edad.');
                                                writeln('Precio: ', precioTEdadN, '$.');
                                            end;
                                            '3': begin //General
                                                clrscr;
                                                precioBoleto:=precioGeneral;
                                                generalDE+=1; //Contador general.
                                                FnBGeneralDE+=1; //Contador para factura.
                                                writeln('Tipo de boleto adquirido: General.');
                                                writeln('Precio: ', precioGeneral, '$.');
                                            end
                                            else begin
                                                writeln('El dato ingresado no es válido.');
                                                delay(2000);
                                            end;
                                        end;
                                    until (tBoleto in ['1', '2', '3']);
                                    FprecioTotalCompra+= precioBoleto;
                                    delay(1000);
                                    writeln('¡Boleto confirmado!');
                                    writeln('Presione cualquier tecla para continuar...');
                                    readkey;
                                end;
                                aDisponiblesDE-=nBoletos;
                                if (not (TDE)) then
                                begin
                                    TDE:=true;
                                end;
                            end
                            else begin
                                writeln('Este tramo no tiene asientos disponibles.');
                                delay(2000);
                                clrscr;
                            end;
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
                ////////////////////////////////////////////////////////////////////////////////////////FACTURA.
                write('Generando factura');
                for i:=1 to 3 do
                begin
                    write('.');
                    delay(1000);
                end;
                clrscr;
                writeln('                            Factura');
                writeln('                      Teleférico de Merida');
                writeln('');
                writeln('Nombre y Apellido: ', nombre, ' ', apellido);
                writeln('Documento: ', tDoc, '-', numDoc);
                writeln('');
                if TAB then
                begin
                    writeln('Tramo Barinitas - La Montaña.');
                    if (FnBGeneralAB>0) then
                    begin
                        writeln('Boletos Generales: ', FnBGeneralAB, ' x', precioGeneral, '$.                           ', FnBGeneralAB*precioGeneral, '$.');
                    end;
                    if (FnBTEdadNAB>0) then
                    begin
                        writeln('Boletos Tercera Edad o Niños: ', FnBTEdadNAB, ' x', precioTEdadN, '$.                ', FnBTEdadNAB*precioTEdadN, '$.');
                    end;
                    if (FnBExoneradosAB>0) then
                    begin
                        writeln('Boletos Exonerados: ', FnBExoneradosAB, ' x', precioExonerado, '$.                           ', FnBExoneradosAB*precioExonerado, '$.');
                    end;
                    writeln('');
                end;
                if TBC then
                begin
                    writeln('Tramo La Montaña - La Aguada.');
                    if (FnBGeneralBC>0) then
                    begin
                        writeln('Boletos Generales: ', FnBGeneralBC, ' x', precioGeneral, '$.                           ', FnBGeneralBC*precioGeneral, '$.');
                    end;
                    if (FnBTEdadNBC>0) then
                    begin
                        writeln('Boletos Tercera Edad o Niños: ', FnBTEdadNBC, ' x', precioTEdadN, '$.                ', FnBTEdadNBC*precioTEdadN, '$.');
                    end;
                    if (FnBExoneradosBC>0) then
                    begin
                        writeln('Boletos Exonerados: ', FnBExoneradosBC, ' x', precioExonerado, '$.                           ', FnBExoneradosBC*precioExonerado, '$.');
                    end;
                    writeln('');
                end;
                if TCD then
                begin
                    writeln('Tramo La Aguada - Loma Redonda.');
                    if (FnBGeneralCD>0) then
                    begin
                        writeln('Boletos Generales: ', FnBGeneralCD, ' x', precioGeneral, '$.                           ', FnBGeneralCD*precioGeneral, '$.');
                    end;
                    if (FnBTEdadNCD>0) then
                    begin
                        writeln('Boletos Tercera Edad o Niños: ', FnBTEdadNCD, ' x', precioTEdadN, '$.                ', FnBTEdadNCD*precioTEdadN, '$.');
                    end;
                    if (FnBExoneradosCD>0) then
                    begin
                        writeln('Boletos Exonerados: ', FnBExoneradosCD, ' x', precioExonerado, '$.                           ', FnBExoneradosCD*precioExonerado, '$.');
                    end;
                    writeln('');
                end;
                if TDE then
                begin
                    writeln('Tramo Loma Redonda - Pico Espejo.');
                    if (FnBGeneralDE>0) then
                    begin
                        writeln('Boletos Generales: ', FnBGeneralDE, ' x', precioGeneral, '$.                           ', FnBGeneralDE*precioGeneral, '$.');
                    end;
                    if (FnBTEdadNDE>0) then
                    begin
                        writeln('Boletos Tercera Edad o Niños: ', FnBTEdadNDE, ' x', precioTEdadN, '$.                ', FnBTEdadNDE*precioTEdadN, '$.');
                    end;
                    if (FnBExoneradosDE>0) then
                    begin
                        writeln('Boletos Exonerados: ', FnBExoneradosDE, ' x', precioExonerado, '$.                           ', FnBExoneradosDE*precioExonerado, '$.');
                    end;
                    writeln('');
                end;
                writeln('                                                 TOTAL: ', FprecioTotalCompra, '$.');
                writeln('');
                writeln('Presione cualquier tecla para continuar...');
                readkey;
                clrscr;
            end;
            //////////////////////////////////////////////////////////////////////////////////////////// VER SISTEMA.
            '2': begin
                repeat
                    clrscr;
                    writeln('Por favor, indique la opción que desea realizar.');
                    writeln('1. Ver cantidad de boletos vendidos.');
                    writeln('2. Ver número de asientos disponibles.');
                    writeln('3. Generar reporte de ventas.');
                    systemOp:=readkey;
                    case (systemOp) of
                        '1': begin
                            clrscr;
                            nBGeneralVendidos:= generalAB + generalBC + generalCD + generalDE;
                            nBTEdadNVendidos:= tEdadNAB + tEdadNBC + tEdadNCD + tEdadNDE;
                            nBExoneradosVendidos:= exoneradoAB + exoneradoBC + exoneradoCD + exoneradoDE;
                            writeln('Número de boletos vendidos en cada tramo: ');
                            writeln('');
                            writeln('Tramo Barinitas - La Montaña:');
                            writeln('General:                                    ', generalAB);
                            writeln('Tercera Edad o Niños:                       ', tEdadNAB);
                            writeln('Exonerados:                                 ', exoneradoAB);
                            writeln('');
                            writeln('Tramo La Montaña - La Aguada:');
                            writeln('General:                                    ', generalBC);
                            writeln('Tercera Edad o Niños:                       ', tEdadNBC);
                            writeln('Exonerados:                                 ', exoneradoBC);
                            writeln('');
                            writeln('Tramo La Aguada - Loma Redonda:');
                            writeln('General:                                    ', generalCD);
                            writeln('Tercera Edad o Niños:                       ', tEdadNCD);
                            writeln('Exonerados:                                 ', exoneradoCD);
                            writeln('');
                            writeln('Tramo Loma Redonda - Pico Espejo:');
                            writeln('General:                                    ', generalDE);
                            writeln('Tercera Edad o Niños:                       ', tEdadNDE);
                            writeln('Exonerados:                                 ', exoneradoDE);
                            writeln('');
                            writeln('Total Boletos Generales:                    ', nBGeneralVendidos);
                            writeln('Total Boletos Tercera Edad o Niños:         ', nBTEdadNVendidos);
                            writeln('Total Boletos Exonerados:                   ', nBExoneradosVendidos);
                            writeln('TOTAL:                                      ', nBTotalVendidos);
                            writeln('');
                            writeln('Presione cualquier tecla para continuar...');
                            readkey;
                            clrscr;
                        end;
                        '2': begin
                            clrscr;
                            writeln('Número de asientos disponibles en cada tramo: ');
                            writeln('');
                            writeln('Tramo Barinitas - La Montaña:            ', aDisponiblesAB, '/60');
                            writeln('');
                            writeln('Tramo La Montaña - La Aguada:            ', aDisponiblesBC, '/60');
                            writeln('');
                            writeln('Tramo La Aguada - Loma Redonda:          ', aDisponiblesCD, '/60');
                            writeln('');
                            writeln('Tramo Loma Redonda - Pico Espejo:        ', aDisponiblesDE, '/60');
                            writeln('');
                            writeln('Presione cualquier tecla para continuar...');
                            readkey;
                            clrscr;
                        end;
                        '3': begin
                            clrscr;
                            VentaGeneralAB:= precioGeneral*generalAB;
                            VentaTEdadNAB:= precioTEdadN*tEdadNAB;
                            VentaExoneradoAB:= precioExonerado*exoneradoAB;
                            VentaGeneralBC:= precioGeneral*generalBC;
                            VentaTEdadNBC:= precioTEdadN*tEdadNBC;
                            VentaExoneradoBC:= precioExonerado*exoneradoBC;
                            VentaGeneralCD:= precioGeneral*generalCD;
                            VentaTEdadNCD:= precioTEdadN*tEdadNCD;
                            VentaExoneradoCD:= precioExonerado*exoneradoCD;
                            VentaGeneralDE:= precioGeneral*generalDE;
                            VentaTEdadNDE:= precioTEdadN*tEdadNDE;
                            VentaExoneradoDE:= precioExonerado*exoneradoDE;
                            VentaGeneralTotal:= VentaGeneralAB + VentaGeneralBC + VentaGeneralCD + VentaGeneralDE;
                            VentaTEdadNTotal:= VentaTEdadNAB + VentaTEdadNBC + VentaTEdadNCD + VentaTEdadNDE;
                            VentaExoneradoTotal:= VentaExoneradoAB + VentaExoneradoBC + VentaExoneradoCD + VentaExoneradoDE;
                            ventaTotal:= VentaGeneralTotal + VentaTEdadNTotal + VentaExoneradoTotal;
                            writeln('Reporte de Ventas');
                            writeln('');
                            writeln('Tramo Barinitas - La Montaña:');
                            writeln('General:                             ', precioGeneral, '$x', generalAB, '                 Total: ', VentaGeneralAB, '$');
                            writeln('Tercera Edad o Niños:                ', precioTEdadN, '$x', tEdadNAB, '                 Total: ', VentaTEdadNAB, '$');
                            writeln('Exonerado:                           ', precioExonerado, '$x', exoneradoAB, '                  Total: ', VentaExoneradoAB, '$');
                            writeln('');
                            writeln('Tramo La Montaña - La Aguada:');
                            writeln('General:                             ', precioGeneral, '$x', generalBC, '                 Total: ', VentaGeneralBC, '$');
                            writeln('Tercera Edad o Niños:                ', precioTEdadN, '$x', tEdadNBC, '                 Total: ', VentaTEdadNBC, '$');
                            writeln('Exonerado:                           ', precioExonerado, '$x', exoneradoBC, '                  Total: ', VentaExoneradoBC, '$');
                            writeln('');
                            writeln('Tramo La Aguada - Loma Redonda:');
                            writeln('General:                             ', precioGeneral, '$x', generalCD, '                 Total: ', VentaGeneralCD, '$');
                            writeln('Tercera Edad o Niños:                ', precioTEdadN, '$x', tEdadNCD, '                 Total: ', VentaTEdadNCD, '$');
                            writeln('Exonerado:                           ', precioExonerado, '$x', exoneradoCD, '                  Total: ', VentaExoneradoCD, '$');
                            writeln('');
                            writeln('Tramo Loma Redonda - Pico Espejo:');
                            writeln('General:                             ', precioGeneral, '$x', generalDE, '                 Total: ', VentaGeneralDE, '$');
                            writeln('Tercera Edad o Niños:                ', precioTEdadN, '$x', tEdadNDE, '                 Total: ', VentaTEdadNDE, '$');
                            writeln('Exonerado:                           ', precioExonerado, '$x', exoneradoDE, '                  Total: ', VentaExoneradoDE, '$');
                            writeln('');
                            writeln('Total General:                       ', VentaGeneralTotal, '$');
                            writeln('Total Tercera Edad o Niños:          ', VentaTEdadNTotal, '$');
                            writeln('Total Exonerado:                     ', VentaExoneradoTotal, '$');
                            writeln('TOTAL:                               ', ventaTotal, '$');
                            writeln('');
                            writeln('Presione cualquier tecla para continuar...');
                            readkey;
                            clrscr;
                        end
                        else begin
                            writeln('El dato ingresado no es válido.');
                            delay(2000);
                        end;
                    end;
                until (systemOp in ['1', '2', '3']);
            end;
            ////////////////////////////////////////////////////////////////////////////////////////////////// SALIR.
            '3': begin //El usuario podra salir del sistema.
                clrscr;
                writeln('¡Gracias por usar el sistema! Vuelva pronto.');
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