-- MySQL dump 10.16  Distrib 10.1.48-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: db
-- ------------------------------------------------------
-- Server version	10.1.48-MariaDB-0+deb9u2
UNLOCK TABLES;
create database if not exists `Banco`;
use `Banco`;
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `endereco`
--
DROP TABLE IF EXISTS `log_endereco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_endereco` (
  `logid`int Not NULL AUTO_INCREMENT primary key,
  `Acao` varchar(200) not null,
  `Data` datetime not null default current_timestamp,
  `id` int Not NULL,
  `cep` varchar(90) DEFAULT NULL,
  `rua` varchar(210) DEFAULT NULL,
  `bairro` varchar(110) DEFAULT NULL,
  `cidade` varchar(90) DEFAULT NULL,
  `uf` varchar(20) DEFAULT NULL,
  `iduser` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `endereco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `endereco` (
  `id` int Not NULL AUTO_INCREMENT Primary KEY,
  `cep` varchar(90) DEFAULT NULL,
  `rua` varchar(210) DEFAULT NULL,
  `bairro` varchar(110) DEFAULT NULL,
  `cidade` varchar(90) DEFAULT NULL,
  `uf` varchar(20) DEFAULT NULL,
  `iduser` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `endereco`
--

LOCK TABLES `endereco` WRITE;
/*!40000 ALTER TABLE `endereco` DISABLE KEYS */;
INSERT INTO `endereco` VALUES (1,'08030560','Rua Alice Dilon Braga','Vila Curuçá','São Paulo','SP',23),(2,'08030560','Rua Alice Dilon Braga','Vila Curuçá','São Paulo','SP',24),(3,'08030-560','Rua Alice Dilon Braga','Vila Curuçá','São Paulo','SP',25),(4,'08030-560','Rua Alice Dilon Braga','Vila Curuçá','São Paulo','SP',26),(5,'08030-560','Rua Alice Dilon Braga','Vila Curuçá','São Paulo','SP',27),(6,'08030-560','Rua Alice Dilon Braga','Vila Curuçá','São Paulo','SP',28),(7,'08030-560','Rua Alice Dilon Braga','Vila Curuçá','São Paulo','SP',29);
/*!40000 ALTER TABLE `endereco` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtos`
--
DROP TABLE IF EXISTS `log_produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_produtos` (
  `logid`int Not NULL AUTO_INCREMENT primary key,
  `Acao` varchar(200) not null,
  `Data` datetime not null default current_timestamp,
  `id` int not NULL,
  `nome` text DEFAULT NULL,
  `preco` decimal(4,2) DEFAULT NULL,
  `quantidade` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produtos` (
  `id` int not NULL AUTO_INCREMENT primary key,
  `nome` text DEFAULT NULL,
  `preco` decimal(4,2) DEFAULT NULL,
  `quantidade` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Dumping data for table `produtos`
--

LOCK TABLES `produtos` WRITE;
/*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
INSERT INTO `produtos` VALUES (14,'Azeitona Balde 2Kg',57.90,400),(15,'Pepino Pouch 900g',22.80,1400),(16,'Picles Pouch 1,01',22.80,1200),(17,'Tomate Seco Balde 2Kg',60.40,160);
/*!40000 ALTER TABLE `produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtos_por_usuario`
--


DROP TABLE IF EXISTS `log_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_users` (
  `logid`int Not NULL AUTO_INCREMENT primary key,
  `Acao` varchar(200) not null,
  `Data` datetime not null default current_timestamp,
  `id` int not NULL auto_increment,
  `nome` text not null,
  `email` varchar(200) DEFAULT NULL,
  `senha` text DEFAULT NULL,
  `perfilid` int DEFAULT NULL,
  UNIQUE KEY `email` (`email`),
  KEY `log_usuario_ibfk_1` (`perfilid`),
  CONSTRAINT `log_usuario_ibfk_1` FOREIGN KEY (`perfilid`) REFERENCES `perfil` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;




DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int not NULL auto_increment,
  `nome` text not null,
  `email` varchar(200) DEFAULT NULL,
  `senha` text DEFAULT NULL,
  `perfilid` int DEFAULT NULL,
	PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `usuario_ibfk_1` (`perfilid`),
  CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`perfilid`) REFERENCES `perfil` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (27,'Davi','davi@gmail.com','$2y$10$DYvhAzMJe15GWMEvfkNSCOhZVYn02PD0p2fVCS8p1oU0L6JE8CLAy',2),(28,'Julinho','julinhozika@yahoo.com.br','$2y$10$ZrNLfE1LrAmnIa6Xv62TwOoD4O2fdkjlkpXFz.wml8Dz29YzouEYW',1),(29,'Lauro','laurosigma@hotmail.com','$2y$10$lQtJnq0Vc.4gz48sOOoR5uT2/jSeBz1Ap2x1ZYZWDhDNo3unmG3K6',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendas`
--

DROP TABLE IF EXISTS `log_vendas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_vendas` (
  `logid`int Not NULL AUTO_INCREMENT primary key,
  `Acao` varchar(200) not null,
  `Data` datetime not null default current_timestamp,
  `id_usuario` int DEFAULT NULL,
  `id_produto` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `vendas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vendas` (
  `id_usuario` int DEFAULT NULL,
  `id_produto` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendas`
--

LOCK TABLES `vendas` WRITE;
/*!40000 ALTER TABLE `vendas` DISABLE KEYS */;
INSERT INTO `vendas` VALUES (13,12),(13,11),(25,13),(25,13),(25,13),(25,13),(17,11),(27,15),(27,14),(28,16),(28,17),(29,14),(29,15),(29,16),(29,17),(28,17);
/*!40000 ALTER TABLE `vendas` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `log_perfil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_perfil` (
  `logid`int Not NULL AUTO_INCREMENT primary key,
  `Acao` varchar(200) not null,
  `Data` datetime not null default current_timestamp,
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(200) NOT NULL,
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `perfil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `perfil` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perfil`
--

LOCK TABLES `perfil` WRITE;
/*!40000 ALTER TABLE `perfil` DISABLE KEYS */;
INSERT INTO `perfil` VALUES (1,'X'),(2,'Y');
/*!40000 ALTER TABLE `perfil` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `log_perfil_permissoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_perfil_permissoes` (
  `logid`int Not NULL AUTO_INCREMENT primary key,
  `Acao` varchar(200) not null,
  `Data` datetime not null default current_timestamp,
  `perfilid` int NOT NULL,
  `permissao_id` int NOT NULL,
  KEY `log_perfil_permissoes_ibfk_2` (`permissao_id`),
  CONSTRAINT `log_perfil_permissoes_ibfk_1` FOREIGN KEY (`perfilid`) REFERENCES `perfil` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `log_perfil_permissoes_ibfk_2` FOREIGN KEY (`permissao_id`) REFERENCES `permissoes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `perfil_permissoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `perfil_permissoes` (
  `perfilid` int NOT NULL,
  `permissao_id` int NOT NULL,
  PRIMARY KEY (`perfilid`,`permissao_id`),
  KEY `perfil_permissoes_ibfk_2` (`permissao_id`),
  CONSTRAINT `perfil_permissoes_ibfk_1` FOREIGN KEY (`perfilid`) REFERENCES `perfil` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `perfil_permissoes_ibfk_2` FOREIGN KEY (`permissao_id`) REFERENCES `permissoes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perfil_permissoes`
--

LOCK TABLES `perfil_permissoes` WRITE;
/*!40000 ALTER TABLE `perfil_permissoes` DISABLE KEYS */;
INSERT INTO `perfil_permissoes` VALUES (2,9),(2,2),(2,3),(2,4),(2,5),(2,6),(2,7),(2,8),(2,1),(2,10),(2,11),(2,12),(1,9),(1,7),(1,5),(1,6),(1,4);
/*!40000 ALTER TABLE `perfil_permissoes` ENABLE KEYS */;
UNLOCK TABLES;

  DROP TABLE IF EXISTS `log_permissoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_permissoes` (
  `logid`int Not NULL AUTO_INCREMENT primary key,
  `Acao` varchar(200) not null,
  `Data` datetime not null default current_timestamp,
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(200) NOT NULL,
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `permissoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissoes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissoes`
--

LOCK TABLES `permissoes` WRITE;
/*!40000 ALTER TABLE `permissoes` DISABLE KEYS */;
INSERT INTO `permissoes` VALUES (1,'criaruser'),(2,'buscauser'),(3,'todosuser'),(4,'criarprod'),(5,'buscaprod'),(6,'todosprod'),(7,'MenuProdutos'),(8,'MenuUsuarios'),(9,'MenuPrincipal'),(10,'criarvenda'),(11,'grafico'),(12,'Gerenciar');
/*!40000 ALTER TABLE `permissoes` ENABLE KEYS */;
UNLOCK TABLES;
DROP VIEW IF EXISTS `produtos_por_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE VIEW produtos_por_usuario AS
SELECT u.id, u.nome, COUNT(v.id_produto) as quantidade_produtos
FROM users u
LEFT JOIN vendas v ON u.id = v.id_usuario
GROUP BY u.id; 

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPermissoesPorPerfil`(IN perfilId INT)
BEGIN
    SELECT perm.nome 
    FROM permissoes perm
    JOIN perfil_permissoes pp ON perm.id = pp.permissao_id
    WHERE pp.perfilid = perfilId;
END ;;
DELIMITER ;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-09-18 10:46:26
