% Elimina todos os circulos e elipses pretos do interior do disco branco.

clear;
clc;
close all;

% Leitura imagem
Imagem = 'resultados_objetos/03_resultado_fechamento.png';
pastaSaida = 'resultado_disco';

if ~exist(pastaSaida, 'dir')
    mkdir(pastaSaida);
end

I = imread(Imagem);

% Conversao para niveis de cinza
if ndims(I) == 3
    Id = double(I);

    Igray = 0.2989 * Id(:, :, 1) + 0.5870 * Id(:, :, 2) + 0.1140 * Id(:, :, 3);
else
    Igray = double(I);
end

% Binarizacao
valorMinimo = min(Igray(:));
valorMaximo = max(Igray(:));
T = (valorMinimo + valorMaximo) / 2;

% Disco branco como primeiro plano:
% branco = 1 e preto = 0.
A = Igray >= T;

%Fechamento
raioFechamento = round(0.07 * min(size(A)));

SE_fechamento = strel('disk', raioFechamento, 4);

A_fechada = imclose(A, SE_fechamento);

% Abertura
raioAbertura = 2;

SE_abertura = strel('disk', raioAbertura, 0);

resultado = imopen(A_fechada, SE_abertura);

% Regioes que foram preenchidas
regioesPreenchidas = resultado & ~A;

fig = figure( 'Name', 'Eliminacao dos objetos internos', 'NumberTitle', 'off', 'Color', 'white');

subplot(2, 2, 1);
imshow(I);
title('Imagem original');

subplot(2, 2, 2);
imshow(A);
title('Imagem binaria');

subplot(2, 2, 3);
imshow(regioesPreenchidas);
title('Objetos internos');

subplot(2, 2, 4);
imshow(resultado);
title('Disco branco');

imwrite(uint8(A) * 255, fullfile(pastaSaida, '01_imagem_binaria.png'));

imwrite(uint8(A_fechada) * 255, fullfile(pastaSaida, '02_apos_fechamento.png'));

imwrite(uint8(regioesPreenchidas) * 255, fullfile(pastaSaida, '03_objetos_preenchidos.png'));

imwrite(uint8(resultado) * 255, fullfile(pastaSaida, '04_disco_branco.png'));

saveas(fig, fullfile(pastaSaida, '05_comparacao.png'));