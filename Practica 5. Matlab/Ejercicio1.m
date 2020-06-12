
tic
%% Lectura del fichero
% Se solicita un fichero al usuario mediante la siguiente instrucción
[nombre_fichero,path_fichero] = uigetfile('*.txt','Selecciona fichero de datos crudos');
% Importamos los datos
nombreFichero_completo = fullfile(path_fichero,nombre_fichero);
datos_leidos = importdata("C:\Users\diego\Downloads\Codigo_Practica_05\Datos_Consumo.txt");

% Tratamos las fechas para unir las dos columnas
fechaHora_cell_2Cols = datos_leidos.textdata(2:end,1:2);
fechaHora_str = strcat(fechaHora_cell_2Cols(:,1), {' '}, fechaHora_cell_2Cols(:,2));
fechaHoraNum = datenum(datetime(fechaHora_str));
    
% Construimos la matriz de datos
datos(:,1)=fechaHoraNum;
datos(:,2:5)=datos_leidos.data(:,1:4);

% Sacamos los nombres de las variables
variables = datos_leidos.textdata(1,1:end-3);    

%% Procesado de los datos

% Se buscan los huecos en la matriz y se rellenan con NaN. A continuación, se buscan los elementos NaN
% y se rellenan con el valor de la fila anterior.
datosProc = datos;
numero = isnan(datos) | isempty(datos);
datosProc(numero) = datos(find(numero)-1);


% Ploteo de la potencia activa
figure(1)
plot(datosProc(:,1), datosProc(:,2))
title('Potencia activa')
ylabel('Potencia (kW)')
datetick('x', 'yyyy')
xlabel('Fecha')

% Calculo del cosphi
cosphi= atan(datos(:,3)./datos(:,2));
    
% Se a–aden a la gr‡fica cruces rojas en los puntos en los que el
% cosphi es menor de 0.8. Para ello, se crea un vector auxiliar llamado 
% cosphi08, en el que se pone el valor NaN en las posiciones donde
% cosphi>=0.8
hold on
cosphi08 = cosphi
indice = find(cosphi>=0.8)
cosphi08(indice)=NaN;
plot(cosphi08 , 'rx')

% Ploteo del histograma
figure(2)
histogram(datosProc(:,4))
title('Histograma de tensiones')
xlabel('Tension (V)')
ylabel('Numero de muestras')
    
% Maximo valor de potencia
[Potmax, Fecha] = max(datos(:,3))
fprintf('El valor maximo de potencia es %0.2f para el dia %s \n', Potmax, fechaHora_str{Fecha})

%% Reformatear la matriz para que en vez de datos por minutos que sean horarios
fechaHoraVec = datevec(datos(:,1));

[C, ia, ic] = unique(fechaHoraVec(:,1:4),'rows'); 
datos60 = zeros(max(ic),5);

% Mediante un bucle calculamos la media horaria para cada variable y lo
% guardamos en la matriz que hemos inicializado.
for i=1:size(datos60,1)
    indicesHora = find(ic==i);
    datos60(i,1) = datenum([fechaHoraVec(indicesHora(1),1:end-2) 0 0]);
    datos60(i,2:5) = mean(datos(indicesHora, 2:end), 1, 'omitnan');
end

% Ploteo de la nueva Potencia horaria
figure (3)
plot(datos60(:,1), datos60(:,3))
title('Nueva Potencia Horaria')
ylabel('Potencia (kW)')
datetick('x', 'yyyy')
xlabel('Fecha')

%% Importe de factura
% Tabla de precios por años: 
%   columna 1: precio por kWh durante los años y horas indicados en guión
%   columna 2: Precio total en cada año, mes y día dependiendo de la hora
%   (es decir, los precios por kWh por la potencia activa del mes, hora y
%   día correspondiente)
Precio = zeros(size(datos60, 1), 2);
Fechas = datevec(datos60(:, 1));
Precio((Fechas(:,1)==2007 | Fechas(:,1) == 2008) & Fechas(:,4)>=0 & Fechas(:,4)<8, 1) = 0.15;
Precio((Fechas(:,1)==2007 | Fechas(:,1) == 2008) & Fechas(:,4)>=8 & Fechas(:,4)<20, 1) = 0.10;
Precio((Fechas(:,1)==2007 | Fechas(:,1) == 2008) & Fechas(:,4)>=20 & Fechas(:,4)<24, 1) = 0.15;
Precio((Fechas(:,1)==2009 | Fechas(:,1) == 2010) & Fechas(:,4)>=0 & Fechas(:,4)<8, 1) = 0.12;
Precio((Fechas(:,1)==2009 | Fechas(:,1) == 2010) & Fechas(:,4)>=8 & Fechas(:,4)<20, 1) = 0.09;
Precio((Fechas(:,1)==2009 | Fechas(:,1) == 2010) & Fechas(:,4)>=20 & Fechas(:,4)<24, 1) = 0.17;

% Aplicamos el precio a los valores de potencia para obtener el importe

Precios_mes = zeros(12, 4); % Matriz vacia donde almacenar los valores de importe por mes
Precio(:,2)=Precio(:,1).*datos60(:,2); %Sacamos los importes horarios
Precio(isnan(Precio)) = 0; % Si no hay valor guardamos un cero

% Calculamos el importe por meses 
for i=unique(Fechas(:,1))'
    for j=unique(Fechas(:,2))'
        Precios_mes(j, i-2006) = sum(Precio(Fechas(:,1) == i & Fechas(:,2) == j,2));
    end
end

% Ploteamos los datos
figure(5)
bar(Precios_mes);
title('Facturas')
ylabel('Coste (€)')
xlabel('Fecha')
legend('2007','2008','2009','2010')

%% Guardado de la matriz
% Creamos un cell con los datos
Matriz = {};
Matriz(1,:)={'','2007','2008','2009','2010'};
Matriz = [Matriz; cellstr(datestr([ones(12,1)*2012 [1:12]' ones(12,1) ones(12,1) ones(12,1) ones(12,1)], 'mmm')), num2cell(Precios_mes)];

% Formateamos la matriz y escribimos el fichero.
fid = fopen('Facturas.txt', 'w+');
fprintf(fid, '   %s',  Matriz{1,:});
fprintf(fid, '\n');
for i=2:length(Matriz)
    fprintf(fid, '%s',  Matriz{i,1});
    fprintf(fid, '\t%6.2f',  Matriz{i, 2:end});
    fprintf(fid, '\n');
end
fclose(fid);
xlswrite('Prueba.xls', Matriz)

toc