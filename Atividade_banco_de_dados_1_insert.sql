
INSERT INTO Paciente (nome, cpf, data_nascimento, endereco, telefone, email)
VALUES 
('João Silva', '12345678901', '1990-05-15', 'Rua A, 100', '11999999999', 'joao@email.com'),
('Maria Souza', '98765432100', '1985-10-20', 'Rua B, 200', '21988888888', 'maria@email.com');


INSERT INTO Medicos (crm, nome, cpf, especialidade, forma_contato)
VALUES
('CRM001', 'Dr. Carlos Almeida', '11122233344', 'Cardiologia', 'carlos@hospital.com'),
('CRM002', 'Dra. Ana Lima', '55566677788', 'Dermatologia', 'ana@hospital.com');


INSERT INTO Sala (equipamento)
VALUES
('Sala com Aparelho de Ultrassom'),
('Sala com Equipamentos de Dermatologia');

INSERT INTO Consulta (data, horario, status, FK_id_paciente, FK_crm_medico, FK_id_sala)
VALUES
('2025-09-25', '09:00', 'agendada', 1, 'CRM001', 1),
('2025-09-23', '03:00', 'agendada', 1, 'CRM001', 1),
('2025-09-26', '14:30', 'realizada', 2, 'CRM002', 2);

UPDATE Consulta
SET status = 'realizada'
WHERE id = 1;

INSERT INTO Registro_Consulta (FK_id_consulta, sintomas, diagnostico)
VALUES
(1, 'Dor no peito e cansaço', 'Possível angina'),
(2, 'Manchas na pele', 'Dermatite alérgica');


INSERT INTO Receita_Medica (FK_id_registro, medicamentos, dosagens, orientacoes, validade_prescricao)
VALUES
(1, 'AAS', '100mg/dia', 'Tomar após o café da manhã', '2025-12-31'),
(2, 'Pomada antialérgica', 'Aplicar 2x ao dia', 'Aplicar após banho', '2025-11-30');


INSERT INTO Exames (tipo, data_realizacao, resultado, FK_crm_medico, FK_id_paciente)
VALUES
('Eletrocardiograma', '2025-09-25', 'Alterações leves', 'CRM001', 1),
('Exame de Pele', '2025-09-26', 'Presença de inflamação', 'CRM002', 2);


INSERT INTO Pagamento (FK_id_consulta, FK_id_exame, valor, data, forma_pagamento, situacao)
VALUES
(1, NULL, 200.00, '2025-09-25', 'pix', 'pendente'),
(2, 2, 350.00, '2025-09-26', 'cartao', 'pago');


INSERT INTO Convenio (FK_id_paciente, operadora, numero_carteirinha, autorizacao)
VALUES
(1, 'Unimed', '123456789', 'AUT001'),
(2, 'Amil', '987654321', 'AUT002');

--Questão 21
Select dbo.Paciente.nome, dbo.Consulta.data from dbo.Paciente
join dbo.Consulta on 
dbo.Paciente.id_paciente = dbo.Consulta.FK_id_paciente
where dbo.Consulta.data between '2025-09-25' and '2025-09-26';

--Questao 22
select * from dbo.Consulta as c
join dbo.Medicos as m on c.FK_crm_medico = m.crm
where c.data = '2025-09-25';

--Questão 23
select e.tipo, m.especialidade from Exames as e
join Medicos as m on e.FK_crm_medico = m.crm;

--Questao 24
select c.id_consulta,rm.* from Receita_Medica as rm
join Registro_Consulta as rc on rc.id_registro = rm.FK_id_registro
join Consulta as c on c.id_consulta = rc.FK_id_consulta
where c.id_consulta = rc.FK_id_consulta;

--Questao 25
select p.id_paciente,rm.* from Receita_Medica as rm
join Registro_Consulta as rc on
rm.FK_id_registro = rc.id_registro
join Consulta as c on c.id_consulta = rc.FK_id_consulta
join Paciente as p on p.id_paciente = c.FK_id_paciente
where p.id_paciente = 1;

--Questao 26
select * from Consulta as c
join Paciente as p on c.FK_id_paciente = p.id_paciente
where c.status = 'agendada' and p.id_paciente = 1;

--Questao 27
select * from Sala as s
join Consulta as c on s.id_sala = c.FK_id_sala
where c.data = '2025-09-26';

--Questao 28
select * from sala as s
where s.id_sala = 1;

--Questao 29
select p.valor, p.forma_pagamento from Pagamento as p
where data between '2025-09-25' and '2025-10-30';

--Questao 30
Select p.nome, c.id_convenio, ct.id_consulta, ct.data, ct.horario from Paciente p
join Convenio as c on c.FK_id_paciente = p.id_paciente
join Consulta as ct on ct.FK_id_paciente = c.FK_id_paciente;

-- Questao 31
SELECT COUNT(*) AS total_consultas_realizadas FROM dbo.Consulta
WHERE status = 'realizada' AND data BETWEEN '2025-09-01' AND '2025-09-30';

-- Questao 32
SELECT tipo, COUNT(*) AS quantidade_exames from Exames
Group By tipo;

-- Questao 33
SELECT SUM(valor) AS total_arrecadado_consultas FROM Pagamento
Where FK_id_consulta IS NOT NULL and data BETWEEN '2025-09-01' and '2025-09-30' and situacao = 'pago';

-- Questao 34
SELECT SUM(valor) AS total_arrecadado_exames FROM Pagamento
Where FK_id_exame IS NOT NULL and data between '2025-09-01' and '2025-09-30' and situacao = 'pago';

-- Questao 35
SELECT m.crm, m.nome, COUNT(c.id_consulta) AS total_consultas FROM Consulta c
JOIN Medicos m ON c.FK_crm_medico = m.crm
WHERE c.data BETWEEN '2025-09-01' AND '2025-09-30' and c.status = 'realizada'
Group By m.crm, m.nome 
Having COUNT(c.id_consulta) > 10;

-- Questao 36
SELECT p.id_paciente, p.nome, COUNT(e.id_exame) AS total_exames FROM Exames e
JOIN Paciente p ON e.FK_id_paciente = p.id_paciente
Where e.data_realizacao BETWEEN '2025-09-01' AND '2025-09-30'
GROUP BY p.id_paciente, p.nome
HAVING COUNT(e.id_exame) > 1;

-- Questao 37
Select p.id_paciente, p.nome FROM Paciente p
LEFT JOIN Consulta c ON p.id_paciente = c.FK_id_paciente
WHERE c.id_consulta IS NULL;

-- Questao 38
SELECT m.crm, m.nome FROM Medicos m 
LEFT JOIN Consulta c ON m.crm = c.FK_crm_medico
LEFT JOIN Registro_Consulta rc ON c.id_consulta = rc.FK_id_consulta
LEFT JOIN Receita_Medica r ON rc.id_registro = r.FK_id_registro
Where r.id_receita IS NULL
Group by m.crm, m.nome;

-- Questao 39
SELECT DISTINCT p.id_paciente, p.nome FROM Exames e JOIN Paciente p ON e.FK_id_paciente = p.id_paciente
Where e.resultado IS NULL OR LTRIM(RTRIM(e.resultado)) = '';

-- Questao 40
SELECT DISTINCT p.id_paciente, p.nome, c.data, c.horario FROM Consulta c
JOIN Paciente p ON p.id_paciente = c.FK_id_paciente
Where c.status = 'agendada' and c.data < '2025-09-25';