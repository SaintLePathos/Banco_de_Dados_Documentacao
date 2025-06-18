USE Loja_Ecommerce;
GO

-- Inserção de Clientes
DECLARE @iCliente INT = 1;
WHILE @iCliente <= 5
BEGIN
    INSERT INTO Cliente (CPF_Cliente, Nome_Cliente, Email_Cliente, Senha_Cliente, Telefone_Cliente, Img_Perfil_Cliente, TokenRecuperacao, TokenTempo)
    VALUES 
    (RIGHT('00000000000' + CAST(@iCliente AS VARCHAR(11)), 11), 
     'Cliente ' + CAST(@iCliente AS VARCHAR(50)), 
     'cliente' + CAST(@iCliente AS VARCHAR(50)) + '@email.com',
     HASHBYTES('SHA2_256', 'Senha' + CAST(@iCliente AS VARCHAR(50))),
     '(11) 99999-' + CAST(1000 + @iCliente AS VARCHAR(15)), 
     'perfil' + CAST(@iCliente AS VARCHAR(255)) + '.jpg', 
     NULL, NULL);

    SET @iCliente = @iCliente + 1;
END;
GO
--Inserir forneçedores veiculos
DECLARE @iFornecedor INT = 1;
WHILE @iFornecedor <= 5
BEGIN
    INSERT INTO Fornecedor (CNPJ_Fornecedor, Nome_Fornecedor, Email_Fornecedor, Telefone_Fornecedor)
    VALUES 
    (RIGHT('00000000000000' + CAST(@iFornecedor AS VARCHAR(14)), 14), 
     'Fornecedor ' + CAST(@iFornecedor AS VARCHAR(50)), 
     'fornecedor' + CAST(@iFornecedor AS VARCHAR(50)) + '@empresa.com',
     '(11) 88888-' + CAST(1000 + @iFornecedor AS VARCHAR(15)));

    SET @iFornecedor = @iFornecedor + 1;
END;
GO


-- Inserção de Endereços de Cliente
DECLARE @iEndereco INT = 1;
WHILE @iEndereco <= 5
BEGIN
    INSERT INTO Endereco_Cliente (Id_Cliente, CEP_Cliente, Estado_Cliente, Cidade_Cliente, Bairro_Cliente, Rua_Cliente, Numero_Cliente, Complemento_Cliente)
    VALUES 
    (@iEndereco, '01001000', 'SP', 'São Paulo', 'Centro', 'Rua Exemplo ' + CAST(@iEndereco AS VARCHAR(100)), 
     CAST(100 + @iEndereco AS VARCHAR(100)), 'Apto ' + CAST(@iEndereco AS VARCHAR(100)));

    SET @iEndereco = @iEndereco + 1;
END;
GO

-- Inserção de Pedidos
DECLARE @iPedido INT = 1;
WHILE @iPedido <= 60
BEGIN
    INSERT INTO Pedido (Id_Endereco_Cliente, Data_Pedido, Data_Envio_Pedido, Data_Entrega_Pedido, Status_Pedido)
    VALUES 
    (@iPedido % 5 + 1, DATEADD(DAY, @iPedido, '2025-01-01'), 
     DATEADD(DAY, @iPedido + 5, '2025-01-01'), 
     DATEADD(DAY, @iPedido + 10, '2025-01-01'), 
     1);

    SET @iPedido = @iPedido + 1;
END;
GO

-- Inserção de Produtos e Imagens
DECLARE @iProduto INT = 1;
WHILE @iProduto <= 5
BEGIN
    IF EXISTS (SELECT 1 FROM Fornecedor WHERE Id_Fornecedor = @iProduto) 
    BEGIN
        INSERT INTO Produto (Id_Fornecedor, Nome_Produto, Descricao_Produto, Valor_Produto, Desconto_Produto, Tamanho_Produto, Quantidade_Produto, Tecido_Produto, Cor_Produto)
        VALUES 
        (@iProduto, 'Produto ' + CAST(@iProduto AS VARCHAR(50)), 
         'Descrição do produto ' + CAST(@iProduto AS VARCHAR(500)), 
         100.00 + @iProduto * 10, 5, 'M', 20, 'Algodão', 'Azul');
        
        -- Inserir imagens apenas se o produto existir
        INSERT INTO Imagem_Produto (Id_Produto, Url_ImgProduto)
        VALUES (@iProduto, 'produto' + CAST(@iProduto AS VARCHAR(255)) + '.jpg');
    END;

    SET @iProduto = @iProduto + 1;
END;
GO


-- Inserção de Relacionamento Produto-Pedido
DECLARE @iProdutoPedido INT = 1, @iPedidoProduto INT = 1;
DECLARE @Quantidade INT, @Valor DECIMAL(10,2);

WHILE @iPedidoProduto <= 60
BEGIN
    SET @Quantidade = 2 + @iProdutoPedido;
    SET @Valor = 100.00 + (@iProdutoPedido * 10);

    INSERT INTO Produto_Pedido (Id_Produto, Id_Pedido, Quantidade_Produto_Pedido, Valor_Produto_Pedido)
    VALUES (@iProdutoPedido, @iPedidoProduto, @Quantidade, @Valor);

    SET @iPedidoProduto = @iPedidoProduto + 1;
    SET @iProdutoPedido = @iProdutoPedido + 1;
    IF @iProdutoPedido > 5 SET @iProdutoPedido = 1;
END;
GO

-- Consultas para verificação dos dados
SELECT * FROM Cliente;
SELECT * FROM Fornecedor;
SELECT * FROM Endereco_Cliente;
SELECT * FROM Pedido;
SELECT * FROM Produto;
SELECT * FROM Imagem_Produto;
SELECT * FROM Produto_Pedido;
GO
use master