DECLARE @num1 INT;
DECLARE @num2 INT;
DECLARE @num3 INT;
DECLARE @num4 DECIMAL(10,2);
SET @num1 = 11;
WHILE @num1 <= 20
BEGIN
    INSERT INTO Cliente VALUES (
        '300300300' + CAST(@num1 AS NVARCHAR), --CPF
        'Cliente_' + CAST(@num1 AS NVARCHAR), --Nome
		'UsuarioCliente_' + CAST(@num1 AS NVARCHAR), --Usuario
        'emailCliente' + CAST(@num1 AS NVARCHAR) + '@Email.com', --Email
		'senhaCliente' + CAST(@num1 AS NVARCHAR), --Senha
        '2030060000040' + CAST(@num1 AS NVARCHAR), --Telefone
		'imgCliente' + CAST(@num1 AS NVARCHAR) + '.png' --ImgPerfil
    );
    SET @num1 = @num1 + 1;
END;

SELECT * FROM Cliente

SET @num1 = 11;
WHILE @num1 <= 20
BEGIN
    INSERT INTO Fornecedor VALUES (
        '203003004000' + CAST(@num1 AS NVARCHAR), --CNPJ
        'Fornecedor_' + CAST(@num1 AS NVARCHAR), --Nome
        'emailFornecedor' + CAST(@num1 AS NVARCHAR) + '@Email.com', --Email 
        '2030060000041' + CAST(@num1 AS NVARCHAR) --Telefone
    );
    SET @num1 = @num1 + 1;
END;
SELECT * FROM Fornecedor

SET @num1 = 11;
SET @num2 = 1;
WHILE @num1 <= 30
BEGIN
    INSERT INTO Endereco_Cliente VALUES (
        @num2, --idcliente
		'Cidade' + CAST(@num1 AS NVARCHAR), --Cidade
		'Estado' + CAST(@num1 AS NVARCHAR), --Estado
		@num2 + @num1, --Numero
		'Rua' + CAST(@num1 AS NVARCHAR), --Rua
		'600000' + CAST(@num1 AS NVARCHAR), --CEP
		'Complemento' + CAST(@num1 AS NVARCHAR), --Referencia
        'Bairro' + CAST(@num1 AS NVARCHAR) --Complemento
    );
    SET @num1 = @num1 + 1;
	SET @num2 = @num2 + 1;
	IF @num2 = 10 SET @num2 = 1;
END;
SELECT * FROM Endereco_Cliente

SET @num1 = 11;
SET @num2 = 1;
SET @num3 = 1;
SET @num4 = 70.00;
WHILE @num1 <= 30
BEGIN
    INSERT INTO Pedido VALUES (
        @num2, --idcliente
		'2025-01-01', --datapedido
		'2025-0' + CAST(@num3 AS NVARCHAR) + '-0' + CAST(@num3 AS NVARCHAR), --Dataenvio
		'2025-0' + CAST(@num3 AS NVARCHAR) + '-0' + CAST(@num3 AS NVARCHAR) --Dataentrega
    );
    SET @num1 = @num1 + 1;
	SET @num2 = @num2 + 1;
	SET @num3 = @num3 + 1;
	IF @num2 = 10 SET @num2 = 1;
	IF @num3 = 9 SET @num3 = 1;
END;
SELECT * FROM Pedido

SET @num1 = 11;
SET @num2 = 1;
SET @num3 = 5;
SET @num4 = 70.00;
WHILE @num1 <= 50
BEGIN																				
    INSERT INTO Produto VALUES (
		@num2, --IdFornecedor
        'Produto' + CAST(@num1 AS NVARCHAR), --Nome 
        'product-' + CAST(@num2 AS NVARCHAR) + '.png', --ImgProduto
		'Descri��oproduto' + CAST(@num1 AS NVARCHAR), --Descri��o
		@num4, --Valor
		@num3, --Desconto
		'Tam' + CAST(@num2+@num2+30 AS NVARCHAR), --Tamanho
		@num1 - 11, --Quantidade
		'Tecido' + CAST(@num3 AS NVARCHAR), --Tecido
		'Cor' + CAST(@num2 AS NVARCHAR) --Cor   
    );
    SET @num1 = @num1 + 1;
	SET @num2 = @num2 + 1;
	SET @num3 = @num3 + 5;
	SET @num4 = @num4 + 7.00;
	IF @num2 = 10 SET @num2 = 1;
	IF @num3 = 50 SET @num3 = 5;
END;
SELECT * FROM Produto

SET @num1 = 1;
SET @num2 = 1;
SET @num3 = 1;
SET @num4 = 10.00;
WHILE @num1 <= 40
BEGIN
    INSERT INTO Produto_Pedido VALUES (
        @num3, --idproduto
		@num2, --idpedido
		@num1+@num1, --quantidade
		@num4 --valorunitario
		
    );
    SET @num1 = @num1 + 1; 
	IF @num2 = 20 SET @num2 = 1 ELSE SET @num2 = @num2 + 1;
	IF @num3 = 40 SET @num3 = 1 ELSE SET @num3 = @num3 + 1;
END;
SELECT * FROM Produto_Pedido

/*go

INSERT INTO Cliente (Nome_Cliente, Email_Cliente, Senha_Cliente, Telefone_Cliente, CPF_Cliente, Usuario_Cliente) VALUES
('Joao', 'Joao@gmail.com','123','11 12345-6789','123456789','Joao12')
INSERT INTO Cliente (Nome_Cliente, Email_Cliente, Senha_Cliente, Telefone_Cliente, CPF_Cliente,Usuario_Cliente) VALUES
('Jhon', 'Jhon@gmail.com','12345','11 12345-6789','12345678910','Jhon123')
INSERT INTO Cliente (Nome_Cliente, Email_Cliente, Senha_Cliente, Telefone_Cliente, CPF_Cliente,Usuario_Cliente) VALUES
('Douglas', 'Dougla11s@gmail.com','123','11 19345-6789','1234678912','Douglas3')


	INSERT INTO Fornecedor (CNPJ_Fornecedor, Nome_Fornecedor, Email_Fornecedor, Telefone_Fornecedor) VALUES
('12345678901234', 'Fornecedor A', 'contato@fornecedora.com', '11987654321'),
('56789012345678', 'Fornecedor B', 'contato@fornecedorb.com', '11987654322'),
('98765432109876', 'Fornecedor C', 'contato@fornecedorc.com', '11987654323');
go

-- Inserindo produtos agora que os fornecedores existem
INSERT INTO Produto (Id_Fornecedor, Nome_Produto, Img_Produto, Descricao_Produto, Valor_Produto, Peso_Produto, Desconto_Produto, Tamanho_Produto, Quantidade_Produto, Tecido_Produto, Cor_Produto) VALUES
(1, 'Camiseta Branca', 'product-1.png', 'Camiseta de algod�o branca', 39.90, 0.3, 10.00, '34', 50, 'Algod�o', 'Branca'),
(1, 'Camiseta Preta', 'product-1.png', 'Camiseta de algod�o preta', 39.90, 0.3, 10.00, '36', 40, 'Algod�o', 'Preta'),
(2, 'Cal�a Jeans', 'product-1.png', 'Cal�a jeans azul', 99.90, 1.2, 15.00, '42', 30, 'Jeans', 'Azul'),
(2, 'Jaqueta Couro', 'product-1.png', 'Jaqueta de couro sint�tico', 199.90, 1.5, 20.00, '38', 25, 'Couro Sint�tico', 'Preto'),
(3, 'T�nis Esportivo', 'product-1.png', 'T�nis confort�vel para corrida', 149.90, 0.8, 5.00, '42', 60, 'Sint�tico', 'Vermelho'),
(3, 'Mochila Casual', 'product-1.png', 'Mochila para uso di�rio', 79.90, 0.5, 12.00, '40', 45, 'Poli�ster', 'Preto'),
(1, 'Bon� Estiloso', 'product-1.png', 'Bon� de algod�o', 49.90, 0.2, 8.00, '42', 35, 'Algod�o', 'Azul'),
(2, '�culos de Sol', 'product-1.png', '�culos com prote��o UV', 129.90, 0.3, 10.00, '44', 20, 'Pl�stico', 'Preto'),
(3, 'Rel�gio Elegante', 'product-1.png', 'Rel�gio anal�gico de a�o', 399.90, 0.4, 25.00, '46', 15, 'A�o', 'Prata'),
(1, 'Carteira de Couro', 'product-1.png', 'Carteira de couro leg�timo', 89.90, 0.3, 12.00, '48', 50, 'Couro', 'Marrom'),
(2, 'Chap�u Panam�', 'product-1.png', 'Chap�u estiloso para ver�o', 59.90, 0.2, 5.00, '40', 22, 'Palha', 'Bege'),
(3, 'Meia Confort�vel', 'product-1.png', 'Meia de algod�o', 15.90, 0.1, 3.00, '38', 100, 'Algod�o', 'Cinza'),
(1, 'Casaco de L�', 'product-1.png', 'Casaco quente para inverno', 229.90, 1.3, 18.00, '42', 30, 'L�', 'Cinza'),
(2, 'Cal�a Moletom', 'product-1.png', 'Cal�a confort�vel de moletom', 79.90, 1.1, 12.00, '46', 45, 'Moletom', 'Cinza'),
(3, 'Cinto de Couro', 'product-1.png', 'Cinto elegante de couro', 59.90, 0.3, 10.00, '40', 40, 'Couro', 'Preto'),
(1, 'Blusa Feminina', 'product-1.png', 'Blusa leve e estilosa', 49.90, 0.4, 8.00, '34', 35, 'Algod�o', 'Rosa'),
(2, 'Saia Jeans', 'product-1.png', 'Saia curta de jeans', 89.90, 0.7, 15.00, '34', 25, 'Jeans', 'Azul'),
(2, 'Saia Jeans', 'product-1.png', 'Saia curta de jeans', 89.90, 0.7, 15.00, '36', 25, 'Jeans', 'Branco'),
(2, 'Saia Jeans', 'product-1.png', 'Saia curta de jeans', 89.90, 0.7, 15.00, '38', 25, 'Jeans', 'Preto'),
(2, 'Saia Jeans', 'product-1.png', 'Saia curta de jeans', 89.90, 0.7, 15.00, '40', 25, 'Jeans', 'Verde'),
(3, 'Sand�lia Casual', 'product-1.png', 'Sand�lia confort�vel para passeio', 79.90, 0.5, 10.00, '42', 50, 'Couro Sint�tico', 'Marrom'),
(1, 'Vestido Floral', 'product-1.png', 'Vestido estampado', 119.90, 0.6, 20.00, '46', 40, 'Poli�ster', 'Vermelho'),
(2, 'Chinelo de Borracha', 'product-1.png', 'Chinelo simples', 29.90, 0.3, 5.00, '48', 80, 'Borracha', 'Preto');
go
SELECT * FROM Produto
*/