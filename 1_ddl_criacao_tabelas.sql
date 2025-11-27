CREATE database ProShine_Local;
USE ProShine_Local;

CREATE TABLE FORNECEDOR (
    ID_Fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    CNPJ VARCHAR(18) UNIQUE NOT NULL,      -- CNPJ é o identificador único e obrigatório
    Nome_Fantasia VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    Telefone VARCHAR(15),
    Logradouro VARCHAR(150),
    Numero VARCHAR(10),
    CEP VARCHAR(10),
    Cidade VARCHAR(50),
    Estado CHAR(2)
);


CREATE TABLE CLIENTE (
    ID_Cliente INT PRIMARY KEY AUTO_INCREMENT, -- Chave Primária
    Nome_Completo VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,       -- Deve ser único e obrigatório
    CPF VARCHAR(14) UNIQUE,
    Telefone VARCHAR(15),
    Logradouro VARCHAR(150),
    Numero VARCHAR(10),
    Complemento VARCHAR(50),                  -- Detalhe do endereço
    Bairro VARCHAR(50),
    CEP VARCHAR(10),
    Cidade VARCHAR(50),
    Estado CHAR(2)
);

CREATE TABLE PRODUTO (
    ID_Produto INT PRIMARY KEY AUTO_INCREMENT,
    ID_Fornecedor INT NOT NULL, -- Chave Estrangeira (FK)
    Nome VARCHAR(100) UNIQUE NOT NULL,
    Preco_Unitario DECIMAL(10, 2) NOT NULL,
    Estoque_Atual INT NOT NULL DEFAULT 0,
    Peso_Gramas INT,
    Categoria VARCHAR(50),
    Descricao_Detalhada TEXT, -- Permite texto longo e não estruturado

    -- Definição da Chave Estrangeira
    FOREIGN KEY (ID_Fornecedor) REFERENCES FORNECEDOR(ID_Fornecedor)
);

CREATE TABLE PEDIDO (
    ID_Pedido INT PRIMARY KEY AUTO_INCREMENT,
    ID_Cliente INT NOT NULL,               -- Chave Estrangeira para CLIENTE
    Data_Hora_Pedido DATETIME NOT NULL,
    Status VARCHAR(20) NOT NULL,           -- Ex: 'Aprovado', 'Enviado', 'Entregue'
    Forma_Pagamento VARCHAR(50),
    Num_Parcelas INT DEFAULT 1,
    Valor_Total DECIMAL(10, 2),            -- Atributo Derivado (Calculado na transação)
    
    -- Definição da Chave Estrangeira
    FOREIGN KEY (ID_Cliente) REFERENCES CLIENTE(ID_Cliente)
);

CREATE TABLE ITEM_PEDIDO (
    ID_Pedido INT NOT NULL,              -- FK para PEDIDO (Parte da PK Composta)
    ID_Produto INT NOT NULL,             -- FK para PRODUTO (Parte da PK Composta)
    Quantidade_Vendida INT NOT NULL,     -- Único atributo que depende de ambas as chaves

    -- Define a PK composta pelas duas chaves estrangeiras
    PRIMARY KEY (ID_Pedido, ID_Produto), 

    -- Definição das Chaves Estrangeiras
    FOREIGN KEY (ID_Pedido) REFERENCES PEDIDO(ID_Pedido),
    FOREIGN KEY (ID_Produto) REFERENCES PRODUTO(ID_Produto) 
);


CREATE TABLE FEEDBACK_AVALIACAO (
    ID_Avaliacao INT PRIMARY KEY AUTO_INCREMENT,
    ID_Cliente INT NOT NULL,              -- FK para o CLIENTE (quem fez a avaliação)
    ID_Produto INT NOT NULL,              -- FK para o PRODUTO (o item avaliado)
    Nota INT NOT NULL,                    -- Ex: 1 a 5
    Comentario_Texto TEXT,
    Data_Avaliacao DATETIME NOT NULL,
    Forma_Captura VARCHAR(50),            -- Ex: 'Site', 'Email'
    Status_Moderacao VARCHAR(20),

    -- Restrição de Unicidade: Um cliente só pode avaliar um produto uma vez (OPCIONAL, mas boa prática)
    UNIQUE (ID_Cliente, ID_Produto), 

    -- Definição das Chaves Estrangeiras
    FOREIGN KEY (ID_Cliente) REFERENCES CLIENTE(ID_Cliente),
    FOREIGN KEY (ID_Produto) REFERENCES PRODUTO(ID_Produto)
);
