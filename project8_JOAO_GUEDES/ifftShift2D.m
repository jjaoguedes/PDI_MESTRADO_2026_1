% Desfaz a centralização de uma matriz 2D
function unshifted = ifftShift2D(input)

    [M, N] = size(input);

    middleRow = floor(M / 2);
    middleColumn = floor(N / 2);

    rowOrder = [middleRow + 1:M, 1:middleRow];
    columnOrder = [middleColumn + 1:N, 1:middleColumn];

    unshifted = input(rowOrder, columnOrder);
end