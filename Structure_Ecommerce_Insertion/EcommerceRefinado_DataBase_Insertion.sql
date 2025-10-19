-- inserção de dados 
use ecommerce_refinado;

show tables;
desc clients;
-- idClient, Fname, Minit, Lname, Address
insert into clients (Fname, Minit, Lname, Address)
	values('Maria', 'M', 'Silva', 'rua silva de prata 29, Carangola - Cidade das flores'),
	      ('Matheus', 'O', 'Pimentel', 'rua alamenda 289, Centro - Cidade das flores'),
          ('Ricardo', 'F', 'Silva', 'avenida alamenda vinha 1009, Centro - Cidade das flores'),
          ('Julia', 'S', 'França', 'rua Laranjeiras 861, Centro - Cidade das flores'),
          ('Roberta', 'G', 'Assis', 'avenida Koller 19, Centro - Cidade das flores'),
          ('Isabela', 'M', 'Cruz', 'rua alameda das flores 28, Centro - Cidade das flores');
          
desc pessoaFísica;
-- idPF, idPFclient, CPF, data_nascimento, contact
insert into pessoaFísica (idPFclient, CPF, data_nascimento, contact)
	values(1, 12345678912, '1975-09-18', 11923874573),
	      (2, 23456789345, '2005-03-20', 32546758),
          (3, 45367890236, '1985-04-01', 26584457);

select * from pessoaJuridica;

desc pessoaJuridica;
-- idPJ, idPJclient, CNPJ, socialName, contact
insert into pessoaJuridica (idPJclient, CNPJ, socialName, contact)
	values(4, 32145327894254, 'Company zélia amálio', 11945327689),
          (5, 22094837291276, 'Mel das abelhas', 92837102),
          (6, 05948371029653, 'Ilustrações condecoradas', 11928372918);


desc product;
-- idProduct, Pname, classification_kids, category('Eletrônico','Vestimenta','Brinquedos','Alimentos', 'Móveis'), unitValue, avaliação, size
insert into product (Pname, classification_kids, category, unitValue, avaliação, size)
	values('Fone de ouvido', false, 'Eletrônico', 59.99, '4', null),
          ('Barbie Elsa', true, 'Brinquedos', 100.99, '3', null),
          ('Body Carters', true, 'Vestimenta', 45.99, '5', null),
          ('Microfone Vedo - Youtuber', false, 'Eletrônico', 155.99, '4', null),
          ('Sofá retrátil', false, 'Móveis', 530.99, '3', '3x57x80'),
          ('Farinha de Arroz', false, 'Alimentos', 15.89, '2', null),
          ('Fire Stick Amazon', false, 'Eletrônico', 230.99, '3', null);

select * from clients;
select * from product;


desc paymentType;
-- idPaymentType, typePayment, titularNameCard, lastNumCard, flagCard, validityCard
insert into paymentType (typePayment, titularNameCard, lastNumCard, flagCard, validityCard)
	value ('Boleto', null, null, null, null),
		  ('Cartão', 'Ricardo', 476, 'Visa', '2029-12-1'),
          ('Cartão', 'Julia', 593, 'Mastercard', '2026-12-1'),
          ('PIX', null, null, null, null),
          ('Dinheiro', null, null, null, null);
insert into paymentType (typePayment, titularNameCard, lastNumCard, flagCard, validityCard)
	value ('Cartão', 'Ricardo', 484, 'Elo', '2028-12-1');

insert into paymentType (typePayment, titularNameCard, lastNumCard, flagCard, validityCard)
	value ('PIX', null, null, null, null);	

desc clientPayment;
-- idCPpayment, idCPclient, titularNameCard, lastNumCard, flagCard, validityCard
insert into clientPayment (idCPpayment, idCPclient)
	value (1, 5),
		  (2, 3),
          (3, 4),
          (4, 2),
          (5, 2),
          (6, 3);
insert into clientPayment (idCPpayment, idCPclient)
	value (7, 1);


select * from clientPayment;

desc orders;
-- idOrder, idOrderClient, orderStatus, orderDescription, sendValue, paymentCash
insert into orders (idOrderClient, orderStatus, orderDescription, sendValue)
	value (1, default, 'compra via aplicativo', default),
		  (2, default, 'compra via aplicativo', 50),
          (3, 'Confirmado', null, default),
          (4, default, 'compra via web site', 150);
		
insert into orders (idOrderClient, orderStatus, orderDescription, sendValue)
	value (2, 'Cancelado', 'compra via aplicativo', 25),
		  (5, default, 'compra via web site', 40),
          (2, 'Confirmado', 'compra via web site', 20),
          (6, 'Cancelado', 'compra via aplicativo', 15),
          (6, default, 'Compra via aplicativo', 24),
          (5, default, 'compra via web site', 34);

select * from orders;

desc productOrder;
-- idPOproduct, idPOorder, poQuantity, poStatus
insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus)
	value (1, 1, 2, default),
		  (2, 1, 1, default),
          (3, 2, 1, default);
          
insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus)
	value (4, 3, 4, default),
		  (5, 3, 2, default),
          (7, 3, 1, default),
		  (7, 1, 2, default),
          (7, 2, 1, default),
          (4, 2, 1, default),
          (4, 6, 3, default);

select * from productOrder;

desc productStorage;
-- idProdStorage, storageLocation, quantity
insert into productStorage (storageLocation, quantity)
	value ('Rio de Janeiro', 1000),
		  ('Rio de Janeiro', 500),
          ('São Paulo', 10),
          ('São Paulo', 100),
          ('São Paulo', 10),
          ('Brasília', 60);

select * from productStorage;

desc storageLocation;
-- idLproduct, idLstorage, location
insert into storageLocation (idLproduct, idLstorage, ProductQuantity)
	value (1, 2, 469),
		  (2, 6, 398),
          (3, 4, 799),
          (4, 2, 10),
          (4, 3, 100);

desc supplier;
-- idSupplier, SocialName, CNPJ, contact
insert into supplier (SocialName, CNPJ, contact)
	value ('Almeida e filhos', 123456789123456, '21985474'),
		  ('Eletrônicos Silva', 854519649143457, '21985484'),
          ('Eletrônicos Valma', 934567893934695, '21975474');

desc productSupplier;
-- idPSsupplier, idPSproduct, Quantity
insert into productSupplier (idPSsupplier, idPSproduct, Quantity)
	value (1, 1, 500),
		  (1, 2, 400),
          (2, 4, 633),
          (3, 3, 5),
          (2, 5, 10);

desc seller;
-- idSeller, SocialName, AbstName, CNPJ, CPF, location, contact
insert into seller (SocialName, AbstName, CNPJ, CPF, location, contact)
	value ('Tech eletronics', null, 123456789456321, null, 'Rio de Janeiro', '214354637'),
		  ('Botique Durgas', null, null, 123456783, 'Rio de Janeiro', '298456307'),
          ('Kids World', null, 456789123654485, null, 'São Paulo', '11913456738');

insert into seller (SocialName, AbstName, CNPJ, CPF, location, contact)
	value ('Eletrônicos Silva', null, 854519649143457, null, 'Rio de Janeiro', '264973084');


desc productSeller;
-- idPseller, idPproduct, prodQuantity
insert into productSeller (idPseller, idPproduct, prodQuantity)
	value (1, 6, 80),
		  (2, 7, 10);