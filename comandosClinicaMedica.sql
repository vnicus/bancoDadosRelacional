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
-- 


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



