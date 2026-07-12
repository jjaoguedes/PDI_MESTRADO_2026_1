function g = media3x3(f)

    [M, N] = size(f);
    g = f;

    for x = 2:M-1
        for y = 2:N-1

            soma = 0;

            for i = -1:1
                for j = -1:1
                    soma = soma + f(x+i, y+j);
                end
            end

            g(x,y) = soma / 9;

        end
    end

end