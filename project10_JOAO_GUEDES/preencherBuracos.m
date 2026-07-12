function preenchida = preencherBuracos(bw)

    [M, N] = size(bw);

    visitado = zeros(M, N);

    filaX = zeros(M*N, 1);
    filaY = zeros(M*N, 1);

    inicio = 1;
    fim = 0;

    % Colocar pixels de fundo das bordas na fila
    for y = 1:N

        if bw(1,y) == 0 && visitado(1,y) == 0
            fim = fim + 1;
            filaX(fim) = 1;
            filaY(fim) = y;
            visitado(1,y) = 1;
        end

        if bw(M,y) == 0 && visitado(M,y) == 0
            fim = fim + 1;
            filaX(fim) = M;
            filaY(fim) = y;
            visitado(M,y) = 1;
        end

    end

    for x = 1:M

        if bw(x,1) == 0 && visitado(x,1) == 0
            fim = fim + 1;
            filaX(fim) = x;
            filaY(fim) = 1;
            visitado(x,1) = 1;
        end

        if bw(x,N) == 0 && visitado(x,N) == 0
            fim = fim + 1;
            filaX(fim) = x;
            filaY(fim) = N;
            visitado(x,N) = 1;
        end

    end

    % Propagar fundo externo
    while inicio <= fim

        x = filaX(inicio);
        y = filaY(inicio);
        inicio = inicio + 1;

        for i = -1:1
            for j = -1:1

                if i == 0 && j == 0
                    continue;
                end

                nx = x + i;
                ny = y + j;

                if nx >= 1 && nx <= M && ny >= 1 && ny <= N

                    if bw(nx,ny) == 0 && visitado(nx,ny) == 0

                        fim = fim + 1;
                        filaX(fim) = nx;
                        filaY(fim) = ny;

                        visitado(nx,ny) = 1;

                    end

                end

            end
        end

    end

    preenchida = bw;

    % Fundo não visitado é buraco, então vira objeto
    for x = 1:M
        for y = 1:N
            if bw(x,y) == 0 && visitado(x,y) == 0
                preenchida(x,y) = 1;
            end
        end
    end

end