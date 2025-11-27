# ProShine
Sistema de Gestão para Loja Online de Estética Automotiva "ProShine"

Este projeto teve como objetivo principal desenvolver um Modelo de Banco de Dados Relacional robusto e normalizado para gerenciar os processos essenciais de uma loja online, focando em estoque, pedidos e análise de desempenho.

1. Fase Conceitual (EP 1: Definição do Minimundo)
A etapa inicial definiu o escopo (minimundo) de uma loja de detalhamento automotivo. Foram estabelecidos os processos principais, como a gestão de estoque e o registro de feedback. Conceitos fundamentais foram aplicados, distinguindo Dado (ex: o fato bruto "Nota 5") de Informação (o dado contextualizado, ex: "Média de Avaliações do Produto X") e classificando Dados Estruturados (CNPJ, Preço) e Não Estruturados (Comentários de Clientes).

2. Modelagem Lógica (EP 2: Diagrama Entidade-Relacionamento - DER)
O Modelo Lógico (DER) foi criado com 6 entidades principais: Cliente, Fornecedor, Produto, Pedido, Item_Pedido e Feedback/Avaliação. Os relacionamentos de 1 para N foram estabelecidos, sendo o relacionamento N:N entre PRODUTO e PEDIDO resolvido pela Entidade Associativa ITEM_PEDIDO.

3. Normalização e Revisão (EP 3: 1FN, 2FN e 3FN)
A normalização garantiu a qualidade do modelo, eliminando redundâncias e anomalias:

 3. 3FN (Transitiva): Garantida pela eliminação de atributos dependentes de outros não-chave (ex: garantindo que o Nome_Fornecedor não estivesse na tabela PRODUTO).

2. FN (Parcial): A tabela ITEM_PEDIDO foi revisada. Para atingir a 2FN estrita no modelo acadêmico, o atributo Preco_Unitario_Vendido foi removido, pois representava uma dependência parcial em relação ao ID_Produto.

4. Implementação Física (EP 4: DDL e DML)
O modelo lógico revisado (já em 2FN e 3FN) foi traduzido para código SQL. O DDL (CREATE TABLE) definiu a estrutura com as Chaves Primárias e Chaves Estrangeiras. Em seguida, o DML (INSERT, SELECT, UPDATE, DELETE) demonstrou a manipulação segura dos dados, executando consultas complexas (JOIN) e respeitando a integridade referencial.


# 🛒 Projeto de Modelagem e Implementação de Banco de Dados
## Sistema de Gestão para Loja Online de Estética Automotiva - ProShine

![Status](https://img.shields.io/badge/Status-Concluído-brightgreen)
![Linguagem](https://img.shields.io/badge/Linguagem-SQL-blue)
![Banco de Dados](https://img.shields.io/badge/Banco%20de%20Dados-MySQL%2FPostgreSQL-orange)

---

### 💡 Visão Geral e Propósito

Este repositório contém os artefatos de Modelagem (DER Normalizado) e os scripts SQL para a criação e manipulação do banco de dados de uma loja virtual especializada em produtos de estética automotiva. O foco é demonstrar a aplicação das Formas Normais e a Integridade Referencial.

**Objetivos do Sistema:**
1.  **Gerenciar** o catálogo de produtos, clientes e o ciclo de vida dos pedidos.
2.  **Controlar e monitorar** os níveis de estoque em tempo real.
3.  **Analisar** o feedback dos clientes para decisões estratégicas de produtos.

---

### 📐 Modelo de Dados (DER Revisado em 2FN/3FN)

O projeto utiliza um **Modelo Lógico Normalizado**.


**Entidades Principais:**
* `CLIENTE`
* `FORNECEDOR`
* `PRODUTO`
* `PEDIDO`
* `ITEM_PEDIDO` (Entidade Associativa N:N, em 2FN estrita)
* `FEEDBACK_AVALIACAO`

---

### 💻 Tecnologias e Configuração

* **Linguagem de Definição de Dados (DDL):** SQL
* **Linguagem de Manipulação de Dados (DML):** SQL
* **Ambiente de Desenvolvimento:** MySQL Workbench ou PgAdmin.

### 📜 Instruções de Execução dos Scripts

Para replicar o banco de dados e as operações, siga a ordem de execução dos scripts:

| Arquivo SQL | Tipo de Comando | Descrição |
| :--- | :--- | :--- |
| `1_ddl_criacao_tabelas.sql` | DDL | Cria o banco de dados e todas as 6 tabelas com PKs e FKs. |
| `2_dml_insercao_dados.sql` | DML (INSERT) | Povoa as tabelas com dados coerentes para testes. |
| `3_dml_consultas_e_analise.sql` | DML (SELECT) | Contém as consultas complexas (JOIN, GROUP BY) para análise gerencial. |
| `4_dml_update_delete.sql` | DML (UPDATE/DELETE) | Comandos de manipulação para demonstração de alteração e exclusão segura. |

#### Ordem de Execução:
1.  Execute o script `1_ddl_criacao_tabelas.sql` para construir a estrutura.
2.  Execute o script `2_dml_insercao_dados.sql` para popular as tabelas.

---

### 🔎 Comandos DML Essenciais para Análise

#### Exemplo 1: Consulta (JOIN e GROUP BY)
```sql
-- Identifica os clientes de maior valor para a loja, somando o total gasto.
SELECT C.Nome_Completo, SUM(P.Valor_Total) AS GastoTotal, COUNT(P.ID_Pedido) AS TotalPedidos
FROM CLIENTE C
JOIN PEDIDO P ON C.ID_Cliente = P.ID_Cliente
GROUP BY C.ID_Cliente
ORDER BY GastoTotal DESC
LIMIT 5;
