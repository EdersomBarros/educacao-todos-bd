# Projeto Integrador de Tecnologia da Informação II 📚

## Módulo 3 – Banco de Dados 🗄️

Atividade prática de modelagem relacional de dados para o sistema **“Educação para Todos”**, com definição clara de entidades, atributos, relacionamentos e restrições.

---

## 👥 Alunos

- Edersom Aparecido Barros Rodrigues  
- Aziz Cotrim

---

## 📖 Descrição do Projeto

Este trabalho visa projetar e implementar o esquema de banco de dados relacional, garantindo integridade e consistência das informações do sistema “Educação para Todos”. São abordados:

- Modelagem conceitual (ER)  
- Implementação física em SQL  
- Inserção de dados de exemplo

---

## 🛠️ Entidades e Atributos

1. **Usuario**  
   - `id_usuario` (PK)  
   - `nome` VARCHAR(100) NOT NULL  
   - `email` VARCHAR(150) NOT NULL UNIQUE  
   - `senha` VARCHAR(255) NOT NULL  
   - `perfil` ENUM('Aluno','Professor','Responsável') NOT NULL

2. **Conteudo**  
   - `id_conteudo` (PK)  
   - `titulo` VARCHAR(200) NOT NULL  
   - `descricao` TEXT  
   - `data_criacao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP  
   - `id_professor` FK → Usuario(id_usuario) NOT NULL

3. **Tarefa**  
   - `id_tarefa` (PK)  
   - `id_conteudo` FK → Conteudo(id_conteudo) NOT NULL  
   - `titulo` VARCHAR(200) NOT NULL  
   - `descricao` TEXT  
   - `data_entrega` DATE NOT NULL

4. **Tarefa_Aluno**  
   - `id_tarefa_aluno` (PK)  
   - `id_tarefa` FK → Tarefa(id_tarefa) NOT NULL  
   - `id_aluno` FK → Usuario(id_usuario) NOT NULL  
   - `status` ENUM('Pendente','Entregue') NOT NULL DEFAULT 'Pendente'  
   - `data_entrega_aluno` TIMESTAMP

5. **Avaliacao**  
   - `id_avaliacao` (PK)  
   - `id_tarefa_aluno` FK → Tarefa_Aluno(id_tarefa_aluno) NOT NULL  
   - `nota` DECIMAL(5,2) NOT NULL  
   - `comentario` TEXT

6. **Notificacao**  
   - `id_notificacao` (PK)  
   - `id_destinatario` FK → Usuario(id_usuario) NOT NULL  
   - `mensagem` TEXT NOT NULL  
   - `data_envio` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP

---

## 🔗 Relacionamentos

- **Usuario → Conteudo**: um professor pode criar vários conteúdos (1:N)  
- **Conteudo → Tarefa**: cada conteúdo pode gerar múltiplas tarefas (1:N)  
- **Tarefa ↔ Usuario (Aluno)**: associação N:N via **Tarefa_Aluno**  
- **Tarefa_Aluno → Avaliacao**: cada submissão pode receber uma avaliação (1:1)  
- **Usuario → Notificacao**: um usuário pode receber diversas notificações (1:N)

---

## ✅ Restrições e Integridade

- **PK** e **FK** devidamente definidas  
- **NOT NULL** em atributos essenciais  
- **UNIQUE(email)** para evitar duplicatas  
- **CHECK/ENUM** para campos com domínio limitado  
- **ON DELETE CASCADE/RESTRICT** configurado conforme política de manutenção de histórico

---

## 📝 Script SQL (`schema.sql`)

Contém os comandos DDL para criação de tabelas e DML para inserção de registros de exemplo, seguindo a ordem de dependência.

## 📊 Resultados de Exemplo


## 👤 Usuario

| id_usuario | nome            | email                      | perfil       |
|-----------:|-----------------|----------------------------|--------------|
|          1 | Maria Silva     | maria.silva@escola.edu     | Professor    |
|          2 | João Souza      | joao.souza@escola.edu      | Aluno        |
|          3 | Ana Pereira     | ana.pereira@escola.edu     | Responsável  |

---

## 📄 Conteúdo

| id_conteudo | titulo                         |id_professor|data_criacao         |
|------------:|--------------------------------|-----------:|----------
|           1 | Matemática – Álgebra Básica    |          1| 2025-05-17 10:00:00  |
|           2 | História – Idade Média         |          1| 2025-05-18 14:30:00  |
|           3 | Ciências – Sistema Solar       |          1| 2025-05-19 09:15:00  |

---

## 📝 Tarefa

| id_tarefa | id_conteudo | titulo                    | data_entrega |
|----------:|------------:|---------------------------|-------------:|
|         1 |           1 | Lista de Exercícios       |   2025-06-01 |
|         2 |           2 | Resumo em PDF             |   2025-06-02 |
|         3 |           3 | Quiz Online               |   2025-06-03 |

---

## 🏷️ Tarefa_Aluno

| id_tarefa_aluno | id_tarefa | id_aluno | status    | data_entrega_aluno    |
|----------------:|---------:|---------:|-----------|-----------------------|
|               1 |        1 |        2 | Entregue  | 2025-05-30 16:45:00   |
|               2 |        2 |        2 | Pendente  |                       |
|               3 |        3 |        2 | Entregue  | 2025-06-01 11:20:00   |

---

## 🏅 Avaliação

| id_avaliacao | id_tarefa_aluno | nota | comentario                       |
|-------------:|----------------:|-----:|----------------------------------|
|            1 |               1 | 9.5  | Bom trabalho, revise a questão 3 |
|            2 |               3 | 8.0  | Atenção ao tempo de resposta     |

---

## 🔔 Notificação

| id_notificacao | id_destinatario | mensagem                                 | data_envio           |
|---------------:|----------------:|------------------------------------------|----------------------|
|              1 |               2 | Sua tarefa foi avaliada com sucesso!     | 2025-06-02 08:00:00  |
|              2 |               2 | Novo conteúdo publicado: História – IM   | 2025-05-18 15:00:00  |