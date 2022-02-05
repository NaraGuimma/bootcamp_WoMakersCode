select products.productName, products.productLine, products.productDescription, products.buyPrice
from products
where  products.productLine like '%Classic Cars%'
order by products.buyPrice desc
limit 5;

select city as cidade, phone as telefone, concat(addressLine1, addressLine2) as endereco_completo, state as estado, country as pais, postalCode as cep
from offices
where country like 'USA';

insert into offices (
	country,
    territory
)
values (
	'Brazil',
    'SA'
);

select * from offices where country like 'Brazil';

select orders.status, count(orders.orderNumber) from orders
group by status; 

select country from offices group by country;

select distinct country from offices;

select orders.status, count(orders.orderNumber) from orders
group by status
having status like 'Shipped'; 

select orders.status, count(orders.orderNumber) as quantidade from orders
group by status
having quantidade >100; 


select * from orderdetails
where orderNumber in
	(select orderNumber from orders where status like 'Shipped');
    
    
    
select   firstName, lastName from employees
where  officeCode in (
	select officeCode from offices where country like 'USA');
    
select customerNumber, amount from payments
where amount = (
	select max(amount) from payments
);

select * from employees
where employeeNumber = (
	select salesRepEmployeeNumber from customers 
    where customerNumber = 141
);

select customerNumber, amount from payments
where amount > (
	select avg(amount) from payments
);


select * from employees
where employeeNumber = (
	select salesRepEmployeeNumber from customers 
    where customerNumber = 141
);



select * from employees
where employeeNumber in (
	select salesRepEmployeeNumber from customers 
    where customerNumber in (
		select customerNumber from payments
		where amount > (
			select avg(amount) from payments
		)
    )
);


SELECT firstName, lastName FROM employees
WHERE employeeNumber in (SELECT salesRepEmployeeNumber FROM customers
WHERE customerNumber in (SELECT customerNumber FROM payments
WHERE amount > (SELECT AVG(amount) FROM payments)));

select o.orderNumber, c.customerName from orders o inner join 
customers c on o.customerNumber = c.customerNumber;

select * from customers where 
customerNumber not in (
select customerNumber from orders
);

select o.orderNumber, c.customerName from orders o left join 
customers c on o.customerNumber = c.customerNumber;

select c.customerName, o.orderNumber from customers c left join
orders o on o.customerNumber = c.customerNumber
where o.orderNumber is null;

select p.productCode, p.productName, p.productDescription from 
products p;

select p.productCode, p.productName, p.productDescription from 
products p inner join productlines pl
on p.productLine = pl.productLine;

select c.customerName from customers c
left join orders o on 
c.customerNumber = o.customerNumber
where o.customerNumber is null;

select concat(f.firstName, f.lastName) as nome_funcionario,
c.customerName as nome_cliente, 
p.amount as pagamentos
from customers c
inner join employees f on f.employeeNumber = c.salesRepEmployeeNumber
inner join payments p on p.customerNumber = c.customerNumber;

select concat(f.firstName, f.lastName) as nome_funcionario,
c.customerName as nome_cliente, 
p.amount as pagamentos
from customers c
inner join employees f on f.employeeNumber = c.salesRepEmployeeNumber
inner join payments p on p.customerNumber = c.customerNumber
order by customerName, checkNumber;

select o.orderNumber, o.status, 
SUM(od.quantityOrdered * od.priceEach) as total
from orders o 
inner join orderdetails od
on o.orderNumber = od.orderNumber
group by o.orderNumber, o.status;

select o.orderNumber, od.orderLineNumber, o.status, 
SUM(od.quantityOrdered * od.priceEach) as total
from orders o 
inner join orderdetails od
on o.orderNumber = od.orderNumber
group by o.orderNumber, od.orderLineNumber, o.status;

select c.customerName, e.firstName as 'employee', o.orderNumber,
SUM(od.quantityOrdered * od.priceEach) as total
from orders o
inner join orderdetails od on o.orderNumber = od.orderNumber
inner join customers c on o.customerNumber = c.customerNumber
inner join employees e on c.salesRepEmployeeNumber = e.employeeNumber
group by o.orderNumber;

select c.state as customer_state, c.country as customer_country,
concat(e.firstName, ' ', e.lastName) as employee,
o.state as office_state, o.country as office_country
from customers c
inner join employees e on c.salesRepEmployeeNumber = e.employeeNumber
inner join offices o on e.officeCode = o.officeCode
having customer_state != office_state;

select c.customerNumber, c.customerName, e.employeeNumber, concat(e.firstName, ' ', e.lastName) as employee_name
from customers c
right join employees e
on c.salesRepEmployeeNumber = e.employeeNumber;

select * from employees
where employeeNumber  in (
	select salesRepEmployeeNumber from customers
);

select distinct status from orders;

select orderNumber, 
case status
	when 'Shipped' then 'Enviado'
    when 'Resolved' then 'Resolvido'
    when 'Cancelled' then 'Cancelado'
    when 'On Hold' then 'Em Espera'
    when 'Disputed' then 'Contestada'
    else 'Em progresso'
end
from orders;

select orderNumber, 
case status
	when 'Shipped' then 'Enviado'
    when 'Resolved' then 'Resolvido'
    when 'Cancelled' then 'Cancelado'
    when 'On Hold' then 'Em Espera'
    when 'Disputed' then 'Contestada'
    else 'Em progresso'
end
from orders
group by orderNumber, status;


select ifnull(c.customerNumber, 'SEM VALOR'), ifnull(c.customerName, 'SEM VALOR'), e.employeeNumber, concat(e.firstName, ' ', e.lastName) as employee_name
from customers c
right join employees e
on c.salesRepEmployeeNumber = e.employeeNumber;


select customerNumber, ifnull(`salesRepEmployeeNumber`, 'SEM REPRESENTANTE')
from customers;

select customerName, length(customerName) as tamanho_nome
from customers;

select lcase(customerName)
from customers;

select lcase(customerName), ucase(customerName)
from customers;

select lcase(customerName), ucase(customerName), substring(customerName, 2,5)
from customers;

select lcase(customerName), ucase(customerName), substring(replace(customerName, ' ', ''), 2,5)
from customers;
	
select curdate();    

select date_format(curdate(), '%m/%d/%Y');

select now();

select datediff('2015-11-04', '2014-11-04');

select datediff('2015-11-04', '2014-11-04')/365;

select date_add(curdate(), interval 2 day);

select date_sub(now(), interval 2 day);

select date_sub(curdate(), interval 2 day);

select convert((datediff('2015-11-04', '2014-11-04')/365), decimal);
