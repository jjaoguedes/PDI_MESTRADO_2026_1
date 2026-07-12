function saida = manterDoisMaiores(bw)

    [rotulos, num, areas] = componentesConectados(bw);

    [M, N] = size(bw);

    maior1 = 0;
    maior2 = 0;

    label1 = 0;
    label2 = 0;

    for k = 1:num

        if areas(k) > maior1

            maior2 = maior1;
            label2 = label1;

            maior1 = areas(k);
            label1 = k;

        elseif areas(k) > maior2

            maior2 = areas(k);
            label2 = k;

        end

    end

    saida = zeros(M, N);

    for x = 1:M
        for y = 1:N

            if rotulos(x,y) == label1 || rotulos(x,y) == label2
                saida(x,y) = 1;
            else
                saida(x,y) = 0;
            end

        end
    end

end