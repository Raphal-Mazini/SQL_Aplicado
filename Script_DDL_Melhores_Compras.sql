-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Projeto_Melhores_Compras_SGV
-- -----------------------------------------------------
-- Modelo Logico banco de dados relacional empresa ecommerce "Melhores Compras"

-- -----------------------------------------------------
-- Schema Projeto_Melhores_Compras_SGV
--
-- Modelo Logico banco de dados relacional empresa ecommerce "Melhores Compras"
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Projeto_Melhores_Compras_SGV` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `Projeto_Melhores_Compras_SGV` ;

-- -----------------------------------------------------
-- Table `Projeto_Melhores_Compras_SGV`.`MC_ESTADO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Projeto_Melhores_Compras_SGV`.`MC_ESTADO` (
  `ID_ESTADO` INT NOT NULL AUTO_INCREMENT COMMENT 'Está coluna informa o numero serial a qual identifica o estado no sistema desta tabela(Informação de carater obrigatorio',
  `NM_ESTADO` VARCHAR(200) NOT NULL COMMENT 'Esta coluna informa o nome do estado',
  `SG_ESTADO` CHAR(2) NOT NULL COMMENT 'Esta coluna informa a sigla a qual representa o estado',
  PRIMARY KEY (`ID_ESTADO`),
  UNIQUE INDEX `NM_ESTADO_UNIQUE` (`NM_ESTADO` ASC) VISIBLE,
  UNIQUE INDEX `SG_ESTADO_UNIQUE` (`SG_ESTADO` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Projeto_Melhores_Compras_SGV`.`MC_CIDADE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Projeto_Melhores_Compras_SGV`.`MC_CIDADE` (
  `ID_CIDADE` INT NOT NULL AUTO_INCREMENT COMMENT 'Está coluna informa o numero serial a qual identifica a cidade no sistema desta tabela(Informação de carater obrigatorio',
  `NM_CIDADE` VARCHAR(200) NOT NULL COMMENT 'Esta coluna ira receber o nome da Cidade. Esse conteúdo é obrigatório.',
  `CD_IBGE` INT(8) NULL COMMENT 'Esta coluna irá receber o código do IBGE que fornece informações para geração da NFe(Informação de caracter opcional)',
  `NM_DDD` INT(3) NULL COMMENT 'Esta coluna irá receber o número do DDD da cidade para ser utilizado no contato telefônico. Seu conteudo é opcional.',
  `ID_CIDADE_ESTADO` INT NOT NULL,
  PRIMARY KEY (`ID_CIDADE`),
  INDEX `fk_MC_CIDADE_ESTADO_idx` (`ID_CIDADE_ESTADO` ASC) VISIBLE,
  CONSTRAINT `fk_MC_CIDADE_ESTADO`
    FOREIGN KEY (`ID_CIDADE_ESTADO`)
    REFERENCES `Projeto_Melhores_Compras_SGV`.`MC_ESTADO` (`ID_ESTADO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Projeto_Melhores_Compras_SGV`.`MC_BAIRRO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Projeto_Melhores_Compras_SGV`.`MC_BAIRRO` (
  `ID_BAIRRO` INT NOT NULL AUTO_INCREMENT COMMENT 'Está coluna informa o numero serial a qual identifica O bairro no sistema desta tabela(Informação de carater obrigatorio)',
  `NM_BAIRRO` VARCHAR(200) NOT NULL COMMENT 'Esta coluna ira receber o nome do Bairro. Esse conteúdo é obrigatório.',
  `NM_ZONA_BAIRRO` VARCHAR(20) NULL COMMENT 'Esta coluna irá receber a localização da zona onde se encontra o bairro. Alguns exemplos: Zona Norte, Zona Sul, Zona Leste, Zona Oeste, Centro(Informação de caracter opcional)',
  `MC_CIDADE_ID_CIDADE` INT NOT NULL,
  PRIMARY KEY (`ID_BAIRRO`),
  INDEX `fk_MC_BAIRRO_MC_CIDADE1_idx` (`MC_CIDADE_ID_CIDADE` ASC) VISIBLE,
  CONSTRAINT `fk_MC_BAIRRO_MC_CIDADE1`
    FOREIGN KEY (`MC_CIDADE_ID_CIDADE`)
    REFERENCES `Projeto_Melhores_Compras_SGV`.`MC_CIDADE` (`ID_CIDADE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Projeto_Melhores_Compras_SGV`.`MC_LOGRADOURO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Projeto_Melhores_Compras_SGV`.`MC_LOGRADOURO` (
  `ID_LOGRAD` INT NOT NULL AUTO_INCREMENT COMMENT 'Está coluna informa o numero serial a qual identifica o logradouro no sistema desta tabela(Informação de carater obrigatorio)',
  `NM_LOGRAD` VARCHAR(200) NOT NULL COMMENT 'Esta coluna irá receber o nome do logradouro e seu conteúdo é obrigatório.',
  `NR_CEP` INT(8) NOT NULL COMMENT 'Esta coluna irá receber o numero do CEP do Logradouro e seu conteúdo é obrigatório.',
  `MC_BAIRRO_ID_BAIRRO` INT NOT NULL,
  PRIMARY KEY (`ID_LOGRAD`),
  INDEX `fk_MC_LOGRADOURO_MC_BAIRRO1_idx` (`MC_BAIRRO_ID_BAIRRO` ASC) VISIBLE,
  CONSTRAINT `fk_MC_LOGRADOURO_MC_BAIRRO1`
    FOREIGN KEY (`MC_BAIRRO_ID_BAIRRO`)
    REFERENCES `Projeto_Melhores_Compras_SGV`.`MC_BAIRRO` (`ID_BAIRRO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Projeto_Melhores_Compras_SGV`.`MC_CLIENTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Projeto_Melhores_Compras_SGV`.`MC_CLIENTE` (
  `ID_CLIENTE` INT NOT NULL AUTO_INCREMENT COMMENT 'Essa coluna irá armazenar o numero serial único do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório, único e preenhcido a  parrtir da chamada de sequence  SQ_MC_CLIENTE, a qual terá sempre o número disponivel para uso.',
  `NM_CLIENTE` VARCHAR(160) NOT NULL COMMENT 'Essa coluna irá armazenar o nome do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório.',
  `QT_ESTRELAS` INT(1) NOT NULL COMMENT 'Essa coluna irá armazenar a quantiade de estrelas do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório e ser possível de estar entre 1 e 5 estrelas.',
  `VL_MEDIO_COMPRA` DECIMAL(10,2) NOT NULL COMMENT 'Essa coluna irá armazenar o valor  médio de gastos f eito pelo cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório e deve ser calculado diariamente.',
  `ST_CLIENTE` ENUM('A', 'I') NULL COMMENT 'Essa coluna irá armazenar o stauts do cliente da Melhorees Compras. Os valores permitidos aqui são: A(tivo) e I(nativo).',
  `DS_EMAIL` VARCHAR(100) NULL COMMENT 'Essa coluna irá armazenar o email  do cliente da Melhorees Compras. No minimo é esperado um email contendo o caractere (@) em seu conteúdo.',
  `NR_TEL_FIXO` CHAR(14) NULL COMMENT 'Essa coluna irá armazenar o número do cliente da Melhorees Compras. A mascara de armazenamento deve ser: (<nr_ddd>) 99999-9999 e  deve ser utilizada pré definida.',
  `NR_CEL` CHAR(14) CHARACTER SET 'binary' NULL COMMENT 'Essa coluna irá armazenar o número TELEFONE CELULAR do cliente da Melhorees Compras. A mascara de armazenamento deve ser: (<nr_ddd>) 99999-9999 e  deve ser utilizada pré definida.',
  `NM_LOGIN` VARCHAR(100) NOT NULL COMMENT 'Essa coluna irá armazenar o login de cada cliente na plataforma ecommerce da Melhores Compras. Seu conteúdo deve ser obrigatório e  único para cada cliente.',
  `DS_SENHA` VARCHAR(100) NOT NULL COMMENT 'Essa coluna irá armazenar a senha de cada cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório.',
  PRIMARY KEY (`ID_CLIENTE`),
  UNIQUE INDEX `NM_LOGIN_UNIQUE` (`NM_LOGIN` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Projeto_Melhores_Compras_SGV`.`MC_END_CLIENTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Projeto_Melhores_Compras_SGV`.`MC_END_CLIENTE` (
  `ID_END_CLI` INT NOT NULL AUTO_INCREMENT COMMENT 'Está coluna informa o numero serial a qual identifica o endereço do cliente no sistema desta tabela(Informação de carater obrigatorio)',
  `NR_END` INT(5) NOT NULL COMMENT 'Número do Endereço do Cliente. O número da Rua/Localidade onde o cliente está associado.',
  `DS_COMPL_END` VARCHAR(200) NULL COMMENT 'Esta coluna irá receber o complemento do endereço do cliente e seu conteúdo pode ser opcional.',
  `DT_INICIO` DATE NULL COMMENT 'Data de início do endereço associado ao cliente.',
  `DT_TERMINO` DATE NULL COMMENT 'Data de término do endereço associado ao cliente.',
  `ST_END` ENUM('A', 'I') NULL COMMENT 'Status do endereço. (A)itvo ou (I)nativo.',
  `MC_LOGRADOURO_ID_LOGRAD` INT NOT NULL,
  `MC_CLIENTE_ID_CLIENTE` INT NOT NULL,
  PRIMARY KEY (`ID_END_CLI`),
  INDEX `fk_MC_END_CLIENTE_MC_LOGRADOURO1_idx` (`MC_LOGRADOURO_ID_LOGRAD` ASC) VISIBLE,
  INDEX `fk_MC_END_CLIENTE_MC_CLIENTE1_idx` (`MC_CLIENTE_ID_CLIENTE` ASC) VISIBLE,
  CONSTRAINT `fk_MC_END_CLIENTE_MC_LOGRADOURO1`
    FOREIGN KEY (`MC_LOGRADOURO_ID_LOGRAD`)
    REFERENCES `Projeto_Melhores_Compras_SGV`.`MC_LOGRADOURO` (`ID_LOGRAD`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MC_END_CLIENTE_MC_CLIENTE1`
    FOREIGN KEY (`MC_CLIENTE_ID_CLIENTE`)
    REFERENCES `Projeto_Melhores_Compras_SGV`.`MC_CLIENTE` (`ID_CLIENTE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Projeto_Melhores_Compras_SGV`.`MC_DEPTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Projeto_Melhores_Compras_SGV`.`MC_DEPTO` (
  `ID_DEPTO` INT NOT NULL AUTO_INCREMENT COMMENT 'Esta coluna irá receber o codigo do departamento  e seu conteúdo é obrigatório.',
  `NM_DEPTO` VARCHAR(100) NOT NULL COMMENT 'Esta coluna irá receber o nome do  departamento  e seu conteúdo é obrigatório.',
  `ST_DEPTO` ENUM('A', 'I') NOT NULL COMMENT 'Esta coluna irá receber o status do departamento  e seu conteúdo é obrigatório. Os valores possíveis são: (A)tivo e (I)nativo.',
  PRIMARY KEY (`ID_DEPTO`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Projeto_Melhores_Compras_SGV`.`MC_SGV_SAC`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Projeto_Melhores_Compras_SGV`.`MC_SGV_SAC` (
  `ID_SAC` INT NOT NULL AUTO_INCREMENT COMMENT 'Essa coluna irá armazenar a chave primária da tabela de SAC de vídeo  da Melhorees Compras. A cada SAC cadastrado pelo cliente será acionada a Sequence  SQ_MC_SGV_SAC que se encarregará de gerar o próximo número único do chamado SAC feito pelo Cliente.',
  `DS_DETALHADA_SAC` LONGTEXT NOT NULL COMMENT 'Essa coluna  irá  receber a descrição completa do SAC aberto pelo cliente. Seu conteudo deve ser obrigatório.',
  `DT_ABERTURA_SAC` DATE NOT NULL COMMENT 'Essa coluna  irá  receber a data e horário do SAC aberto pelo cliente. Seu conteudo deve ser obrigatório.',
  `HR_ABERTURA_SAC` DOUBLE NOT NULL COMMENT 'Essa coluna  irá  receber a hora do SAC aberto pelo cliente. Seu conteudo deve ser obrigatório.',
  `DT_ATENDIMENTO` DATE NULL COMMENT 'Essa coluna  irá  receber a data e horário do atendmiento SAC feita pelo funcionário da Melhores Compras. Seu conteudo deve ser opcional..',
  `HR_ATENDIIMENTO` DOUBLE NULL COMMENT 'Essa coluna  irá  receber a hora do SAC do atendimento  feito  pelo funcionario da Melhores Compras. Seu conteudo deve ser opcional.',
  `NR_TEMPO_TOTAL_SAC` DOUBLE NULL COMMENT 'Essa coluna  irá  receber o tempo total em horas  (HH24) computado desde a abertura até a conclusão dele. A unidade de medida é horas, ou seja, em quantas horas o chamado foi concluído desde a sua abertura.',
  `DS_DETALHADA_RETORNO_SAC` LONGTEXT NULL COMMENT 'Essa coluna  irá  receber a descrição detalhada do retorno feito pelo funcionário a partir da solicitação do cliente. Seu conteúdo deve ser opcional e preenchido pelo funcionário.',
  `TP_SAC` ENUM('S', 'D', 'E') NOT NULL COMMENT 'Essa coluna  irá  receber o TIPO  do chamado SAC aberto pelo cliente.  Seu conteúdo deve ser  obrigatório e os possíveis valores são: (S)ugestão; (D)úvida ou  (E)logio.',
  `ST_SAC` ENUM('E', 'C', 'F', 'X') NOT NULL COMMENT 'Essa coluna  irá  receber o STATUS  do chamado SAC aberto pelo cliente.  Seu conteúdo deve ser  obrigatório e os possíveis valores são: (E)m Atendimento; (C)ancelado; (F)echado ou (X)Fechado com Insatisfação do cliente.',
  `NR_INDICE_SATISFACAO` ENUM('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10') NULL COMMENT 'Essa coluna  irá  receber o índice de satisfação, , computado como um valor simples de 1 a 10, onde 1 refere-se ao cliente menos satisfeito e 10 o cliente mais satisfeito. Esse índice de satisfação é opcional e informado pelo cliente ao final do atendimento.',
  `MC_CLIENTE_ID_CLIENTE` INT NOT NULL,
  PRIMARY KEY (`ID_SAC`),
  INDEX `fk_MC_SGV_SAC_MC_CLIENTE1_idx` (`MC_CLIENTE_ID_CLIENTE` ASC) VISIBLE,
  CONSTRAINT `fk_MC_SGV_SAC_MC_CLIENTE1`
    FOREIGN KEY (`MC_CLIENTE_ID_CLIENTE`)
    REFERENCES `Projeto_Melhores_Compras_SGV`.`MC_CLIENTE` (`ID_CLIENTE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Projeto_Melhores_Compras_SGV`.`MC_FUNCIONARIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Projeto_Melhores_Compras_SGV`.`MC_FUNCIONARIO` (
  `ID_FUNCIONARIO` INT NOT NULL AUTO_INCREMENT,
  `CD_GERENTE` INT NULL COMMENT 'Esta coluna irá receber o codigo do gestor do funcionario trabalha  e seu conteúdo é opcional.',
  `NM_FUNCIONARIO` VARCHAR(50) NOT NULL COMMENT 'Esta coluna irá receber o nome do funcionário e seu conteúdo é obrigatório.',
  `DT_NASCIMENTO` DATE NOT NULL COMMENT 'Esta coluna irá receber a data de nascimento  do funcionário e seu conteúdo é obrigatório',
  `GENERO_BIOLOGICO` CHAR(1) NOT NULL COMMENT 'Esta coluna irá receber o sexo biológico do funcionário e seu conteúdo é obrigatório.Os valores permitidos aqui seriam: (F)eminino; (M)asculino ou (Hermafrodita)',
  `DS_CARGO` VARCHAR(80) NULL COMMENT 'Esta coluna irá receber o cargo do funcionário e seu conteúdo é opcional.',
  `VL_SALARIO` DECIMAL(10,2) NULL COMMENT 'Esta coluna irá receber o valor do salário do funcionário e seu conteúdo é opcional.',
  `DS_EMAIL` VARCHAR(100) NULL COMMENT 'Esta coluna irá receber o email do funcionário e seu conteúdo é opcional.',
  `ST_FUNCIONARIO` ENUM('A', 'I') NULL COMMENT 'Essa coluna irá armazenar o stauts do funcionário da Melhorees Compras. Os valores permitidos aqui são: A(tivo) e I(nativo).',
  `DT_CADASTRAMENTO` DATE NOT NULL COMMENT 'Data de cadastramento do Funcionario',
  `DT_DESLIGAMENTO` DATE NULL COMMENT 'Data de desligamento  do Funcionario. Seu conteúdo é opcional.',
  `MC_FUNCIONARIO_ID_FUNCIONARIO` INT NOT NULL,
  `MC_DEPTO_ID_DEPTO` INT NOT NULL,
  `MC_SGV_SAC_ID_SAC` INT NOT NULL,
  PRIMARY KEY (`ID_FUNCIONARIO`),
  INDEX `fk_MC_FUNCIONARIO_MC_FUNCIONARIO1_idx` (`MC_FUNCIONARIO_ID_FUNCIONARIO` ASC) VISIBLE,
  INDEX `fk_MC_FUNCIONARIO_MC_DEPTO1_idx` (`MC_DEPTO_ID_DEPTO` ASC) VISIBLE,
  INDEX `fk_MC_FUNCIONARIO_MC_SGV_SAC1_idx` (`MC_SGV_SAC_ID_SAC` ASC) VISIBLE,
  CONSTRAINT `fk_MC_FUNCIONARIO_MC_FUNCIONARIO1`
    FOREIGN KEY (`MC_FUNCIONARIO_ID_FUNCIONARIO`)
    REFERENCES `Projeto_Melhores_Compras_SGV`.`MC_FUNCIONARIO` (`ID_FUNCIONARIO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MC_FUNCIONARIO_MC_DEPTO1`
    FOREIGN KEY (`MC_DEPTO_ID_DEPTO`)
    REFERENCES `Projeto_Melhores_Compras_SGV`.`MC_DEPTO` (`ID_DEPTO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MC_FUNCIONARIO_MC_SGV_SAC1`
    FOREIGN KEY (`MC_SGV_SAC_ID_SAC`)
    REFERENCES `Projeto_Melhores_Compras_SGV`.`MC_SGV_SAC` (`ID_SAC`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Projeto_Melhores_Compras_SGV`.`MC_END_FUNC`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Projeto_Melhores_Compras_SGV`.`MC_END_FUNC` (
  `ID_END_FUNC` INT NOT NULL AUTO_INCREMENT COMMENT 'Está coluna informa o numero serial a qual identifica o logradouro no sistema desta tabela(Informação de carater obrigatorio)',
  `NR_END` INT(5) NOT NULL COMMENT 'Número do Endereço do Cliente. O número da Rua/Localidade onde o cliente está associado.',
  `DS_COMPLEMENTO` VARCHAR(200) NULL COMMENT 'Esta coluna informa os dados complementares ao endereço, como bloco/torre do predio, numero do apto, identificação de uma casa em um terreno com diversas(informação de caracter opcional)',
  `DT_INICIO` DATE NOT NULL COMMENT 'Data de início do endereço associado ao cliente.',
  `DT_TERMINO` DATE NULL COMMENT 'Data de término do endereço associado ao cliente.',
  `ST_END` ENUM('A', 'I') NOT NULL COMMENT 'Status do endereço. (A)itvo ou (I)nativo.',
  `MC_LOGRADOURO_ID_LOGRAD` INT NOT NULL,
  `MC_FUNCIONARIO_ID_FUNCIONARIO` INT NOT NULL,
  PRIMARY KEY (`ID_END_FUNC`),
  INDEX `fk_MC_END_FUNC_MC_LOGRADOURO1_idx` (`MC_LOGRADOURO_ID_LOGRAD` ASC) VISIBLE,
  INDEX `fk_MC_END_FUNC_MC_FUNCIONARIO1_idx` (`MC_FUNCIONARIO_ID_FUNCIONARIO` ASC) VISIBLE,
  CONSTRAINT `fk_MC_END_FUNC_MC_LOGRADOURO1`
    FOREIGN KEY (`MC_LOGRADOURO_ID_LOGRAD`)
    REFERENCES `Projeto_Melhores_Compras_SGV`.`MC_LOGRADOURO` (`ID_LOGRAD`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MC_END_FUNC_MC_FUNCIONARIO1`
    FOREIGN KEY (`MC_FUNCIONARIO_ID_FUNCIONARIO`)
    REFERENCES `Projeto_Melhores_Compras_SGV`.`MC_FUNCIONARIO` (`ID_FUNCIONARIO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Projeto_Melhores_Compras_SGV`.`MC_CLI_PJ`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Projeto_Melhores_Compras_SGV`.`MC_CLI_PJ` (
  `ID_PJ` INT NOT NULL AUTO_INCREMENT COMMENT 'Essa coluna irá armazenar o código único do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório, único e preenhcido a  parrtir da tabela NC_CLIENTE. ',
  `DT_FUNDACAO` DATE NOT NULL COMMENT 'Essa coluna irá armazenar data  de fundação do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório.',
  `NR_CNPJ` VARCHAR(25) NOT NULL COMMENT 'Essa coluna irá armazenar o  numero do CNPJ do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório.',
  `NR_INSCR_EST` VARCHAR(25) NULL COMMENT 'Essa coluna irá armazenar o  numero da Inscrição Estadual  do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser opcional',
  `MC_CLIENTE_ID_CLIENTE` INT NOT NULL,
  PRIMARY KEY (`ID_PJ`, `MC_CLIENTE_ID_CLIENTE`),
  INDEX `fk_MC_CLI_PJ_MC_CLIENTE1_idx` (`MC_CLIENTE_ID_CLIENTE` ASC) VISIBLE,
  CONSTRAINT `fk_MC_CLI_PJ_MC_CLIENTE1`
    FOREIGN KEY (`MC_CLIENTE_ID_CLIENTE`)
    REFERENCES `Projeto_Melhores_Compras_SGV`.`MC_CLIENTE` (`ID_CLIENTE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Projeto_Melhores_Compras_SGV`.`MC_CLI_PF`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Projeto_Melhores_Compras_SGV`.`MC_CLI_PF` (
  `ID_PF` INT NOT NULL AUTO_INCREMENT COMMENT 'Essa coluna irá armazenar o código único do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório, único e preenhcido a  parrtir da tabela NC_CLIENTE. ',
  `DT_NASCIMENTO` DATE NOT NULL COMMENT 'Essa coluna irá armazenar a data de nascimento do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório. ',
  `GENERO_BIOLOGICO` ENUM('M', 'F') NOT NULL COMMENT 'Essa coluna irá armazenar o sexo biológico do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório.(\'F\' FEMININO , \'M\' MASCULINO)',
  `GENERO_INDENTIFICA` VARCHAR(45) NOT NULL COMMENT 'Esta coluna informa o Genero social a qual o Cliente se identifica. Seu conteúdo deve ser obrigatório.',
  `NR_CPF` VARCHAR(14) NOT NULL COMMENT 'Essa coluna irá armazenar o número do CPF do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório. ',
  `MC_CLIENTE_ID_CLIENTE` INT NOT NULL,
  PRIMARY KEY (`ID_PF`, `MC_CLIENTE_ID_CLIENTE`),
  INDEX `fk_MC_CLI_PF_MC_CLIENTE1_idx` (`MC_CLIENTE_ID_CLIENTE` ASC) VISIBLE,
  CONSTRAINT `fk_MC_CLI_PF_MC_CLIENTE1`
    FOREIGN KEY (`MC_CLIENTE_ID_CLIENTE`)
    REFERENCES `Projeto_Melhores_Compras_SGV`.`MC_CLIENTE` (`ID_CLIENTE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Projeto_Melhores_Compras_SGV`.`MC_CATEGORIA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Projeto_Melhores_Compras_SGV`.`MC_CATEGORIA` (
  `ID_CATEGORIA` INT NOT NULL AUTO_INCREMENT COMMENT 'Essa coluna irá armazenar a chave primária da tabela de categoria de produtos da Melhorees Compras. Cada categoria nova cadastrada  será acionada a Sequence  SQ_MC_CATEGORIA que se encarregará de gerar o próximo número único da categoria..',
  `TP_CATEGORIA` ENUM('V', 'P') NOT NULL COMMENT 'Nessa  coluna  será  armazenada o tipo de categoria que poderá  ser (V)ídeo ou (P)rodudto. Seu conteúdo deve ser obrigatório.',
  `DS_CATEGORIA` LONGTEXT NULL COMMENT 'Essa coluna irá armazenar descrição da categoria de produtos da Melhorees Compras. Cada categoria tem uma  descrição única e serve para organizar os produtos em categorias simliares, melhorando a tomada de decisão.',
  `DT_INICIO` DATE NOT NULL COMMENT 'Essa coluna irá receber  a data de início da categoria. Seu formato é dd/mm/yyyy e seu conteúdo deve ser sempre  obrigatório.',
  `DT_TERMINO` DATE NOT NULL COMMENT 'Essa coluna irá receber  a data de encerramento  da categoria. Seu formato é dd/mm/yyyy e seu conteúdo deve ser sempre  opcional. Conteúdo obrigatório significa que a categoria foi encerrada a partir da data término. Já o conteúdo opcional indica que a categoria está ativa e operante.',
  `ST_CATEGORIA` ENUM('A', 'I') NULL COMMENT 'Essa coluna irá armazenar o stauts da categoria da Melhorees Compras. Os valores permitidos aqui são: A(tivo) e I(nativo).',
  PRIMARY KEY (`ID_CATEGORIA`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Projeto_Melhores_Compras_SGV`.`MC_PRODUTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Projeto_Melhores_Compras_SGV`.`MC_PRODUTO` (
  `ID_PRODUTO` INT NOT NULL AUTO_INCREMENT,
  `NR_CD_BARRAS` VARCHAR(50) NULL COMMENT 'Essa coluna irá armazenar o número do codigo de barras  do produto. Seu conteúdo deve ser opcional.',
  `DS_PRODUTO` TINYTEXT NOT NULL COMMENT 'Essa coluna irá armazenar a descrição principal do produto. Seu conteúdo deve ser  obrigatorio.',
  `VL_UNITARIO` DECIMAL(9,2) NOT NULL COMMENT 'Essa coluna irá armazenar o valor unitário do produto. Seu conteúdo deve ser > 0 ',
  `TP_EMBALAGEM` VARCHAR(15) NULL COMMENT 'Essa coluna irá armazenar o tipo de embalagem do produto. Seu conteúdo pode ser opcional.',
  `ST_PRODUTO` ENUM('A', 'I') NULL COMMENT 'Essa coluna irá armazenar o stauts do produto da Melhorees Compras. Os valores permitidos aqui são: A(tivo) e I(nativo).',
  `VL_PERC_LUCRO` DECIMAL(9,2) NULL COMMENT 'Essa coluna irá armazenar o percentual  do lucro médio para cada produto. Seu conteúdo deve ser opcional.',
  `DS_COMPLETA_PRODUTO` LONGTEXT NOT NULL COMMENT 'Essa coluna irá armazenar a descrição completa do produto. Seu conteúdo deve ser  obrigatorio.',
  `MC_CATEGORIA_ID_CATEGORIA` INT NOT NULL,
  PRIMARY KEY (`ID_PRODUTO`),
  INDEX `fk_MC_PRODUTO_MC_CATEGORIA1_idx` (`MC_CATEGORIA_ID_CATEGORIA` ASC) VISIBLE,
  CONSTRAINT `fk_MC_PRODUTO_MC_CATEGORIA1`
    FOREIGN KEY (`MC_CATEGORIA_ID_CATEGORIA`)
    REFERENCES `Projeto_Melhores_Compras_SGV`.`MC_CATEGORIA` (`ID_CATEGORIA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Projeto_Melhores_Compras_SGV`.`MC_CLIENTE_has_MC_PRODUTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Projeto_Melhores_Compras_SGV`.`MC_CLIENTE_has_MC_PRODUTO` (
  `MC_CLIENTE_ID_CLIENTE` INT NOT NULL,
  `MC_PRODUTO_ID_PRODUTO` INT NOT NULL,
  PRIMARY KEY (`MC_CLIENTE_ID_CLIENTE`, `MC_PRODUTO_ID_PRODUTO`),
  INDEX `fk_MC_CLIENTE_has_MC_PRODUTO_MC_PRODUTO1_idx` (`MC_PRODUTO_ID_PRODUTO` ASC) VISIBLE,
  INDEX `fk_MC_CLIENTE_has_MC_PRODUTO_MC_CLIENTE1_idx` (`MC_CLIENTE_ID_CLIENTE` ASC) VISIBLE,
  CONSTRAINT `fk_MC_CLIENTE_has_MC_PRODUTO_MC_CLIENTE1`
    FOREIGN KEY (`MC_CLIENTE_ID_CLIENTE`)
    REFERENCES `Projeto_Melhores_Compras_SGV`.`MC_CLIENTE` (`ID_CLIENTE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MC_CLIENTE_has_MC_PRODUTO_MC_PRODUTO1`
    FOREIGN KEY (`MC_PRODUTO_ID_PRODUTO`)
    REFERENCES `Projeto_Melhores_Compras_SGV`.`MC_PRODUTO` (`ID_PRODUTO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Projeto_Melhores_Compras_SGV`.`MC_SGV_SAC_has_MC_PRODUTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Projeto_Melhores_Compras_SGV`.`MC_SGV_SAC_has_MC_PRODUTO` (
  `MC_SGV_SAC_ID_SAC` INT NOT NULL,
  `MC_PRODUTO_ID_PRODUTO` INT NOT NULL,
  PRIMARY KEY (`MC_SGV_SAC_ID_SAC`, `MC_PRODUTO_ID_PRODUTO`),
  INDEX `fk_MC_SGV_SAC_has_MC_PRODUTO_MC_PRODUTO1_idx` (`MC_PRODUTO_ID_PRODUTO` ASC) VISIBLE,
  INDEX `fk_MC_SGV_SAC_has_MC_PRODUTO_MC_SGV_SAC1_idx` (`MC_SGV_SAC_ID_SAC` ASC) VISIBLE,
  CONSTRAINT `fk_MC_SGV_SAC_has_MC_PRODUTO_MC_SGV_SAC1`
    FOREIGN KEY (`MC_SGV_SAC_ID_SAC`)
    REFERENCES `Projeto_Melhores_Compras_SGV`.`MC_SGV_SAC` (`ID_SAC`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MC_SGV_SAC_has_MC_PRODUTO_MC_PRODUTO1`
    FOREIGN KEY (`MC_PRODUTO_ID_PRODUTO`)
    REFERENCES `Projeto_Melhores_Compras_SGV`.`MC_PRODUTO` (`ID_PRODUTO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Projeto_Melhores_Compras_SGV`.`MC_VIDEO_PRODUTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Projeto_Melhores_Compras_SGV`.`MC_VIDEO_PRODUTO` (
  `ID_VIDEO` INT NOT NULL AUTO_INCREMENT COMMENT 'Esta coluna identifica o numero serial unico que ideinctifica o video cadastrado no sistema desta tabela',
  `VIDEO_PRODUTO` LONGTEXT NULL COMMENT 'Esta coluna informa o link de acesso ao video do produto',
  `DS_VIDEO` LONGTEXT NULL COMMENT 'Esta coluna informa a descrição do video do produto',
  `ST_VIDEO` ENUM('A', 'I') NULL COMMENT 'Essa coluna irá armazenar o stauts do video do produto da Melhorees Compras. Os valores permitidos aqui são: A(tivo) e I(nativo).',
  `DT_CADASTRAMENTO` DATE NOT NULL COMMENT 'Esta coluna informa a data em que o video foi inserido no sistema para divulgação',
  `MC_PRODUTO_ID_PRODUTO` INT NOT NULL,
  PRIMARY KEY (`ID_VIDEO`),
  INDEX `fk_MC_VIDEO_PRODUTO_MC_PRODUTO1_idx` (`MC_PRODUTO_ID_PRODUTO` ASC) VISIBLE,
  CONSTRAINT `fk_MC_VIDEO_PRODUTO_MC_PRODUTO1`
    FOREIGN KEY (`MC_PRODUTO_ID_PRODUTO`)
    REFERENCES `Projeto_Melhores_Compras_SGV`.`MC_PRODUTO` (`ID_PRODUTO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Projeto_Melhores_Compras_SGV`.`MC_VISUALIZACAO_VIDEO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Projeto_Melhores_Compras_SGV`.`MC_VISUALIZACAO_VIDEO` (
  `ID_VISUALIZACAO` INT NOT NULL AUTO_INCREMENT COMMENT 'Esta coluna informa o numero serial a qual identifica a visualização do video',
  `DT_HR_VISUALIZACAO` DATETIME NOT NULL COMMENT 'Esta coluna informa a data, hora e minuto em que o video do produto foi visualizado',
  `LOGIN_CLIENTE` VARCHAR(100) NULL COMMENT 'Esta coluna informa o login de acesso ao sistema ecommerce Melhores Compras do cliente logado que visualiza o video',
  `MC_VIDEO_PRODUTO_ID_VIDEO` INT NOT NULL,
  PRIMARY KEY (`ID_VISUALIZACAO`),
  UNIQUE INDEX `LOGIN_CLIENTE_UNIQUE` (`LOGIN_CLIENTE` ASC) VISIBLE,
  INDEX `fk_MC_VISUALIZACAO_VIDEO_MC_VIDEO_PRODUTO1_idx` (`MC_VIDEO_PRODUTO_ID_VIDEO` ASC) VISIBLE,
  CONSTRAINT `fk_MC_VISUALIZACAO_VIDEO_MC_VIDEO_PRODUTO1`
    FOREIGN KEY (`MC_VIDEO_PRODUTO_ID_VIDEO`)
    REFERENCES `Projeto_Melhores_Compras_SGV`.`MC_VIDEO_PRODUTO` (`ID_VIDEO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Projeto_Melhores_Compras_SGV`.`MC_CLASSE_VIDEO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Projeto_Melhores_Compras_SGV`.`MC_CLASSE_VIDEO` (
  `ID_CATEGORIA_VIDEO` INT NOT NULL AUTO_INCREMENT COMMENT 'Essa coluna irá armazenar o código único do DA  na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório, único e preenhcido a  parrtir da  ',
  `DS_CLASSE_VIDEO` LONGTEXT NOT NULL COMMENT 'Este coluna informa a descrição completa da classe a qual pertence o video(Exemplo: Vídeo de instalação do produto; Uso no cotidiano; Comercial com personalidade; entre outros)',
  `DS_TIPO_VIDEO` VARCHAR(45) NOT NULL COMMENT 'Esta coluna informa apenas o tipo de video(Exemplo: Instalação, Comercial, Cotidiano.....)',
  `MC_VIDEO_PRODUTO_ID_VIDEO` INT NOT NULL,
  `ST_CLASSE` ENUM('A', 'I') NULL,
  PRIMARY KEY (`ID_CATEGORIA_VIDEO`, `MC_VIDEO_PRODUTO_ID_VIDEO`),
  INDEX `fk_MC_CLASSE_VIDEO_MC_VIDEO_PRODUTO1_idx` (`MC_VIDEO_PRODUTO_ID_VIDEO` ASC) VISIBLE,
  CONSTRAINT `fk_MC_CLASSE_VIDEO_MC_VIDEO_PRODUTO1`
    FOREIGN KEY (`MC_VIDEO_PRODUTO_ID_VIDEO`)
    REFERENCES `Projeto_Melhores_Compras_SGV`.`MC_VIDEO_PRODUTO` (`ID_VIDEO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
