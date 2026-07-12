function bw = limiarMediaDesvio(f, fator)

    [M, N] = size(f);

    soma = 0;
    soma2 = 0;

    for x = 1:M
        for y = 1:N
            soma = soma + f(x,y);
            soma2 = soma2 + f(x,y)^2;
        end
    end

    media = soma / (M*N);
    desvio = sqrt((soma2 / (M*N)) - media^2);

    T = media + fator * desvio;

    bw = zeros(M, N);

    for x = 1:M
        for y = 1:N
            if f(x,y) > T
                bw(x,y) = 1;
            else
                bw(x,y) = 0;
            end
        end
    end

end