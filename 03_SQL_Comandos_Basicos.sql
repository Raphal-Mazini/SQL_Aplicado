------------------------------------------ Comandos, Restrições e Cláusulas de Condições ----------------------------------------------------------------------------------------------------------------------

DROP TABLE TABELA_TESTE;
DROP TABLE TABELA_TESTE_02;
DROP SEQUENCE NOME_SEQUENCIA_01;
DROP SEQUENCE NOME_SEQUENCIA_02;
COMMIT;

-- Criando uma SEQUENCE para inserção na tabela de exemplificação 
CREATE SEQUENCE NOME_SEQUENCIA_01
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE
NOMAXVALUE
ORDER;


-- Criando uma SEQUENCE para inserção na tabela de exemplificação 
CREATE SEQUENCE NOME_SEQUENCIA_02
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE
NOMAXVALUE
ORDER;



-- Gerando tabela para exemplificação
CREATE TABLE TABELA_TESTE(
CD_TABELA NUMBER DEFAULT NOME_SEQUENCIA_01.NEXTVAL NOT NULL,
NOME_COLUNA VARCHAR(60) NOT NULL,
DATA_COLUNA_01 DATE NOT NULL,
DATA_COLUNA_02 DATE NULL);



-- Identificando a chave-primaria na tabela de exemplificação
ALTER TABLE TABELA_TESTE 
ADD CONSTRAINT PK_TABELA_TESTE
PRIMARY KEY(CD_TABELA);



-- Gerando tabela para exemplificação
CREATE TABLE TABELA_TESTE_02(
CD_TABELA INT PRIMARY KEY NOT NULL,
NOME_COLUNA VARCHAR(50) NOT NULL,
DATA_COLUNA_01 DATE NOT NULL,
DATA_COLUNA_02 DATE);




-- Inserindo dados na tabela 
INSERT INTO TABELA_TESTE(
 NOME_COLUNA, DATA_COLUNA_01, DATA_COLUNA_02) 
VALUES 
( 'TESTE_01', TO_DATE('06/09/2000', 'DD/MM/YYYY' ),
              TO_DATE('05/10/2002', 'DD/MM/YYYY' ));



-- Inserindo dados na tabela 
INSERT INTO TABELA_TESTE_02(
CD_TABELA, NOME_COLUNA, DATA_COLUNA_01, DATA_COLUNA_02) 
VALUES (NOME_SEQUENCIA_02.NEXTVAL,'TESTE_02', TO_DATE('06/09/2000', 'DD/MM/YYYY' ),
                                              TO_DATE('05/10/2002', 'DD/MM/YYYY' )); 
                    


-- Exportando uma copia dos dados da "TABELA_TESTE" para outra tabela "TABELA_TESTE_02"
-- Porém, irá inserir os dados a partir da continuidade da sequencia, entretanto, somente os dados não nulos na coluna data_coluna 
INSERT INTO TABELA_TESTE_02(
CD_TABELA, NOME_COLUNA, DATA_COLUNA_01, DATA_COLUNA_02)
(SELECT NOME_SEQUENCIA_01.NEXTVAL,'TESTE', DATA_COLUNA_01, DATA_COLUNA_02 
FROM TABELA_TESTE WHERE DATA_COLUNA_02 IS NOT NULL );



-- Atualizando dados de uma coluna
UPDATE TABELA_TESTE_02
SET 
NOME_COLUNA = 'TESTAR_0101',
DATA_COLUNA_01 = TO_DATE('18/05/1985','DD/MM/YYYY')
WHERE CD_TABELA = 2;

-- Inserindo a coluna salario
ALTER TABLE TABELA_TESTE
ADD SALARIO_COLUNA DECIMAL(8,2);


-- Atualizando a coluna salario_coluna
UPDATE TABELA_TESTE
SET
SALARIO_COLUNA = 1850.25;

-- Atualizando valor da coluna salario_coluna
UPDATE TABELA_TESTE
SET
SALARIO_COLUNA = SALARIO_COLUNA * 1.5
WHERE 
CD_TABELA = 1;

COMMIT;


