function [rotulos, num, areas] = componentesConectados(bw)

    [M, N] = size(bw);

    rotulos = zeros(M, N);
    areas = zeros(M*N, 1);

    filaX = zeros(M*N, 1);
    filaY = zeros(M*N, 1);

    num = 0;

    for x = 1:M
        for y = 1:N

            if bw(x,y) == 1 && rotulos(x,y) == 0

                num = num + 1;

                inicio = 1;
                fim = 1;

                filaX(fim) = x;
                filaY(fim) = y;

                rotulos(x,y) = num;
                area = 0;

                while inicio <= fim

                    cx = filaX(inicio);
                    cy = filaY(inicio);
                    inicio = inicio + 1;

                    area = area + 1;

                    for i = -1:1
                        for j = -1:1

                            if i == 0 && j == 0
                                continue;
                            end

                            nx = cx + i;
                            ny = cy + j;

                            if nx >= 1 && nx <= M && ny >= 1 && ny <= N

                                if bw(nx,ny) == 1 && rotulos(nx,ny) == 0

                                    fim = fim + 1;

                                    filaX(fim) = nx;
                                    filaY(fim) = ny;

                                    rotulos(nx,ny) = num;

                                end

                            end

                        end
                    end

                end

                areas(num) = area;

            end

        end
    end

    areas = areas(1:num);

end