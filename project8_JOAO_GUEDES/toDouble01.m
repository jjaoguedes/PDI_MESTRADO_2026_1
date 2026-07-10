% Converte uma imagem para double no intervalo [0,1]
function f = toDouble01(img)

originalClass = class(img);

if ismatrix(img)
    imgDouble = double(img);
end

% Ajustar a faixa de valores conforme a classe original
switch originalClass

    case 'uint8'
        f = imgDouble / 255;

    case 'uint16'
        f = imgDouble / 65535;

    case 'logical'
        % Imagem já possui valores 0 e 1
        f = imgDouble;

    otherwise
        % Tratamento para imagens single ou double
        minimumValue = min(imgDouble(:));
        maximumValue = max(imgDouble(:));

        % Verificar se a imagem já está no intervalo [0,1]
        if minimumValue >= 0 && maximumValue <= 1

            f = imgDouble;

            % Normalização para [0,1]
        elseif maximumValue > minimumValue

            f = (imgDouble - minimumValue) / (maximumValue - minimumValue);

        else
            % Imagem constante: evita divisão por zero
            f = zeros(size(imgDouble));
        end
end
end