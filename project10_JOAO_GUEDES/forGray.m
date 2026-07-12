function g = forGray(f)

    [M, N, C] = size(f);
    g = zeros(M, N);

    if C == 3
        for x = 1:M
            for y = 1:N
                R = double(f(x,y,1));
                G = double(f(x,y,2));
                B = double(f(x,y,3));

                g(x,y) = 0.2989*R + 0.5870*G + 0.1140*B;
            end
        end
    else
        for x = 1:M
            for y = 1:N
                g(x,y) = double(f(x,y));
            end
        end
    end

end