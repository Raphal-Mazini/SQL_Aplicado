------------------------------------------------------------------------------ CONSULTAS E FILTROS SQL ----------------------------------------------------------------

-- Consultar todos os dados distintos, sem repetição
SELECT DISTINCT NOME_COLUNA FROM TABELA_TESTE;


-- Filtrando da tabela "TABELA_TESTE" somente as colunas "NOME_COLUNA" e "SALARIO_COLUNA"
-- Após o filtro aplicar um aumento de 15% no valor referente ao salario na coluna "SALARIO_COLUNA" 
SELECT 
NOME_COLUNA, 
SALARIO_COLUNA "Valor_Mensal", 
SALARIO_COLUNA * 1.15 AS "Reajuste_de_Salario"
FROM 
TABELA_TESTE ;



-- Apartir da tabela "TABELA_TESTE", retornar somente os valores colunas "SALARIO_COLUNA" E "NOME_COLUNA",
-- ordenando os valores de maneira CRESCENTE tomando comom referencia a coluna "SALARIO_COLUNA"
SELECT SALARIO_COLUNA, NOME_COLUNA
FROM TABELA_TESTE
ORDER BY SALARIO_COLUNA;



-- Apartir da tabela "TABELA_TESTE", retornar somente os valores colunas "SALARIO_COLUNA" E "NOME_COLUNA",
-- ordenando os valores de maneira DECRESCENTE tomando comom referencia a coluna "SALARIO_COLUNA"
SELECT SALARIO_COLUNA, NOME_COLUNA
FROM TABELA_TESTE
ORDER BY SALARIO_COLUNA DESC;



-- Apartir da tabela "TABELA_TESTE", consultar somente os valores das colunas NOME_COLUNA, SALARIO_COLUNA e DATA_COLUNA_01
-- mas retornar os valores ordenados de maneira CRESCENTE tomando como referencia a coluna na posição 2 na consulta SQL
-- e ordenar os valores de modo decrescente a coluna na posição 3 na consulta SQL
SELECT NOME_COLUNA, SALARIO_COLUNA, DATA_COLUNA_01
FROM TABELA_TESTE
ORDER BY 2 ASC, 3 DESC;



-- Filtrando de uma tabela dados que sejam iguais ao especificado pela condição imposta
-- A condição imposta determina um interesse em um grupo de caracteres de texto
SELECT * FROM TABELA_TESTE
WHERE NOME_COLUNA = 'TESTE';



-- -- Filtrando de uma tabela, dados que, sejam iguais ao especificado pela condição imposta.
-- A condição imposta determina um grupo de caracteres de texto especifico
-- A clausula UPPER ou LOWER identifica o formato dos caracteres de texto
SELECT * FROM TABELA_TESTE
WHERE LOWER(NOME_COLUNA) = 'teste';



-- Filtrando por meio da imposição da condição de data especificada
SELECT * FROM TABELA_TESTE
WHERE DATA_COLUNA_02 < TO_DATE('05/05/2008','DD/MM/YYYY');



-- Filtrando dados a partir de uma data especifica, 
-- e que estes, sejam dados do interesse especificado, e dentro do periodo de data imposto pela condição.
SELECT * FROM TABELA_TESTE
WHERE DATA_COLUNA_01 < TO_DATE('01/01/2010','DD/MM/YYYY')
AND UPPER(NOME_COLUNA) = 'TESTE_03';



-- Filtrando dados a partir de uma data especifica ou sendo dados do interesse especificado.
-- Ao atender a qualquer uma das condições imposta o filtro se torna verdadeiro.
SELECT * FROM TABELA_TESTE
WHERE UPPER(NOME_COLUNA) = 'TESTE'
OR SALARIO_COLUNA < 3500;



-- Filtrar dados de acordo com um determinado intervalo de valor contindos uma coluna especifica
SELECT * FROM TABELA_TESTE
WHERE SALARIO_COLUNA BETWEEN 800 AND 2500;



-- Consultar na tabela se estão contidos certos dados de interesse
SELECT * FROM TABELA_TESTE_02
WHERE NOME_COLUNA IN ('TESTAR_0101', 'TESTE_02');



-- Consultar na tabela os dados que não estão contidos em uma determinada coluna de interesse
SELECT * FROM TABELA_TESTE_02
WHERE NOME_COLUNA NOT IN ('TESTAR_0101', 'TESTE_02');



-- Consultar em uma tabela a existencia de uma data anual especifica
-- A data anual será transformada em caracter de texto com "TO_CHAR()"
SELECT * FROM TABELA_TESTE_02
WHERE TO_CHAR(DATA_COLUNA_01, 'YYYY') 
IN ('1985', '2005');



-- Consultar em uma determinada tabela todos os dados,
-- mas somente os dados onde existam valores NÃO NULOS em uma coluna de interesse.
SELECT * FROM TABELA_TESTE
WHERE SALARIO_COLUNA IS NOT NULL;



-- Consultar em uma determinada tabela todos os dados,
-- mas somente os dados onde existam valores NULOS em uma coluna de interesse.
SELECT * FROM TABELA_TESTE
WHERE SALARIO_COLUNA IS NULL;



-- Filtrar dados que se INICIEM ou TERMINAM com uma determinada caracteristica em especifico
SELECT * FROM MC_FUNCIONARIO
WHERE DS_CARGO LIKE '%Financeiro%';



-- Filtrar dados que TERMINEM com uma determinada caracteristica em especifico
SELECT * FROM MC_FUNCIONARIO
WHERE NM_FUNCIONARIO LIKE '%-Hannigan';



-- Filtrar dados que se iniciem por um conjunto de caracteres, e que, 
-- como SEGUNDA LETRA no conjunto de caratcteres seja a vogal "a"
SELECT * FROM MC_FUNCIONARIO
WHERE UPPER (NM_FUNCIONARIO) LIKE '_A%';



-- Filtrar dados que se iniciem por um conjunto de caracteres, e que, 
-- como TERCEIRA LETRA no conjunto de caratcteres seja a consoante "M"
SELECT * FROM MC_FUNCIONARIO
WHERE UPPER (NM_FUNCIONARIO) LIKE '__M%';



-- Filtar dados que estejam em um determinado intervalo de data
-- e que estejam acima de determinado valor, e que, não seja um certo dados  em especifico
-- caso este esteja dentro do conjunto de dados retornado pelo filtro imposto.
SELECT * FROM MC_FUNCIONARIO
WHERE DT_NASCIMENTO BETWEEN
TO_DATE('01/01/1980','DD/MM/YYYY') AND TO_DATE('01/01/2020','DD/MM/YYYY')
AND VL_SALARIO >= 850.25 
AND NOT CD_FUNCIONARIO = 3;



-- Concatenando palavras ou texto com os dados existentes na tabela
-- o proposito É extrair informação dos dados por meio da contextualização
-- Obtendo a informação sobre quanto cada funcionario ganha.
SELECT 
'O Funcionario ' || NM_FUNCIONARIO ||
' Possui um Salario de R$ '|| VL_SALARIO
"Funcionario Salario"
FROM MC_FUNCIONARIO;



-- Concatenando palavras ou texto com os dados existentes na tabela.
-- o proposito a entrair informação dos dados por meio da contextualização.
-- Obtendo informação sobre a duração de um periodo de acordo com a coluna DT_CADASTRAMENTO existente na tabela ate hoje.
SELECT 
NM_FUNCIONARIO,
DS_CARGO,
DT_CADASTRAMENTO,
('TEMPO DE DURACAO ' || TO_CHAR(SYSDATE - DT_CADASTRAMENTO) || ' DIAS ' )"TEMPO DE DURACAO" 
FROM MC_FUNCIONARIO WHERE DT_CADASTRAMENTO IS NOT NULL ORDER BY "TEMPO DE DURACAO" DESC;


-- Consulta utlizando uma pseudo coluna ROWNUM
SELECT 
ROWNUM,
CD_DEPTO, 
NM_FUNCIONARIO,
VL_SALARIO
FROM MC_FUNCIONARIO;



-- Consulta de dados limitando a quantidade de registros em 3 linhas
SELECT * FROM MC_FUNCIONARIO
WHERE ROWNUM < 4;



-- Filtrar dados por meio da Analise Top-N e limitando com a 4 registros "ROWNUM e RANK". 
-- Em primeiro plano a consulta irá criar um rank há enumrando os dados contidos nas colunas.
-- O segundo plano faz com que o rank seja ordenado de ordem decrescente a partir das mesmas colunas selecionadas no primeiro plano.
-- Será ao final, retornado somente as 3 primeiras linhas.
SELECT ROWNUM AS RANK,
NM_FUNCIONARIO,
VL_SALARIO
FROM
(SELECT 
NM_FUNCIONARIO,
VL_SALARIO
FROM MC_FUNCIONARIO
ORDER BY VL_SALARIO DESC)
WHERE ROWNUM <= 3;


-- Visualizar todas as configurações referente aos parametros que compõem o banco de dados
SELECT * FROM V$NLS_PARAMETERS;   



-- Reconfigurando o formato de exibição da data dia, mes e ano.
ALTER SESSION SET
NLS_DATE_FORMAT = 'DD/MM/YYYY';



-- Visualizando o mes atual por extenso e a data atual do sistema 
SELECT 
SYSDATE "DATA DE HOJE",
TO_CHAR(SYSDATE, 'MONTH') "MÊS CORRENTE"
FROM DUAL;


