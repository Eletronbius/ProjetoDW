-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Tempo de geração: 18/11/2023 às 20:52
-- Versão do servidor: 10.5.20-MariaDB
-- Versão do PHP: 7.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";
use banco;


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `id21521125_meubd`
--

DELIMITER $$
--
-- Procedimentos
--
CREATE DEFINER=`id21521125_root`@`%` PROCEDURE `GetPermissoesPorPerfil` (IN `perfilId` INT)   BEGIN
    SELECT perm.nome 
    FROM permissoes perm
    JOIN perfil_permissoes pp ON perm.id = pp.permissao_id
    WHERE pp.perfilid = perfilId;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `endereco`
--

CREATE TABLE `endereco` (
  `id` int(11) NOT NULL,
  `cep` varchar(90) DEFAULT NULL,
  `rua` varchar(210) DEFAULT NULL,
  `bairro` varchar(110) DEFAULT NULL,
  `cidade` varchar(90) DEFAULT NULL,
  `uf` varchar(20) DEFAULT NULL,
  `iduser` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `endereco`
--

INSERT INTO `endereco` (`id`, `cep`, `rua`, `bairro`, `cidade`, `uf`, `iduser`) VALUES
(3, '08030-560', 'Rua Alice Dilon Braga', 'Vila Curuçá', 'São Paulo', 'SP', 25),
(4, '08030-560', 'Rua Alice Dilon Braga', 'Vila Curuçá', 'São Paulo', 'SP', 26),
(5, '08030-560', 'Rua Alice Dilon Braga', 'Vila Curuçá', 'São Paulo', 'SP', 27),
(6, '08030-560', 'Rua Alice Dilon Braga', 'Vila Curuçá', 'São Paulo', 'SP', 28),
(7, '08030-560', 'Rua Alice Dilon Braga', 'Vila Curuçá', 'São Paulo', 'SP', 29),
(8, '', '', '', '', '', 30);

--
-- Acionadores `endereco`
--
DELIMITER $$
CREATE TRIGGER `DeleteEnd` AFTER DELETE ON `endereco` FOR EACH ROW insert into log_endereco(Acao,id,cep,rua,bairro,cidade,uf,iduser) values("Deletado",OLD.id,OLD.cep,OLD.rua,OLD.bairro,OLD.cidade,OLD.uf,OLD.iduser)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `UpdateEnd` AFTER UPDATE ON `endereco` FOR EACH ROW insert into log_endereco(Acao,id,cep,rua,bairro,cidade,uf,iduser) values("Alterado",OLD.id,OLD.cep,OLD.rua,OLD.bairro,OLD.cidade,OLD.uf,OLD.iduser)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `log_endereco`
--

CREATE TABLE `log_endereco` (
  `logid` int(11) NOT NULL,
  `Acao` varchar(200) NOT NULL,
  `Data` datetime NOT NULL DEFAULT current_timestamp(),
  `id` int(11) DEFAULT NULL,
  `cep` varchar(90) DEFAULT NULL,
  `rua` varchar(210) DEFAULT NULL,
  `bairro` varchar(110) DEFAULT NULL,
  `cidade` varchar(90) DEFAULT NULL,
  `uf` varchar(20) DEFAULT NULL,
  `iduser` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `log_endereco`
--

INSERT INTO `log_endereco` (`logid`, `Acao`, `Data`, `id`, `cep`, `rua`, `bairro`, `cidade`, `uf`, `iduser`) VALUES
(2, 'Deletado', '2023-11-18 20:27:25', 2, '08030560', 'Rua Alice Dilon Braga', 'Vila Curuçá', 'São Paulo', 'SP', 24);

-- --------------------------------------------------------

--
-- Estrutura para tabela `log_perfil`
--

CREATE TABLE `log_perfil` (
  `logid` int(11) NOT NULL,
  `Acao` varchar(200) NOT NULL,
  `Data` datetime NOT NULL DEFAULT current_timestamp(),
  `id` int(11) NOT NULL,
  `nome` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `log_perfil_permissoes`
--

CREATE TABLE `log_perfil_permissoes` (
  `logid` int(11) NOT NULL,
  `Acao` varchar(200) NOT NULL,
  `Data` datetime NOT NULL DEFAULT current_timestamp(),
  `perfilid` int(11) NOT NULL,
  `permissao_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `log_permissoes`
--

CREATE TABLE `log_permissoes` (
  `logid` int(11) NOT NULL,
  `Acao` varchar(200) NOT NULL,
  `Data` datetime NOT NULL DEFAULT current_timestamp(),
  `id` int(11) NOT NULL,
  `nome` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `log_produtos`
--

CREATE TABLE `log_produtos` (
  `logid` int(11) NOT NULL,
  `Acao` varchar(200) NOT NULL,
  `Data` datetime NOT NULL DEFAULT current_timestamp(),
  `id` int(11) NOT NULL,
  `nome` text DEFAULT NULL,
  `preco` decimal(4,2) DEFAULT NULL,
  `quantidade` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `log_produtos`
--

INSERT INTO `log_produtos` (`logid`, `Acao`, `Data`, `id`, `nome`, `preco`, `quantidade`) VALUES
(1, 'Deletado', '2023-11-18 20:48:44', 18, 'algo', 1.00, 1),
(2, 'Alterado', '2023-11-18 20:49:24', 19, 'algo', 1.00, 22),
(3, 'Alterado', '2023-11-18 20:49:40', 19, 'algo', 1.00, 22),
(4, 'Deletado', '2023-11-18 20:50:01', 19, 'algo', 3.00, 22);

-- --------------------------------------------------------

--
-- Estrutura para tabela `log_users`
--

CREATE TABLE `log_users` (
  `logid` int(11) NOT NULL,
  `Acao` varchar(200) NOT NULL,
  `Data` datetime NOT NULL DEFAULT current_timestamp(),
  `id` int(11) NOT NULL,
  `nome` text NOT NULL,
  `email` varchar(200) DEFAULT NULL,
  `senha` text DEFAULT NULL,
  `perfilid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `log_users`
--

INSERT INTO `log_users` (`logid`, `Acao`, `Data`, `id`, `nome`, `email`, `senha`, `perfilid`) VALUES
(1, 'Alterado', '2023-11-18 20:51:22', 30, 'BielLol', 'bibibilu@hotmail.com', '$2y$10$Ki15ywGeeOoTLwvxBdO1DuB3JmlkO1izGWgKHL6gcm6GAti0P6wQW', 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `log_vendas`
--

CREATE TABLE `log_vendas` (
  `logid` int(11) NOT NULL,
  `Acao` varchar(200) NOT NULL,
  `Data` datetime NOT NULL DEFAULT current_timestamp(),
  `id_usuario` int(11) DEFAULT NULL,
  `id_produto` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `perfil`
--

CREATE TABLE `perfil` (
  `id` int(11) NOT NULL,
  `nome` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `perfil`
--

INSERT INTO `perfil` (`id`, `nome`) VALUES
(1, 'X'),
(2, 'Y');

--
-- Acionadores `perfil`
--
DELIMITER $$
CREATE TRIGGER `DeletePerfil` AFTER DELETE ON `perfil` FOR EACH ROW insert into log_perfil(Acao,id,nome) 
values("Deletado",OLD.id,OLD.nome)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `UpdatePerfil` AFTER UPDATE ON `perfil` FOR EACH ROW insert into log_perfil(Acao,id,nome) 
values("Alterado",OLD.id,OLD.nome)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `perfil_permissoes`
--

CREATE TABLE `perfil_permissoes` (
  `perfilid` int(11) NOT NULL,
  `permissao_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `perfil_permissoes`
--

INSERT INTO `perfil_permissoes` (`perfilid`, `permissao_id`) VALUES
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 9),
(2, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 5),
(2, 6),
(2, 7),
(2, 8),
(2, 9),
(2, 10),
(2, 11),
(2, 12);

--
-- Acionadores `perfil_permissoes`
--
DELIMITER $$
CREATE TRIGGER `DeletePerfilPerm` AFTER DELETE ON `perfil_permissoes` FOR EACH ROW insert into log_perfil_permissoes(Acao,perfilid,permissao_id) 
values("Deletado",OLD.perfilid,OLD.permissao_id)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `UpdatePerfilPerm` AFTER UPDATE ON `perfil_permissoes` FOR EACH ROW insert into log_perfil_permissoes(Acao,perfilid,permissao_id) 
values("Alterado",OLD.perfilid,OLD.permissao_id)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `permissoes`
--

CREATE TABLE `permissoes` (
  `id` int(11) NOT NULL,
  `nome` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `permissoes`
--

INSERT INTO `permissoes` (`id`, `nome`) VALUES
(5, 'buscaprod'),
(2, 'buscauser'),
(4, 'criarprod'),
(1, 'criaruser'),
(10, 'criarvenda'),
(12, 'Gerenciar'),
(11, 'grafico'),
(9, 'MenuPrincipal'),
(7, 'MenuProdutos'),
(8, 'MenuUsuarios'),
(6, 'todosprod'),
(3, 'todosuser');

--
-- Acionadores `permissoes`
--
DELIMITER $$
CREATE TRIGGER `DeletePerm` AFTER DELETE ON `permissoes` FOR EACH ROW insert into log_permissoes(Acao,id,nome) 
values("Deletado",OLD.id,OLD.nome)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `UpdatePerm` AFTER UPDATE ON `permissoes` FOR EACH ROW insert into log_permissoes(Acao,id,nome) 
values("Alterado",OLD.id,OLD.nome)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `produtos`
--

CREATE TABLE `produtos` (
  `id` int(11) NOT NULL,
  `nome` text DEFAULT NULL,
  `preco` decimal(4,2) DEFAULT NULL,
  `quantidade` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `produtos`
--

INSERT INTO `produtos` (`id`, `nome`, `preco`, `quantidade`) VALUES
(14, 'Azeitona Balde 2Kg', 57.90, 400),
(15, 'Pepino Pouch 900g', 22.80, 1400),
(16, 'Picles Pouch 1,01', 22.80, 1200),
(17, 'Tomate Seco Balde 2Kg', 60.40, 160);

--
-- Acionadores `produtos`
--
DELIMITER $$
CREATE TRIGGER `DeleteProd` AFTER DELETE ON `produtos` FOR EACH ROW insert into log_produtos(Acao,id,nome,preco,quantidade) 
values("Deletado",OLD.id,OLD.nome,OLD.preco,OLD.quantidade)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `UpdateProd` AFTER UPDATE ON `produtos` FOR EACH ROW insert into log_produtos(Acao,id,nome,preco,quantidade) 
values("Alterado",OLD.id,OLD.nome,OLD.preco,OLD.quantidade)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `produtos_por_usuario`
-- (Veja abaixo para a visão atual)
--
CREATE TABLE `produtos_por_usuario` (
`id` int(11)
,`nome` text
,`quantidade_produtos` bigint(21)
);

-- --------------------------------------------------------

--
-- Estrutura para tabela `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `nome` text NOT NULL,
  `email` varchar(200) DEFAULT NULL,
  `senha` text DEFAULT NULL,
  `perfilid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `users`
--

INSERT INTO `users` (`id`, `nome`, `email`, `senha`, `perfilid`) VALUES
(27, 'Davi', 'davi@gmail.com', '$2y$10$DYvhAzMJe15GWMEvfkNSCOhZVYn02PD0p2fVCS8p1oU0L6JE8CLAy', 2),
(28, 'Julinho', 'julinhozika@yahoo.com.br', '$2y$10$ZrNLfE1LrAmnIa6Xv62TwOoD4O2fdkjlkpXFz.wml8Dz29YzouEYW', 1),
(29, 'Lauro', 'laurosigma@hotmail.com', '$2y$10$lQtJnq0Vc.4gz48sOOoR5uT2/jSeBz1Ap2x1ZYZWDhDNo3unmG3K6', 1),
(30, 'BielLol', 'bibibilu@hotmail.com', '$2y$10$Ki15ywGeeOoTLwvxBdO1DuB3JmlkO1izGWgKHL6gcm6GAti0P6wQW', 2);

--
-- Acionadores `users`
--
DELIMITER $$
CREATE TRIGGER `DeleteUsers` AFTER DELETE ON `users` FOR EACH ROW insert into log_users(Acao,id,nome,email,senha,perfilid) 
values("Deletado",OLD.id,OLD.nome,OLD.email,OLD.senha,OLD.perfilid)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `UpdateUsers` AFTER UPDATE ON `users` FOR EACH ROW insert into log_users(Acao,id,nome,email,senha,perfilid) 
values("Alterado",OLD.id,OLD.nome,OLD.email,OLD.senha,OLD.perfilid)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `vendas`
--

CREATE TABLE `vendas` (
  `id_usuario` int(11) DEFAULT NULL,
  `id_produto` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `vendas`
--

INSERT INTO `vendas` (`id_usuario`, `id_produto`) VALUES
(13, 12),
(13, 11),
(25, 13),
(25, 13),
(25, 13),
(25, 13),
(17, 11),
(27, 15),
(27, 14),
(28, 16),
(28, 17),
(29, 14),
(29, 15),
(29, 16),
(29, 17),
(28, 17);

-- --------------------------------------------------------

--
-- Estrutura para view `produtos_por_usuario`
--
DROP TABLE IF EXISTS `produtos_por_usuario`;

CREATE ALGORITHM=UNDEFINED DEFINER=`id21521125_root`@`%` SQL SECURITY DEFINER VIEW `produtos_por_usuario`  AS SELECT `u`.`id` AS `id`, `u`.`nome` AS `nome`, count(`v`.`id_produto`) AS `quantidade_produtos` FROM (`users` `u` left join `vendas` `v` on(`u`.`id` = `v`.`id_usuario`)) GROUP BY `u`.`id` ;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `endereco`
--
ALTER TABLE `endereco`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `log_endereco`
--
ALTER TABLE `log_endereco`
  ADD PRIMARY KEY (`logid`);

--
-- Índices de tabela `log_perfil`
--
ALTER TABLE `log_perfil`
  ADD PRIMARY KEY (`logid`),
  ADD UNIQUE KEY `nome` (`nome`);

--
-- Índices de tabela `log_perfil_permissoes`
--
ALTER TABLE `log_perfil_permissoes`
  ADD PRIMARY KEY (`logid`),
  ADD KEY `log_perfil_permissoes_ibfk_2` (`permissao_id`),
  ADD KEY `log_perfil_permissoes_ibfk_1` (`perfilid`);

--
-- Índices de tabela `log_permissoes`
--
ALTER TABLE `log_permissoes`
  ADD PRIMARY KEY (`logid`),
  ADD UNIQUE KEY `nome` (`nome`);

--
-- Índices de tabela `log_produtos`
--
ALTER TABLE `log_produtos`
  ADD PRIMARY KEY (`logid`);

--
-- Índices de tabela `log_users`
--
ALTER TABLE `log_users`
  ADD PRIMARY KEY (`logid`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `log_usuario_ibfk_1` (`perfilid`);

--
-- Índices de tabela `log_vendas`
--
ALTER TABLE `log_vendas`
  ADD PRIMARY KEY (`logid`);

--
-- Índices de tabela `perfil`
--
ALTER TABLE `perfil`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nome` (`nome`);

--
-- Índices de tabela `perfil_permissoes`
--
ALTER TABLE `perfil_permissoes`
  ADD PRIMARY KEY (`perfilid`,`permissao_id`),
  ADD KEY `perfil_permissoes_ibfk_2` (`permissao_id`);

--
-- Índices de tabela `permissoes`
--
ALTER TABLE `permissoes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nome` (`nome`);

--
-- Índices de tabela `produtos`
--
ALTER TABLE `produtos`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `usuario_ibfk_1` (`perfilid`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `endereco`
--
ALTER TABLE `endereco`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de tabela `log_endereco`
--
ALTER TABLE `log_endereco`
  MODIFY `logid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `log_perfil`
--
ALTER TABLE `log_perfil`
  MODIFY `logid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `log_perfil_permissoes`
--
ALTER TABLE `log_perfil_permissoes`
  MODIFY `logid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `log_permissoes`
--
ALTER TABLE `log_permissoes`
  MODIFY `logid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `log_produtos`
--
ALTER TABLE `log_produtos`
  MODIFY `logid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `log_users`
--
ALTER TABLE `log_users`
  MODIFY `logid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `log_vendas`
--
ALTER TABLE `log_vendas`
  MODIFY `logid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `perfil`
--
ALTER TABLE `perfil`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `permissoes`
--
ALTER TABLE `permissoes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de tabela `produtos`
--
ALTER TABLE `produtos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de tabela `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `log_perfil_permissoes`
--
ALTER TABLE `log_perfil_permissoes`
  ADD CONSTRAINT `log_perfil_permissoes_ibfk_1` FOREIGN KEY (`perfilid`) REFERENCES `perfil` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `log_perfil_permissoes_ibfk_2` FOREIGN KEY (`permissao_id`) REFERENCES `permissoes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `log_users`
--
ALTER TABLE `log_users`
  ADD CONSTRAINT `log_usuario_ibfk_1` FOREIGN KEY (`perfilid`) REFERENCES `perfil` (`id`);

--
-- Restrições para tabelas `perfil_permissoes`
--
ALTER TABLE `perfil_permissoes`
  ADD CONSTRAINT `perfil_permissoes_ibfk_1` FOREIGN KEY (`perfilid`) REFERENCES `perfil` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `perfil_permissoes_ibfk_2` FOREIGN KEY (`permissao_id`) REFERENCES `permissoes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`perfilid`) REFERENCES `perfil` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
