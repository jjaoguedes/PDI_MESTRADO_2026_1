% Constrói um filtro passa-baixa 2D
function H = lpfilt(type, M, N, D0, n)
% type:
%   'ideal'    -> passa-baixa ideal
%   'btw'      -> passa-baixa Butterworth
%   'gaussian' -> passa-baixa Gaussiano

% M, N: dimensões do filtro
% D0: raio de corte
% n: ordem do Butterworth

type = lower(char(type));

H = zeros(M, N);

% Posição do termo DC após a centralização
centerRow = floor(M / 2) + 1;
centerColumn = floor(N / 2) + 1;

for u = 1:M
    for v = 1:N

        deltaU = u - centerRow;
        deltaV = v - centerColumn;

        % Distância radial até o centro
        D = sqrt(deltaU^2 + deltaV^2);

        switch type
            case 'ideal'
                if D <= D0
                    H(u, v) = 1;
                else
                    H(u, v) = 0;
                end

            case {'btw', 'butterworth'}
                H(u, v) = 1 / ...
                    (1 + (D / D0)^(2 * n));

            case {'gaussian', 'gauss'}
                H(u, v) = exp(-(D^2) / (2 * D0^2));

            otherwise
                error('Tipo de filtro inválido');
        end
    end
end
end