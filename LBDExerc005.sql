CREATE DATABASE LBDExerc005
GO
USE LBDExerc005



--Exercícios:
--1) Fazer em SQL Server os seguintes algoritmos:
--a) Fazer um algoritmo que leia 1 número e mostre se são múltiplos de 2,3,5 ou nenhum deles

DECLARE @numerador INT
SET @numerador = 30
IF (@numerador % 2 = 0 AND @numerador % 3 = 0 AND @numerador % 5 = 0)
BEGIN 
	PRINT CAST(@numerador AS VARCHAR) + ' É múltiplo de 2, 3 e 5'
END
ELSE
BEGIN 
	IF (@numerador % 2 = 0 AND @numerador % 3 = 0)
BEGIN 
	PRINT CAST(@numerador AS VARCHAR) + ' É múltiplo de 2 e 3'
END
ELSE
BEGIN 
	IF (@numerador % 2 = 0 AND @numerador % 5 = 0)
BEGIN 
	PRINT CAST(@numerador AS VARCHAR) + ' É múltiplo de 2 e 5'
END
ELSE 
BEGIN 
	IF (@numerador % 3 = 0 AND @numerador % 5 = 0)
BEGIN 
	PRINT CAST(@numerador AS VARCHAR) + ' É múltiplo de 3 e 5'
END
ELSE 
BEGIN 
	IF (@numerador % 2 = 0)
BEGIN 
	PRINT CAST(@numerador AS VARCHAR) + ' É múltiplo de 2'
END
ELSE 
BEGIN 
	IF (@numerador % 3 = 0)
BEGIN
	PRINT CAST(@numerador AS VARCHAR) + ' É múltiplo de 3'
END
ELSE 
BEGIN 
	IF (@numerador % 5 = 0)
BEGIN 
	PRINT CAST(@numerador AS VARCHAR) + ' É múltiplo de 5'
END
END
END
END
END
END
END

--b) Fazer um algoritmo que leia 3 números e mostre o maior e o menor
DECLARE @maior INT,
		@menor INT,
		@meio INT,
		@aux INT
SET @maior = 5
SET @meio = 10
SET @menor = 15
SET @aux = 0
WHILE (@maior < @meio OR @meio < @menor)
BEGIN 
	IF (@maior < @meio)
	BEGIN 
		SET @aux = @maior
		SET @maior = @meio
		SET @meio = @aux
	END
	if (@meio < @menor)
	BEGIN 
		SET @aux = @meio
		SET @meio = @menor
		SET @menor = @aux
	END
END
PRINT CAST(@maior AS VARCHAR) + ' É o maior'
PRINT CAST(@meio AS VARCHAR) + ' É o meio'
PRINT CAST(@menor AS VARCHAR) + ' É o menor'


--c) Fazer um algoritmo que calcule os 15 primeiros termos da série
--1,1,2,3,5,8,13,21,...
--E calcule a soma dos 15 termos

DECLARE @cont INT,
		@num1 INT,
		@num2 INT,
		@num3 INT
SET @cont = 0
SET @num1 = 0
SET @num2 = 1
SET @num3 = 1
WHILE (@cont < 15)
BEGIN 
	PRINT @num3
	SET @num3 = @num1 + @num2
	SET @num1 = @num2
	SET @num2 = @num3
	SET @cont = @cont + 1
END


--d) Fazer um algoritmo que separa uma frase, colocando todas as letras em maiúsculo e em
--minúsculo (Usar funções UPPER e LOWER)
DECLARE @frase VARCHAR(MAX) = 'Uma pequena frase'
PRINT UPPER(@frase)
PRINT LOWER(@frase)

--e) Fazer um algoritmo que inverta uma palavra (Usar a função SUBSTRING)
DECLARE @frase_normal VARCHAR(MAX) = 'Queijo',
		@frase_invertida VARCHAR(MAX) = '',
		@tamanho INT
SET @tamanho = LEN(@frase_normal)
WHILE (@tamanho >= 0)
BEGIN
	SET @frase_invertida = @frase_invertida + SUBSTRING(@frase_normal, @tamanho, 1) 
	SET @tamanho = @tamanho - 1
END
PRINT @frase_invertida


--f) Considerando a tabela abaixo, gere uma massa de dados, com 100 registros, para fins de teste
--com as regras estabelecidas (Não usar constraints na criação da tabela)

--Computador
--ID      Marca         QtdRAM    TipoHD    QtdHD    FreqCPU
--INT (PK) VARCHAR(40)  INT     VARCHAR(10) INT    DECIMAL(7,2)

CREATE TABLE computador
(
	id			INT 			NOT NULL,
	marca		VARCHAR(40) 	NOT NULL,
	qtd_ram		INT 			NOT NULL,
	tipo_hd		VARCHAR(10) 	NOT NULL,
	qtd_hd		INT				NOT NULL,
	freq_cpu	DECIMAL(7, 2) 	NOT NULL
	PRIMARY KEY (id)
)

DECLARE @id INT = 10001,
		@marca VARCHAR(40) = 'Marca',
		@qtd_ram INT = 2,
		@tipo_hd VARCHAR(10),
		@qtd_hd INT,
		@freq_hd DECIMAL(7, 2),
		@cont_pc INT = 1
WHILE (@cont_pc <= 100)
BEGIN
	SET @qtd_ram = 	CASE (CAST(RAND() * 4 AS INT))
						WHEN 0 THEN 2
						WHEN 1 THEN 4
						WHEN 2 THEN 8
						ELSE 16
					END
	SET @tipo_hd = 	CASE (@id % 3)
						WHEN 0 THEN 'HDD'
						WHEN 1 THEN 'SSD'
						ELSE 'M2 NVME'
					END
	SET @qtd_hd =   CASE (@tipo_hd)
						WHEN 'HDD' THEN 
						CASE (CAST(RAND() * 3 AS INT))
							WHEN 0 THEN 500
							WHEN 1 THEN 1000
							ELSE 2000
						END
						ELSE
						CASE (CAST(RAND() * 3 AS INT))
							WHEN 0 THEN 128
							WHEN 1 THEN 256
							ELSE 512
						END
					END
	SET @freq_hd = 	RAND() * 1.5 + 1.70
	INSERT INTO computador VALUES
	(
		@id,
		CONCAT(@marca, ' ', CAST(@cont_pc AS VARCHAR)),
		@qtd_ram,
		@tipo_hd,
		@qtd_hd,
		@freq_hd
	)
	SET @id = @id + 1
	SET @cont_pc = @cont_pc + 1
END


SELECT * FROM computador

DELETE FROM computador

--• ID incremental a iniciar de 10001
--• Marca segue o padrão simples, Marca 1, Marca 2, Marca 3, etc.
--• QtdRAM é um número aleatório* dentre os valores permitidos (2, 4, 8, 16)
--• TipoHD segue o padrão:
--o Se o ID dividido por 3 der resto 0, é HDD
--o Se o ID dividido por 3 der resto 1, é SSD
--o Se o ID dividido por 3 der resto 2, é M2 NVME
--• QtdHD segue o padrão:
--o Se o TipoHD for HDD, um valor aleatório* dentre os valores permitidos (500, 1000 ou 2000)
--o Se o TipoHD for SSD, um valor aleatório* dentre os valores permitidos (128, 256, 512)
--• FreqHD é um número aleatório* entre 1.70 e 3.20

--* Função RAND() gera números aleatórios entre 0 e 0,9999...