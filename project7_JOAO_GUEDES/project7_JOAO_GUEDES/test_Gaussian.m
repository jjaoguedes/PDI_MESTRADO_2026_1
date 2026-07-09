clear;
close all;
clc;

% Leitura da imagem
f = imread('testpattern512.tif');

% Conversão para double
f = double(f);

% Escala a imagem para [0, 1]
fmin = min(f(:));
fmax = max(f(:));

if fmax > fmin
    f = (f - fmin) / (fmax - fmin);
else
    f = zeros(size(f));
end

% Parâmetros
sig = 5;
limiar = 1/256;

% Tamanhos ímpares de kernels a serem testados
tamanhos = 3:2:61;

% Variáveis para armazenar o resultado anterior
g_ant = [];
n_ant = 0;

% Variáveis de controle
encontrou = false;
menor_kernel = 0;
menor_diferenca = 0;

fprintf('Comparacao entre kernels Gaussianos consecutivos\n');
fprintf('Sigma = %.2f\n', sig);
fprintf('Limiar = %.8f\n\n', limiar);
fprintf('Kernel anterior | Kernel atual | Max diferenca | Max diferenca em niveis 0-255\n');
fprintf('--------------------------------------------------------------------------\n');

for k = 1:length(tamanhos)

    n = tamanhos(k);

    % Cria kernel Gaussiano n x n com sigma = 5
    % fspecial retorna um filtro Gaussiano passa-baixa.
    w = fspecial('gaussian', [n n], sig);

    % Aplica filtragem espacial linear usando a função feita anteriormente
    % Sem usar imfilter, conv2 ou imgaussfilt.
    g = LinearSFilter(f, w);

    % A partir do segundo kernel, compara com o anterior
    if k > 1

        diferenca = abs(g - g_ant);
        maxDiff = max(diferenca(:));

        fprintf('%7dx%-7d | %5dx%-5d | %.10f | %.6f\n', ...
            n_ant, n_ant, n, n, maxDiff, maxDiff*255);

        % Critério do projeto
        if maxDiff < limiar && encontrou == false
            encontrou = true;
            menor_kernel = n;
            menor_diferenca = maxDiff;
        end
    end

    % Atualiza imagem anterior
    g_ant = g;
    n_ant = n;
end

fprintf('\n');

if encontrou
    fprintf('Menor kernel encontrado: %dx%d\n', menor_kernel, menor_kernel);
    fprintf('Diferenca maxima encontrada: %.10f\n', menor_diferenca);
    fprintf('Diferenca em niveis de intensidade 0-255: %.6f\n', menor_diferenca*255);
else
    fprintf('Nenhum kernel testado satisfez o criterio.\n');
end

% Visualização do resultado com o kernel esperado 31x31

w31 = fspecial('gaussian', [31 31], sig);
g31 = LinearSFilter(f, w31);

figure;

subplot(1,2,1);
imshow(f, []);
title('Imagem original');

subplot(1,2,2);
imshow(g31, []);
title('Filtro Gaussiano 31x31, sigma = 5');
