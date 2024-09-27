### Comandos DML ###

DELETE FROM especialidades
WHERE id_especialidade=11;

UPDATE exames SET valor = valor * 1.10 #ou = valor + (valor*0.10), desse forma seria mais ideal, por ser variavel
WHERE valor < 200; 
#WHERE valor BETWEEN 10 AND 200 - altera o valor em uma faixa de valores especeficados; 
#WHERE valor IN (80,150) - altera o valor de valor iguais ao informado;

UPDATE pacientes SET cidade = "Rio de Janeiro", bairro = "Ipanema"
WHERE id_paciente = 1;

SELECT id_medico "Codigo", nome #select ira selecionar o campos especificados na linha, o "Codigo" altera o 'id_medico' para 'Codigo' -> seria um rotulo
FROM medicos
WHERE id_especialidade = 1;


### ineer join = junção ###
-- serve para exibir duas tabelas atraves das chaves estrangeiras


SELECT *
FROM tabela INNER JOIN tabela2 
ON (tabela.campo=tabela2.campo);


SELECT m.id_medico "Codigo medico", m.nome, e.descritivo "especialidade" 
/* usa a especificação com 'tabela.campo' para não acontecer o erro de ambiguidade */
FROM medicos m INNER JOIN especialidades e 
#ao alterar o 'medico' para 'm' é uma referencia
ON (m.id_especialidade = e.id_especialidade); 
#'m.id_especialidade' chama a 'fk' da tabela medicos, ja o 'e.id_especialidade chama o 'id' da tabela especialidades



SELECT m.id_medico "Codigo Medico", m.nome, DATE_FORMAT(a.data_a, "%d/%m/%Y")
"Data da Consulta", a.horario_a "Horario da Consulta"
FROM medicos m INNER JOIN atendimentos a
ON (m.id_medico = a.id_medico)
ORDER BY data_a; # 'ORDER BY' = "ordenar por', nesse caso vai ordenar pela a data, sempre a ultima clausa desse comodo



SELECT p.id_paciente "Código Paciente", p.nome, p.sexo, DATE_FORMAT(a.data_a, "%d/%m/%Y") "Data_Consulta", 
a.horario_a "Horario_Consulta"
FROM pacientes p INNER JOIN atendimentos a
ON (p.id_paciente = a.id_paciente)
ORDER BY data_a;


-- Exercicio 3 
SELECT m.id_medico "Código Médico", m.nome "Nome Médico",  m.sexo, e.descritivo "Especialidade do Médico", DATE_FORMAT(a.data_a, "%d/%m/%Y") "Data Consulta", p.nome "Atendimento"
FROM atendimentos a INNER JOIN medicos m
ON (a.id_medico = m.id_medico) 
INNER JOIN especialidades e 
ON (m.id_especialidade = e.id_especialidade) 
INNER JOIN pacientes p 
ON (p.id_paciente = a.id_paciente)
WHERE m.sexo = "F"
ORDER BY m.nome;

-- Exercicio 4                 o 'format' fez formatação da exbição, invertendo o formato americano para o nosso brasileiro
SELECT e.id_exame "Codigo", e.descritivo, FORMAT(e.valor, 2, "de_DE") "Valor", 
r.id_realizae, DATE_FORMAT(r.data_e, "%d/%m/%y") "Data_Exame", p.nome "Nome Paciente"
FROM realiza_exames r INNER JOIN exames e
ON (r.id_exame = e.id_exame) INNER JOIN pacientes p ON (r.id_paciente = p.id_paciente)
ORDER BY e.descritivo DESC; -- 'DESC' inverte a order de Z-A ao inves de A-Z


-- Exercicio 6
# Usando o 'LEFT JOIN' para exibir medicos que não fizeram nenhum atendimento
SELECT m.id_medico "Código do Médico", m.nome "Nome Médico", DATE_FORMAT(m.data_nasc, "%d/%m/%Y") "Data_nasc", e.descritivo
FROM medicos m LEFT JOIN atendimentos a # 'LEFT JOIN' exibi todos os campos da tabelas até mesmo aquelas que não tem associação
ON (m.id_medico = a.id_medico) 
INNER JOIN especialidades e
ON (e.id_especialidade = m.id_especialidade)
WHERE a.id_medico IS NULL
ORDER BY m.data_nasc;

-- Exercicio 7
SELECT m.id_medico "Código Médico", m.nome, m.sexo, e.descritivo
FROM medicos m LEFT JOIN atendimentos a
ON (m.id_medico = a.id_medico)
INNER JOIN especialidades e
ON (e.id_especialidade = m.id_especialidade)
WHERE a.id_medico IS NULL AND m.sexo = "M" 
ORDER BY m.id_medico;

-- 
SELECT p.id_paciente "Código Cliente", p.nome, p.sexo
FROM pacientes p LEFT JOIN atendimentos a
ON (p.id_paciente = a.id_paciente)
WHERE a.id_paciente IS NULL
ORDER BY p.id_paciente;
