### Funções Agregadas - Agrupamento ###

SUM(parametro) - numerico - soma valores -- n utiliza id's e nem strings
AVG(parametro) - numerico - media aritmética
COUNT(parametro) - id - contador de registro -- usa o id pois id é um idetificador de registro

MAX(parametro) - maior elemento de um grupo
MIN(parametro) - menor elemento de um grupo;

-- -------------- --

#Exemplo 1 - quantos medico tem cadastrado na clinica
DAY() - extrai dia de um campo DATE
MONTH() - extrai mes de um campo DATE
YEAR() - extrai ano de um campo DATE;


SELECT COUNT(*) "numero de Médicos cadastrados"
FROM medicos
WHERE sexo = "F" AND YEAR(data_nasc) > 1970;

-- -------- --

SELECT COUNT(id_medico) "numero de Médicos cadastrados" -- normalmente utiliza o id para contar
FROM medicos
WHERE sexo = "F" AND YEAR(data_nasc) > 1970;

#Exemplo 2 - Contar quantos atendimentos foram realizados na clinica

SELECT COUNT(id_atendimento) "Numeros de Atendimento"
FROM atendimentos
WHERE data_a BETWEEN "2024-08-01" AND "2024-08-10" AND id_medico IN (3, 4, 5);
/* obs. linha 32
na lina 32, esta filtrando para contar quantos atendimentos que 
foram feitos entre o dia 01/08 até o dia 10/08, a funçao 'in' define quais medicos especificos
fizeram atendimento, no caso o medico 3, 4 e 5 
*/


#Exemplo 3 - Calcule a media das idades entre todos os médicos.

SELECT CURRENT_DATE(); -- entrega a data de hoje (data do sistema)


SELECT YEAR(CURRENT_DATE()) - YEAR(data_nasc) "Idade dos medicos" 
-- calculando a idade de cada medico
FROM medicos;


SELECT FORMAT(AVG(YEAR(CURRENT_DATE()) - YEAR(data_nasc)), 2) "Idade dos medicos" 
-- calculando a media de idade dos medicos
FROM medicos;
/*  obs. linha 47
- format(x, y) define quantas casas serão exibidas
- avg(), calcula a média
- current_date(), pega a data do sistema
- year(data_nasc), pega o ano da coluna de data de nascimento da tabela medico
*/


#Exemplo 4 - calcular a media dos valores de exames cadastrados.

-- 'CONCAT' server para concaternar
SELECT CONCAT("R$ ", FORMAT(AVG(valor), 2, "de_DE")) "media valores de Exames"
FROM exames;

-- fazendo a média de forma manual
SELECT SUM(valor), COUNT(valor), SUM(valor)/COUNT(valor)
FROM exames;


#Exemplo 5 - calcular a receita da clinica considerando o valor da consulta padrão R$ 250,00

SELECT CONCAT("R$ ", FORMAT(COUNT(id_atendimento)*250, 2, "de_DE")) "Receita da clinica",
FROM atendimentos;

SELECT CONCAT("R$ ", FORMAT(COUNT(id_atendimento)*250, 2, "de_DE")) "Receita da clinica por Medicos M"
FROM atendimentos a INNER JOIN medicos m
ON (m.id_medico = a.id_medico)
WHERE m.sexo = "M";


SELECT CONCAT("R$ ", FORMAT(COUNT(id_atendimento)*250, 2, "de_DE")) "Receita da clinica por Medicos F"
FROM atendimentos a INNER JOIN medicos m 
ON (m.id_medico = a.id_medico)
WHERE m.sexo = "F";


# Exemplo 6 - Achar o exame com maior valor

SELECT MAX(valor) "Exame de Maior valor"
FROM exames;

# Exemplo 7 - Achar o exame com menor valor

SELECT MIN(valor) "Exame de Menor valor"
FROM exames;

# Exemplo 8 - Achar o exame com o maior e menor valor

SELECT MAX(valor) "Exame de Maior valor", MIN(valor)"Exame de Menor valor"
FROM exames;



### base de dados - Faculdade_wds ###

#exercicio 1 - contar o numero de aluno de sexo M da faculdade

SELECT COUNT(id_aluno) "Numero total de alunos"
FROM alunos
WHERE sexo = "M";

#Exercicio 2 - calcular a receite da faculdade. 
#A receita da faculdade é a soma dos valores de todas as 
#disciplinas que estao sendo cursadas

SELECT CONCAT("R$ ", FORMAT(SUM(d.valor), 2, "de_DE")) "Receita da Faculdade"
FROM matriculas m INNER JOIN disciplinas d
ON (m.id_disciplina = d.id_disciplina);

#Exercicio 3 - Calcular a receita de cada curso da faculdade

SELECT c.id_curso "Código curso", c.descritivo, CONCAT("R$ ", FORMAT(SUM(d.valor), 2, "de_DE")) "Receita por curso"
FROM matriculas m INNER JOIN disciplinas d
ON (m.id_disciplina = d.id_disciplina) INNER JOIN cursos c 
ON (c.id_curso = d.id_curso)
GROUP BY c.id_curso; -- 'Group By', faz o desagrupamento por id dos cursos


### 13-09-2024 ###

# Ex1 - calcular o num de alunos do sexo F em cada curso. Classificar a lista em ordem Alfabetica

SELECT c.id_curso "Codigo", c.descritivo "Curso", COUNT(a.id_aluno) "N_Alunos"
FROM alunos a INNER JOIN cursos c
ON (a.id_curso = c.id_curso)
WHERE a.sexo = "F"
GROUP BY c.id_curso
HAVING N_Alunos >= 6 -- 'Having' usado para exibir com uma condição o 'Count'
ORDER BY c.descritivo;

# Ex2 - calcular o num de disciplnas ministradas por cada professor. 
# classificar listagem em ordem alfabetica pelo o nome do professor

SELECT p.id_professor "Codigo Professor", p.nome "Nome Professor", c.descritivo, COUNT(d.id_disciplina) "Nro_disciplinas"
FROM disciplinas d INNER JOIN professores p
ON (d.id_professor = p.id_professor) INNER JOIN cursos c
ON (p.id_curso = c.id_curso)
GROUP BY p.id_professor
ORDER BY p.nome;

# Ex3 - calcular o num de alunos matriculados em cada disciplina, classificar por id da disciplina

SELECT d.id_disciplina "Código disciplina", d.descritivo "Nome Curso", COUNT(m.id_disciplina) "Nro_alunos"
FROM matriculas m INNER JOIN alunos a
ON (m.id_aluno = a.id_aluno) INNER JOIN disciplinas d
ON (m.id_disciplina = d.id_disciplina)
GROUP BY  d.id_disciplina
ORDER BY d.id_disciplina;

#ex4 - Calcular a mensalidade que cada aluno paga pelas as disciplinas cursadas
# classificar a listagem pelo o nome

SELECT a.id_aluno "Código Aluno", a.nome "Nome do Aluno", c.descritivo "Nome Curso", 
CONCAT( "R$ ", FORMAT(SUM(d.valor), 2, "de_DE")) "Valor", COUNT(m.id_aluno)
FROM matriculas m INNER JOIN disciplinas d
ON (m
.id_disciplina = d.id_disciplina) INNER JOIN alunos a
ON (m.id_aluno = a.id_aluno) INNER JOIN cursos c
ON (a.id_curso = c.id_curso)
GROUP BY a.id_aluno
ORDER BY a.nome;


