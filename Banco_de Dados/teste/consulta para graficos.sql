--pega de todos os anos
SELECT 
    YEAR(Data_Entrega_Pedido) AS Ano,
    COUNT(Id_Pedido) AS Quantidade_Vendas
FROM Pedido
WHERE Data_Entrega_Pedido IS NOT NULL 
AND DATEDIFF(DAY, Data_Entrega_Pedido, GETDATE()) > 7
GROUP BY YEAR(Data_Entrega_Pedido)
ORDER BY Ano DESC;

--pega do ultimo ano
SELECT 
    YEAR(Data_Entrega_Pedido) AS Ano,
    MONTH(Data_Entrega_Pedido) AS Mes,
    COUNT(Id_Pedido) AS Quantidade_Vendas
FROM Pedido
WHERE Data_Entrega_Pedido IS NOT NULL 
AND DATEDIFF(DAY, Data_Entrega_Pedido, GETDATE()) > 7
AND YEAR(Data_Entrega_Pedido) = YEAR(GETDATE()) -- Obtém o ano atual dinamicamente
GROUP BY YEAR(Data_Entrega_Pedido), MONTH(Data_Entrega_Pedido)
ORDER BY Ano DESC, Mes DESC;


--pega do ano selecionado
SELECT 
    YEAR(Data_Entrega_Pedido) AS Ano,
    MONTH(Data_Entrega_Pedido) AS Mes,
    COUNT(Id_Pedido) AS Quantidade_Vendas
FROM Pedido
WHERE Data_Entrega_Pedido IS NOT NULL 
AND DATEDIFF(DAY, Data_Entrega_Pedido, GETDATE()) > 7
AND YEAR(Data_Entrega_Pedido) = 2023 -- Substitua pelo ano desejado
GROUP BY YEAR(Data_Entrega_Pedido), MONTH(Data_Entrega_Pedido)
ORDER BY Ano DESC, Mes DESC;

--pega os ultimos 30 dias
SELECT 
    DAY(Data_Entrega_Pedido) AS Dia,
    COUNT(Id_Pedido) AS Quantidade_Vendas
FROM Pedido
WHERE Data_Entrega_Pedido IS NOT NULL 
AND DATEDIFF(DAY, Data_Entrega_Pedido, GETDATE()) BETWEEN 8 AND 30
GROUP BY DAY(Data_Entrega_Pedido)
ORDER BY Dia DESC;


--pega os 30 dias do ano e mes selecionado
SELECT 
    DAY(Data_Entrega_Pedido) AS Dia,
    COUNT(Id_Pedido) AS Quantidade_Vendas
FROM Pedido
WHERE Data_Entrega_Pedido IS NOT NULL 
AND DATEDIFF(DAY, Data_Entrega_Pedido, GETDATE()) BETWEEN 8 AND 30
AND YEAR(Data_Entrega_Pedido) = 2025  -- Substitua pelo ano desejado
AND MONTH(Data_Entrega_Pedido) = 6    -- Substitua pelo mês desejado
GROUP BY DAY(Data_Entrega_Pedido)
ORDER BY Dia DESC;
