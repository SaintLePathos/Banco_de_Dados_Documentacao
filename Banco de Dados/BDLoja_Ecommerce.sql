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
CREATE TABLE Funcionario (
    Id_Funcionario INT PRIMARY KEY IDENTITY,
    Nome_Funcionario VARCHAR(50),
    Usuario_Funcionario VARCHAR(50) UNIQUE,
    Senha_Funcionario VARCHAR(255),
    Cargo_Funcionario VARCHAR(30),  -- Ex: Admin, Estoquista, Gerente
    Ativo BIT DEFAULT 1,
    Data_Cadastro DATETIME DEFAULT GETDATE()
);
go
CREATE TABLE Cliente  (
    Id_Cliente INT PRIMARY KEY IDENTITY,
    CPF_Cliente VARCHAR(11)  UNIQUE,
    Nome_Cliente VARCHAR(50)  ,
    Email_Cliente VARCHAR(50) UNIQUE ,
    Senha_Cliente VARCHAR(255),
    Telefone_Cliente VARCHAR(15),
    Img_Perfil_Cliente VARCHAR(255),
    TokenRecuperacao VARCHAR(255),
    TokenTempo DATETIME,
	Conta_Ativa BIT DEFAULT 1
);
go
CREATE TABLE Fornecedor (
    Id_Fornecedor INT PRIMARY KEY IDENTITY,
    CNPJ_Fornecedor CHAR(14) UNIQUE NOT NULL,
    Razao_Social_Fornecedor VARCHAR(100) NOT NULL,
    Nome_Fornecedor VARCHAR(100),
    Email_Fornecedor VARCHAR(100) UNIQUE NOT NULL,
    Telefone_Fornecedor VARCHAR(15),
    Contato_Fornecedor VARCHAR(50),    -- nome da pessoa para contato
    Cargo_Contato_Fornecedor VARCHAR(50),         -- cargo dessa pessoa
    CEP_Fornecedor CHAR(8) NOT NULL,
    Endereco_Fornecedor VARCHAR(100) NOT NULL,
    Numero_Fornecedor VARCHAR(10) NOT NULL,
    UF_Fornecedor CHAR(2) NOT NULL,
    Data_Cadastro_Fornecedor DATETIME DEFAULT GETDATE()
);
 go
CREATE TABLE Endereco_Cliente  (
    Id_Endereco_Cliente INT PRIMARY KEY IDENTITY,
    Id_Cliente INT,
    CEP_Cliente CHAR(8) UNIQUE,
    Estado_Cliente CHAR(2),
    Cidade_Cliente VARCHAR(50),
    Bairro_Cliente VARCHAR(50),
    Rua_Cliente VARCHAR(50),
    Numero_Cliente VARCHAR(9),
    Complemento_Cliente VARCHAR(150),
	Visivel BIT DEFAULT 1
);
go
CREATE TABLE Pedido  (
    Id_Pedido INT PRIMARY KEY IDENTITY,
    Id_Endereco_Cliente INT,
	Id_Funcionario INT,
	Data_Pedido DATE,
    Data_Envio_Pedido DATE,
    Data_Entrega_Pedido DATE,
	Status_Pedido BIT DEFAULT 1
);
go
CREATE TABLE Produto  (
    Id_Produto INT PRIMARY KEY IDENTITY,
    Id_Fornecedor INT,
    Nome_Produto VARCHAR(50),
    Descricao_Produto VARCHAR(500),
    Valor_Produto DECIMAL(10,2),
    Desconto_Produto INT default 0,
    Tamanho_Produto VARCHAR(50),
    Quantidade_Produto INT,
    Tecido_Produto VARCHAR(50),
    Cor_Produto VARCHAR(50),
	Custo_Produto DECIMAL(10,2)
);
go
CREATE TABLE Imagem_Produto (
    Id_Imagem_Produto INT PRIMARY KEY IDENTITY,
    Id_Produto INT,
    Url_ImgProduto VARCHAR(255),
	Ordem_ImgProduto INT DEFAULT 0
);
go
CREATE TABLE Produto_Pedido  (
    Id_Produto INT,
    Id_Pedido INT,
    Quantidade_Produto_Pedido INT,
	Valor_Produto_Pedido DECIMAL(10,2)
    PRIMARY KEY (Id_Produto, Id_Pedido)
);
go

ALTER TABLE Imagem_Produto ADD CONSTRAINT FK_Id_Produto_Imagem_Produto
    FOREIGN KEY (Id_Produto)
    REFERENCES Produto (Id_Produto);
go
ALTER TABLE Endereco_Cliente  ADD CONSTRAINT FK_Id_Cliente_Endereco_Cliente
    FOREIGN KEY (Id_Cliente)
    REFERENCES Cliente  (Id_Cliente);
 go
ALTER TABLE Pedido  ADD CONSTRAINT FK_Id_Endereco_Cliente_Pedido
    FOREIGN KEY (Id_Endereco_Cliente)
    REFERENCES Endereco_Cliente  (Id_Endereco_Cliente);
go
ALTER TABLE Pedido  ADD CONSTRAINT FK_Id_Funcionario_Pedido
    FOREIGN KEY (Id_Funcionario)
    REFERENCES Funcionario  (Id_Funcionario);
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
-- Inserindo dados na tabela Funcionario
INSERT INTO Funcionario (Nome_Funcionario, Usuario_Funcionario, Senha_Funcionario, Cargo_Funcionario) VALUES
('Ana Souza', 'ana', 'ana1234', 'Administrador'),
('Carlos Mendes', 'carlos', 'carlos1234', 'Administrador'),
('Beatriz Lima', 'beatriz', 'beatriz1234', 'Operador'),
('Fernando Oliveira', 'fernando', 'fernando1234', 'Financeiro'),
('Juliana Santos', 'juliana', 'juliana1234', 'Gerente');

-- "Administrador", "Operador", "Gerente", "Financeiro" 

-- Inserindo dados na tabela Fornecedor
INSERT INTO Fornecedor (
    CNPJ_Fornecedor, Razao_Social_Fornecedor, Nome_Fornecedor, 
    Email_Fornecedor, Telefone_Fornecedor, Contato_Fornecedor, 
    Cargo_Contato_Fornecedor, CEP_Fornecedor, Endereco_Fornecedor, 
    Numero_Fornecedor, UF_Fornecedor
) VALUES
('12345678000101', 'Fornecedor A Ltda', 'Fornecedor A', 'contato@fornecedora.com', '11999994444', 'João Silva', 'Gerente', '01001000', 'Rua das Flores, 123', '100', 'SP'),
('98765432000102', 'Fornecedor B S.A.', 'Fornecedor B', 'contato@fornecedorb.com', '21988883333', 'Maria Souza', 'Diretora', '20020000', 'Av. Central, 456', '200', 'RJ'),
('45678912000103', 'Fornecedor C ME', 'Fornecedor C', 'contato@fornecedorc.com', '31977772222', 'Carlos Lima', 'Supervisor', '30030000', 'Rua do Comércio, 789', '300', 'MG'),
('65432198000104', 'Fornecedor D EIRELI', 'Fornecedor D', 'contato@fornecedord.com', '41966661111', 'Ana Pereira', 'Coordenadora', '40040000', 'Av. Paulista, 101', '400', 'PR'),
('78912345000105', 'Fornecedor E Ltda', 'Fornecedor E', 'contato@fornecedore.com', '51955550000', 'Pedro Santos', 'Analista', '50050000', 'Rua das Palmeiras, 202', '500', 'RS');

-- Inserindo dados na tabela Produto
INSERT INTO Produto (Id_Fornecedor, Nome_Produto, Descricao_Produto, Valor_Produto, Tamanho_Produto, Quantidade_Produto, Tecido_Produto, Cor_Produto, Custo_Produto) VALUES
(1, 'Camisa Casual', 'Camisa de algodão confortável.', 89.99, 'M', 50, 'Algodão', 'Azul', 45.00),
(2, 'Calça Jeans', 'Calça jeans resistente e estilosa.', 129.90, '42', 30, 'Denim', 'Preta', 60.00),
(3, 'Jaqueta', 'Jaqueta de couro sintético.', 199.90, 'P', 20, 'Couro Sintético', 'Marrom', 95.00),
(4, 'Bermuda', 'Bermuda confortável para corrida.', 249.90, '42', 25, 'Viscose', 'Branco', 120.00),
(5, 'Vestido Elegante', 'Vestido de seda para ocasiões especiais.', 299.90, 'M', 15, 'Seda', 'Vermelho', 150.00);

-- Inserindo dados na tabela Imagem_Produto
INSERT INTO Imagem_Produto (Id_Produto, Url_ImgProduto, Ordem_ImgProduto) VALUES
(1, 'uploads\imgProduto\img1.png',0),
(1, 'uploads\imgProduto\img2.png',1),
(1, 'uploads\imgProduto\img3.png',2),
(1, 'uploads\imgProduto\img4.png',3),
(2, 'uploads\imgProduto\img1.png',0),
(2, 'uploads\imgProduto\img2.png',1),
(2, 'uploads\imgProduto\img3.png',2),
(2, 'uploads\imgProduto\img4.png',3),
(3, 'uploads\imgProduto\img1.png',0),
(3, 'uploads\imgProduto\img2.png',1),
(3, 'uploads\imgProduto\img3.png',2),
(3, 'uploads\imgProduto\img4.png',3),
(4, 'uploads\imgProduto\img1.png',0),
(4, 'uploads\imgProduto\img2.png',1),
(4, 'uploads\imgProduto\img3.png',2),
(4, 'uploads\imgProduto\img4.png',3),
(5, 'uploads\imgProduto\img1.png',0),
(5, 'uploads\imgProduto\img2.png',1),
(5, 'uploads\imgProduto\img3.png',2),
(5, 'uploads\imgProduto\img4.png',3);

go
-- Exibir todos os funcionários
SELECT * FROM Funcionario;

-- Exibir todos os clientes
SELECT * FROM Cliente;

-- Exibir todos os fornecedores
SELECT * FROM Fornecedor;

-- Exibir todos os endereços de clientes
SELECT * FROM Endereco_Cliente;

-- Exibir todos os pedidos
SELECT * FROM Pedido;

-- Exibir todos os produtos
SELECT * FROM Produto;

-- Exibir todas as imagens dos produtos
SELECT * FROM Imagem_Produto;

-- Exibir relação entre produtos e pedidos
SELECT * FROM Produto_Pedido;

go

CREATE PROCEDURE mySp_getSenhaPorLogin
	@login VARCHAR(100)
AS
BEGIN
	SELECT Email_Cliente, Senha_Cliente
	FROM Cliente
	WHERE Email_Cliente = @login
END
go
use master
