function g = erode3x3(f)

[M, N] = size(f);
g = zeros(M, N);

for x = 2:M-1
    for y = 2:N-1

        valor = 1;

        for i = -1:1
            for j = -1:1
                if f(x+i, y+j) == 0
                    valor = 0;
                end
            end
        end

        g(x,y) = valor;

    end
end

end