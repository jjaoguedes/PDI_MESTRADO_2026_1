clear;
close all;
clc;

% Leitura da imagem
inputImage = imread('chestXray.tif');

% Conversão para tons de cinza em [0,1]
f = toDouble01(inputImage);

[M, N] = size(f);

% Parâmetros de alta ênfase

a = 0.5;
b = 0.75;
type = 'gaussian';
showFilter = true;

% Aplicação do filtro de alta ênfase
[filteredImage, HFE, spectrumBefore, spectrumAfter] = highEnphasisFilt(a, b, f, type, showFilter);

% Normalização da imagem filtrada
filteredNormalized = normalize01Manual(filteredImage);

% Equalização de histograma
[equalizedImage, histogramBeforeEq, histogramAfterEq] = histEq(filteredNormalized, 256);

% Preparação dos espectros para visualização
magnitudeBefore = log(1 + abs(spectrumBefore));
magnitudeAfter = log(1 + abs(spectrumAfter));

magnitudeBeforeDisplay = normalize01(magnitudeBefore);
magnitudeAfterDisplay = normalize01(magnitudeAfter);

% Espectro antes e depois da alta ênfase
figure('Name', 'Espectros antes e depois da filtragem');

subplot(1, 2, 1);
imagesc(magnitudeBeforeDisplay, [0 1]);
axis image off;
colormap gray;
title('Espectro antes da filtragem');

subplot(1, 2, 2);
imagesc(magnitudeAfterDisplay, [0 1]);
axis image off;
colormap gray;
title('Espectro após a alta ênfase');

% Comparação das imagens
figure('Name', 'Alta enfase e equalizacao');

subplot(1, 3, 1);
imagesc(f, [0 1]);
axis image off;
colormap gray;
title('Radiografia original');

subplot(1, 3, 2);
imagesc(filteredNormalized, [0 1]);
axis image off;
colormap gray;
title(sprintf('Alta enfase: a=%.2f, b=%.2f', a, b));

subplot(1, 3, 3);
imagesc(equalizedImage, [0 1]);
axis image off;
colormap gray;
title('Alta enfase + equalizacao');

% Histogramas antes e depois da equalização
levels = 0:255;

figure('Name', 'Histogramas');

subplot(2, 2, 1);
imagesc(filteredNormalized, [0 1]);
axis image off;
colormap gray;
title('Antes da equalizacao');

subplot(2, 2, 2);
bar(levels, histogramBeforeEq);
xlim([0 255]);
title('Histograma antes');
xlabel('Nivel de intensidade');
ylabel('Quantidade de pixels');

subplot(2, 2, 3);
imagesc(equalizedImage, [0 1]);
axis image off;
colormap gray;
title('Depois da equalizacao');

subplot(2, 2, 4);
bar(levels, histogramAfterEq);
xlim([0 255]);
title('Histograma depois');
xlabel('Nivel de intensidade');
ylabel('Quantidade de pixels');

% Informações do filtro
fprintf('\nParametros usados na alta enfase:\n');
fprintf('a = %.2f\n', a);
fprintf('b = %.2f\n', b);
fprintf('Tipo = %s\n', type);
fprintf('Ganho no centro do espectro = a = %.2f\n', a);
fprintf('Ganho aproximado nas altas frequencias = a+b = %.2f\n', a + b);