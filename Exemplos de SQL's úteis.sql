
------------------------------------- Procedimento lançado errado -------------------------------------------------
-- Dentista lançou um procedimento extra na consulta de id=1 e deve apagá-lo para não cobrar a mais do paciente. --
-------------------------------------------------------------------------------------------------------------------
DELETE FROM
	matriz.realiza
WHERE
	id_consulta=1 AND id_procedimento=2;

SELECT * FROM matriz.realiza;

----------------------------- Mudança na grade de horários do dentista -------------------------------
-- Dra. Mariana (id = 1) não vai mais poder atender às segundas-feiras no primeiro horário (id = 1) --
------------------------------------------------------------------------------------------------------
DELETE FROM 
	matriz.disponibilidade
WHERE
	id_horario=1 AND id_dentista=1;

SELECT * FROM matriz.disponibilidade;

--------------------------------------- Cancelamento de consulta -------------------------------------------
-- O paciente Henrique estava no telefone com a recepção que criou uma consulta (id=8) até que a chamada  --
-- caiu e não conseguiu confirmar os detalhes finais, então a recepção deve apagar as consultas.          --
------------------------------------------------------------------------------------------------------------
DELETE FROM
	matriz.consulta
WHERE
	id_consulta=8;

SELECT * FROM matriz.consulta;

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

SELECT * FROM matriz.consulta WHERE	id_paciente=6;

------------------------------------------ Mudança de endereço de paciente --------------------------------------------------
-- Paciente de cpf 123.456.789-01 ligou para fazer uma nova consulta e avisou que se mudou, então a recepção vai atualizar --
-----------------------------------------------------------------------------------------------------------------------------
UPDATE matriz.paciente
SET
	cep='34328-001',
	numero_endereco='672B'
WHERE
	cpf='12345678901';

SELECT * FROM matriz.paciente;

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

------------------------------------------
-- Consultas marcadas por especialidade --
------------------------------------------
SELECT
	d.especialidade,
	COUNT(c.id_consulta) AS quantidade_consulta		
FROM matriz.consulta AS c
INNER JOIN
	matriz.dentista AS d
ON d.id_dentista=c.id_dentista
GROUP BY
	d.especialidade
ORDER BY
	quantidade_consulta DESC;
	
----------------------------
-- Consultas por dentista --
----------------------------
SELECT
	d.nome_completo,
	COUNT(c.id_consulta) AS quantidade_consulta	
FROM matriz.consulta AS c
INNER JOIN
	matriz.dentista AS d
ON d.id_dentista=c.id_dentista
GROUP BY
	d.nome_completo
ORDER BY
	quantidade_consulta DESC;

------------------------------------------------------------------------------
-- Média de consultas realizadas por dentista em período de dias específico --
------------------------------------------------------------------------------
SELECT 
	ROUND(AVG("Média geral de consultas".total_consultas), 2) "Média de consultas por dentista",
    (SELECT MIN(data_consulta) FROM matriz.consulta) AS data_inicio_coleta,
    (SELECT MAX(data_consulta) FROM matriz.consulta) AS data_fim_coleta,
	(SELECT MAX(data_consulta) - MIN(data_consulta) FROM matriz.consulta) AS total_dias_corridos
	FROM (
        -- Subquery: Conta quantas consultas foram feitas e agrupa os dentistas --       
		SELECT COUNT(c2.id_consulta) AS total_consultas
        	FROM matriz.dentista AS d2
            LEFT JOIN matriz.consulta AS c2 
                ON d2.id_dentista = c2.id_dentista
					WHERE c2.status = 'Realizada'
            GROUP BY d2.id_dentista
        ) AS "Média geral de consultas";
