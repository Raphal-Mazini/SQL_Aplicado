------------------- Aplicações PL/SQL -- 02 ------------------------------------

-- Exemplo 01 >>> Introduzindo uma estrutura condicional "IF"

-- Ativa a saido do output
SET SERVEROUTPUT ON

-- Declara as variaveis de interesse
DECLARE 
V_COL1 TABELA_TESTE.SALARIO_COLUNA %TYPE;
V_TAMANHO NUMBER(8);

-- Identifica o inicio da estrutura 
BEGIN
-- Extrai apenas os dados de interesse e atribui as variaveis declaradas
SELECT LENGTH(SALARIO_COLUNA), SALARIO_COLUNA
INTO V_TAMANHO, V_COL1
FROM TABELA_TESTE
WHERE CD_TABELA =1; 

-- Implica uma condicionante
IF V_TAMANHO < 25 THEN
-- Comando do output e a saida editada
DBMS_OUTPUT.PUT_LINE('TEXTO = '|| V_COL1||' >>> TAMANHO = '||V_TAMANHO);
-- Identifica o final da condicionante
END IF;
-- identifica o final da estrutura
END;
/
--------------------------------------------------------------------------------

-- Exemplo 02 >>> Intruduzindo uma estrutura condicional "IF" e "ELSE"

-- Ativa a saido do output
SET SERVEROUTPUT ON

-- Declara as variaveis de interesse
DECLARE
V_COL1 TABELA_TESTE.NOME_COLUNA %TYPE;
V_TAMANHO NUMBER(3);

-- Identifica o inicio da estrutura 
BEGIN 
-- Extrai apenas os dados de interesse e atribui as variaveis declaradas
SELECT LENGTH(NOME_COLUNA), NOME_COLUNA
INTO V_TAMANHO, V_COL1
FROM TABELA_TESTE
WHERE CD_TABELA =1;

-- Implica uma condicionante
IF V_TAMANHO <= 4 THEN
-- Comando do output e a saida editada
DBMS_OUTPUT.PUT_LINE('TEXTO = '|| V_COL1);
ELSE
-- Comando do output e a saida editada
DBMS_OUTPUT.PUT_LINE('MAIOR QUE 5 '||' TAMANHO '||V_TAMANHO);
-- Identifica o final da condicionante
END IF;
-- identifica o final da estrutura
END;
/
--------------------------------------------------------------------------------

-- Exemplo 03 >>> Estabelecendo multiplas condiçoes e um output
SET SERVEROUTPUT ON
DECLARE
V_COL1 TABELA_TESTE.NOME_COLUNA %TYPE;
V_TAMANHO NUMBER(3);
BEGIN
SELECT LENGTH(NOME_COLUNA), NOME_COLUNA
INTO V_TAMANHO, V_COL1
FROM TABELA_TESTE
WHERE CD_TABELA = 1;

IF V_TAMANHO >= 8 THEN
DBMS_OUTPUT.PUT_LINE('TEXTO 8 OU + = '||V_COL1||' TAMANHO = '||V_TAMANHO);

ELSIF V_TAMANHO <=6 THEN
DBMS_OUTPUT.PUT_LINE('TEXTO 6 OU - = '||V_COL1||' TAMANHO = '||V_TAMANHO);

ELSIF V_TAMANHO <=4 THEN
DBMS_OUTPUT.PUT_LINE('TEXTO 4 OU - = '||V_COL1||' TAMANHO = '||V_TAMANHO);
END IF;
END;
/
--------------------------------------------------------------------------------

-- Exemplo 04 >>> Inserção de uma estrutura condicionante compostas IMPOSITIVA
SET SERVEROUTPUT ON
DECLARE
V_DATA TABELA_TESTE.DATA_COLUNA_01 %TYPE;
V_TAMANHO NUMBER(3);
BEGIN
SELECT LENGTH(NOME_COLUNA), DATA_COLUNA_01
INTO V_TAMANHO, V_DATA FROM TABELA_TESTE WHERE CD_TABELA = 5;
IF V_TAMANHO >= 5 AND TO_CHAR(V_DATA, 'YYYY') <= 2005 THEN
DBMS_OUTPUT.PUT_LINE('TAMANHO = '||V_TAMANHO||' >>> ANO = '||TO_CHAR(V_DATA, 'YYYY'));
END IF;
END;
/
--------------------------------------------------------------------------------

-- Exemplo 05 >>> Inserção de uma estrutura condicionante compostas OPTATIVA
SET SERVEROUTPUT ON
DECLARE
V_DATA TABELA_TESTE_02.DATA_COLUNA_02 %TYPE;
V_TAMANHO NUMBER(3);
BEGIN
SELECT LENGTH(NOME_COLUNA), DATA_COLUNA_02
INTO V_TAMANHO, V_DATA FROM TABELA_TESTE_02 WHERE CD_TABELA = 2;
IF V_TAMANHO <= 5 OR TO_CHAR(V_DATA, 'YYYY') >= 2007 THEN
DBMS_OUTPUT.PUT_LINE('ANO = '||TO_CHAR(V_DATA, 'YYYY')||' >>> TOTAL DE BYTES = '||V_TAMANHO);
ELSE
DBMS_OUTPUT.PUT_LINE('MAIOR QUE 5 = '||V_TAMANHO||' >>> ANO = '||TO_CHAR(V_DATA,'YYYY'));
END IF;
END;
/
--------------------------------------------------------------------------------

-- Exemplo 06 >>> Gerando uma estrutura de repetição simples

-- Declara as variaveis de interesse
DECLARE
V_CONTADOR NUMBER(2) := 1;

-- Identifica o inicio de toda a estrutura 
BEGIN 
-- Inicia a estrutura do looping
LOOP
-- Inserindo novos dados de modo automatizado
INSERT INTO TABELA_01
VALUES('NOVO_DADO_'||V_CONTADOR);
-- Gerando uma contagem
V_CONTADOR := V_CONTADOR + 1;
-- Identificando o ponto final da condicionante do looping
EXIT WHEN V_CONTADOR >= 20;
-- Identificando o final da estrutura do looping
END LOOP;
--Identificando o final de toda a estrutura
END;
/
--------------------------------------------------------------------------------

-- Exemplo 07 >>> Gerando uma estrutura de repetição condicionante com "FOR"

-- Indica o inicio de toda a estrutura
BEGIN

-- Indica o incio da estrutura do looping "FOR"
FOR I IN 1..10 LOOP
-- Inserindo dados referenciados na instrução SQL
INSERT INTO TABELA_01
VALUES('Nova_Insercao_'||i);
-- Indica o final da estrutura do looping "FOR"
END LOOP;
-- Indica o final de toda a estrutura
END;
/
--------------------------------------------------------------------------------

-- Exemplo 08 >>> Gerando uma estrutura de repetição condicionante com "WHILE"

-- Declarando a varivel de interesse
DECLARE
V_CONTADOR TABELA_01.COLUNA_01 %TYPE := 1;

-- Indica o inicio de toda a estrutura
BEGIN
-- Indica o incio da estrutura de repetição "WHILE"
WHILE V_CONTADOR <= 10 LOOP
-- Inserindo dados referenciados na instrução SQL
INSERT INTO TABELA_01
VALUES('Dados_Teste_'||V_CONTADOR);
-- Gerando um contador de looping
V_CONTADOR := V_CONTADOR + 1;
-- Indica o final da estrutura de repetição "WHILE"
END LOOP;
-- Indica o final de toda a estrutura
END;
/
--------------------------------------------------------------------------------

-- Exemplo 09 >>> Gerando uma estrutura de repetição "WHILE" com condicionante Booleano

-- Declarando variavel de interesse
DECLARE
V_BOO BOOLEAN := TRUE;
V_REGISTRO TABELA_01.COLUNA_01 %TYPE;

-- Indica o inicio de toda a estrutura
BEGIN
-- Indica o inicio da estrutura de repetição "WHILE"
WHILE V_BOO = TRUE LOOP
-- Inserindo dados referenciados na instrução SQL
INSERT INTO TABELA_01
VALUES('DADOS_WHILE_TRUE');
-- Extraindo dados da tabela e atribuindo a variavel
SELECT COUNT(*)
INTO V_REGISTRO
FROM TABELA_01;
-- Impondo Clausula condicionante para fim da repetição "WHILE"
IF V_REGISTRO = 35 THEN
-- Conseguencia da clausula condionante 
V_BOO := FALSE;
-- Indica o final da estrutura condicionante
END IF;
-- Indica o final da estrutura de repetição "WHILE"
END LOOP;
-- Indica o final de toda a estrutura
END;
/
--------------------------------------------------------------------------------

-- Exemplo 10 >>> Gerando uma estrutura de repetição "FOR" composto(Aninhado)

-- Indica o inicio de toda a estrutura
BEGIN
-- Indica o inicio da primeira estrutura de repetição "FOR"
FOR i IN 1..3 LOOP
-- Indica o inicio da segunda estrutura de repetição "FOR"
FOR j IN 1..5 LOOP
-- Inserindo dados referenciados na instrução SQL
INSERT INTO TABELA_01
VALUES('FOR_DADOS_FOR_'||i||'_'||j);
-- Indica o final da primeira estrutura de repetição "FOR"
END LOOP;
-- Indica o final da segunda estrutura de repetição "FOR"
END LOOP;
-- Indica o final de toda a estrutura 
END;
/
--------------------------------------------------------------------------------



