------------------- Aplica��es PL/SQL -- 03 ------------------------------------

-- Exemplo 01 >>> Gerando um OUTPUT multivariado

-- Ativando o gerador OUTPUT
SET SERVEROUTPUT ON

-- Declarando a variavel MULTIVARIADA
DECLARE
V_TESTE_01 TABELA_TESTE_02 %ROWTYPE;

-- Indica o inicio de toda a estrutura
BEGIN
-- Extraindo dados referenciado na instru��o SQL
SELECT *  INTO V_TESTE_01
FROM TABELA_TESTE_02
WHERE CD_TABELA = 1;
-- Instanciando objeto OUTPUT
DBMS_OUTPUT.PUT_LINE('NOME = '||V_TESTE_01.NOME_COLUNA);
DBMS_OUTPUT.PUT_LINE('DATA_INICIO = '||V_TESTE_01.DATA_COLUNA_01);
DBMS_OUTPUT.PUT_LINE('DATA_TERMINO = '||V_TESTE_01.DATA_COLUNA_02);
-- Indica o final de toda a estrutura
END;
/
--------------------------------------------------------------------------------

-- Exemplo 02 >>> Gerando um CURSOR com remo��o de multiplas linha e OUTPUT

-- Ativa a visualiza��o da saida gerada pela fun��o OUTPUT
SET SERVEROUTPUT ON

-- Indica o inicio de toda a estrutura
BEGIN
-- Indica o filtro aplicado a remo��o das linhas e que est� armazenado no CURSOR
DELETE FROM TABELA_01
WHERE LENGTH(COLUNA_01) <= 11;
-- Indica a fun��o OUTPUT e a respectiva saida de interesse no CURSOR    
DBMS_OUTPUT.PUT_LINE('Total de Linhas Removidas = '|| SQL%ROWCOUNT);
-- Indica o final de toda a estrutura
END;
/
--------------------------------------------------------------------------------

-- Exemplo 03 >>> Gerando um CURSOR para extrair informa��es armazenadas

-- Ativa a visualiza��o da saida gerada pela fun��o OUTPUT
SET SERVEROUTPUT ON

-- Indica a inicializa��o de toda a estrutura
BEGIN 
-- Instru��es SQL para armazenamento no CURSOR das linhas para a removo��o
DELETE FROM TABELA_01
WHERE LENGTH(COLUNA_01) >= 15;
-- Aplica��o do fun��o OUTPUT e visualizando a sa�da do comando "SQL%ROWCOUNT"
DBMS_OUTPUT.PUT_LINE('Total de Linhas Removidas = '||SQL%ROWCOUNT);
-- Aplicando uma condicionante sobre a fun��o OUTPUT com o comando "SQL%FOUND"
IF SQL%FOUND = TRUE THEN
DBMS_OUTPUT.PUT_LINE('Linhas Encontradas');
ELSE
DBMS_OUTPUT.PUT_LINE('Linhas N�o Encontradas');
END IF;
ROLLBACK;
END;
/
--------------------------------------------------------------------------------

-- Exemplo 04 >>> Gerando um CURSOR explicito para agrupamento dos dados

-- Declarando a fun��o CURSOR
DECLARE
-- Explicitando o CURSOR na declara��o
CURSOR EXEMPLO_CURSOR IS
-- Instru��o SQL que compoe a fun��o CURSOR
SELECT NOME_COLUNA, SUM(SALARIO_COLUNA)
FROM TABELA_TESTE
GROUP BY NOME_COLUNA;
-- Indica o inicio de toda a estrututa
BEGIN
-- Ativa a Abertura o CURSOR para a instru��o SQL ser aplicada aos dados
OPEN EXEMPLO_CURSOR;
-- Indica o final de toda a estrutura
END;
/
--------------------------------------------------------------------------------
-- Exemplo 05 >>> Criando um CURSOR explicito com multiplos "OUTPUTs" aplicando "LOOP FOR" 

-- Ativa o retorno da saida da fun��o OUTPUT
SET SERVEROUTPUT ON
-- Declara as variaveis de interesse
DECLARE
-- Instancia as variaveis
V_CLI MC_CLIENTE %ROWTYPE;
V_EST MC_ESTADO %ROWTYPE;
V_PROD MC_PRODUTO %ROWTYPE;
V_SAC MC_SGV_SAC %ROWTYPE;
-- Define uma fun��o explicita do CURSOR
CURSOR CLI_OCORRENCIA_SAC IS
-- Aplica a filtragem dos dados ap�s a jun��o das tabelas de interesse
SELECT 
CLI.NR_CLIENTE, CLI.NM_CLIENTE,
PROD.CD_PRODUTO, PROD.DS_PRODUTO,
PROD.VL_PERC_LUCRO, PROD.VL_UNITARIO,
SAC.NR_SAC, SAC.DT_ABERTURA_SAC,
SAC.HR_ABERTURA_SAC, SAC.TP_SAC,
EST.SG_ESTADO, EST.NM_ESTADO
-- Guarda os dados os respectivos nas variaveis declaradas
INTO 
V_CLI.NR_CLIENTE, 
V_CLI.NM_CLIENTE,
V_PROD.CD_PRODUTO,
V_PROD.DS_PRODUTO,
V_PROD.VL_PERC_LUCRO,
V_PROD.VL_UNITARIO,
V_SAC.NR_SAC,
V_SAC.DT_ABERTURA_SAC,
V_SAC.HR_ABERTURA_SAC,
V_SAC.TP_SAC,
V_EST.SG_ESTADO,
V_EST.NM_ESTADO
-- Aplica a jun��o das tabelas de interesse
FROM MC_ESTADO EST
INNER JOIN MC_CIDADE CID ON (EST.SG_ESTADO = CID.SG_ESTADO)
INNER JOIN MC_BAIRRO BAR ON (BAR.CD_CIDADE = CID.CD_CIDADE)
INNER JOIN MC_LOGRADOURO LOGR ON (LOGR.CD_BAIRRO = BAR.CD_BAIRRO)
INNER JOIN MC_END_CLI ENDCLI ON (LOGR.CD_LOGRADOURO = ENDCLI.CD_LOGRADOURO_CLI)
INNER JOIN MC_CLIENTE CLI ON (CLI.NR_CLIENTE = ENDCLI.NR_CLIENTE)
INNER JOIN MC_SGV_SAC SAC ON (SAC.NR_CLIENTE = CLI.NR_CLIENTE)
INNER JOIN MC_PRODUTO PROD ON (PROD.CD_PRODUTO = SAC.CD_PRODUTO);
-- Identifica o inicia de toda a estrutura��o
BEGIN
-- Define o inicio de uma estrutura de repeti��o "FOR"
FOR VAR_TEMP IN CLI_OCORRENCIA_SAC LOOP
-- Aplica a fun��o OUTPUT e retorna a saida antes ativada
DBMS_OUTPUT.PUT_LINE('N� DA OCORRENCIA SAC = '||VAR_TEMP.NR_SAC);
DBMS_OUTPUT.PUT_LINE('DATA DA ABERTURA DA OCORRENCIA SAC = '||VAR_TEMP.DT_ABERTURA_SAC);
DBMS_OUTPUT.PUT_LINE('HORA DA ABERTURA DA OCORRENCIA SAC = '||VAR_TEMP.HR_ABERTURA_SAC||'H');
DBMS_OUTPUT.PUT_LINE('TIPO DE OCORRENCIA SAC = '||VAR_TEMP.TP_SAC);
DBMS_OUTPUT.PUT_LINE('CODIGO DE IDENTIFICA��O DO PRODUTO = '||VAR_TEMP.CD_PRODUTO);
DBMS_OUTPUT.PUT_LINE('DESCRI��O DO PRODUTO = '||VAR_TEMP.DS_PRODUTO);
DBMS_OUTPUT.PUT_LINE('VALOR/UNID. = '||VAR_TEMP.VL_UNITARIO);
DBMS_OUTPUT.PUT_LINE('VALOR PERCENTUAL DE LUCRO DO PRODUTO = '||VAR_TEMP.VL_PERC_LUCRO||'%');
DBMS_OUTPUT.PUT_LINE('NOME DO CLIENTE = '||VAR_TEMP.NM_CLIENTE);
DBMS_OUTPUT.PUT_LINE('N� DO CLIENTE = '||VAR_TEMP.NR_CLIENTE);
-- Identifica o ponto final da estrutura de repeti��o "FOR"
END LOOP;
-- Identifica o ponto final de toda a estrutura
END;
/
--------------------------------------------------------------------------------







