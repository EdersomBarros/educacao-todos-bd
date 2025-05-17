CREATE TABLE Usuario (
  id_usuario SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  senha VARCHAR(255) NOT NULL,
  perfil VARCHAR(20) NOT NULL CHECK (perfil IN ('Aluno','Professor','Responsável'))
);

-- Criação da tabela Conteudo
CREATE TABLE Conteudo (
  id_conteudo SERIAL PRIMARY KEY,
  titulo VARCHAR(200) NOT NULL,
  descricao TEXT,
  data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  id_professor INTEGER NOT NULL REFERENCES Usuario(id_usuario) ON DELETE RESTRICT
);

-- Criação da tabela Tarefa
CREATE TABLE Tarefa (
  id_tarefa SERIAL PRIMARY KEY,
  id_conteudo INTEGER NOT NULL REFERENCES Conteudo(id_conteudo) ON DELETE CASCADE,
  titulo VARCHAR(200) NOT NULL,
  descricao TEXT,
  data_entrega DATE NOT NULL
);

-- Criação da tabela Tarefa_Aluno
CREATE TABLE Tarefa_Aluno (
  id_tarefa_aluno SERIAL PRIMARY KEY,
  id_tarefa INTEGER NOT NULL REFERENCES Tarefa(id_tarefa) ON DELETE CASCADE,
  id_aluno INTEGER NOT NULL REFERENCES Usuario(id_usuario) ON DELETE CASCADE,
  status VARCHAR(20) NOT NULL DEFAULT 'Pendente' CHECK (status IN ('Pendente','Entregue')),
  data_entrega_aluno TIMESTAMP
);

-- Criação da tabela Avaliacao
CREATE TABLE Avaliacao (
  id_avaliacao SERIAL PRIMARY KEY,
  id_tarefa_aluno INTEGER NOT NULL REFERENCES Tarefa_Aluno(id_tarefa_aluno) ON DELETE CASCADE,
  nota DECIMAL(5,2) NOT NULL,
  comentario TEXT
);

-- Criação da tabela Notificacao
CREATE TABLE Notificacao (
  id_notificacao SERIAL PRIMARY KEY,
  id_destinatario INTEGER NOT NULL REFERENCES Usuario(id_usuario) ON DELETE CASCADE,
  mensagem TEXT NOT NULL,
  data_envio TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Exemplos de inserção de dados
INSERT INTO Usuario (nome, email, senha, perfil) VALUES ('Maria Silva', 'maria.silva@exemplo.edu', 'senha123', 'Professor');
INSERT INTO Usuario (nome, email, senha, perfil) VALUES ('João Souza', 'joao.souza@exemplo.edu', 'senha456', 'Aluno');

INSERT INTO Conteudo (titulo, descricao, id_professor)
VALUES ('Matemática – Álgebra Básica', 'Introdução a equações de 1º grau', 1);

INSERT INTO Tarefa (id_conteudo, titulo, data_entrega)
VALUES (1, 'Exercícios de Equações', '2025-06-01');

INSERT INTO Tarefa_Aluno (id_tarefa, id_aluno)
VALUES (1, 2);

INSERT INTO Avaliacao (id_tarefa_aluno, nota, comentario)
VALUES (1, 9.5, 'Bom desempenho, revisitar questão 3');

INSERT INTO Notificacao (id_destinatario, mensagem)
VALUES (2, 'Sua tarefa foi avaliada com sucesso!');