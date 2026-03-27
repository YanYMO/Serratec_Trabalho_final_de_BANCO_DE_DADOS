----------------------------------------------
-- Criação do DATABASE clinica_odontologica --
----------------------------------------------
CREATE DATABASE clinica_odontologica;

------------------------------
-- Criação do SCHEMA matriz --
------------------------------
CREATE SCHEMA matriz;

---------------------
-- Tabela Paciente --
---------------------
CREATE TABLE matriz.paciente (
    id_paciente SERIAL PRIMARY KEY,
    nome_completo VARCHAR(150) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(150) UNIQUE,
    numero_endereco VARCHAR(20) NOT NULL,
    cep VARCHAR(9) NOT NULL

	CONSTRAINT chk_telefone_formato
    	CHECK (telefone ~ '^\(\d{2}\) \d{5}-\d{4}$'),

	CONSTRAINT chk_cep_formato
		CHECK (cep ~ '^\d{5}-\d{3}$')	
);

---------------------
-- Tabela Dentista --
---------------------
CREATE TABLE matriz.dentista (
    id_dentista SERIAL PRIMARY KEY,
    nome_completo VARCHAR(150) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    cro VARCHAR(30) NOT NULL UNIQUE,
    especialidade VARCHAR(100) NOT NULL
);

--------------------
-- Tabela Horario --
--------------------
CREATE TABLE matriz.horario (
    id_horario SERIAL PRIMARY KEY,
    dia_semana VARCHAR(10),
    horario_inicio TIME NOT NULL,
    horario_fim TIME NOT NULL
	
	CONSTRAINT chk_dia_semana
    CHECK (dia_semana IN ('Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado'))

    CONSTRAINT chk_horario_valido
    CHECK (horario_fim > horario_inicio)
);

-------------------------
-- Tabela Procedimento --
-------------------------
CREATE TABLE matriz.procedimento (
    id_procedimento SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    duracao_media INT NOT NULL
);

---------------------
-- Tabela Consulta --
---------------------
CREATE TYPE matriz.status AS ENUM ('Agendada', 'Cancelada', 'Realizada');

CREATE TABLE matriz.consulta (
    id_consulta SERIAL PRIMARY KEY,
    data_consulta DATE NOT NULL,
	hora_consulta TIME NOT NULL,
    descricao_atendimento TEXT,
    prescricao TEXT,
    status matriz.status NOT NULL,
    id_paciente INT NOT NULL,
    id_dentista INT NOT NULL,

    CONSTRAINT consulta_paciente_fkey
        FOREIGN KEY (id_paciente)
        REFERENCES matriz.paciente(id_paciente)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT consulta_dentista_fkey
        FOREIGN KEY (id_dentista)
        REFERENCES matriz.dentista(id_dentista)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

	CONSTRAINT consulta_unica
		UNIQUE (id_dentista, data_consulta, hora_consulta)
);

----------------------------
-- Tabela Disponibilidade --
----------------------------
CREATE TABLE matriz.disponibilidade (
    id_disponibilidade SERIAL PRIMARY KEY,
    id_horario INT NOT NULL,
    id_dentista INT NOT NULL,

    CONSTRAINT disponivel_horario_fkey
        FOREIGN KEY (id_horario)
        REFERENCES matriz.horario(id_horario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT disponivel_dentista_fkey
        FOREIGN KEY (id_dentista)
        REFERENCES matriz.dentista(id_dentista)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

--------------------
-- Tabela Realiza --
--------------------
CREATE TABLE matriz.realiza (
    id_procedimento_consulta SERIAL PRIMARY KEY,
    id_consulta INT NOT NULL,
    id_procedimento INT NOT NULL,

    CONSTRAINT realiza_consulta_fkey
        FOREIGN KEY (id_consulta)
        REFERENCES matriz.consulta(id_consulta)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT realiza_procedimento_fkey
        FOREIGN KEY (id_procedimento)
        REFERENCES matriz.procedimento(id_procedimento)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);