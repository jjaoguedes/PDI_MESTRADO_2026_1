clear;
close all;
clc;

% Leitura da imagem
f = imread('circuitboard-saltandpep.tif');

% Conversao para tons de cinza e escala [0,1]
f_view = double(f);

f_min = min(f_view(:));
f_max = max(f_view(:));

if f_max > f_min
    f_view = (f_view - f_min) / (f_max - f_min);
else
    f_view = zeros(size(f_view));
end

% Filtros lineares passa-baixa: filtros de media

w3 = ones(3,3) / (3*3);
w11 = ones(11,11) / (11*11);
w21 = ones(21,21) / (21*21);

g_media_3 = LinearSFilter(f, w3);
g_media_11 = LinearSFilter(f, w11);
g_media_21 = LinearSFilter(f, w21);

% Filtro nao linear de mediana 3x3

g_mediana_3 = medianSFilter(f, [3 3]);

% Exibicao dos resultados

figure;

subplot(2,3,1);
imshow(f_view, []);
title('Imagem original');

subplot(2,3,2);
imshow(g_media_3, []);
title('Media 3x3');

subplot(2,3,3);
imshow(g_media_11, []);
title('Media 11x11');

subplot(2,3,4);
imshow(g_media_21, []);
title('Media 21x21');

subplot(2,3,5);
imshow(g_mediana_3, []);
title('Mediana 3x3');

% Salvando os resultados

imwrite(g_media_3, 'resultado_media_3x3.png');
imwrite(g_media_11, 'resultado_media_11x11.png');
imwrite(g_media_21, 'resultado_media_21x21.png');
imwrite(g_mediana_3, 'resultado_mediana_3x3.png');