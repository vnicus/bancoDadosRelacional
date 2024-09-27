#======================================#
###    Subquery´s - select aninhados ###
#======================================#
#Regras para a construção de Subqueries:
#======================================#
/*Podem ser muito úteis quando é preciso selecionar 
dados de uma tabela com uma condição que dependa da 
própria tabela ou de outras.

É possível utilizar uma subquery em várias 
cláusulas: SELECT, WHERE, HAVING e FROM.
Operadores pode ser de 2 tipos:	
	*Operadores de Uma Linha (=, >, >=, <, <=, <>).
	*Operadores de Múltiplas Linhas (IN). */
======================================================

SELECT campo1, campo2, (subquery), ....
FROM tabela1 INNER JOIN (subquery)
WHERE campox IN (subquery) AND campoy >= (subquery)
GROUP BY
HAVING campo < (subquery);

======================================================


#Exemplos#

#Ex1-Quais funcionários tem o salário maior do que o 
#salário do funcionário cujo codigo = 1.
Código     Nome      Salário   

SELECT id_funcionario "Código", nome, salario
FROM funcionarios
WHERE salario > (SELECT salario FROM funcionarios WHERE id_funcionario = 1);
	       -- entre parenteses é a subquery, sendo usado para encontrar o funcionario de id_1


#Ex2-Quais funcionários tem o salário maior do que o 
#salário do funcionário cujo codigo = 1 e que participam 
#do projeto cujo codigo = 3.
Código       Nome        Salário;

SELECT id_funcionario "Código", nome, salario
FROM funcionarios
WHERE salario > (SELECT salario FROM funcionarios WHERE id_funcionario = 1) 
AND id_funcionario IN (SELECT id_funcionario FROM funcionarios_projetos WHERE id_projeto = 3);
		-- usando 'in' posso ser feito a verificação em uma tabela interia com multiplas linhas
-- não foi necessario usar 'inner join' para verificar com outras tabelas



#Ex3-Listar os funcionários cujo valor do salário é igual 
#ao menor salário cadastrado na empresa.*/

Código	Nome	Sexo	Salário		Cargo

SELECT f.id_funcionario "Codigo", f.nome, f.sexo, 
CONCAT("R$ ", FORMAT(f.salario, "de_DE")) "Salario", c.descritivo "Cargo"
FROM funcionarios f INNER JOIN cargos c ON (f.id_cargo=c.id_cargo)
WHERE salario = (SELECT MIN(salario) FROM funcionarios);



#Ex4-Listar todos os funcionários que possuem salários 
#abaixo da média dos salários entre todos os funcionários 
#da empresa 
	
Código     Nome     Salário       Departamento
                                   descritivo ;
                                   
                                   
SELECT f.id_funcionario "Código", f.nome, CONCAT("R$ ", FORMAT(f.salario, "de_DE")) "Salario",
d.descritivo "Departamento", 
CONCAT("R$ ", FORMAT((SELECT AVG(salario) FROM funcionarios), "de_DE")) "Média"
FROM funcionarios f INNER JOIN departamentos d 
ON (f.id_departamento = d.id_departamento)
WHERE f.salario < (SELECT AVG(salario) FROM funcionarios);



#Ex6-Criar uma query para reajustar em 10% o salario de 
#todos os funcionarios com numero de dependentes maior 
#do que 2.

UPDATE funcionarios SET salario = salario*1.10
WHERE id_funcionario IN (
SELECT id_funcionario 
FROM dependentes
GROUP BY id_funcionario
HAVING COUNT(id_funcionario) >= 2
-- seleciona os funcionarios que tem dois ou mais dependentes
);




#Ex7-Liste todos os dependentes que possuem idade maior 
#ou igual a idade média de todos os dependentes cadastrados 
#na empresa.

Código     Nome     Sexo     Idade     Média_Idadess;

SELECT id_dependente "CODIGO", nome, sexo, YEAR(CURRENT_DATE) - YEAR(datan) "idade"
FROM dependentes
WHERE (YEAR(CURRENT_DATE) - YEAR(datan)) >= 
(SELECT AVG(YEAR(CURRENT_DATE) - YEAR(datan)) FROM dependentes);


#Ex8 - Listar os departamentos que possuem 2 ou mais funcionarios

