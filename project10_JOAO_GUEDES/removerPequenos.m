function saida = removerPequenos(bw, areaMinima)

    [rotulos, num, areas] = componentesConectados(bw);

    [M, N] = size(bw);
    saida = zeros(M, N);

    for x = 1:M
        for y = 1:N

            label = rotulos(x,y);

            if label > 0
                if areas(label) >= areaMinima
                    saida(x,y) = 1;
                end
            end

        end
    end

end