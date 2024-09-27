### Criação das tabela da base de dados ###

CREATE DATABASE clinica_medica;

CREATE TABLE especialidades #'tabale' no plurarl, 'id' no singular
( 
 id_especialidade INT AUTO_INCREMENT PRIMARY KEY,
 descritivo VARCHAR(80) NOT NULL 
); #'varchar' é usando quando n se sabe a quantidades de caracters q serão usados, 'varchar = dinamico'


CREATE TABLE medicos 
(
  id_medico INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(80) NOT NULL,
  sexo ENUM('F', 'M') NOT NULL, #'ENUM' limita o campo a receber valores determinados
  data_nasc DATE NOT NULL,
  CRM INT NOT NULL,
  id_especialidade INT NOT NULL,
  FOREIGN KEY (id_especialidade) REFERENCES especialidades(id_especialidade)
);

CREATE TABLE pacientes 
(
  id_paciente INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(80) NOT NULL,
  sexo ENUM('F', 'M') NOT NULL,
  #campos derividos do atributo composto endereço
  logradouro VARCHAR(80) NOT NULL,
  bairro VARCHAR(80) NOT NULL,
  cidade VARCHAR(80) NOT NULL,
  estado CHAR(2) NOT NULL
);

CREATE TABLE atendimentos 
(
  id_atendimento INT AUTO_INCREMENT PRIMARY KEY,
  data_a DATE NOT NULL,
  horario_a TIME NOT NULL,
  id_paciente INT not null,
  id_medico INT not null,
  FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente),
  FOREIGN KEY (id_medico) REFERENCES medicos(id_medico)
);

CREATE TABLE exames 
(
  id_exame INT AUTO_INCREMENT PRIMARY KEY,
  valor DECIMAL(8,2) NOT NULL, #'DECIMAL' add virgula, são 8 depois das duas primeiras casas é colocado a virgula ex.: 000.000,00
  descritivo VARCHAR(80) NOT NULL
);

CREATE TABLE realiza_exames 
(
 id_realizae INT AUTO_INCREMENT PRIMARY KEY,
 data_e DATE NOT NULL,
 horario_a TIME NOT NULL,
 id_exame INT not null,
 id_paciente INT not null,
 FOREIGN KEY (id_exame) REFERENCES exames(id_exame),
 FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente)
);

