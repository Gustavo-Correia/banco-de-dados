CREATE DATABASE ClinicaDB;


USE ClinicaDB;

CREATE TABLE Paciente (
    id_paciente INT IDENTITY(1,1) PRIMARY KEY,
    nome NVARCHAR(100) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    data_nascimento DATE NOT NULL,
    endereco NVARCHAR(200),
    telefone VARCHAR(20),
    email NVARCHAR(100)
);

CREATE TABLE Medicos (
    crm VARCHAR(20) PRIMARY KEY,
    nome NVARCHAR(100) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    especialidade NVARCHAR(100),
    forma_contato NVARCHAR(100)
);

CREATE TABLE Sala (
    id_sala INT IDENTITY(1,1) PRIMARY KEY,
    equipamento NVARCHAR(200)
);

CREATE TABLE Consulta (
    id_consulta INT IDENTITY(1,1) PRIMARY KEY,
    data DATE NOT NULL,
    horario TIME NOT NULL,
    status VARCHAR(20) CHECK (status IN ('agendada','realizada','cancelada')) NOT NULL,
    FK_id_paciente INT NOT NULL,
    FK_crm_medico VARCHAR(20) NOT NULL,
    FK_id_sala INT NOT NULL,
    FOREIGN KEY (FK_id_paciente) REFERENCES Paciente(id_paciente),
    FOREIGN KEY (FK_crm_medico) REFERENCES Medicos(crm),
    FOREIGN KEY (FK_id_sala) REFERENCES Sala(id_sala)
);

CREATE TABLE Registro_Consulta (
    id_registro INT IDENTITY(1,1) PRIMARY KEY,
    FK_id_consulta INT NOT NULL,
    sintomas NVARCHAR(500),
    diagnostico NVARCHAR(500),
    FOREIGN KEY (FK_id_consulta) REFERENCES Consulta(id_consulta)
);

CREATE TABLE Receita_Medica (
    id_receita INT IDENTITY(1,1) PRIMARY KEY,
    FK_id_registro INT NOT NULL,
    medicamentos NVARCHAR(500),
    dosagens NVARCHAR(500),
    orientacoes NVARCHAR(500),
    validade_prescricao DATE,
    FOREIGN KEY (FK_id_registro) REFERENCES Registro_Consulta(id_registro)
);

CREATE TABLE Exames (
    id_exame INT IDENTITY(1,1) PRIMARY KEY,
    tipo NVARCHAR(100),
    data_realizacao DATE,
    resultado NVARCHAR(500),
    FK_crm_medico VARCHAR(20) NOT NULL,
    FK_id_paciente INT NOT NULL,
    FOREIGN KEY (FK_crm_medico) REFERENCES Medicos(crm),
    FOREIGN KEY (FK_id_paciente) REFERENCES Paciente(id_paciente)
);

CREATE TABLE Pagamento (
    id_pagamento INT IDENTITY(1,1) PRIMARY KEY,
    FK_id_consulta INT NULL,
    FK_id_exame INT NULL,
    valor DECIMAL(10,2) NOT NULL,
    data DATE NOT NULL,
    forma_pagamento VARCHAR(20) CHECK (forma_pagamento IN ('dinheiro','cartao','pix','convenio')) NOT NULL,
    situacao VARCHAR(20) CHECK (situacao IN ('pago','pendente','cancelado')) NOT NULL,
    FOREIGN KEY (FK_id_consulta) REFERENCES Consulta(id_consulta),
    FOREIGN KEY (FK_id_exame) REFERENCES Exames(id_exame)
);

CREATE TABLE Convenio (
    id_convenio INT IDENTITY(1,1) PRIMARY KEY,
    FK_id_paciente INT NOT NULL,
    operadora NVARCHAR(100) NOT NULL,
    numero_carteirinha NVARCHAR(50) NOT NULL,
    autorizacao NVARCHAR(50),
    FOREIGN KEY (FK_id_paciente) REFERENCES Paciente(id_paciente)
);