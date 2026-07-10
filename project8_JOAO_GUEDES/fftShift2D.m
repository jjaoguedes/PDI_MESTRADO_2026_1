% Centraliza uma matriz 2D
function shifted = fftShift2D(input)

    [M, N] = size(input);

    middleRow = ceil(M / 2);
    middleColumn = ceil(N / 2);

    rowOrder = [middleRow + 1:M, 1:middleRow];
    columnOrder = [middleColumn + 1:N, 1:middleColumn];

    shifted = input(rowOrder, columnOrder);
end