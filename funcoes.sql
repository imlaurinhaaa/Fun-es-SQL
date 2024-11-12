CREATE DATABASE sistema_cursos;

\c sistema_cursos;

CREATE TABLE cursos (
id SERIAL PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
descricao TEXT
);

CREATE TABLE estudantes (
id SERIAL PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
email VARCHAR(180) UNIQUE NOT NULL
);

CREATE TABLE inscricoes (
id_inscricao SERIAL PRIMARY KEY,
curso_id INT,
estudante_id INT,
data_inscricao DATE,
CONSTRAINT fk_curso FOREIGN KEY (curso_id) REFERENCES cursos(id),
CONSTRAINT fk_estudante FOREIGN KEY (estudante_id) REFERENCES estudantes(id)
);

INSERT INTO cursos (nome, descricao) VALUES
('Introdução à Programação', 'Curso básico de programação com Python.'),
('Desenvolvimento Web com HTML e CSS', 'Curso introdutório de criação de páginas web.'),
('Banco de Dados com PostgreSQL', 'Curso sobre conceitos de banco de dados e uso do PostgreSQL.'),
('JavaScript Avançado', 'Curso avançado para desenvolvimento de aplicações interativas com JavaScript.');

INSERT INTO estudantes (nome, email) VALUES
('Alice Silva', 'alice.silva@example.com'),
('Bruno Oliveira', 'bruno.oliveira@example.com'),
('Carla Mendes', 'carla.mendes@example.com'),
('Daniel Sousa', 'daniel.sousa@example.com');

INSERT INTO inscricoes (curso_id, estudante_id, data_inscricao) VALUES
(1, 1, '2024-01-15'),
(1, 2, '2024-01-18'),
(2, 3, '2024-02-10'),
(3, 4, '2024-03-05'),
(4, 2, '2024-03-20');

INSERT INTO inscricoes (curso_id, estudante_id, data_inscricao) VALUES
(2, 1, '2024-04-01'),
(3, 2, '2024-04-02'),
(1, 3, '2024-04-03'),
(4, 1, '2024-04-05'),
(2, 4, '2024-04-06'),
(3, 1, '2024-04-08'),
(1, 2, '2024-04-09'),
(4, 3, '2024-04-10'),
(2, 3, '2024-04-11'),
(3, 4, '2024-04-12'),
(4, 2, '2024-04-13'),
(1, 4, '2024-04-14'),
(3, 2, '2024-04-15'),
(2, 1, '2024-04-16'),
(4, 1, '2024-04-17'),
(1, 3, '2024-04-18'),
(2, 4, '2024-04-19'),
(3, 4, '2024-04-20'),
(4, 1, '2024-04-21'),
(1, 2, '2024-04-22');

SELECT * FROM cursos;

SELECT * FROM estudantes;

SELECT * FROM inscricoes;

SELECT e.nome, c.nome, i.data_inscricao
FROM inscricoes i
JOIN estudantes e ON i.estudante_id = e.id
JOIN cursos c ON i.curso_id = c.id;

CREATE FUNCTION obter_inscricoes()
RETURNS TABLE (Estudante VARCHAR, Curso VARCHAR, Data_inscricao DATE) AS $$
BEGIN 
RETURN 
QUERY SELECT e.nome AS Estudante, c.nome AS Curso, i.data_inscricao AS Data_inscricao
FROM inscricoes i
JOIN estudantes e ON i.estudante_id = e.id
JOIN cursos c ON i.curso_id = c.id;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM obter_inscricoes();

CREATE FUNCTION obter_inscricoes_byId(id_consultar INT)
RETURNS TABLE ( curso VARCHAR, data_inscricao DATE) AS $$
BEGIN
RETURN QUERY 
SELECT c.nome AS curso_nome, i.data_inscricao
FROM inscricoes i
JOIN cursos c ON i.curso_id = c.id
WHERE i.estudante_id = id_consultar;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM estudantes;

SELECT * FROM obter_inscricoes_byId(4);