CREATE DATABASE teste3;
USE teste3;
CREATE TABLE analise_dados (
    Registro_ANS INT,
    CNPJ FLOAT,
    RazaoSocial VARCHAR(255),
    NomeFantasia VARCHAR(255),
    Modalidade VARCHAR(255),
    Logradouro VARCHAR(255),
    Numero VARCHAR(255),
    Complemento VARCHAR(255),
    Bairro VARCHAR(255),
    Cidade VARCHAR(255),
    UF VARCHAR(255),
    CEP VARCHAR(255),
    DDD VARCHAR(255),
    Telefone VARCHAR(255),
    Fax VARCHAR(255),
    EnderecoEletronico VARCHAR(255),
    Representante VARCHAR(255),
    Cargo VARCHAR(255),
    DataRegistro_ANS VARCHAR(255)
);


LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\RelatorioCOPIA.csv' INTO TABLE analise_dados
CHARACTER SET latin1
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 3 ROWS;

UPDATE analise_dados
SET DataRegistro_ANS = STR_TO_DATE(DataRegistro_ANS, '%d/%m/%Y')
WHERE DataRegistro_ANS IS NOT NULL;

ALTER TABLE analise_dados MODIFY DataRegistro_ANS date;
SELECT * FROM analise_dados










