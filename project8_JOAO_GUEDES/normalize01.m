% Normaliza uma matriz para o intervalo [0,1]
function output = normalize01(input)

    input = double(input);

    minimumValue = min(input(:));
    maximumValue = max(input(:));

    if maximumValue == minimumValue
        output = zeros(size(input));
    else
        output = (input - minimumValue) / (maximumValue - minimumValue);
    end
end