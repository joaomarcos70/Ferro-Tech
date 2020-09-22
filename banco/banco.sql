Create DATABASE ferrotech;

USE ferrotech;

Create TABLE funcionario (
nome	varchar(50) NOT NULL	
);


Create TABLE cliente(
nome	varchar(50) NOT NULL,
cpf	varchar(12) NOT NULL,
data	DATE,
tipoMaterial varchar(40),
compra	BOOLEAN,
venda	BOOLEAN
);


Create TABLE material(
tipo	varchar(50),
nome	varchar(50),
pesoUnidade BOOLEAN,
peso	DOUBLE,
unidade	INT,
dataEntrada DATE,
usuarioCadastrado varchar(50)
);