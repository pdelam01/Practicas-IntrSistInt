%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Visualizacion de datos por medio de una pca %%
% Programacion de un script que realiza una pca sobre unos datos de entrada
% Este script realiza la lectura de un fichero de datos y realiza una pca,
% la seleccion del numero de variables se realizara o bien de forma
% automatica o se insertara por codigo.

%% Parametros
% Seleccion del numero de componentes principales.
k = 2; % k no puede ser 0

% Carga de los datos
load('datos_iris.mat');

%% Ploteo de los datos originales

% Se crea un scatter de los datos en 3D en el cual la posicion es
% indiciativa de las tres primeras propiedades de la flor, el tama?o del
% punto de la cuarta propiedad y el color de la clase.
figure()
for i=1:length(tiposIris)
    % Se aisla cada grupo de datos
    datos_in = X(Y==i, :);
    % Se a?ade al scatter cada grupo de datos
    scatter3(datos_in(:,1), datos_in(:,2), datos_in(:,3), (datos_in(:,4)*50), Y(Y==i), 'filled');
    % Se marca con un texto el tipo de planta de cada grupo
    text(mean(datos_in(:,1)), mean(datos_in(:,2)), mean(datos_in(:,3)), tiposIris(i), 'FontSize', 14);
    hold on
end

%% Programa de la PCA
% En ese apartado se programara la PCA de acuerdo al algortimo visto en
% clase.

% 1. Normalizacion de los datos. La normalizacion consistira en la
% tipificacion: restar a cada variable la media de esa variable en todos 
% los vectores de caracteristicas (en este caso: la media de toda la columa 
% correspondiente) y dividirla entre la desviacion tipica de esa variable
% en todos los vectores de caracteristicas
% ====================== YOUR CODE HERE ======================
X_noNorm = X;
desviacion = std(X_noNorm);
media = mean(X_noNorm);
X_Norm = (X_noNorm - media)./ desviacion;
% ============================================================

% 2. Calculo de la matriz de covarianza
% ====================== YOUR CODE HERE ======================
M_covarianza = cov(X_Norm);
% ============================================================

% 3. Obtencion de los autovalores y autovectoresvectores de la matriz de
% covarianza de los datos.
% ====================== YOUR CODE HERE ======================
eig = eig(M_covarianza);
% ============================================================

% 4. Ordenacion de los autovectores en funcion de sus valores singulares
% asociados de mayor a menor. 
% ====================== YOUR CODE HERE ======================
eig = sort(eig,'descend');
% ============================================================


% 5. Crear la matriz de componentes principales
% Seleccionar los k primeros autovectores (despues de ordenarlos en el
% paso 4)
% ====================== YOUR CODE HERE ======================
primeros_autovectores = zeros(1,length(eig));

for i = 1:k
 primeros_autovectores(i) = eig(i);
end
% ============================================================

% 6. Obtenemos los nuevos datos
% Es lo mismo que multiplicar la matriz de componentes principales por 
% la de los datos para obtener los valores con las nuevas corrdenadas.
% ====================== YOUR CODE HERE ======================
primeros_autovectores = diag(primeros_autovectores);
DatosPCASol = X_Norm * primeros_autovectores;
% ============================================================

%% Ploteo del resultado de la PCA cuando k = 2
% Se va a crear un subplot para cada variable, la posicion de los puntos
% se determina por medio de las coordenadas PCA, el radio del punto va
% a depender en cada caso de una de las variables originales.
if(k==2)
    figure();
    % Recorremos los subplots para plotear en cada uno una cosa
    for i=1:length(tiposIris)
        index = Y==i;
        % Ploteamos los datos como puntos
        scatter(DatosPCASol(index,1), DatosPCASol(index,2), X_noNorm(index,4)*50, Y(Y==i),'filled');
        % A?adimos el texto correspondiente a cada grupo
        text(mean(DatosPCASol(index,1)), mean(DatosPCASol(index,2)), tiposIris(i), 'FontSize', 14);
        hold on
    end    
end
