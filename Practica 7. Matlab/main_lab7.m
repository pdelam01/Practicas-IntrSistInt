%------------------------------------
% CLASIFICADOR REGRESION LOGISTICA
% 
% Author: Victor Gonzalez Castro
% Date: April 2020
%------------------------------------

clear
close all

%% PASO INICIAL: CARGA CONJUNTO DE DATOS Y PARTICI?N TRAIN-TEST

load mammographic_data_norm.mat;
% X contiene los patrones de entrenamiento (dimension 5)
% Y contiene la clase del patron

% Numero de patrones (elementos) y de variables por cada patron en este dataset
[num_patrones, num_variables] = size(X);

% Parametro que indica el porcentaje de patrones que se utilizaran en 
% el conjunto de entrenamiento
p_train = 0.7;

% Particion de los datos en conjuntos de entrenamiento y test. 

num_patrones_train = round(p_train*num_patrones);
%num_patrones_test = num_patrones - num_patrones_train;

ind_permuta = randperm(num_patrones);

inds_train = ind_permuta(1:num_patrones_train);
inds_test = ind_permuta(num_patrones_train+1:end);

X_train = X(inds_train, :);
Y_train = Y(inds_train);

X_test= X(inds_test, :);
Y_test = Y(inds_test);

%% PASO 1: ENTRENAMIENTO DEL CLASIFICADOR Y CLASIFICACION DEL CONJUNTO DE TEST

% La funcion fClassify_LogisticReg implementa el clasificador de la regresion 
% logistica. Abrela y completa el codigo
alpha = 2;
umbral_decision = 0.5;

% ENTRENAMIENTO
theta = fEntrena_LogisticReg(X_train, Y_train, alpha);

% CLASIFICACION DEL CONJUNTO DE TEST
Y_test_hat = fClasifica_LogisticReg(X_test, theta);
Y_test_asig = Y_test_hat>=umbral_decision;

%% PASO 2: RENDIMIENTO DEL CLASIFICADOR: CALCULO DEl ACCURACY Y FSCORE

% Muestra matriz de confusion
figure;
plotconfusion(Y_test, Y_test_asig);

Tp=sum(Y_test == 1 & Y_test_asig ==1);
Fn=sum(Y_test == 1 & Y_test_asig ==0);
Fp=sum(Y_test == 0 & Y_test_asig ==1);
Tn=sum(Y_test == 0 & Y_test_asig ==0);

% Error--> Error global
% ====================== YOUR CODE HERE ======================
error = (Fp + Fn)/ (Fp + Fn + Tp + Tn);
% ============================================================

fprintf('\n******\nError global = %1.4f%% (classification)\n', error*100);

% Sensitivity
% ====================== YOUR CODE HERE ======================
sensitivity = 1 - (Fn / Fn + Tp);
% ============================================================

fprintf('\n******\nSensitivity = %1.4f (classification)\n', sensitivity);

% Specificity
% ====================== YOUR CODE HERE ======================
specificity = 1 - (Fp / Fp + Tn);
% ============================================================

fprintf('\n******\nSpecificity = %1.4f (classification)\n', specificity);

% F-SCORE
% ====================== YOUR CODE HERE ======================
precision=Tp/(Tp+Fp);
recall=Tp/(Tp+Fp);
FScore = 2*(precision*recall)/(precision+recall);
% ============================================================
fprintf('\n******\nFScore = %1.4f (classification)\n', FScore);
