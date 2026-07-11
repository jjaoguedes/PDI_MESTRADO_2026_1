% Elimina os pequenos discos e a borda preta
dentro do circulo branco
clear;
clc;
close all;

% Leitura da imagem
Imagem = 'objects-inside-circle.bmp';
pastaSaida = 'resultados_objetos';

if ~exist(pastaSaida, 'dir')
    mkdir(pastaSaida);
end

I = imread(Imagem);

% Conversão para níveis de cinza
if ndims(I) == 3
    Id = double(I);

    Igray = 0.2989 * Id(:, :, 1) + 0.5870 * Id(:, :, 2) + 0.1140 * Id(:, :, 3);
else
    Igray = double(I);
end

% Binarização
valorMinimo = min(Igray(:));
valorMaximo = max(Igray(:));

T = (valorMinimo + valorMaximo) / 2;

% Os pixels pretos passam a valer 1.
mascaraPreta = Igray < T;

% Elementos estruturantes
raioAbertura = 17;
SE_abertura = strel('disk', raioAbertura, 0);

raioFechamento = 2;
SE_fechamento = strel('disk', raioFechamento, 0);

% Abertura
mascaraAberta = imopen(mascaraPreta, SE_abertura);

% Fechamento
mascaraFinal = imclose(mascaraAberta, SE_fechamento);

% Retorno à representação original
resultado = ~mascaraFinal;

fig = figure('Name', 'Filtragem morfologica', 'NumberTitle', 'off', 'Color', 'white');

subplot(2, 2, 1);
imshow(I);
title('Imagem original');

subplot(2, 2, 2);
imshow(~mascaraPreta);
title('Imagem binaria');

subplot(2, 2, 3);
imshow(~mascaraAberta);
title(sprintf('Após abertura, r = %d', raioAbertura));

subplot(2, 2, 4);
imshow(resultado);
title(sprintf('Resultado final, fechamento r = %d', raioFechamento));

imwrite(uint8(~mascaraPreta) * 255, fullfile(pastaSaida, '01_imagem_binaria.png'));

imwrite(uint8(~mascaraAberta) * 255, fullfile(pastaSaida, '02_resultado_abertura.png'));

imwrite(uint8(resultado) * 255, fullfile(pastaSaida, '03_resultado_fechamento.png'));

saveas(fig, fullfile(pastaSaida, '04_comparacao.png'));