function g = imagePad(f, r, c, padtype)

[M, N, K] = size(f);

% Cria imagem de saída com tamanho aumentado
g = zeros(M + 2*r, N + 2*c, K);

if strcmpi(padtype, 'zeros')

    % Coloca a imagem original no centro
    g(r+1:r+M, c+1:c+N, :) = f;

elseif strcmpi(padtype, 'replicate')

    % Cada posição fora da imagem copia o pixel válido mais próximo da borda
    for i = 1:(M + 2*r)
        for j = 1:(N + 2*c)

            src_i = i - r;
            src_j = j - c;

            % Limita a linha ao intervalo [1, M]
            if src_i < 1
                src_i = 1;
            elseif src_i > M
                src_i = M;
            end

            % Limita a coluna ao intervalo [1, N]
            if src_j < 1
                src_j = 1;
            elseif src_j > N
                src_j = N;
            end

            g(i, j, :) = f(src_i, src_j, :);
        end
    end

else
    error('invalido');
end
end