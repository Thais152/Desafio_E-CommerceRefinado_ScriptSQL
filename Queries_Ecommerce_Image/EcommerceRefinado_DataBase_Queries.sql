-- Queries SQL

use ecommerce_refinado;

--
select * from clients;
select * from orders;
--
-- 1. Quantos pedidos foram feitos por cada cliente?

select idClient, concat(Fname, ' ', Minit, ' ', Lname) as NomeCliente, count(*) as QuantPedidos from clients
	join orders on idClient = idOrderClient
    group by idClient; 

-- 
select * from seller;
select * from supplier;
--  
-- 2. Algum vendedor também é fornecedor?

		-- Não usando JOIN para trazer as linhas que têm o mesmo CNPJ em ambas as tabelas
select s.idSeller, p.idSupplier, s.SocialName, p.CNPJ from seller s, supplier p 
	where s.CNPJ = p.CNPJ;
		-- Usando JOIN para trazer as linhas que têm o mesmo CNPJ em ambas as tabelas
select s.idSeller, p.idSupplier, s.SocialName, p.CNPJ from seller s
	INNER join supplier p ON s.CNPJ = p.CNPJ;

-- 3. Vendedores que não são fornecedores

		-- Usando LEFT JOIN
select idSeller, s.SocialName, p.CNPJ from seller s left JOIN supplier p 
	ON s.CNPJ = p.CNPJ
    where p.CNPJ is null;
    
	-- Usando Not exists
select s.CNPJ, s.SocialName
from seller s
where not exists (
    select p.CNPJ
    from supplier p
    where p.CNPJ = s.CNPJ
);

select p.CNPJ, p.SocialName
from supplier p
where not exists (
    select s.CNPJ
    from seller s
    where s.CNPJ = p.CNPJ
);


--
select * from product;
select * from supplier;
select * from productSupplier;
select * from productstorage;
select * from storageLocation;   
--
-- 4. Quantidade de produtos por estado 

select storagelocation, sum(quantity) from productstorage
	group by storagelocation;
    
--  5. Relação de produtos e estoques

select idProdStorage, storagelocation, quantity, idProduct, Pname, ProductQuantity from product	
	JOIN storageLocation ON idProduct = idLproduct
    JOIN productstorage ON idProdStorage = idLstorage;

-- 6. Quantidade total de cada produto independente do estoque

select idProduct, Pname, sum(ProductQuantity) as Quant_Total_produto from product	
	JOIN storageLocation ON idProduct = idLproduct
    group by idProduct;

-- 7. Relação de produtos, fornecedores e estoques

select SocialName as Nome_fornecedor, Pname as Nome_produto, 
	idProdStorage as Identificação_estoque, storageLocation as Localização_estoque
    from supplier
		JOIN productSupplier ON idPSsupplier = idSupplier
		JOIN product ON idPSproduct = idProduct
		JOIN storageLocation ON idLproduct = idProduct
		JOIN productstorage ON idLstorage = idProdStorage;

--
select * from product;
select * from supplier;
select * from productSupplier;
--
-- 8. Relação de nomes dos fornecedores e nomes dos produtos;

select SocialName as Fornecedor, Pname as Produto_fornecido from supplier
	JOIN productSupplier ON idPSsupplier = idSupplier
    JOIN product ON idPSproduct = idProduct;

-- 9. Quantas pessoas da tabela cliente são pessoas físicas e quantas são jurídicas

select * from clients;
select * from pessoaFísica;
select * from pessoaJuridica;
	-- Física
select concat(Fname, ' ', Minit, ' ', Lname) as NomeCompleto, Address from clients
	JOIN pessoaFísica ON idClient = idPFclient
    ORDER BY Minit;
	-- Jurídica
select concat(Fname, ' ', Minit, ' ', Lname) as NomeCompleto, Address from clients
	JOIN pessoaJuridica ON idClient = idPJclient
    ORDER BY Minit;

	-- Cláusula HAVING
select Fname, Minit, Lname, Address from clients
	JOIN pessoaFísica ON idClient = idPFclient
    HAVING Address like 'rua%';
    
--
select * from product;
select * from orders;
select * from productOrder;
select * from clients;
--
-- 10. Qual o valor final pela quantidade de produto? 

select Pname, idOrder, idOrderClient, unitValue, poQuantity, 
	round(unitValue*poQuantity, 2) as Valor_pela_quantidade from product
		JOIN productOrder ON idProduct = idPOproduct
		JOIN orders ON idOrder =  idPOorder;
        
-- 11. E o valor total por cada pedido?

select idOrder as idPedido, idOrderClient as idCliente, Fname as NomeCliente, 
	round(sum(unitValue*poQuantity), 2) as Valor_Total_pedido, 
	sum(poQuantity) as Quant_Produto, sendValue as Frete,
	round(sum(unitValue*poQuantity)+sendValue, 2) as Valor_final_frete from product
		JOIN productOrder ON idProduct = idPOproduct
		JOIN orders ON idOrder =  idPOorder
        JOIN clients ON idOrderClient = idClient
        group by idOrder;
    











