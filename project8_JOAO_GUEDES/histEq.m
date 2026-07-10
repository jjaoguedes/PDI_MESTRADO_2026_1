% Equalização global de histograma
function [g, histogramInput, histogramOutput, mapping] = histEq(f, L)

    if nargin < 2
        L = 256;
    end

    % A imagem no intervalo [0,1]
    f = normalize01(f);

    [M, N] = size(f);
    totalPixels = M * N;

    % Quantização para [0, L-1]
    quantized = zeros(M, N);

    for x = 1:M
        for y = 1:N
            value = floor(f(x, y) * (L - 1));

            if value < 0
                value = 0;
            elseif value > L - 1
                value = L - 1;
            end

            quantized(x, y) = value;
        end
    end

    % Histograma
    histogramInput = zeros(1, L);

    for x = 1:M
        for y = 1:N
            level = quantized(x, y);
            histogramInput(level + 1) = histogramInput(level + 1) + 1;
        end
    end

    % Histograma normalizado
    probability = histogramInput / totalPixels;

    % Distribuição acumulada
    cumulative = zeros(1, L);

    cumulative(1) = probability(1);

    for k = 2:L
        cumulative(k) = cumulative(k - 1) + probability(k);
    end

    % Mapeamento de intensidades
    mapping = zeros(1, L);

    for k = 1:L
        mapping(k) = round((L - 1) * cumulative(k));
    end

    % Aplicação do mapeamento
    equalizedLevels = zeros(M, N);

    for x = 1:M
        for y = 1:N
            oldLevel = quantized(x, y);
            equalizedLevels(x, y) = mapping(oldLevel + 1);
        end
    end

    % Retorno no intervalo [0,1]
    g = equalizedLevels / (L - 1);

    % Histograma da saída
    histogramOutput = zeros(1, L);

    for x = 1:M
        for y = 1:N
            level = equalizedLevels(x, y);
            histogramOutput(level + 1) = histogramOutput(level + 1) + 1;
        end
    end
end