----------------- APLICAÇÕES PL/SQL -- 01 --------------------------------------


--------------- Exemplo_01 >>> Gerando um OUTPUT

-- ACIONANDO FUNÇÃO OUTPUT
SET SERVEROUTPUT ON 

-- Declarando a variavel "V_TESTE"
DECLARE 
V_TESTE VARCHAR2(30) := 'Hello World'; 
BEGIN 
DBMS_OUTPUT.PUT_LINE(V_TESTE);
END;
--------------------------------------------------------------------------------


---------- Exemplo_02 >>> Atribuindo dados a varivel declarada e gerando output

-- ACIONANDO FUNÇÃO OUTPUT
SET SERVEROUTPUT ON 

-- Declarando uma variavel
DECLARE V_TESTE02 NUMBER(7,2);
BEGIN

-- Extraindo os dados da coluna e atribuindo a variavel declarada e output
SELECT SAL
INTO V_TESTE02 
FROM EMP
WHERE EMPNO = 7369 ;
DBMS_OUTPUT.PUT_LINE(V_TESTE02);
END;
--------------------------------------------------------------------------------


---- Exemplo 03 >>> Declarando variavei, somando dados e concatenando informação

-- ACIONANDO FUNÇÃO OUTPUT
SET SERVEROUTPUT ON 

--Gerando as variaveis
DECLARE 
V_SOMA_SAL NUMBER;
V_DEPTO NUMBER NOT NULL := 10;
-- Iniciando o bloco
BEGIN
SELECT SUM(SAL)
INTO V_SOMA_SAL
FROM EMP
WHERE DEPTNO = V_DEPTO;
DBMS_OUTPUT.PUT_LINE('Soma dos sal. '||V_SOMA_SAL||' do departamento '||V_DEPTO);
END;
--------------------------------------------------------------------------------


------------- Exemplo 04 >>> Inserir Dados com PL/SQL
DECLARE 
V_EMPNO NUMBER := 11;
V_ENAME VARCHAR2(13) := 'SANDRA';
V_JOB VARCHAR2(13) := 'GERENTE';
V_DEPTNO NUMBER := 10;
BEGIN
INSERT INTO 
EMP(EMPNO, ENAME, JOB, DEPTNO)
VALUES(V_EMPNO, V_ENAME, V_JOB, V_DEPTNO);
END;
--------------------------------------------------------------------------------

------ Exemplo 05 >>> Atualizando dados com PL/SQL
DECLARE
V_SAL_INCREASE NUMBER := 2000;
BEGIN 
UPDATE EMP
SET
SAL = SAL + V_SAL_INCREASE
WHERE
JOB = 'ANALYST';
END;
--------------------------------------------------------------------------------

---- Exemplo 06 >>> Deletar dados atribuidos a varivel 

DECLARE 
V_DEPTNO NUMBER := 10;
BEGIN
DELETE FROM EMP
WHERE DEPTNO = V_DEPTNO;
END;
--------------------------------------------------------------------------------

--- Exemplo 07 >>> Acoplar tratamento de exceões a instrução SQL

BEGIN 
INSERT INTO DEPT
VALUES('A','A','A');
COMMIT;
EXCEPTION
WHEN OTHERS THEN ROLLBACK;
END;
-- "When Others Then" é uma instrução SQL que trata qualquer erro 
-- que não seja tratado por outras instruções
--------------------------------------------------------------------------------

-- Exemplo 08 >>> Gerando variavel compativel por meio do comando "%TYPE" 
SET SERVEROUTPUT ON
DECLARE 
V_COL1 TABELA_TESTE.SALARIO_COLUNA %TYPE;
BEGIN
SELECT SALARIO_COLUNA 
INTO V_COL1
FROM TABELA_TESTE
WHERE CD_TABELA = 1;
DBMS_OUTPUT.PUT_LINE('Valor = '||V_COL1);
END;
/
--------------------------------------------------------------------------------