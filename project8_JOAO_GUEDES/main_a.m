clear;
close all;
clc;

% Leitura da imagem
inputImage = imread('woman.tif');

% Conversão para [0,1]
f = toDouble01(inputImage);

[M, N] = size(f);
% Transformada de Fourier 2D
F = fft2(f);

% Centralização do espectro
Fc = fftShift2D(F);

% Espectro de magnitude para visualização
spectrum = log(1 + abs(Fc));
spectrumDisplay = normalize01(spectrum);

% Parâmetros do Butterworth
% Utiliza-se 15% da menor dimensão como raio de corte

D0 = round(0.15 * min(M, N));
order = 2;

fprintf('Raio de corte D0: %d\n', D0);
fprintf('Ordem do Butterworth: %d\n', order);

% Construção do filtro passa-baixa Butterworth
HLP = lpfilt('btw', M, N, D0, order);

% Construção do passa-alta por complementaridade
HHP = 1 - HLP;

% Aplicação dos filtros
GLP = HLP .* Fc;
GHP = HHP .* Fc;

% Desfazer a centralização
GLPUnshifted = ifftShift2D(GLP);
GHPUnshifted = ifftShift2D(GHP);

% Transformada inversa
gLP = real(ifft2(GLPUnshifted));
gHP = real(ifft2(GHPUnshifted));

% Normalização para visualização
gLPDisplay = normalize01(gLP);
gHPDisplay = normalize01(gHP);

    % Imagem original e espectro centralizado
    figure('Name', 'Imagem e espectro centralizado');
    
    subplot(1, 2, 1);
    imagesc(f, [0 1]);
    axis image off;
    colormap gray;
    title('Imagem original - woman.tif');
    
    subplot(1, 2, 2);
    imagesc(spectrumDisplay, [0 1]);
    axis image off;
    colormap gray;
    title('Espectro centralizado: log(1 + |F|)');
    
    % Resultados dos filtros
    figure('Name', 'Resultados da filtragem Butterworth');
    
    subplot(1, 3, 1);
    imagesc(f, [0 1]);
    axis image off;
    colormap gray;
    title('Imagem original');
    
    subplot(1, 3, 2);
    imagesc(gLPDisplay, [0 1]);
    axis image off;
    colormap gray;
    title(sprintf('Passa-baixa: D0=%d, n=%d', D0, order));
    
    subplot(1, 3, 3);
    imagesc(gHPDisplay, [0 1]);
    axis image off;
    colormap gray;
    title(sprintf('Passa-alta: D0=%d, n=%d', D0, order));
    
    % Visualizações 2D e 3D dos filtros
    
    % Reduz a quantidade de pontos apenas na visualização 3D
    plotStep = max(1, floor(min(M, N) / 100));
    
    figure('Name', 'Filtros Butterworth 2D e 3D');
    
    subplot(2, 2, 1);
    imagesc(HLP, [0 1]);
    axis image;
    colorbar;
    title('Passa-baixa Butterworth - 2D');
    xlabel('v');
    ylabel('u');
    
    subplot(2, 2, 2);
    mesh(HLP(1:plotStep:end, 1:plotStep:end));
    title('Passa-baixa Butterworth - 3D');
    xlabel('v');
    ylabel('u');
    zlabel('H_{LP}(u,v)');
    axis tight;
    
    subplot(2, 2, 3);
    imagesc(HHP, [0 1]);
    axis image;
    colorbar;
    title('Passa-alta Butterworth - 2D');
    xlabel('v');
    ylabel('u');
    
    subplot(2, 2, 4);
    mesh(HHP(1:plotStep:end, 1:plotStep:end));
    title('Passa-alta Butterworth - 3D');
    xlabel('v');
    ylabel('u');
    zlabel('H_{HP}(u,v)');
    axis tight;
    
    % Espectros filtrados
    lowSpectrum = normalize01(log(1 + abs(GLP)));
    highSpectrum = normalize01(log(1 + abs(GHP)));
    
    figure('Name', 'Espectros após a filtragem');
    
    subplot(1, 2, 1);
    imagesc(lowSpectrum, [0 1]);
    axis image off;
    colormap gray;
    title('Espectro após o passa-baixa');
    
    subplot(1, 2, 2);
    imagesc(highSpectrum, [0 1]);
    axis image off;
    colormap gray;
    title('Espectro após o passa-alta');