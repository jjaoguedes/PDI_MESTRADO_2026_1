function g = normalize01(f)

    [M, N] = size(f);

    menor = f(1,1);
    maior = f(1,1);

    for x = 1:M
        for y = 1:N

            if f(x,y) < menor
                menor = f(x,y);
            end

            if f(x,y) > maior
                maior = f(x,y);
            end

        end
    end

    g = zeros(M, N);

    if maior == menor
        return;
    end

    for x = 1:M
        for y = 1:N
            g(x,y) = (f(x,y) - menor) / (maior - menor);
        end
    end

end