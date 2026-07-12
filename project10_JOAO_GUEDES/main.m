clear;
clc;
close all;

nomes = {'Imagem1.jpg', 'Imagem2.jpg', 'Imagem3.jpg'};

for img = 1:3

    % Leitura da imagem
    f = imread(nomes{img});

    % Converter para tons de cinza
    fgray = forGray(f);

    % Normalizar para o intervalo [0,1]
    fgray = normalize01(fgray);

    % Suavizar para reduzir pequenos ruídos
    fsuave = media3x3(fgray);

    % Aplicar operador de Sobel
    grad = sobel(fsuave);

    % Normalizar o gradiente para [0,1]
    grad = normalize01(grad);

    % Limiarizar o gradiente
    fator = 0.6;
    bordas = limiarMediaDesvio(grad, fator);

    % Fechar falhas nas bordas
    raioFechamento = 4;

    bordasFechadas = dilataRaio(bordas, raioFechamento);
    bordasFechadas = erodeRaio(bordasFechadas, raioFechamento);

    % Preencher regiões fechadas
    regioes = preencherBuracos(bordasFechadas);

    % Remover objetos pequenos
    areaMinima = 200;
    regioes = removerPequenos(regioes, areaMinima);

    % Selecionar as duas maiores bolhas
    duasBolhas = manterDoisMaiores(regioes);

    % Mostrar resultados
    figure('Name', ['Imagem ', num2str(img)]);

    subplot(2,3,1);
    imshow(fgray, []);
    title(['Imagem ', num2str(img)]);

    subplot(2,3,2);
    imshow(grad, []);
    title('Gradiente Sobel');

    subplot(2,3,3);
    imshow(bordas);
    title('Bordas binárias');

    subplot(2,3,4);
    imshow(bordasFechadas);
    title('Bordas fechadas');

    subplot(2,3,5);
    imshow(regioes);
    title('Regiões preenchidas');

    subplot(2,3,6);
    imshow(duasBolhas);
    title('Duas maiores bolhas');

    imwrite(duasBolhas, ['duas_maiores_bolhas_', num2str(img), '.png']);

end