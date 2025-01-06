--------------- PL/SQL - Tratamento de Exce��es --------------------------------


-- Tratanmento de Erro ( Divis�o Por Zero )

-- Ativandoo a visualiza��o do retorno "OUTPUT"
SET SERVEROUTPUT ON

DECLARE 
CINCO NUMBER := 5;
BEGIN
DBMS_OUTPUT.PUT_LINE(CINCO / (CINCO - CINCO));
EXCEPTION
WHEN ZERO_DIVIDE THEN
DBMS_OUTPUT.PUT_LINE('DIVIS�O POR ZERO');
WHEN OTHERS THEN 
DBMS_OUTPUT.PUT_LINE('ERRO IMPREVISTO');
END;
/
--------------------------------------------------------------------------------

-- Tratamento de exce��es com a captura e armazenamento em uma tabela de erros
CREATE TABLE ERROS(
USUARIO VARCHAR2(30),
DATA DATE,
COD_ERRO NUMBER,
MSG_ERRO VARCHAR2(100));

SET SERVEROUTPUT ON
DECLARE
COD ERROS.COD_ERRO%TYPE;
MSG ERROS.MSG_ERRO%TYPE;
CINCO NUMBER := 5;

BEGIN
DBMS_OUTPUT.PUT_LINE(CINCO / (CINCO - CINCO));
EXCEPTION 
WHEN ZERO_DIVIDE THEN
COD := SQLCODE;-- Retorna o Codigo do Erro
MSG := SUBSTR(SQLERRM, 1, 100);-- Retorna a Mensagem d Erro at� o 100� caracter
INSERT INTO ERROS
VALUES
(USER, SYSDATE, COD, MSG);
WHEN OTHERS THEN 
DBMS_OUTPUT.PUT_LINE('ERRO IMPREVISTO');
END;
/
--------------------------------------------------------------------------------
-- Nomeando tratamento de exce��es (Erro Personalizavel)
SET SERVEROUTPUT ON
DECLARE
E_MEU_ERRO EXCEPTION;
V_TESTE TABELA_TESTE%ROWTYPE;

CURSOR CURSOR_TESTE IS 
SELECT 
NOME_COLUNA, 
SALARIO_COLUNA
FROM TABELA_TESTE
WHERE SALARIO_COLUNA = 110;--

BEGIN
OPEN CURSOR_TESTE;
LOOP
FETCH CURSOR_TESTE INTO 
V_TESTE.NOME_COLUNA,
V_TESTE.SALARIO_COLUNA;

IF CURSOR_TESTE%NOTFOUND THEN
RAISE E_MEU_ERRO;
END IF;
DBMS_OUTPUT.PUT_LINE('NOME: '||V_TESTE.NOME_COLUNA);
DBMS_OUTPUT.PUT_LINE('SALARIO: '||V_TESTE.SALARIO_COLUNA);
EXIT WHEN CURSOR_TESTE%NOTFOUND;
END LOOP;
EXCEPTION 
WHEN E_MEU_ERRO THEN
DBMS_OUTPUT.PUT_LINE('CADASTRO N�O EXISTE');
ROLLBACK;
END;
/
--------------------------------------------------------------------------------



SELECT AVG(vl_salario) FROM mc_funcionario;

SELECT nm_funcionario FROM mc_funcionario WHERE vl_salario > (SELECT AVG(vl_salario) FROM mc_funcionario);















