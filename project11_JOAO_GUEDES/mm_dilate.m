function C = mm_dilate(A, B)

    A = A ~= 0;
    B = B ~= 0;

    [linhasA, colunasA] = size(A);
    [linhasB, colunasB] = size(B);

    origemLinha = (linhasB + 1) / 2;
    origemColuna = (colunasB + 1) / 2;

    paddingLinha = origemLinha - 1;
    paddingColuna = origemColuna - 1;

    A_padded = false( linhasA + 2 * paddingLinha, colunasA + 2 * paddingColuna);

    A_padded( paddingLinha + 1 : paddingLinha + linhasA, paddingColuna + 1 : paddingColuna + colunasA) = A;

    C = false(linhasA, colunasA);

    for i = 1:linhasA
        for j = 1:colunasA

            encontrou = false;

            for u = 1:linhasB
                for v = 1:colunasB

                    valorB = B(linhasB - u + 1, colunasB - v + 1);

                    if valorB && A_padded(i + u - 1, j + v - 1)
                        encontrou = true;
                        break;
                    end

                end

                if encontrou
                    break;
                end
            end

            C(i, j) = encontrou;
        end
    end
end