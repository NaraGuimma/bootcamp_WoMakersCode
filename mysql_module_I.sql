/* Criar database */
create database EXERCICIO;
USE EXERCICIO;

/* fazer o drop das tabelas caso existam */
DROP TABLE IF EXISTS CLIENTE;
DROP TABLE IF EXISTS PEDIDOS;

/* criar tabela de Clientes */
CREATE TABLE CLIENTE (
ID INT AUTO_INCREMENT NOT NULL,
COD_ORIGEM INT,
DATA_ORIGEM DATETIME,
NOME VARCHAR(100),
DATA_NASCIMENTO DATE,
CPF BIGINT NOT NULL,
UF VARCHAR(2),
EMAIL VARCHAR(50),
PRIMARY KEY (ID)
);

/* Criar tabela de Pedidos */
USE EXERCICIO;
CREATE TABLE PEDIDOS (
ID INT AUTO_INCREMENT NOT NULL,
ID_CLIENTE INT NOT NULL,
COD_ORIGEM INT, 
DATA_ORIGEM DATETIME,
NUMERO_PEDIDO VARCHAR(250),
VALOR_TOTAL_PEDIDO FLOAT,
DATA_PEDIDO DATE,
PRIMARY KEY (ID),
FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE(ID)
);
SELECT * FROM PEDIDOS;

DESCRIBE PEDIDOS;

/*Alterar a tabela criada incluindo um nova coluna, ou removendo-a */
ALTER TABLE PEDIDOS ADD FLAG_PROCESSAMENTO INT NOT NULL;

ALTER TABLE PEDIDOS DROP COLUMN FLAG_PROCESSAMENTO;

ALTER TABLE PEDIDOS ADD COLUMN (FLAG_PROCESSAMENTO BIT(1) NOT NULL);

/* Inserir os registros nas tabelas Cliente e Pedidos */
INSERT INTO CLIENTE (COD_ORIGEM, DATA_ORIGEM, NOME, DATA_NASCIMENTO, CPF, UF, EMAIL)
VALUES (1, NOW(), 'KIKO'                , '1988-02-09',  32145896325, 'MG', 'KIKO@GMAIL.COM'),
	   (1, NOW(), 'SEU MADRUGA'         , '1900-02-17',  21458963252, 'SP', 'SEUMADRUGA@GMAIL.COM'),
	   (1, NOW(), 'CHAVES'              , '1990-04-22',  45858963252, 'SP', 'CHAVES@HOTMAIL.COM'),
	   (1, NOW(), 'CHIQUINHA'           , '1988-01-20',  32145896325, 'MG', 'CHUIQUINHA@GMAIL.COM'),
	   (1, NOW(), 'DONA CLOTILDES'      , '1900-12-20',  21458963252, 'RJ', 'CLOTILDE@GMAIL.COM'),
	   (1, NOW(), 'DONA FLORINDA'       , '1910-07-18',  784125369,   'SP', 'FLORINDA@HOTMAIL.COM'),
	   (1, NOW(), 'POPIS'               , '1990-08-24',  210458793,   'ES', 'POPIS@HOTMAIL.COM'),
	   (1, NOW(), 'PROFESSOR GIRAFALES' , '1964-11-13',  123658964,   'PR', 'GIRRAFALES@HOTMAIL.COM'),
	   (1, NOW(), 'SENHOR BARRIGA'      , '1952-09-15',  12547869321, 'SP', 'BARRIGAS@HOTMAIL.COM');

SELECT * FROM CLIENTE;


INSERT INTO PEDIDOS (ID_CLIENTE, COD_ORIGEM, DATA_ORIGEM, NUMERO_PEDIDO, VALOR_TOTAL_PEDIDO, DATA_PEDIDO, FLAG_PROCESSAMENTO)
    VALUES (1, 1,NOW(), 2233, 23548  , '20200209', 0),
           (1, 2,NOW(), 4455, 65148  , '20190217', 0),
           (1, 1,NOW(), 2244, 23658  , '20200422', 1),
           (2, 2,NOW(), 8845, 47851  , '20200209', 0),
           (2, 3,NOW(), 3147, 36985  , '20210217', 1),
           (4, 1,NOW(), 3698, 12458  , '20200422', 0),
           (4, 1,NOW(), 3265, 23658  , '20180420', 1),
           (4, 1,NOW(), 4587, 12478  , '20200425', 0),
           (5, 1,NOW(), 1245, 23658  , '20190422', 1),
           (5, 1,NOW(), 7857, 98745  , '20200428', 1),
           (5, 1,NOW(), 5689, 32569  , '20200212', 1),
           (5, 1,NOW(), 7845, 23556  , '20210613', 1);

/* Usando o comando SELECT */
SELECT * FROM PEDIDOS;

SELECT * FROM PEDIDOS WHERE FLAG_PROCESSAMENTO = 1;

SELECT distinct ID_CLIENTE FROM PEDIDOS WHERE FLAG_PROCESSAMENTO = 1;

SELECT * FROM CLIENTE c
	WHERE NOT EXISTS 
		(SELECT * FROM PEDIDOS p WHERE c.id = p.id_cliente);
        
SELECT * FROM CLIENTE c
	WHERE EXISTS 
		(SELECT * FROM PEDIDOS p WHERE c.id = p.id_cliente);  
        
        
SELECT * FROM CLIENTE WHERE 
UF = 'MG' AND YEAR(DATA_NASCIMENTO) = 1988;   

SELECT * 
	FROM CLIENTE 
    WHERE 
		UF = 'SP' 
        OR 
        YEAR(DATA_NASCIMENTO) = 1988
	;        

/* RETORNAR TODOS OS CLIENTES COM ano de nascimento = 1900, OU que UF = PR, E que tenham feito um pedido, E  o pedido precisa ter sido processado, E ano do pedido = 2021  */
USE EXERCICIO;
/* primeira possibilidade */
SELECT * FROM CLIENTE c
	WHERE EXISTS 
		(SELECT * 
         FROM PEDIDOS p 
         WHERE (c.id = p.id_cliente 
         AND p.FLAG_PROCESSAMENTO = 1
         AND YEAR(p.DATA_PEDIDO) = 2021)) 
	AND 
		(YEAR(c.DATA_NASCIMENTO) = 1900 
		 OR c.UF = 'PR');

/* segunda possibilidade - errada, mesmo o resultado estando correto */
/* não é uma boa prática, o código precisa contar uma história */
/* a cláusula dos clientes precisa estar separada da dos pedidos */
SELECT * FROM CLIENTE c
	WHERE EXISTS 
		(SELECT * 
		 FROM PEDIDOS p 
         WHERE (c.id = p.id_cliente 
         AND p.FLAG_PROCESSAMENTO = 1 
         AND (YEAR(c.DATA_NASCIMENTO) = 1900 
			  OR c.UF = 'PR'
			 )
	     )
	);


/* usando o between com datas */

SELECT * 
	FROM CLIENTE 
    WHERE DATA_NASCIMENTO 
		BETWEEN '1988-02-09' 
        AND NOW();

/* Usando o LIKE, apenas com coluna String */
	
SELECT * 
	FROM CLIENTE 
    WHERE EMAIL LIKE '%HOTMAIL%';

SELECT * 
	FROM CLIENTE 
    WHERE EMAIL LIKE 'C%';

SELECT * 
	FROM CLIENTE 
    WHERE EMAIL LIKE '%HOTMAIL.COM';

/* Comando UPDATE */

UPDATE CLIENTE
	SET NOME = 'KIKO TESOURO'
    WHERE NOME = 'KIKO';

SELECT * 
	FROM CLIENTE 
    WHERE NOME LIKE 'P%';
    
UPDATE CLIENTE 
	SET UF = 'RJ'
    WHERE NOME LIKE 'P%';

/* EXERCÍCIO:
PARTE 1:
 Criar uma coluna na tabela de pedidos chamada forma_pagamento
 Inserir 'Cartao de Credito'  pedidos feitos em 2020
 Inserir 'A vista' pedidos feitos em 2018 ou 2019
 Inserir 'Boleto' pedidos feitos em 2021 

PARTE 2:
 selecionar apenas o nome e data de nascimento cliente que 
 realizaram pedidos pagando com cartão de credito
 que o pedido foi processado e tenha o cliente tenha um e-mail do Gmail*/

ALTER TABLE PEDIDOS ADD COLUMN (FORMA_PAGAMENTO VARCHAR(100));

DESCRIBE PEDIDOS;

UPDATE PEDIDOS 
	SET FORMA_PAGAMENTO = 'CARTÃO DE CRÉDITO' 
    WHERE YEAR(DATA_PEDIDO) = 2020;

UPDATE PEDIDOS 
SET 
    FORMA_PAGAMENTO = 'À VISTA'
WHERE
    YEAR(DATA_PEDIDO) = 2018 OR YEAR(DATA_PEDIDO) = 2019;

/* Usando o IN ao invés do OR */    
UPDATE PEDIDOS 
SET 
    FORMA_PAGAMENTO = 'À VISTA'
WHERE
    YEAR(DATA_PEDIDO) IN (2018, 2019);    

UPDATE PEDIDOS 
	SET FORMA_PAGAMENTO = 'BOLETO' 
    WHERE YEAR(DATA_PEDIDO) = 2021;

/* Verificando se todos os registros tem valores para a nova coluna FORMA_PAGAMENTO */ 
SELECT * FROM PEDIDOS WHERE FORMA_PAGAMENTO = ""; 
    
SELECT DISTINCT NOME, DATA_NASCIMENTO 
	FROM CLIENTE c   
    WHERE EXISTS (
		SELECT * 
			FROM PEDIDOS p
			WHERE (c.id = p.id_cliente 
            AND p.FORMA_PAGAMENTO = 'CARTÃO DE CRÉDITO'
            AND p.FLAG_PROCESSAMENTO =1)
		)
	AND EMAIL LIKE '%GMAIL%';
    
    

 