# Projeto: Sistema de Gestão para Clínica Odontológica

## O projeto contempla a modelagem <b>CONCEITUAL, LÓGICA</b> (feitas no site BRModelo: https://app.brmodeloweb.com/) e <b>FÍSICA</b> (feita no pgAdmin 4: https://www.pgadmin.org/) de um <b>BANCO DE DADOS</b> (PosgreSQL: https://www.postgresql.org/) para o armazenamento dos dados necessários para a gestão dos pacientes, dentistas, consultas, procedimentos e horários.

### Esse modelo poderia ser usado em outros tipos de clínicas médicas, talvez sendo necessário apenas alguns ajustes para que ele se enquadre na regra de negócio solicitada. Já que ele é capas de armazenar as informações dos pacientes, profissionais, atendimentos, horários de disponibilidade, consultas e armazena o histórico de todas essas informações de forma coesa.

## Modelo Conceitual:

![alt text](<Prints/Modelo Conceitual.png>)

## Modelo Lógico:

![alt text](<Prints/Modelo Lógico.png>)

## Modelo Físico:

### O modelo físico foi dividido em três arquivos independentes, para facilitar o entendimento do funcionamento.

## A primeira parte diz respeito a criação do banco de dados e suas regras de negócio.

```SQL
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
```
## A segunda parte é uma simulação de inserção de dados, referentes a cada tabela do banco de dados. Primeiro preenchendo as tabelas "mães" e após preenchendo as tabelas "filhas", assim registrando as cardinalidades corretamente. Exemplo: Não é possível cadastrar uma consulta para um cliente que ainda não existe.

```SQL
--------------------------------------
-- Inserção dos dados dos Pacientes --
--------------------------------------
INSERT INTO matriz.paciente
(nome_completo, cpf, data_nascimento, telefone, email, numero_endereco, cep)
VALUES
('Ana Souza Lima', '12345678901', '1990-05-12', '(41) 99876-1234', 'ana.lima@email.com', '123A', '80010-000'),
('Bruno Martins Silva', '23456789012', '1985-08-23', '(41) 99765-2345', 'bruno.silva@email.com', '45B', '80020-310'),
('Carla Mendes Rocha', '34567890123', '1992-11-30', '(41) 99654-3456', 'carla.rocha@email.com', '78', '80230-110'),
('Daniel Pereira Costa', '45678901234', '1988-02-14', '(41) 99543-4567', 'daniel.costa@email.com', '210', '80310-150'),
('Eduarda Alves Ferreira','56789012345', '1995-07-19', '(41) 99432-5678', 'eduarda.ferreira@email.com','9C', '80420-210'),
('Felipe Gomes Santos', '67890123456', '1983-03-05', '(41) 99321-6789', 'felipe.santos@email.com', '321',  '80510-000'),
('Gabriela Ribeiro Lopes','78901234567', '1998-09-27', '(41) 99210-7890', 'gabriela.lopes@email.com', '654', '80620-250'),
('Henrique Barbosa Nunes','89012345678', '1979-12-11', '(41) 99109-8901', 'henrique.nunes@email.com', '12', '80730-300'),
('Isabela Teixeira Duarte','90123456789','2000-01-22', '(41) 99098-9012', 'isabela.duarte@email.com', '87D', '80840-400'),
('João Carvalho Freitas', '01234567890', '1993-06-03', '(41) 98987-0123', 'joao.freitas@email.com', '500', '80950-500'),
('Carlos Eduardo Santos', '23456789002', '1985-10-25', '(11) 98765-4321', 'carlos.santos@email.com', '456B', '01310-000'),
('Mariana Oliveira Rocha', '34567880123', '1993-02-08', '(21) 97654-3210', 'mari.rocha@email.com', '789C', '20040-000'),
('Ricardo Alves Pereira', '45678903124', '1978-12-15', '(31) 96543-2109', 'ricardo.alves@email.com', '101D', '30110-000'),
('Juliana Costa Neves', '56789013345', '2000-07-20', '(51) 95432-1098', 'ju.neves@email.com', '202E', '90010-000'),
('Fernando Souza Melo', '67890123546', '1988-04-03', '(61) 94321-0987', 'f.melo@email.com', '303F', '70040-000'),
('Beatriz Machado Dias', '88901234567', '1995-09-17', '(48) 93210-9876', 'bia.dias@email.com', '404G', '88010-000'),
('Thiago Moreira Luz', '80912345678', '1982-11-30', '(71) 92109-8765', 'thiago.luz@email.com', '505H', '40010-000'),
('Camila Ferreira Gomes', '90213456789', '1997-01-22', '(81) 91098-7654', 'camila.gomes@email.com', '606I', '50010-000'),
('Lucas Vieira Silva', '01234576890', '1991-06-10', '(92) 90987-6543', 'lucas.vieira@email.com', '707J', '69010-000'),
('Patrícia Nunes Barbosa', '11223343556', '1986-03-05', '(19) 99887-7665', 'patricia.nunes@email.com', '808K', '13010-000');

--------------------------------------
-- Inserção dos dados dos Dentistas --
--------------------------------------
INSERT INTO matriz.dentista
(nome_completo, cpf, cro, especialidade)
VALUES
('Mariana Alves Costa', '11111111101', 'CRO-PR 12345', 'Ortodontia'),
('Ricardo Souza Lima', '22222222202', 'CRO-PR 12346', 'Endodontia'),
('Fernanda Rocha Mendes', '33333333303', 'CRO-PR 12347', 'Implantodontia'),
('Carlos Eduardo Pinto', '44444444404', 'CRO-PR 12348', 'Clínico Geral'),
('Juliana Ferreira Alves','55555555505', 'CRO-PR 12349', 'Odontopediatria'),
('Paulo Henrique Gomes', '66666666606', 'CRO-PR 12350', 'Periodontia'),
('Aline Ribeiro Santos', '77777777707', 'CRO-PR 12351', 'Ortodontia'),
('Bruno Carvalho Nunes', '88888888808', 'CRO-PR 12352', 'Cirurgia Bucomaxilofacial'),
('Camila Teixeira Duarte', '99999999909', 'CRO-PR 12353', 'Estética Dental'),
('Lucas Barbosa Freitas', '00000000000', 'CRO-PR 12354', 'Prótese Dentária');

-------------------------------------
-- Inserção dos dados dos Horários --
-------------------------------------
INSERT INTO matriz.horario
(dia_semana, horario_inicio, horario_fim)
VALUES
('Segunda', '08:00', '09:00'),
('Segunda', '09:00', '10:00'),
('Segunda', '10:00', '11:00'),
('Segunda', '11:00', '12:00'),
('Terça', '08:00', '09:00'),
('Terça', '09:00', '10:00'),
('Terça', '10:00', '11:00'),
('Terça', '11:00', '12:00'),
('Quarta', '13:00', '14:00'),
('Quarta', '14:00', '15:00'),
('Quarta', '15:00', '16:00'),
('Quarta', '16:00', '17:00'),
('Quinta', '13:00', '14:00'),
('Quinta', '14:00', '15:00'),
('Quinta', '15:00', '16:00'),
('Quinta', '16:00', '17:00'),
('Sexta', '08:00', '09:00'),
('Sexta', '09:00', '10:00'),
('Sexta', '10:00', '11:00'),
('Sexta', '11:00', '12:00');

---------------------------------------------
-- Agenda de disponibilidade dos dentistas --
---------------------------------------------
INSERT INTO matriz.disponibilidade 
(id_horario, id_dentista)
VALUES
(1, 1), (2, 1), (3, 1), (4, 1), (7, 1), 
(1, 2), (2, 2), (3, 2), (5, 2), (8, 2), 
(14, 2), (4, 3), (5, 3), (9, 3), (10, 3),         
(6, 4), (19, 4), (7, 5), (20, 5), (1, 6), 
(2, 6), (11, 7), (12, 7), (3, 7), (13, 8), 
(14, 8), (15, 9), (16, 9), (17, 10), (18, 10);

------------------------------------------
-- Inserção dos dados dos das Consultas --
------------------------------------------
INSERT INTO matriz.consulta
(data_consulta, hora_consulta, prescricao, status, id_paciente, id_dentista)
VALUES
('2026-04-01', '08:00', 'Limpeza básica', 'Realizada', 1, 1),
('2026-04-01', '09:00', 'Avaliação geral', 'Agendada', 2, 1),
('2026-04-02', '10:00', 'Tratamento de canal', 'Agendada', 3, 2),
('2026-04-02', '11:00', 'Extração simples', 'Cancelada', 4, 2),
('2026-04-03', '13:00', 'Clareamento dental', 'Agendada', 5, 3),
('2026-04-03', '14:00', 'Manutenção aparelho', 'Realizada', 6, 1),
('2026-04-04', '15:00', 'Implante dentário', 'Agendada', 7, 3),
('2026-04-04', '16:00', 'Consulta pediátrica', 'Realizada', 8, 5),
('2026-04-05', '17:00', 'Profilaxia', 'Agendada', 9, 4),
('2026-04-05', '08:30', 'Ajuste de prótese', 'Agendada', 10, 5),
('2026-04-01', '14:00', 'Revisão de pontos', 'Realizada', 11, 1),
('2026-04-01', '10:00', 'Avaliação ortodôntica', 'Agendada', 12, 6),
('2026-04-02', '15:00', 'Urgência - Dor dente', 'Agendada', 13, 2),
('2026-04-02', '08:00', 'Consulta de rotina', 'Realizada', 14, 7),
('2026-04-03', '14:00', 'Troca de elásticos', 'Agendada', 15, 3),
('2026-04-03', '09:00', 'Limpeza semestral', 'Realizada', 16, 8),
('2026-04-04', '15:00', 'Avaliação de prótese', 'Agendada', 17, 5),
('2026-04-04', '11:00', 'Remoção de tártaro', 'Agendada', 18, 9),
('2026-04-05', '09:00', 'Primeira consulta', 'Agendada', 19, 10),
('2026-04-05', '10:00', 'Finalização limpeza', 'Agendada', 1, 1),
('2026-04-06', '08:00', 'Avaliação de siso', 'Agendada', 11, 4),
('2026-04-06', '09:00', 'Limpeza retorno', 'Realizada', 12, 1),
('2026-04-06', '10:00', 'Manutenção mensal', 'Agendada', 13, 6),
('2026-04-06', '14:00', 'Ajuste de canal', 'Agendada', 14, 2),
('2026-04-07', '08:00', 'Clareamento laser', 'Agendada', 15, 3),
('2026-04-07', '09:00', 'Profilaxia infantil', 'Realizada', 16, 7),
('2026-04-07', '11:00', 'Restauração resina', 'Cancelada', 17, 8),
('2026-04-07', '15:00', 'Avaliação estética', 'Agendada', 18, 1),
('2026-04-08', '08:00', 'Cirurgia implante', 'Agendada', 19, 3),
('2026-04-08', '10:00', 'Remoção de tártaro', 'Realizada', 20, 9),
('2026-04-08', '13:00', 'Urgência dor', 'Agendada', 1, 2),
('2026-04-08', '16:00', 'Check-up anual', 'Agendada', 2, 10),
('2026-04-09', '09:00', 'Manutenção aparelho', 'Agendada', 3, 6),
('2026-04-09', '11:00', 'Extração siso', 'Agendada', 4, 4),
('2026-04-09', '14:00', 'Ajuste prótese total', 'Realizada', 5, 5),
('2026-04-09', '15:00', 'Aplicação flúor', 'Agendada', 6, 7),
('2026-04-10', '08:00', 'Revisão implante', 'Agendada', 7, 3),
('2026-04-10', '10:00', 'Limpeza profunda', 'Realizada', 8, 1),
('2026-04-10', '13:00', 'Consulta inicial', 'Agendada', 9, 8),
('2026-04-10', '16:00', 'Ortodontia preventiva', 'Agendada', 10, 6);

------------------------------------------
-- Inserção dos dados dos Procedimentos --
------------------------------------------
INSERT INTO matriz.procedimento
(nome, descricao, duracao_media)
VALUES
('Limpeza', 'Remoção de tártaro e placa bacteriana', 30),
('Clareamento dental', 'Procedimento estético para clarear os dentes', 60),
('Extração simples', 'Remoção de dente sem complicações', 45),
('Tratamento de canal', 'Remoção da polpa dentária infectada',  90),
('Implante dentário', 'Colocação de pino para prótese',  120),
('Profilaxia', 'Limpeza preventiva odontológica',  30),
('Aplicação de flúor', 'Fortalecimento do esmalte dental', 20),
('Restauração', 'Recuperação de dente danificado', 40),
('Ajuste de prótese', 'Correção de prótese dentária', 35),
('Ortodontia manutenção', 'Ajuste periódico de aparelho', 25);

------------------------------------------------
-- Procedimentos realizados por cada consulta --
------------------------------------------------
INSERT INTO matriz.realiza 
(id_consulta, id_procedimento)
VALUES
(1, 1), (1, 2), (2, 1), (3, 3), (4, 4), (5, 5), (6, 2),
(7, 6), (8, 1), (9, 3), (11, 8), (12, 10), (13, 4), 
(14, 6), (15, 10), (16, 1), (17, 9), (18, 1), (19, 6), 
(20, 1), (21, 3), (22, 1), (23, 10), (24, 4), (25, 2), 
(26, 6), (27, 8), (28, 2), (29, 5), (30, 1), (31, 4), 
(32, 6), (33, 10), (34, 3), (35, 9), (36, 7), (37, 5),
(38, 1), (39, 6), (40, 10);
```
## A terceira parte contem comandos SQL simulando possíveis eventos, como os exemplos abaixo:

```SQL
------------------------------------- Procedimento lançado errado -------------------------------------------------
-- Dentista lançou um procedimento extra na consulta de id=1 e deve apagá-lo para não cobrar a mais do paciente. --
-------------------------------------------------------------------------------------------------------------------
DELETE FROM
	matriz.realiza
WHERE
	id_consulta=1 AND id_procedimento=2;

SELECT * FROM matriz.realiza

----------------------------- Mudança na grade de horários do dentista -------------------------------
-- Dra. Mariana (id = 1) não vai mais poder atender às segundas-feiras no primeiro horário (id = 1) --
------------------------------------------------------------------------------------------------------
DELETE FROM 
	matriz.disponibilidade
WHERE
	id_horario=1 AND id_dentista=1;

select * from matriz.disponibilidade

--------------------------------------- Cancelamento de consulta -------------------------------------------
-- O paciente Henrique estava no telefone com a recepção que criou uma consulta (id=8) até que a chamada  --
-- caiu e não conseguiu confirmar os detalhes finais, então a recepção deve apagar as consultas.          --
------------------------------------------------------------------------------------------------------------
DELETE FROM
	matriz.consulta
WHERE
	id_consulta=8;

SELECT * FROM matriz.consulta

-------------------------------------------------------------
-- Criando indice em id_paciente (fk) na tabela "consulta" --
-------------------------------------------------------------
CREATE INDEX idx_consulta_id_paciente ON matriz.consulta (id_paciente);

----------------------------------------------------------
-- Criando indice em data_consulta na tabela "consulta" -- 
----------------------------------------------------------
CREATE INDEX idx_consulta_data_consulta ON matriz.consulta (data_consulta);


-------------------------------------------- Update de Fim de Consulta ----------------------------------------------------
-- Nesse caso, o dentista terminou uma consulta com o paciente de id=6 e vai atualizar a situação dele no banco de dados --
---------------------------------------------------------------------------------------------------------------------------
UPDATE matriz.consulta
SET
	status='Realizada',
	
	prescricao= '1. Amoxicilina 500mg: Tomar 1 comprimido de 8 em 8 horas por 7 dias.
	2. Ibuprofeno 600mg: Tomar 1 comprimido de 12 em 12 horas por 3 dias (em caso de dor ou inchaço).
	3. Repouso absoluto nas primeiras 24 horas.
	4. Dieta líquida ou pastosa e fria (sorvete, açaí, sopas frias) nos primeiros 2 dias.
	5. Aplicar compressa de gelo no rosto por 20 minutos a cada hora.',
	
	descricao_atendimento='Paciente compareceu à clínica para a extração do dente 38 (siso inferior esquerdo).
	Procedimento cirúrgico realizado sob anestesia local, sem intercorrências.
	Feita a sutura no local.
	Paciente orientado sobre os cuidados pós-operatórios.'
WHERE
	id_paciente = 6
AND id_dentista = 1
AND data_consulta = '2026-04-03'
AND hora_consulta = '14:00:00';

SELECT * FROM matriz.consulta WHERE	id_paciente=6

------------------------------------------ Mudança de endereço de paciente --------------------------------------------------
-- Paciente de cpf 123.456.789-01 ligou para fazer uma nova consulta e avisou que se mudou, então a recepção vai atualizar --
-----------------------------------------------------------------------------------------------------------------------------
UPDATE matriz.paciente
SET
	cep='34328-001',
	numero_endereco='672B'
WHERE
	cpf='12345678901';

SELECT * FROM matriz.paciente

--------------------------------------- Ajuste de tempo de procedimento ------------------------------------------------------
-- A gerencia da clinica percebeu que o procedimento limpeza esta atrasando a agenda, então decidem alterar a duração média --
------------------------------------------------------------------------------------------------------------------------------
UPDATE matriz.procedimento
SET
	duracao_media=45
WHERE
	id_procedimento=1; -- Limpeza;

SELECT * FROM matriz.procedimento;

--------------------------------------------------------------------------------------
-- View: Lista de Consultas Realizadas, ordenada da mais recente para a mais antiga --
--------------------------------------------------------------------------------------
CREATE VIEW matriz.vw_lista_consultas AS
SELECT 
	c.id_consulta,	
	p.nome_completo AS nome_paciente,
	d.nome_completo AS nome_dentista,
    c.data_consulta,    
    c.status,
	proc.nome AS procedimento
FROM matriz.consulta AS c
INNER JOIN matriz.paciente AS p 
    ON c.id_paciente = p.id_paciente
INNER JOIN matriz.dentista AS d 
    ON c.id_dentista = d.id_dentista
INNER JOIN matriz.realiza AS r
	ON c.id_consulta=r.id_consulta
INNER JOIN matriz.procedimento AS proc
	ON r.id_procedimento=proc.id_procedimento
WHERE
	status!='Cancelada' AND status!='Agendada'
ORDER BY 
    c.data_consulta DESC;
   
SELECT * FROM matriz.vw_lista_consultas;
```

## Colaboradores:

- [@lcamaraol](https://github.com/lcamaraol)
- [@Brun0Fr3itas](https://github.com/Brun0Fr3itas)
- [@pedrohgmello](https://github.com/pedrohgmello)
- [@Valois1961](https://github.com/Valois1961)
- [@YanYMO](https://github.com/YanYMO)

![Pooh agradecendo](Prints/pooh-cute.gif)