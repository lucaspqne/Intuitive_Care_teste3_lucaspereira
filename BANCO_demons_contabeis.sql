CREATE DATABASE dados2021_2022;
USE dados2021_2022;

CREATE TABLE tabela (
    DATA VARCHAR(255),
    REG_ANS VARCHAR(255),
    CD_CONTA_CONTABIL VARCHAR(255),
    DESCRICAO VARCHAR(255),
    VL_SALDO_INICIAL FLOAT,
    VL_SALDO_FINAL FLOAT
);


#___________________________________________________________________________________________________________________
-- Todas as tabelas foram tratadas previamente com um código em python para remover as aspas. 
-- Os três primeiros trimestres de 2021 estão faltando a coluna 'VL_SALDO_INICIAL'
-- Os três primeiros trimestres de 2021 contêm um formato de data diferente do quarto trimestre
-- O segundo trimestre de 2022 contém um formato de data igual aos 3 primeiros trimestres de 2021, portanto deve ser importado em sequência.
-- SEQUENCIA CORRETA: 1°TRI 2021, 2°TRI 2021, 3°TRI 2021, 2°TRI 2022

#_________________________________________(1° TRIMESTRE 2021)_____________________________________________                
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\1T2021COPIA.csv' INTO TABLE tabela
CHARACTER SET latin1
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(DATA,REG_ANS,CD_CONTA_CONTABIL,DESCRICAO,VL_SALDO_FINAL);

#_________________________________________(2° TRIMESTRE 2021)_____________________________________________
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\2T2021COPIA.csv' INTO TABLE tabela
CHARACTER SET latin1
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(DATA,REG_ANS,CD_CONTA_CONTABIL,DESCRICAO,VL_SALDO_FINAL);

#_________________________________________(3° TRIMESTRE 2021)_____________________________________________
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\3T2021COPIA.csv' INTO TABLE tabela
CHARACTER SET latin1
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(DATA,REG_ANS,CD_CONTA_CONTABIL,DESCRICAO,VL_SALDO_FINAL);

#_________________________________________(2° TRIMESTRE 2022)_____________________________________________ 
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\2T2022COPIA.csv' INTO TABLE tabela
CHARACTER SET latin1
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Alterar o formato da data dos 3 primeiros trimestres 2021 E 2° trimestre 2022 antes de chamar os demais dados.
UPDATE tabela SET DATA = STR_TO_DATE(DATA, '%d/%m/%Y') WHERE DATA IS NOT NULL;

#___________________________________________________________________________________________________________________

#_________________________________________(4° TRIMESTRE 2021)_____________________________________________ 
-- O encoding do 4 trimestre de 2021 foi setado em UTF8MB4 pois LATIN1 não exibia caracteres especiais
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\4T2021COPIA.csv' INTO TABLE tabela
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- formato da data Y%-%m-%d 

-- ALTERAR DATA TYPE PARA VARCHAR ANTES DE IMPORTAR O 1° TRIMESTRE DE 2022 para no final remover as barras.
ALTER TABLE tabela MODIFY COLUMN DATA VARCHAR(255);

#_________________________________________(1° TRIMESTRE 2022)_____________________________________________ 
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\1T2022COPIA.csv' INTO TABLE tabela
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- formato da data Y%/%m/%d 

#_________________________________________(3° TRIMESTRE 2022)_____________________________________________ 
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\3T2022COPIA.csv' INTO TABLE tabela
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- formato da data Y%-%m-%d 

#_________________________________________(4° TRIMESTRE 2022)_____________________________________________ 
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\4T2022COPIA.csv' INTO TABLE tabela
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- formato da data Y%-%m-%d 

-- Alterar o tipo para DATE e assim todas as datas serão convertidas para o tipo Y%-%m-%d
ALTER TABLE tabela MODIFY COLUMN DATA date;

#___________________________________________________________________________________________________________

-- Remover valores do tipo null por 0 para facilitar cálculos
UPDATE tabela
SET VL_SALDO_INICIAL = 0
WHERE VL_SALDO_INICIAL IS NULL;


-- Quais as 10 operadoras que mais tiveram despesas com "EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR" no último trimestre?
SELECT REG_ANS, SUM(VL_SALDO_INICIAL - VL_SALDO_FINAL) AS DESPESAS_ANO FROM tabela
WHERE DESCRICAO = 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR '#Tem um espaço no final!!!!
  AND DATA >= '2022-01-01'  -- Data inicial do intervalo
  AND DATA <= '2022-12-31'  -- Data final do intervalo
GROUP BY REG_ANS
ORDER BY DESPESAS_ANO ASC
LIMIT 10;


-- Quais as 10 operadoras que mais tiveram despesas com "EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR" no último ano?
SELECT REG_ANS, SUM(VL_SALDO_INICIAL - VL_SALDO_FINAL) AS DESPESAS_ANO FROM tabela
WHERE DESCRICAO = 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR ' #Tem um espaço no final!!!!
  AND DATA >= '2022-10-01'  -- Data inicial do intervalo
  AND DATA <= '2023-12-31'  -- Data final do intervalo
GROUP BY REG_ANS
ORDER BY DESPESAS_ANO ASC
LIMIT 10;

