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