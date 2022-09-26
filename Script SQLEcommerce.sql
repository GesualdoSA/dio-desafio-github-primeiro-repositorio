-- criação do banco de dados para o cenário de E-commerce
create database ecommerce;
use ecommerce;
-- criar tabela cliente
create table clients(
				idClient int auto_increment primary key,
                Fname varchar(10),
                Minit char(3),
                Lname varchar(20),
                CPF char(11) not null,
                Address varchar(30),
                constraint unique_cpf_client unique (CPF)
);
desc clients;
-- criar tabela produto
create table product(
				idProduct int auto_increment primary key,
                Pname varchar(10),
                classificatio_kids bool default false,
                category enum ("Eletrônico","Vestimento","Brinquedos","Alimentos","Movéis") not null,
                avaliação float default 0,
                size varchar(10)
);

create table payments(
			idclient int,
            id_payment int,
            typePayment enum("Boleto", "Cartão","Dois Cartões"),
            limitAvailable float,
            primary key(idclient, id_payment)
);
-- criar tabela pedido
drop table orders;
create table orders(
				idOrders int auto_increment primary key,
                IdOrderClients int,
                orderStatus enum("Cancelado", "Confirmado","Em processamento") default "Em processamento",
                orderDescription varchar (255),
                sendvalue float default 10,
                paymentCash boolean default false,
                constraint fk_orders_client foreign key (idOrderClients) references clients(idclient)
);
-- criar tabela estoque 
create table productStorage(
				idproductStorage int auto_increment primary key,
                storagelocation varchar (255),
                quantity int default 0
                
);
-- criar tabela fornecedor
create table supplier(
				idsupplier int auto_increment primary key,
                socialName varchar (255) not null,
                CNPJ char(15) not null,
                contact char(11) not null,
                constraint unique_supplier unique(CNPJ)
);
                
  -- criar tabela vendedor
create table seller(
				idseller int auto_increment primary key,
                socialName varchar (255) not null,
                absName varchar(255),
				CNPJ char(15),
				CPF char(9),
                location varchar(255),
                contact char(11) not null,
                constraint unique_cnpj_seller unique (CNPJ),
                constraint unique_cpf_seller unique (CPF)
);
-- cria tabela produto por vendedor terceiro
create table productSeller(
				idPseller int,
                Idproduct int,
                prodQuantity int default 1,
				primary key (idPseller, idProduct),
				constraint fk_product_seller foreign key (IdPseller) references seller(idseller),
                constraint fk_product_product foreign key (IdProduct) references product(idProduct)

);

-- criar tabela produto por fornecedor
create table storageLocation(
			idLproduct int,
            idLstorage int,
            location varchar(255) not null,
            primary key (idLproduct, idLstorage),
            constraint fk_storage_location_product foreign key (IdLproduct) references product(idProduct),
			constraint fk_storage_location_storage foreign key (IdLStorage) references productStorage(idproductStorage)

);

-- criar tabela produto por fornecedor
create table productOrder(
			idLproduct int,
            idPorder int,
            poQuantity int default 1,
            poStatus enum("Disponível", "Sem estoque") default "Disponível",
            primary key (idLproduct, idPorder),
            constraint fk_product_orders foreign key (IdLproduct) references product(idProduct),
			constraint fk_product_Lproduct foreign key (IdPorder) references orders(Idorders)

);
show tables;