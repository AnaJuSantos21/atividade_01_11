create database bd_exporta;

use bd_exporta;

create table departamento (
    id int primary key auto_increment not null,
    nome varchar(50),
    localizacao varchar(50),
    orcamento decimal(10, 2)
    );
    
    insert into departamento (nome, localizacao, orcamento) values
    ('Recursos Humanos', 'São Paulo', 50000.00),
    ('Financeiro', 'Rio de Janeiro', 75000.00),
    ('Marketing', 'Belo Horizonte', 60000.00),
    ('TI', 'Curitiba', 90000.00),
    ('Vendas', 'Porto Alegre', 45000.00);
    
    
    select * from departamento
    into outfile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\depto.csv'
    fields terminated by ',' enclosed by '"'
    lines terminated by '\n';

delete from departamento
where id = 5;

    #importa arquivo .csv exportado
    load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\depto.csv'
    into table departamento
    fields terminated by ',' enclosed by '"'
    lines terminated by '\n';
    
    -- Início da transação 
Start transaction;

   -- Aumentar o orçamento do departamento de TI em 1000
update departamento set orcamento = orcamento + 1000.00 where nome = 'TI';

   -- aumentar o orçamento do departamento financeiro m 1000
update departamento set orcamento = orcamento + 1000.00 where nome = 'Financeiro';

   -- confirmar a transação 
commit;

Start transaction;

   -- Reduzir o orçamento do departamento de marketing em 5000
update departamento set orcamento = orcamento - 5000.00 where nome = 'Marketing';

   -- Reduzir o orçamento do departamento de vendas em 3000
update departamento set orcamento = orcamento - 3000.00 where nome = 'Vendas';

-- Cancelar a transação 
rollback;

Start transaction;

 -- Aumentar o orçamento do departamento de Recursos humanos em 7000
update departamento set orcamento = orcamento + 7000.00 where nome = 'Recursos Humanos';

-- Definir um ponto intermedíario
savepoint ajuste_parcial;

   -- aumentar o orçamento do departamento de vendas em 2000
update departamento set orcamento = orcamento + 2000.00 where nome = 'Vendas';

-- reverter para o ponto intermediário (desfaz o aumento do orçamento de vendas)
rollback to ajuste_parcial;