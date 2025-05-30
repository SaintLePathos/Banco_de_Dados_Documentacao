/* MERLoja_Ecommerce: */
USE master
go
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'Loja_Ecommerce')
BEGIN
    DROP DATABASE Loja_Ecommerce;
END
GO
CREATE DATABASE Loja_Ecommerce
go
USE Loja_Ecommerce
go
CREATE TABLE Cliente  (
    Id_Cliente INT PRIMARY KEY IDENTITY,
    CPF_Cliente VARCHAR(14)  UNIQUE,
    Nome_Cliente VARCHAR(50)  ,
    Email_Cliente VARCHAR(50) UNIQUE ,
    Senha_Cliente VARCHAR(255),
    Telefone_Cliente VARCHAR(15),
    Img_Perfil_Cliente VARCHAR(255)
);
go
CREATE TABLE Fornecedor  (
    Id_Fornecedor INT PRIMARY KEY IDENTITY,
    CNPJ_Fornecedor VARCHAR(14),--CNPJ e composto de 14 digitos alterar na versão final
    Nome_Fornecedor VARCHAR(50),
    Email_Fornecedor VARCHAR(50),
    Telefone_Fornecedor VARCHAR(15)
);
 go
CREATE TABLE Endereco_Cliente  (
    Id_Endereco_Cliente INT PRIMARY KEY IDENTITY,
    Id_Cliente INT,
    CEP_Cliente VARCHAR(8),
    Estado_Cliente VARCHAR(100),
    Cidade_Cliente VARCHAR(100),
    Bairro_Cliente VARCHAR(100),
    Rua_Cliente VARCHAR(100),
    Numero_Cliente VARCHAR(100),
    Complemento_Cliente VARCHAR(100)
);
go
CREATE TABLE Pedido  (
    Id_Pedido INT PRIMARY KEY IDENTITY,
    Id_Cliente INT,
    Data_Envio_Pedido DATE,
    Data_Entrega_Pedido DATE
);
go
CREATE TABLE Produto  (
    Id_Produto INT PRIMARY KEY IDENTITY,
    Id_Fornecedor INT,

    Nome_Produto VARCHAR(50),
    Img_Produto VARCHAR(50),
    Descricao_Produto VARCHAR(500),
    Valor_Produto DECIMAL(10,2),
    Desconto_Produto INT,
    Tamanho_Produto VARCHAR(10),
    Quantidade_Produto INT,
    Tecido_Produto VARCHAR(50),
    Cor_Produto VARCHAR(50)
);
go
CREATE TABLE Produto_Pedido  (
    Id_Produto INT,
    Id_Pedido INT,
    Quantidade_Produto_Pedido INT,
	Valor_Produto_Pedido DECIMAL(10,2),
	Data_Produto_Pedido DATE
    PRIMARY KEY (Id_Produto, Id_Pedido)
);
go

ALTER TABLE Endereco_Cliente  ADD CONSTRAINT FK_Id_Cliente_Endereco_Cliente
    FOREIGN KEY (Id_Cliente)
    REFERENCES Cliente  (Id_Cliente);
 go
ALTER TABLE Pedido  ADD CONSTRAINT FK_Id_Cliente_Pedido
    FOREIGN KEY (Id_Cliente)
    REFERENCES Cliente  (Id_Cliente);
go 
ALTER TABLE Produto  ADD CONSTRAINT FK_Id_Fornecedor_Produto
    FOREIGN KEY (Id_Fornecedor)
    REFERENCES Fornecedor  (Id_Fornecedor);
go 
ALTER TABLE Produto_Pedido  ADD CONSTRAINT FK_Id_Produto_Produto_Pedido
    FOREIGN KEY (Id_Produto)
    REFERENCES Produto  (Id_Produto);
go 
ALTER TABLE Produto_Pedido  ADD CONSTRAINT FK_Id_Pedido_Produto_Pedido
    FOREIGN KEY (Id_Pedido)
    REFERENCES Pedido  (Id_Pedido);
go

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
		'600000' + CAST(@num1 AS NVARCHAR), --CEP
		'Estado' + CAST(@num1 AS NVARCHAR), --Estado
		'Cidade' + CAST(@num1 AS NVARCHAR), --Municipio
		'Bairro' + CAST(@num1 AS NVARCHAR), --Referencia
		'Rua' + CAST(@num1 AS NVARCHAR), --Rua
		@num2 + @num1, --Numero
        'Complemento' + CAST(@num1 AS NVARCHAR) --Complemento
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
		'Descriçãoproduto' + CAST(@num1 AS NVARCHAR), --Descrição
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
		@num4, --valorunitario
		'2025-01-01' --datapedido
    );
    SET @num1 = @num1 + 1; 
	IF @num2 = 20 SET @num2 = 1 ELSE SET @num2 = @num2 + 1;
	IF @num3 = 40 SET @num3 = 1 ELSE SET @num3 = @num3 + 1;
END;
SELECT * FROM Produto_Pedido

SELECT * FROM Produto

SELECT 
    pp.Id_Pedido,
    p.*,
    pp.Quantidade_Produto_Pedido
FROM Produto_Pedido pp
JOIN Produto p ON pp.Id_Produto = p.Id_Produto
WHERE p.Id_Produto = 1;


SELECT 
    p.*,
    COUNT(pp.Id_Pedido) AS Quantidade_Total_Produto_Pedido
FROM Produto_Pedido pp
JOIN Produto p ON pp.Id_Produto = p.Id_Produto
WHERE p.Id_Produto = 8
GROUP BY p.Id_Produto, p.Id_Fornecedor, p.Nome_Produto, p.Img_Produto, p.Descricao_Produto, 
         p.Valor_Produto, p.Desconto_Produto, p.Tamanho_Produto, p.Quantidade_Produto, 
         p.Tecido_Produto, p.Cor_Produto;

Select * from Cliente
SELECT * FROM Cliente WHERE Email_Cliente = 'emailCliente11@Email.com' AND Senha_Cliente = 'senhaCliente11'

--Procedure de autentificação


/*CREATE PROCEDURE mySp_autenticaUsuario

	--definindo parâmetros de entrada
	@login varchar(20),
	@senha varchar(20)
AS
	--criando variaveis
	DECLARE @getLogin varchar(50), @getSenha varchar(255)

	--definindo o valor de cada variavel
	SET @getLogin = (SELECT Email_Cliente FROM Cliente
											WHERE Email_Cliente = @login)
	SET @getSenha = (SELECT Senha_Cliente FROM Cliente 
											WHERE Senha_Cliente = @senha)

	--condicional para retornarmos o login
	if(LEN(@getLogin) > 0) AND (LEN(@getSenha) > 0)
		BEGIN 
		-- trabalhando com condicionais aninhados
		IF(@getLogin <> '') AND (@getSenha <>'')
			BEGIN
				SELECT ('Usuario pode ser logado pois os dados conferem ...') AS logger
			END
		END
	ELSE
		BEGIN
		SELECT ('Usuario não pode ser logado pois os dados não conferem ...') AS logger
		END

EXEC mySp_autenticaUsuario 'Jhon@gmail.com', '1235' */