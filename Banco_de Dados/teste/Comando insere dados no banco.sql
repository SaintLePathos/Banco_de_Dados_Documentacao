-- Inserir Clientes
DECLARE @i INT = 1;
WHILE @i <= 5
BEGIN
    INSERT INTO Cliente (CPF_Cliente, Nome_Cliente, Email_Cliente, Senha_Cliente, Telefone_Cliente, Img_Perfil_Cliente)
    VALUES 
    (RIGHT('00000000000' + CAST(@i AS VARCHAR(11)), 11), 
     'Cliente ' + CAST(@i AS VARCHAR(50)), 
     'cliente' + CAST(@i AS VARCHAR(50)) + '@email.com',
     HASHBYTES('SHA2_256', 'Senha' + CAST(@i AS VARCHAR(255))),
     '(11) 99999-' + CAST(1000 + @i AS VARCHAR(15)), 
     'perfil' + CAST(@i AS VARCHAR(255)) + '.jpg');

    SET @i = @i + 1;
END;

-- Inserir Fornecedores
SET @i = 1;
WHILE @i <= 5
BEGIN
    INSERT INTO Fornecedor (CNPJ_Fornecedor, Nome_Fornecedor, Email_Fornecedor, Telefone_Fornecedor)
    VALUES 
    (RIGHT('00000000000000' + CAST(@i AS VARCHAR(14)), 14), 
     'Fornecedor ' + CAST(@i AS VARCHAR(50)), 
     'fornecedor' + CAST(@i AS VARCHAR(50)) + '@empresa.com',
     '(11) 88888-' + CAST(1000 + @i AS VARCHAR(15)));

    SET @i = @i + 1;
END;

-- Inserir Endereços de Cliente
SET @i = 1;
WHILE @i <= 5
BEGIN
    INSERT INTO Endereco_Cliente (Id_Cliente, CEP_Cliente, Estado_Cliente, Cidade_Cliente, Bairro_Cliente, Rua_Cliente, Numero_Cliente, Complemento_Cliente)
    VALUES 
    (@i, '01001000', 'SP', 'São Paulo', 'Centro', 'Rua Exemplo ' + CAST(@i AS VARCHAR(100)), 
     CAST(100 + @i AS VARCHAR(100)), 'Apto ' + CAST(@i AS VARCHAR(100)));

    SET @i = @i + 1;
END;

-- Inserir Pedidos
DECLARE @i1 INT = 1;
DECLARE @i2 INT = 0;
DECLARE @Mes INT;
WHILE @i2 <= 5
BEGIN
    SET @Mes = 1;
    WHILE @Mes <= 12
    BEGIN
        DECLARE @Ano VARCHAR(4) = '202' + CAST(@i2 AS VARCHAR);
        INSERT INTO Pedido (Id_Endereco_Cliente, Data_Pedido, Data_Envio_Pedido, Data_Entrega_Pedido)
        VALUES (
            @i1, 
            CONVERT(DATE, CONCAT(@Ano, '-', FORMAT(@Mes, '00'), '-01')), 
            CONVERT(DATE, CONCAT(@Ano, '-', FORMAT(@Mes, '00'), '-05')), 
            CONVERT(DATE, CONCAT(@Ano, '-', FORMAT(@Mes, '00'), '-10'))
        );
        SET @Mes = @Mes + 1;
    END;
    SET @i1 = @i1 + 1;
    SET @i2 = @i2 + 1;
    IF @i1 = 5 SET @i1 = 1;
END;
-- Inserir Produtos
SET @i = 1;
WHILE @i <= 5
BEGIN
    INSERT INTO Produto (Id_Fornecedor, Nome_Produto, Img_Produto, Descricao_Produto, Valor_Produto, Desconto_Produto, Tamanho_Produto, Quantidade_Produto, Tecido_Produto, Cor_Produto)
    VALUES 
    (@i, 'Produto ' + CAST(@i AS VARCHAR(50)), 'produto' + CAST(@i AS VARCHAR(50)) + '.jpg',
     'Descrição do produto ' + CAST(@i AS VARCHAR(500)), 
     100.00 + @i * 10, 5, 'M', 20, 'Algodão', 'Azul');

    SET @i = @i + 1;
END;

-- Inserir Relacionamento Produto-Pedido
-- Inserir produtos em pedidos
DECLARE @iProduto INT = 1;
DECLARE @iPedido INT = 1;

WHILE @iPedido <= 60 -- Supondo que existam 60 pedidos (5 anos x 12 meses)
BEGIN
    -- Definir quantidade e valor baseado no produto
    DECLARE @Quantidade INT = 2 + @iProduto; -- Quantidade variável
    DECLARE @Valor DECIMAL(10,2) = 100.00 + (@iProduto * 10); -- Valor baseado no produto

    -- Inserir na tabela Produto_Pedido
    INSERT INTO Produto_Pedido (Id_Produto, Id_Pedido, Quantidade_Produto_Pedido, Valor_Produto_Pedido)
    VALUES (@iProduto, @iPedido, @Quantidade, @Valor);

    -- Alternar para o próximo pedido
    SET @iPedido = @iPedido + 1;

    -- Alternar entre os produtos (5 produtos cadastrados)
    SET @iProduto = @iProduto + 1;
    IF @iProduto > 5 SET @iProduto = 1;
END;

-- Consultas
SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_TYPE = 'BASE TABLE' 
AND TABLE_CATALOG = 'Loja_Ecommerce';

SELECT * FROM Cliente;
SELECT * FROM Fornecedor;
SELECT * FROM Endereco_Cliente;
SELECT * FROM Pedido;
SELECT * FROM Produto;
SELECT * FROM Produto_Pedido;

