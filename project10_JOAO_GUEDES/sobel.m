function grad = sobel(f)

    [M, N] = size(f);
    grad = zeros(M, N);

    Hx = [-1 0 1;
          -2 0 2;
          -1 0 1];

    Hy = [-1 -2 -1;
           0  0  0;
           1  2  1];

    for x = 2:M-1
        for y = 2:N-1

            gx = 0;
            gy = 0;

            for i = -1:1
                for j = -1:1

                    pixel = f(x+i, y+j);

                    gx = gx + pixel * Hx(i+2, j+2);
                    gy = gy + pixel * Hy(i+2, j+2);

                end
            end

            grad(x,y) = sqrt(gx^2 + gy^2);

        end
    end

end