go

select * from Pedido

DECLARE @num1 INT;
DECLARE @num2 INT;
DECLARE @num3 INT;
DECLARE @num4 DECIMAL(10,2);

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

SELECT 
    p.Id_Pedido,
    FORMAT(p.Data_Pedido, 'dd-MM-yyyy') AS Data_Pedido,
    FORMAT(p.Data_Envio_Pedido, 'dd-MM-yyyy') AS Data_Envio,
    FORMAT(p.Data_Entrega_Pedido, 'dd-MM-yyyy') AS Data_Entrega,
    COALESCE(SUM(pp.Valor_Produto_Pedido * pp.Quantidade_Produto_Pedido), 0) AS Valor_Total
FROM Pedido p
JOIN Endereco_Cliente ec ON p.Id_Endereco_Cliente = ec.Id_Endereco_Cliente
LEFT JOIN Produto_Pedido pp ON p.Id_Pedido = pp.Id_Pedido
WHERE ec.Id_Cliente = 1
GROUP BY p.Id_Pedido, p.Data_Pedido, p.Data_Envio_Pedido, p.Data_Entrega_Pedido;



INSERT INTO Pedido (Id_Endereco_Cliente, Data_Pedido) 
VALUES (1, '2025-05-27');

UPDATE Pedido 
SET Data_Envio_Pedido = '2025-01-01' 
WHERE Id_Pedido = 21;

Select * from Pedido
select * from Produto_Pedido where Id_Pedido = 1


--SELECT * FROM Produto ORDER BY CASE WHEN 1=1 AND Tecido_Produto IN ('Algodão', 'Jeans') AND Tamanho_Produto IN ('34', '36', '38') AND Cor_Produto IN ('Cinza', 'Azul', 'Branco', 'Preto') THEN 1 ELSE 2 END, Valor_Produto ASC;
/*
SELECT * FROM Produto
WHERE 1=1
AND Tecido_Produto IN ('Algod�o','Jeans')
AND Tamanho_Produto IN ('34','36','38')
AND Cor_Produto IN ( 'Cinza','Azul','Branco','Preto');
go

SELECT Tamanho_Produto, COUNT(*) AS Quantidade
FROM Produto
GROUP BY Tamanho_Produto
ORDER BY Tamanho_Produto ASC;
go

go 
SELECT * FROM Cliente

--Procedure de autentificação


CREATE PROCEDURE mySp_autenticaUsuario

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