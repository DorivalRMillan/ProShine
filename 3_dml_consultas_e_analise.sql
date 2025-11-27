USE ProShine_Local;

SELECT
    C.Nome_Completo AS Cliente,
    P.ID_Pedido,
    P.Data_Hora_Pedido,
    P.Status
FROM CLIENTE C
JOIN PEDIDO P ON C.ID_Cliente = P.ID_Cliente
ORDER BY P.Data_Hora_Pedido DESC;

SELECT
    P.Nome AS Produto,
    P.Estoque_Atual,
    F.Nome_Fantasia AS Fornecedor
FROM PRODUTO P
JOIN FORNECEDOR F ON P.ID_Fornecedor = F.ID_Fornecedor
WHERE P.Estoque_Atual <= 150 -- Condição de baixo estoque
ORDER BY P.Estoque_Atual ASC;

SELECT
    C.Nome_Completo AS Cliente,
    SUM(P.Valor_Total) AS GastoTotal,
    COUNT(P.ID_Pedido) AS TotalPedidos
FROM CLIENTE C
JOIN PEDIDO P ON C.ID_Cliente = P.ID_Cliente
GROUP BY C.ID_Cliente, C.Nome_Completo -- Agrupa por cliente
ORDER BY GastoTotal DESC
LIMIT 5; -- Limita aos 5 maiores compradores

SELECT
    PR.Nome AS Produto,
    F.Nota,
    F.Comentario_Texto,
    C.Nome_Completo AS Cliente
FROM FEEDBACK_AVALIACAO F
JOIN PRODUTO PR ON F.ID_Produto = PR.ID_Produto
JOIN CLIENTE C ON F.ID_Cliente = C.ID_Cliente
WHERE F.Nota < 4
ORDER BY F.Nota ASC;
