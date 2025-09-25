
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