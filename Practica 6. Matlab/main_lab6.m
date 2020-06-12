%------------------------------------
% CLASIFICADOR K VECINOS MAS PROXIMOS
%------------------------------------

clear

%% PARTE 1: CARGA CONJUNTO DE DATOS Y PARTICION TRAIN-TEST

load spambase_data.mat;
% X contiene los elementos que se van a estudiar (cada fila corresponde a 
% un vector de caracteristicas)
% Y contiene la clase de cada elemento 

% Numero de elementos del dataset y de variables que tiene cada uno 
[num_patrones, num_variables] = size(X);

% Parametro que indica el porcentaje de elementos que se utilizaran en 
% el conjunto de entrenamiento
p_train = 0.7;

% En la siguiente seccion de codigo se realiza la particion de los datos en 
% entrenamiento y test. Indica lo que realiza cada linea de codigo mediante 
% comentarios.
% ============================================

%Redondea al número entero más cercano el procentaje de patrones que serán
%usados en el entrenamiento.
num_patrones_train = round(p_train*num_patrones);

%Crea un vector de los patrones (no entrenamiento)y varía la posición de 
%los elementos, de manera que no sea un conjunto ordenado. 
%ind_permuta 1 x num_patrones
ind_permuta = randperm(num_patrones);

%Crea un vector con los datos de entrenamiento desde el 1 hasta
%num_patrones_train, y un vector con los datos de test que va desde el
%último dato de entrenamiento, hasta el final del número de patrones.
inds_train = ind_permuta(1:num_patrones_train);
inds_test = ind_permuta(num_patrones_train+1:end);

%Separa en dos variables X e Y los datos y las etiquetas donde X_train son
%los datos de entrenamiento y Y_train son las etiquetas de esos datos.
X_train = X(inds_train, :);
Y_train = Y(inds_train);

%Separa en dos variables X e Y los datos y las etiquetas donde X_test son
%los datos de test y Y_test son las etiquetas de esos datos.
X_test= X(inds_test, :);
Y_test = Y(inds_test);

% ============================================

%% PARTE 2: ALGORITMO DE LOS K VECINOS MAS CERCANOS

% La funcion fClassify_kNN ejecuta el algoritmo de kNN. Abrela y completa 
% el codigo
k=3;

Y_test_asig = fClassify_kNN(X_train, Y_train, X_test, k);

%% PARTE 3: EVALUACION DEL RENDMIENTO DEL CLASIFICADOR

% Muestra matriz de confusion
plotconfusion(Y_test, Y_test_asig)

Tp=sum(Y_test == 1 & Y_test_asig ==1);
Fn=sum(Y_test == 1 & Y_test_asig ==0);
Fp=sum(Y_test == 0 & Y_test_asig ==1);
Tn=sum(Y_test == 0 & Y_test_asig ==0);

% Error--> Error global
% ====================== YOUR CODE HERE ======================
    error = (Fp + Fn)/ (Fp + Fn + Tp + Tn);
% ============================================================
fprintf('\n******\nError global = %1.4f%% (classification)\n', error*100);

% Tasa de falsa aceptaci?n
% ====================== YOUR CODE HERE ======================
    FPR = Fp / (Fp + Tn);
% ============================================================
fprintf('\n******\nTasa de falsa aceptacion = %1.4f%% (classification)\n', FPR*100);

% Tasa de falso rechazo
% ====================== YOUR CODE HERE ======================
    FNR = Fn / (Tp + Fn);
% ============================================================
fprintf('\n******\nTasa de falso rechazo = %1.4f%% (classification)\n', FNR*100);

% Precision
% ====================== YOUR CODE HERE ======================
    precision = Tp / (Tp + Fp);
% ============================================================
fprintf('\n******\nPrecision = %1.4f%% (classification)\n', precision*100);

% Recall
% ====================== YOUR CODE HERE ======================

%recall = Tp / (Tp + Fn);
recall = sum(Y_test_asig==1 & Y_test==1)/sum(Y_test==1);

% ============================================================
fprintf('\n******\nRecall = %1.4f%% (classification)\n', recall*100);

