function g = erodeRaio(f, raio)

[M, N] = size(f);
g = zeros(M, N);

for x = 1:M
    for y = 1:N

        valor = 1;

        for i = -raio:raio
            for j = -raio:raio

                if i^2 + j^2 <= raio^2

                    nx = x + i;
                    ny = y + j;

                    if nx < 1 || nx > M || ny < 1 || ny > N
                        valor = 0;
                    else
                        if f(nx,ny) == 0
                            valor = 0;
                        end
                    end

                end

            end
        end

        g(x,y) = valor;

    end
end

end