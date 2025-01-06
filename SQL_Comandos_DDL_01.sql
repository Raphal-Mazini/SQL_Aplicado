--------------------------------------------- Exemplos de Comando DDL SQL ----------------------------------------------------------------------------------------



-- Gerando uma Nova Tabela no Bando de Dados 
CREATE TABLE Nome_Tabela(
ID_Tabela NUMERIC NOT NULL, 
Nome_Coluna VARCHAR(150),
Nome_Coluna01 CHAR(3), 
Nome_Coluna02 INT);
-- Inserindo comantario descricionarios referente a tabela especificada
COMMENT ON TABLE Nome_Tabela IS 'EXEMPLO DE COMENTÁRIO PARA A TABELA';



-- Inserindo comantarios descricionarios referente a coluna da tabela especificada
COMMENT ON COLUMN Nome_Tabela.Nome_Coluna IS 'EXEMPLO DE COMENTÁRIO DE COLUNA';




-- Alterando a coluna para uma Chave-Primeria Simples
ALTER TABLE Nome_Tabela
ADD CONSTRAINT PK_Nome_Indentificacao_PrimeraryKey_Simples
PRIMARY KEY (ID_Tabela);




-- Alterando as colunas para Chaves-Primaria(PK) Composta
ALTER TABLE Nome_Tabela
ADD CONSTRAINT PK_Nome_Identificacao_PrimaryKey_Composta
PRIMARY KEY (Nome_Coluna01, Nome_Coluna02);




-- Alterando uma coluna da tabela de interesse em uma Chave_Estrangeira(FK)
ALTER TABLE Nome_Tabela
ADD CONSTRAINT FK_Nome_Identificacao_ForeignKey
FOREIGN KEY(Nome_Coluna01)
REFERENCES Nome_Identificacao_Referencial(Nome_Coluna01);




-- Alterando para uma CONSTRAINT do tipo UNIQUE (UN)
ALTER TABLE Nome_Tabela
ADD CONSTRAINT UN_Nome_Identificacao_UNIQUE
UNIQUE (Nome_Coluna);




-- Inserindo uma condição com CHECK CONSTRAINT
ALTER TABLE Nome_Tabela
ADD CONSTRAINT CK_Nome_Identificacao_check
CHECK ( Coluna_e_Condicao_Especificada );





-- Removendo todos os dadosa da tabela de interesse
TRUNCATE TABLE Nome_Tabela;



-- Excluindo/Apagando a Tabela
DROP TABLE Nome_Tabela;




-- Excluindo uma coluna em uma tabela especifica
ALTER TABLE Nome_Tabela
DROP COLUMN Nome_Coluna02 ;



-- Adicionando uma nova coluna em uma tabela de interesse
ALTER TABLE Nome_Tabela
ADD Nome_Coluna03 varchar(20) NOT NULL;



-- Adicionando duas nova coluna em uma tabela de interesse
ALTER TABLE Nome_Tabela
ADD (Nome_Coluna04 Date, 
Nome_Coluna05 BLOB);



-- Modificando o tipo dos dados que seram permitidos na coluna de interesse
ALTER TABLE Nome_Tabela 
MODIFY Nome_Coluna04 NUMERIC;




-- Alterando a coluna de uma tabela para inserção da contição DEFAULT 
ALTER TABLE Nome_Tabela
MODIFY Nome_Coluna 
DEFAULT SYSDATE;




-- Removendo a CONSTRAINT que consta na tabela de interesse
ALTER TABLE Nome_Tabela
DROP CONSTRAINT PK_Nome_Indentificacao_PrimeraryKey_Simples;




-- Removendo a CONSTRAINT UNIQUE
ALTER TABLE Nome_Tabela
MODIFY Nome_Coluna DEFAULT NULL;



-- Renomear uma Tabela 
ALTER TABLE Nome_Tabela 
RENAME TO New_Name_Table;



-- Renomeando uma coluna na tabela
ALTER TABLE New_Name_Table
RENAME COLUMN Nome_Coluna
TO New_Name_Column;



-- Renomeando uma CONSTRAINT
ALTER TABLE NEW_NAME_TABLE
RENAME CONSTRAINT PK_Nome_Indentificacao_PrimeraryKey_Simples
TO PK_Simples_New_Name;



-- Desativar/Desabilitar CONSTRAINT
ALTER TABLE New_Name_Table
DISABLE CONSTRAINT PK_Simples_New_Name;



-- Ativando/Habilitando CONSTRAINT
ALTER TABLE New_Name_Table
ENABLE CONSTRAINT PK_Simples_New_Name;



-- Eliminando a CONSTRAINT PRIMARY KEY  e suas reações com outras entidades se houverem
ALTER TABLE New_Name_Table 
DROP CONSTRAINT PK_Simples_New_Name;