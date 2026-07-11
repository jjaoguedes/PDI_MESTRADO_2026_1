clear;
clc;
close all;

% Leitura da imagem
I = imread('letterA.tif');

Igray = double(I);


%Binarizacao
% Limiar calculado
valor_minimo = min(Igray(:));
valor_maximo = max(Igray(:));
T = (valor_minimo + valor_maximo) / 2;

A = Igray < T;

% Elemento estruturante 9x9 de 1s
B = ones(9, 9);

% Operacoes com as funcoes implementadas
E_ = mm_erode(A, B);
D_ = mm_dilate(A, B);

% Operacoes com o Image Processing Toolbox
SE = strel('square', 9);

E_matlab = imerode(A, SE);
D_matlab = imdilate(A, SE);

% Comparacao numerica da erosao
dif_erosao = E_ ~= E_matlab;

pixels_diferentes_erosao = sum(dif_erosao(:));
erro_maximo_erosao = max(abs(double(E_(:)) - double(E_matlab(:))));
emq_erosao = mean((double(E_(:)) - double(E_matlab(:))).^2);
erosoes_identicas = isequal(E_, E_matlab);

% Comparacao numerica da dilatacao
dif_dilatacao = D_ ~= D_matlab;

pixels_diferentes_dilatacao = sum(dif_dilatacao(:));
erro_maximo_dilatacao = max(abs(double(D_(:)) - double(D_matlab(:))));
emq_dilatacao = mean((double(D_(:)) - double(D_matlab(:))).^2);
dilatacoes_identicas = isequal(D_, D_matlab);

fprintf('COMPARACAO\n');

fprintf('\nEROSAO\n');
fprintf('Pixels diferentes       : %d\n', pixels_diferentes_erosao);
fprintf('Erro maximo              : %.0f\n', erro_maximo_erosao);
fprintf('Erro medio quadratico    : %.6f\n', emq_erosao);
fprintf('Resultados identicos     : %d\n', erosoes_identicas);

fprintf('\nDILATACAO\n');
fprintf('Pixels diferentes       : %d\n', pixels_diferentes_dilatacao);
fprintf('Erro maximo              : %.0f\n', erro_maximo_dilatacao);
fprintf('Erro medio quadratico    : %.6f\n', emq_dilatacao);
fprintf('Resultados identicos     : %d\n', dilatacoes_identicas);

A_exibicao = ~A;

E_manual_exibicao = ~E_;
E_matlab_exibicao = ~E_matlab;

D_manual_exibicao = ~D_;
D_matlab_exibicao = ~D_matlab;

fig = figure('Name', 'Comparacao das operacoes morfologicas', 'NumberTitle', 'off','Color', 'white');

subplot(2, 4, 1);
imshow(Igray, []);
title('Imagem original');

subplot(2, 4, 2);
imshow(A_exibicao);
title('Imagem binaria');

subplot(2, 4, 3);
imshow(E_manual_exibicao);
title('Erosao: mm\_erode');

subplot(2, 4, 4);
imshow(E_matlab_exibicao);
title('Erosao: imerode');

subplot(2, 4, 5);
imshow(dif_erosao);
title(sprintf('Dif. erosao: %d', pixels_diferentes_erosao));

subplot(2, 4, 6);
imshow(D_manual_exibicao);
title('Dilatacao: mm\_dilate');

subplot(2, 4, 7);
imshow(D_matlab_exibicao);
title('Dilatacao: imdilate');

subplot(2, 4, 8);
imshow(dif_dilatacao);
title(sprintf('Dif. dilatacao: %d', pixels_diferentes_dilatacao));

% Salvamento das imagens
imwrite(uint8(A_exibicao) * 255, fullfile('01_imagem_binaria.png'));

imwrite(uint8(E_manual_exibicao) * 255, fullfile('02_erosao.png'));

imwrite(uint8(E_matlab_exibicao) * 255, fullfile('03_erosao_matlab.png'));

imwrite(uint8(dif_erosao) * 255, fullfile('04_diferenca_erosao.png'));

imwrite(uint8(D_manual_exibicao) * 255, fullfile('05_dilatacao.png'));

imwrite(uint8(D_matlab_exibicao) * 255, fullfile('06_dilatacao_matlab.png'));

imwrite(uint8(dif_dilatacao) * 255, fullfile('07_diferenca_dilatacao.png'));

