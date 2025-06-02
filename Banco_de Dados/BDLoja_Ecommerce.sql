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
    CPF_Cliente VARCHAR(11)  UNIQUE,
    Nome_Cliente VARCHAR(50)  ,
    Email_Cliente VARCHAR(50) UNIQUE ,
    Senha_Cliente VARCHAR(255),
    Telefone_Cliente VARCHAR(15),
    Img_Perfil_Cliente VARCHAR(255),
    TokenRecuperacao VARCHAR(255),
    TokenTempo DATETIME
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
    Id_Endereco_Cliente INT,
	Data_Pedido DATE,
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
    Tamanho_Produto VARCHAR(50),
    Quantidade_Produto INT,
    Tecido_Produto VARCHAR(50),
    Cor_Produto VARCHAR(50)
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
