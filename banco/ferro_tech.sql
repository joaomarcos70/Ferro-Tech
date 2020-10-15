create database ferro_tech;

use ferro_tech;

create table categoria(
	id_categoria int(11) not null,
	nm_categoria varchar(30),
	primary key (id_categoria)
);

insert into categoria (id_categoria, nm_categoria)
values (87, 'Alimento'),
(44, 'Eletrodoméstico'),
(17, 'Eletroeletrônico');

create table forma_pagamento (
	id_forma_pagamento int(11) not null,
    nm_forma_pagamento varchar(30),
    primary key (id_forma_pagamento)
);

insert into forma_pagamento (id_forma_pagamento, nm_forma_pagamento)
values (01, 'dinheiro'),
(02, 'cartão de crédito'),
(03, 'transferência bancária'),
(04, 'depósito'),
(05, 'cartão de débito');

create table nota(
	cod_nota int(11) not null,
	numero_nota varchar(10),
	data_nota date,
	fechado char(1),
	primary key (cod_nota)
);

insert into nota (cod_nota, numero_nota, data_nota, fechado)
values (264, '654123', '2017-05-09', 'S'),
(154, '154155', '2018-09-22', 'N'),
(977, '976543','2018-08-23', 'N');

create table estoque(
	id_estoque int(11) not null, 
	quantidade int(4),
	primary key (id_estoque)
);

insert into estoque (id_estoque, quantidade)
values(15592, 450),
(2495, 665),
(76529, 348);

create table material(
	id_material int(11) not null,
	codigo varchar(6),
	nome_material varchar(50) not null,
	unidade_referencia char(2) not null,
	categoria int(11),
    peso double(3,2),
    estoque int(11),
	primary key (id_material),
constraint fk_material_categoria
	foreign key (categoria)
		references categoria (id_categoria),
constraint fk_material_estoque
	foreign key (estoque)
		references estoque (id_estoque)
);

insert into material (id_material, codigo, nome_material, unidade_referencia, categoria, peso)
values (063, '264355', 'Cafe', 'kg', 87, 85.5),
(535, '124565', 'Geladeira', 'Gr', 87, 5.6);

create table item(
	id_item int(11) not null,
	valor_item decimal(8,2),
	quantidade int(4),
	cd_nota int(11),
	material int(11),
	primary key (id_item),
constraint fk_item_nota
	foreign key (cd_nota)		
		references nota (cod_nota),
constraint fk_item_material
	foreign key (material)
		references material (id_material)
);

insert into item (id_item, valor_item, quantidade, cd_nota, material)
values (445, 789.90, 1, 264, 063),
(336, 9.99, 2, 264, 063);

create table tipo_usuario (
	id_tipo_usuario int(11) not null, 
	tipo int(2),
	primary key (id_tipo_usuario)
);

insert into tipo_usuario (id_tipo_usuario, tipo)
values('01', 'cliente'),
('02', 'funcionario'),
('03', 'administrador');

create table usuario (
	id_usuario int (11) not null,
	login varchar(20),
	senha varchar(10),
	ativo char (1),
    cd_tipo_usuario int(11),
	primary key (id_usuario),
    Constraint fk_usuario_tipo_usuario
		foreign key (cd_tipo_usuario) 
			references  tipo_usuario (id_tipo_usuario)
);

insert into usuario (id_usuario, login, senha, ativo)
values (001, 'Adm258', 'admin859', 'S'),
(004, 'Finan.G', 'Gerenfinan', 'S'),
(009, 'Estoque431', 'est1752', 'S');

create table cliente (
	id_cliente int(11) not null,
    nome_cliente varchar(80),
    sexo_cliente char(1),
    data_nascimento_cliente date,
    cep_cliente char(8),
    endereco_cliente varchar(50),
    numero_endereco_cliente int(5),
    municipio_cliente varchar(80),
    bairro_cliente varchar(50),
    celular_cliente int(20),
    primary key (id_cliente)
);

insert into cliente (id_cliente, nome_cliente, sexo_cliente, data_nascimento_cliente, 
cep_cliente, endereco_cliente, numero_endereco_cliente, municipio_cliente, bairro_cliente, celular_cliente)
values (898, 'Cassandra Souza', 'F', '1989-02-20', '11712150', 'Avenida das gaivotinhas', 329, 'Praia Grande', 'Boqueirão', 13912341234),
(1352, 'Quezia Belarmino', 'F', '1992-09-04', '11712020', 'Avenida dos Pipoqueiros', 667, 'Praia Grande', 'Boqueirão', 13943214321);

create table pedido (
	cod_pedido int(11) not null,
	quantidade_pedida int(4),
	cliente int(11) not null,
	cd_material int(11) not null,
	data_pedido date,
	obs varchar(180) not null,
    cd_pagamento int(11) not null,
	primary key (cod_pedido),
	constraint fk_pedido_cliente
		foreign key (cliente)
			references cliente (id_cliente),
	constraint fk_pedido_material
		foreign key (cd_material)
			references material (id_material),
	constraint fk_pedido_pagamento
		foreign key (cd_pagamento)
			references forma_pagamento (id_forma_pagamento)
);


insert into pedido (cod_pedido, quantidade_pedida, cliente, cd_material, data_pedido, obs, cd_pagamento)
values 			   (548, 2, 1352, 535, '2018-08-09', 'Precisando repor na sala', 01),
	               (579, 1, 1352, 535, '2018-04-06', 'Precisando substituir a existente', 02);

create table item_pedido(
	id_item_pedido int(11) not null,
	quantidade int(11),
	cd_pedido int(11),
	cod_material int(11),
	obs varchar(180),
	primary key (id_item_pedido),
	constraint fk_item_pedido
		foreign key (cd_pedido)
			references pedido (cod_pedido)
);

insert into item_pedido(id_item_pedido, quantidade, cd_pedido, cod_material, obs)
values ('762', '2', '548', '023', 'Precisando repor na sala'),
('161', '1', '579', '135', 'Precisando substituir a existente');