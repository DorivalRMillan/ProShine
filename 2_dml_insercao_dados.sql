USE ProShine_Local;

-- Fornecedores de produtos (sem FKs)
INSERT INTO FORNECEDOR (CNPJ, Nome_Fantasia, Email, Telefone, CEP, Cidade, Estado) VALUES
('12.345.678/0001-90', 'Auto Brilho Supply', 'contato@autobrilho.com.br', '(11) 5555-1234', '01000-000', 'São Paulo', 'SP'),
('98.765.432/0001-50', 'Microfibra Premium', 'vendas@microfibra.com.br', '(21) 9876-5432', '20000-000', 'Rio de Janeiro', 'RJ');


-- Clientes (sem FKs)
INSERT INTO CLIENTE (Nome_Completo, Email, CPF, Telefone, Logradouro, CEP, Cidade, Estado) VALUES
('Joao Silva', 'joao.silva@teste.com', '12345678901', '(11) 98765-1111', 'Rua das Ceras, 100', '03000-000', 'São Paulo', 'SP'),
('Maria Souza', 'maria.souza@teste.com', '98765432109', '(41) 99999-2222', 'Avenida dos Detalhes, 50', '80000-000', 'Curitiba', 'PR'),
('Pedro Alvares', 'pedro.alvares@teste.com', NULL, '(31) 88888-3333', 'Rua dos Panos, 30', '30000-000', 'Belo Horizonte', 'MG');


-- Produtos (ID_Fornecedor deve existir na tabela FORNECEDOR)
INSERT INTO PRODUTO (ID_Fornecedor, Nome, Preco_Unitario, Estoque_Atual, Peso_Gramas, Categoria) VALUES
(1, 'Cera Pro Brilho 500ml', 50.00, 150, 600, 'Ceras'),
(1, 'Shampoo Neutro 1L', 35.50, 200, 1100, 'Shampoos'),
(2, 'Pano Microfibra 40x40', 15.90, 500, 50, 'Microfibra');


-- Pedidos (ID_Cliente deve existir na tabela CLIENTE)
INSERT INTO PEDIDO (ID_Cliente, Data_Hora_Pedido, Status, Forma_Pagamento, Valor_Total) VALUES
(1, NOW(), 'Aprovado', 'PIX', 65.90),    -- Joao comprou 1 Pano (15.90) + 1 Shampoo (50.00)
(2, NOW(), 'Em Processamento', 'Cartão', 50.00), -- Maria comprou 1 Cera (50.00)
(3, NOW(), 'Aprovado', 'Boleto', 15.90);    -- Pedro comprou 1 Pano (15.90)

-- Detalhes dos Pedidos (FKs de PEDIDO e PRODUTO devem existir)
INSERT INTO ITEM_PEDIDO (ID_Pedido, ID_Produto, Quantidade_Vendida) VALUES
(1, 2, 1), -- Pedido 1: 1 Shampoo Neutro
(1, 3, 1), -- Pedido 1: 1 Pano Microfibra
(2, 1, 1), -- Pedido 2: 1 Cera Pro Brilho
(3, 3, 1); -- Pedido 3: 1 Pano Microfibra

-- Avaliações (FKs de CLIENTE e PRODUTO devem existir)
INSERT INTO FEEDBACK_AVALIACAO (ID_Cliente, ID_Produto, Nota, Comentario_Texto, Data_Avaliacao, Forma_Captura, Status_Moderacao) VALUES
(1, 2, 5, 'Excelente shampoo, espuma na medida certa!', NOW(), 'Site', 'Publicado'),
(2, 1, 4, 'A cera é boa, mas o brilho não durou o esperado.', DATE_SUB(NOW(), INTERVAL 1 DAY), 'Email Pós-Venda', 'Publicado'),
(1, 3, 3, 'O pano solta um pouco de fiapo.', NOW(), 'Site', 'Pendente');
