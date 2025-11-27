USE ProShine_Local;
-- Desabilita o modo de segurança para a sessão atual
SET SQL_SAFE_UPDATES = 0;

-- Seu comando UPDATE
UPDATE PRODUTO
SET Preco_Unitario = Preco_Unitario * 1.05
WHERE Categoria = 'Ceras';

-- Habilita o modo de segurança novamente
SET SQL_SAFE_UPDATES = 1;

UPDATE PEDIDO
SET Status = 'Enviado', Data_Hora_Pedido = NOW()
WHERE ID_Pedido = 2 AND Status = 'Em Processamento';

UPDATE CLIENTE
SET Telefone = '(11) 99999-0000', CEP = '04000-000'
WHERE ID_Cliente = 3;


DELETE FROM FEEDBACK_AVALIACAO
WHERE Data_Avaliacao < DATE_SUB(NOW(), INTERVAL 1 YEAR) 
  AND Status_Moderacao = 'Pendente';
  
  -- Supondo que ID_Produto = 500 é o produto obsoleto.
DELETE FROM PRODUTO
WHERE ID_Produto = 5 AND Estoque_Atual = 0;

-- Remova primeiro os itens filhos, para depois remover o pedido pai.
DELETE FROM ITEM_PEDIDO
WHERE ID_Pedido = 3; 

DELETE FROM PEDIDO
WHERE ID_Pedido = 3 AND Status = 'Aprovado'; -- Use uma condição adicional para segurança

select * from PRODUTO;
select * from PEDIDO;
select * from ITEM_PEDIDO;
