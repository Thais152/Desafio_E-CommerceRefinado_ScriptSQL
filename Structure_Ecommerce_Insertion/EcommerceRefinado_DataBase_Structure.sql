-- Criação do banco de dados para o cenário de E-commerce Refinado Desafio

-- drop database ecommerce_refinado;
CREATE DATABASE ecommerce_refinado;
use ecommerce_refinado;

-- criar tabela cliente
create table clients(
	idClient int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    Address varchar(255)
);

alter table clients auto_increment=1;

-- Tabela filha de cliente: pessoa física
create table pessoaFísica(
	idPF int auto_increment,
    idPFclient int,
    primary key (idPF, idPFclient),
	CPF char(11) not null,
    data_nascimento DATE,
    contact char(11) not null,
	constraint unique_cpf_client unique (CPF),
    constraint fk_PF_client foreign key (idPFclient) references clients (idClient)
);

-- Tabela filha de cliente: pessoa jurídica
create table pessoaJuridica(
	idPJ int auto_increment,
    idPJclient int,
	primary key (idPJ, idPJclient),
	CNPJ char(15) not null,
    socialName varchar(255) not null,
    contact char(11) not null,
	constraint unique_cnpj_client unique (CNPJ),
	constraint fk_PJ_client foreign key (idPJclient) references clients (idClient)
);

desc clients;

-- criar tabela produto
  -- Size equivale a dimensão do produto
create table product(
	idProduct int auto_increment primary key,
    Pname varchar(100),
    classification_kids bool default false,
    category enum('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis') not null,
    unitValue float not null,
    avaliação float default 0,
    size varchar(10)
);

-- criar tabela pedido
create table orders(
	idOrder int auto_increment primary key,
    idOrderClient int,
    orderStatus enum('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
    orderDescription varchar(255),
    sendValue float default 10,
    constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
		on update cascade
);

-- tabela tipo de pagamento
create table paymentType(
	idPaymentType int primary key auto_increment,
    typePayment enum('Boleto', 'Cartão', 'PIX', 'Dinheiro'),
    titularNameCard varchar(45),
    lastNumCard char(4),
    flagCard varchar(45),
    validityCard DATE
);

-- tabela pagamento pedido
create table clientPayment(
	idCPpayment int,
    idCPclient int,
    primary key (idCPpayment, idCPclient),
    constraint fk_payment_CPpayment foreign key (idCPpayment) references paymentType (idPaymentType),
    constraint fk_payment_CPclient foreign key (idCPclient) references clients (idClient)
);


-- Tabela entrega
create table delivery(
	idDelivery int auto_increment primary key,
    idDeliveryOrder int,
    idDeliveryClient int,
    deliveryStatus enum ('Preparando para envio', 'Em trânsito', 'Saiu para entrega', 'Entregue') default 'Preparando para envio',
    trackingCode varchar (45),
    constraint fk_delivery_order foreign key (idDeliveryOrder) references orders (idOrder),
    constraint fk_delivery_client foreign key (idDeliveryClient) references clients (idClient)
);

desc orders;

-- criar tabela Estoque
create table productStorage(
	idProdStorage int auto_increment primary key,
    storageLocation varchar(255) not null,
    quantity int default 0
);

-- criar tabela Fornecedor
create table supplier(
	idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);

desc supplier;

-- criar tabela vendedor
create table seller(
	idSeller int auto_increment primary key,
    SocialName varchar(255) not null,
    AbstName varchar(255),
    CNPJ char(15),
    CPF char(9),
    location varchar(255),
    contact char(11) not null,
    constraint unique_CNPJ_seller unique (CNPJ),
    constraint unique_CPF_seller unique (CPF)
);

-- criar tabela Produto vendedor
create table productSeller(
	idPseller int,
    idPproduct int,
    prodQuantity int default 1,
    primary key (idPseller, idPproduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idPproduct) references product(idProduct)
);

desc productSeller;

-- criar tabela Produto pedido
create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponível', 'Sem estoque') default 'Disponível',
    primary key (idPOproduct, idPOorder),
    constraint fk_product_POproduct foreign key(idPOproduct) references product(idProduct),
    constraint fk_product_POorder foreign key(idPOorder) references orders(idOrder)
);

-- criar tabela Estoque produto
create table storageLocation(
	idLproduct int,
    idLstorage int,
    ProductQuantity int not null,
    primary key (idLproduct, idLstorage),
    constraint fk_storage_Lproduct foreign key(idLproduct) references product(idProduct),
    constraint fk_storage_Lstorage foreign key(idLstorage) references productStorage(idProdStorage)
);

-- criar tabela produto fornecedor
create table productSupplier(
	idPSsupplier int,
    idPSproduct int,
    Quantity int not null,
    primary key(idPSsupplier, idPSproduct),
    constraint fk_product_supplier_supplier foreign key (idPSsupplier) references supplier(idSupplier),
	constraint fk_product_supplier_product foreign key (idPSproduct) references product(idProduct)

);

desc productSupplier;
