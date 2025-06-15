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
CREATE TABLE Fornecedor  (
    Id_Fornecedor INT PRIMARY KEY IDENTITY,
    CNPJ_Fornecedor CHAR(14) UNIQUE,--CNPJ e composto de 14 digitos alterar na vers�o final
    Nome_Fornecedor VARCHAR(50),
    Email_Fornecedor VARCHAR(50),
    Telefone_Fornecedor VARCHAR(15)
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
    Complemento_Cliente VARCHAR(150)
);
go
CREATE TABLE Pedido  (
    Id_Pedido INT PRIMARY KEY IDENTITY,
    Id_Endereco_Cliente INT,
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

-- Inserindo dados na tabela Cliente
INSERT INTO Cliente (CPF_Cliente, Nome_Cliente, Email_Cliente, Senha_Cliente, Telefone_Cliente, Img_Perfil_Cliente) VALUES
('12345678901', 'Lucas Pereira', 'lucas@email.com', 'lucas123', '11999998888', 'img1.png'),
('23456789012', 'Mariana Costa', 'mariana@email.com', 'mariana456', '11988887777', 'img2.png'),
('34567890123', 'Thiago Silva', 'thiago@email.com', 'thiago789', '11977776666', 'img3.png'),
('45678901234', 'Bruna Martins', 'bruna@email.com', 'brunaabc', '11966665555', 'img4.png'),
('56789012345', 'Felipe Rocha', 'felipe@email.com', 'felipedef', '11955554444', 'img5.png');

-- Inserindo dados na tabela Fornecedor
INSERT INTO Fornecedor (CNPJ_Fornecedor, Nome_Fornecedor, Email_Fornecedor, Telefone_Fornecedor) VALUES
('12345678000101', 'FashionStore', 'contato@fashionstore.com', '11999996666'),
('23456789000102', 'TrendShop', 'contato@trendshop.com', '11988885555'),
('34567890000103', 'ModaExpress', 'contato@modaexpress.com', '11977774444'),
('45678901000104', 'StyleWear', 'contato@stylewear.com', '11966663333'),
('56789012000105', 'Elegance', 'contato@elegance.com', '11955552222');

-- Inserindo dados na tabela Endereco_Cliente
INSERT INTO Endereco_Cliente (Id_Cliente, CEP_Cliente, Estado_Cliente, Cidade_Cliente, Bairro_Cliente, Rua_Cliente, Numero_Cliente, Complemento_Cliente) VALUES
(1, '01001000', 'SP', 'São Paulo', 'Centro', 'Rua A', '123', 'Ap 10'),
(2, '02002000', 'SP', 'São Paulo', 'Moema', 'Rua B', '456', 'Casa'),
(3, '03003000', 'RJ', 'Rio de Janeiro', 'Copacabana', 'Rua C', '789', 'Bloco 2'),
(4, '04004000', 'MG', 'Belo Horizonte', 'Savassi', 'Rua D', '321', 'Fundos'),
(5, '05005000', 'RS', 'Porto Alegre', 'Moinhos', 'Rua E', '654', 'Casa');

-- Inserindo dados na tabela Pedido
INSERT INTO Pedido (Id_Endereco_Cliente, Data_Pedido, Data_Envio_Pedido, Data_Entrega_Pedido) VALUES
(1, '2025-06-01', '2025-06-02', '2025-06-05'),
(2, '2025-06-03', '2025-06-04', '2025-06-07'),
(3, '2025-06-05', '2025-06-06', '2025-06-10'),
(4, '2025-06-07', '2025-06-08', '2025-06-12'),
(5, '2025-06-09', '2025-06-10', '2025-06-15');

-- Inserindo dados na tabela Produto
INSERT INTO Produto (Id_Fornecedor, Nome_Produto, Descricao_Produto, Valor_Produto, Tamanho_Produto, Quantidade_Produto, Tecido_Produto, Cor_Produto, Custo_Produto) VALUES
(1, 'Camisa Casual', 'Camisa de algodão confortável.', 89.90, 'M', 50, 'Algodão', 'Azul', 45.00),
(2, 'Calça Jeans', 'Calça jeans resistente e estilosa.', 129.90, '42', 30, 'Denim', 'Preta', 60.00),
(3, 'Jaqueta', 'Jaqueta de couro sintético.', 199.90, 'P', 20, 'Couro Sintético', 'Marrom', 95.00),
(4, 'Bermuda', 'Bermuda confortável para corrida.', 249.90, '42', 25, 'Viscose', 'Branco', 120.00),
(5, 'Vestido Elegante', 'Vestido de seda para ocasiões especiais.', 299.90, 'M', 15, 'Seda', 'Vermelho', 150.00);

-- Inserindo dados na tabela Imagem_Produto
INSERT INTO Imagem_Produto (Id_Produto, Url_ImgProduto) VALUES
(1, 'camisa_azul.jpg'),
(2, 'calca_preta.jpg'),
(3, 'jaqueta_marrom.jpg'),
(4, 'tenis_branco.jpg'),
(5, 'vestido_vermelho.jpg');

-- Inserindo dados na tabela Produto_Pedido
INSERT INTO Produto_Pedido (Id_Produto, Id_Pedido, Quantidade_Produto_Pedido, Valor_Produto_Pedido) VALUES
(1, 1, 2, 45.00),
(2, 2, 1, 60.00),
(3, 3, 1, 95.00),
(4, 4, 2, 120.00),
(5, 5, 1, 150.00);
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

use master
