% Aplica filtragem de alta ênfase
function [H, HFE, Fbefore, Fafter] = highEnphasisFilt(a, b, f, type, show)

% Entradas:
%   a     - offset aplicado a todas as frequências
%   b     - multiplicador da componente passa-alta
%   f     - imagem de entrada
%   type  - 'ideal', 'btw' ou 'gaussian'
%   show  - true para exibir o filtro; false caso contrário

% Saídas:
%   H       - imagem filtrada
%   HFE     - função de transferência da alta ênfase
%   Fbefore - espectro centralizado da imagem original
%   Fafter  - espectro centralizado após a filtragem

    show = logical(show);

    % Conversão da imagem
    fDouble = toDouble01(f);

    [M, N] = size(fDouble);

    % Parâmetros 
    
    % A assinatura solicitada não possui D0 nem n, então usa-se 10% da maior dimensão da imagem

    D0 = max(1, round(0.10 * max(M, N)));
    order = 2;

    % Filtro passa-baixa
    HLP = lpfilt(type, M, N, D0, order);

    % Filtro passa-alta
    HHP = 1 - HLP;

    % Filtro de alta ênfase
    HFE = a + b * HHP;

    % Transformada da imagem e centralização
    F = fft2(fDouble);
    Fbefore = fftShift2D(F);

    % Filtragem
    Fafter = HFE .* Fbefore;

    % Desfazer a centralização
    FafterUnshifted = ifftShift2D(Fafter);

    % Transformada inversa
    H = real(ifft2(FafterUnshifted));

    % Visualização do filtro
    if show
        plotStep = max(1, floor(min(M, N) / 100));

        figure('Name', 'Filtro de alta enfase');

        subplot(1, 2, 1);
        imagesc(HFE);
        axis image;
        colorbar;
        title(sprintf(['Alta enfase - 2D\n', ...
            'a=%.2f, b=%.2f, D0=%d, tipo=%s'], ...
            a, b, D0, type));
        xlabel('v');
        ylabel('u');

        subplot(1, 2, 2);
        mesh(HFE(1:plotStep:end, 1:plotStep:end));
        axis tight;
        title('Alta enfase - 3D');
        xlabel('v');
        ylabel('u');
        zlabel('H_{HFE}(u,v)');
    end
end