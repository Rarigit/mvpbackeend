-- MySQL dump 10.13  Distrib 5.5.62, for Win64 (AMD64)
--
-- Host: 35.223.135.253    Database: mvpfinalo
-- ------------------------------------------------------
-- Server version	5.5.5-10.11.1-MariaDB-1:10.11.1+maria~deb11

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `client_session`
--

DROP TABLE IF EXISTS `client_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_session` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int(10) unsigned NOT NULL,
  `token` varchar(45) NOT NULL DEFAULT uuid(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `client_session_UN_token` (`token`),
  KEY `client_session_FK_user` (`client_id`),
  CONSTRAINT `client_session_FK_user` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `clients_UN_email` (`email`),
  UNIQUE KEY `clients_UN_pass` (`password`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `market_data`
--

DROP TABLE IF EXISTS `market_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market_data` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ath` decimal(10,2) NOT NULL,
  `atl` decimal(10,2) DEFAULT NULL,
  `current_price` decimal(10,2) NOT NULL,
  `market_cap` bigint(20) unsigned NOT NULL,
  `market_cap_rank` int(10) unsigned NOT NULL,
  `name` varchar(100) NOT NULL,
  `total_supply` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `total_volume` bigint(20) unsigned NOT NULL,
  `images` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42501 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `portfolio_tracker`
--

DROP TABLE IF EXISTS `portfolio_tracker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portfolio_tracker` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int(10) unsigned NOT NULL,
  `name` varchar(100) NOT NULL,
  `quantity` decimal(10,2) NOT NULL,
  `purchase_price` decimal(10,2) NOT NULL,
  `client_email` varchar(100) NOT NULL,
  `market_data_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `portfolio_tracker_FK_user` (`client_id`),
  KEY `portfolio_tracker_FK_email` (`client_email`),
  KEY `portfolio_tracker_FK_mktid` (`market_data_id`),
  CONSTRAINT `portfolio_tracker_FK_email` FOREIGN KEY (`client_email`) REFERENCES `clients` (`email`) ON DELETE CASCADE,
  CONSTRAINT `portfolio_tracker_FK_mktid` FOREIGN KEY (`market_data_id`) REFERENCES `market_data` (`id`) ON DELETE CASCADE,
  CONSTRAINT `portfolio_tracker_FK_user` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `predictions`
--

DROP TABLE IF EXISTS `predictions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `predictions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `predicted_price` decimal(10,2) NOT NULL,
  `duration_predict` time NOT NULL,
  `predict_result` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `coin_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `predictions_FK_user` (`client_id`),
  CONSTRAINT `predictions_FK_user` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'mvpfinalo'
--
/*!50003 DROP PROCEDURE IF EXISTS `check_purc_price` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`topdev`@`%` PROCEDURE `check_purc_price`(name_input CHAR(100), purchase_price_input DEC(10,2))
BEGIN
	DECLARE max_price DECIMAL(10,2);	

	SELECT MAX(ath) INTO max_price FROM market_data WHERE name = name_input;

	IF max_price IS NULL THEN
		SELECT JSON_OBJECT('error', 'Coin does not exixt in market data', 'status', 400) AS result;
	ELSEIF purchase_price_input > max_price THEN
		SELECT JSON_OBJECT('error', 'Purchase price must be below ATH', 'status', 400) AS result;
	ELSE
		SELECT 1 AS count;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_clients` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`topdev`@`%` PROCEDURE `delete_clients`(token_input CHAR(45))
    MODIFIES SQL DATA
BEGIN
	DELETE c FROM clients c INNER JOIN client_session cs ON c.id = cs.client_id WHERE cs.token = token_input;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `del_folio_data` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`topdev`@`%` PROCEDURE `del_folio_data`(id_input INT UNSIGNED)
    MODIFIES SQL DATA
BEGIN
	DELETE p FROM portfolio_tracker p WHERE p.id = id_input;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `del_login_step2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`topdev`@`%` PROCEDURE `del_login_step2`(token_input CHAR(45))
    MODIFIES SQL DATA
BEGIN
	DELETE FROM client_session WHERE token = token_input;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `edit_clients` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`topdev`@`%` PROCEDURE `edit_clients`(token_input CHAR(45), password_input CHAR(100), username_input CHAR(100), first_name_input CHAR(100), last_name_input CHAR(100))
    MODIFIES SQL DATA
BEGIN
	UPDATE clients c 
	INNER JOIN client_session cs ON c.id = cs.client_id
	SET
		password = IFNULL(password_input, password),
		username = IFNULL(username_input, username),
		first_name = IFNULL(first_name_input, first_name),
		last_name = IFNULL(last_name_input, last_name)
	WHERE cs.token = token_input;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `edit_folio_data` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`topdev`@`%` PROCEDURE `edit_folio_data`(token_input CHAR(45), id_input INT UNSIGNED, name_input CHAR(100), purchase_price_input DECIMAL(10,2), quantity_input DECIMAL(10,2))
    MODIFIES SQL DATA
BEGIN
	UPDATE portfolio_tracker p
	INNER JOIN client_session cs ON p.client_id = cs.client_id  
	SET 
		name = IFNULL(name_input, name),
		purchase_price = IFNULL(purchase_price_input, purchase_price),
		quantity  = IFNULL(quantity_input, quantity)
	WHERE cs.token = token_input AND p.id = id_input;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_clients_tkarg` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`topdev`@`%` PROCEDURE `get_clients_tkarg`(token_input CHAR(45))
BEGIN
	SELECT c.id, email, first_name, last_name, username FROM clients c JOIN client_session cs ON c.id = cs.client_id WHERE token = token_input; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_folio_data` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`topdev`@`%` PROCEDURE `get_folio_data`(token_input CHAR(45))
BEGIN
    SELECT p.id, p.client_id, p.name, p.quantity, p.purchase_price, md.current_price, p.client_email
    FROM portfolio_tracker p
    JOIN client_session cs ON p.client_id = cs.client_id
    JOIN (
    	SELECT name, MAX(id) AS max_id
    	FROM market_data
    	WHERE name IN ('Bitcoin', 'Ethereum', 'Tether', 'BNB', 'Litecoin', 'Avalanche', 'Polygon', 'Uniswap', 'Solana', 'Polkadot')
    	GROUP BY name 
    ) AS latest_md ON latest_md.name = p.name
    JOIN market_data md ON md.id = latest_md.max_id
    WHERE cs.token = token_input;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_login_step1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`topdev`@`%` PROCEDURE `get_login_step1`(IN email_input CHAR(100) COLLATE utf8mb4_general_ci)
    MODIFIES SQL DATA
BEGIN
	SELECT id, password FROM clients WHERE email COLLATE utf8mb4_general_ci = email_input;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_mkt_data` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`topdev`@`%` PROCEDURE `get_mkt_data`()
BEGIN
	IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'temp_table' AND table_type = 'TEMPORARY')
	THEN
		DROP TEMPORARY TABLE temp_table;
	END IF;

	CREATE TEMPORARY TABLE temp_table
	SELECT images, ath, atl, current_price, market_cap, market_cap_rank, name, total_supply, total_volume
	FROM market_data
	WHERE name IN ('Bitcoin', 'Ethereum', 'Chainlink', 'BNB', 'Litecoin', 'Avalanche', 'Polygon', 'Uniswap', 'Solana', 'Polkadot')
	ORDER BY id DESC 
	LIMIT 10;

	SELECT * FROM temp_table;
	DROP TEMPORARY TABLE temp_table;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_predictions` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`topdev`@`%` PROCEDURE `get_predictions`(token_input CHAR(45))
BEGIN
	SELECT p.client_id, created_at, predicted_price, TIME_TO_SEC(duration_predict) AS duration_predict_seconds, 
	predict_result, coin_name FROM predictions p JOIN client_session cs ON p.client_id = cs.client_id WHERE token = token_input;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_clients` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`topdev`@`%` PROCEDURE `insert_clients`(username_input CHAR(100), first_name_input CHAR(100), last_name_input CHAR(100), email_input CHAR(100), password_input CHAR(100))
BEGIN
	DECLARE client_id_value INT UNSIGNED;
	INSERT INTO clients (username, first_name, last_name, email, password) VALUES (username_input, first_name_input, last_name_input, email_input, password_input);
	SET client_id_value = LAST_INSERT_ID(); 
	INSERT INTO client_session (client_id) VALUES (client_id_value);
	SELECT client_id, token FROM client_session WHERE id = LAST_INSERT_ID(); 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_folio_data` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`topdev`@`%` PROCEDURE `insert_folio_data`(client_id_input INT UNSIGNED, name_input CHAR(100), quantity_input DEC(10,2), purchase_price_input DEC(10,2), client_email_input CHAR(100))
    MODIFIES SQL DATA
BEGIN
	DECLARE market_id INT;
	SELECT id INTO market_id FROM market_data WHERE name = name_input ORDER BY id DESC LIMIT 1;
	INSERT INTO portfolio_tracker (client_id, name, quantity, purchase_price, client_email, market_data_id)
	VALUES (client_id_input, name_input, quantity_input, purchase_price_input, client_email_input, market_id);
	SELECT id FROM portfolio_tracker WHERE id = LAST_INSERT_ID();  
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_mkt_avax` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`topdev`@`%` PROCEDURE `insert_mkt_avax`(image_value_avax TEXT, ath_value_avax DEC(10,2), atl_value_avax DEC(10,2), cur_price_value_avax DEC(10,2), market_cap_value_avax BIGINT UNSIGNED, market_cap_rank_value_avax INT UNSIGNED, name_value_avax CHAR(100), total_supply_value_avax BIGINT UNSIGNED, total_volume_value_avax BIGINT UNSIGNED)
BEGIN
	INSERT INTO market_data (images, ath, atl, current_price, market_cap, market_cap_rank, name, total_supply, total_volume) 
	VALUES (image_value_avax, ath_value_avax, atl_value_avax, cur_price_value_avax, market_cap_value_avax, market_cap_rank_value_avax, name_value_avax, total_supply_value_avax, total_volume_value_avax);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_mkt_bnb` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`topdev`@`%` PROCEDURE `insert_mkt_bnb`(image_value_bnb TEXT, ath_value_bnb INT UNSIGNED, atl_value_bnb INT UNSIGNED, cur_price_value_bnb INT UNSIGNED, market_cap_value_bnb BIGINT UNSIGNED, market_cap_rank_value_bnb INT UNSIGNED, name_value_bnb CHAR(100), total_supply_value_bnb BIGINT UNSIGNED, total_volume_value_bnb BIGINT UNSIGNED)
    MODIFIES SQL DATA
BEGIN
	INSERT INTO market_data (images, ath, atl, current_price, market_cap, market_cap_rank, name, total_supply, total_volume) 
	VALUES (image_value_bnb, ath_value_bnb, atl_value_bnb, cur_price_value_bnb, market_cap_value_bnb, market_cap_rank_value_bnb, name_value_bnb, total_supply_value_bnb, total_volume_value_bnb);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_mkt_dot` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`topdev`@`%` PROCEDURE `insert_mkt_dot`(image_value_dot TEXT, ath_value_dot INT UNSIGNED, atl_value_dot INT UNSIGNED, cur_price_value_dot INT UNSIGNED, market_cap_value_dot BIGINT UNSIGNED, market_cap_rank_value_dot INT UNSIGNED, name_value_dot CHAR(100), total_supply_value_dot BIGINT UNSIGNED, total_volume_value_dot BIGINT UNSIGNED)
    MODIFIES SQL DATA
BEGIN
	INSERT INTO market_data (images, ath, atl, current_price, market_cap, market_cap_rank, name, total_supply, total_volume) 
	VALUES (image_value_dot, ath_value_dot, atl_value_dot, cur_price_value_dot, market_cap_value_dot, market_cap_rank_value_dot, name_value_dot, total_supply_value_dot, total_volume_value_dot);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_mkt_eth` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`topdev`@`%` PROCEDURE `insert_mkt_eth`(image_value_eth TEXT, ath_value_eth INT UNSIGNED, atl_value_eth INT UNSIGNED, cur_price_value_eth INT UNSIGNED, market_cap_value_eth BIGINT UNSIGNED, market_cap_rank_value_eth INT UNSIGNED, name_value_eth CHAR(100), total_supply_value_eth BIGINT UNSIGNED, total_volume_value_eth BIGINT UNSIGNED)
    MODIFIES SQL DATA
BEGIN
	INSERT INTO market_data (images, ath, atl, current_price, market_cap, market_cap_rank, name, total_supply, total_volume) 
	VALUES (image_value_eth, ath_value_eth, atl_value_eth, cur_price_value_eth, market_cap_value_eth, market_cap_rank_value_eth, name_value_eth, total_supply_value_eth, total_volume_value_eth);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_mkt_link` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`topdev`@`%` PROCEDURE `insert_mkt_link`(image_value_link TEXT, ath_value_link INT UNSIGNED, atl_value_link INT UNSIGNED, cur_price_value_link INT UNSIGNED, market_cap_value_link BIGINT UNSIGNED, market_cap_rank_value_link INT UNSIGNED, name_value_link CHAR(100), total_supply_value_link BIGINT UNSIGNED, total_volume_value_link BIGINT UNSIGNED)
    MODIFIES SQL DATA
BEGIN
	INSERT INTO market_data (images, ath, atl, current_price, market_cap, market_cap_rank, name, total_supply, total_volume) 
	VALUES (image_value_link, ath_value_link, atl_value_link, cur_price_value_link, market_cap_value_link, market_cap_rank_value_link, name_value_link, total_supply_value_link, total_volume_value_link);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_mkt_ltc` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`topdev`@`%` PROCEDURE `insert_mkt_ltc`(image_value_ltc TEXT, ath_value_ltc DEC(10,2), atl_value_ltc DEC(10,2), cur_price_value_ltc DEC(10,2), market_cap_value_ltc BIGINT UNSIGNED, market_cap_rank_value_ltc INT UNSIGNED, name_value_ltc CHAR(100), total_supply_value_ltc BIGINT UNSIGNED, total_volume_value_ltc BIGINT UNSIGNED)
BEGIN
	INSERT INTO market_data (images, ath, atl, current_price, market_cap, market_cap_rank, name, total_supply, total_volume) 
	VALUES (image_value_ltc, ath_value_ltc, atl_value_ltc, cur_price_value_ltc, market_cap_value_ltc, market_cap_rank_value_ltc, name_value_ltc, total_supply_value_ltc, total_volume_value_ltc);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_mkt_matic` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`topdev`@`%` PROCEDURE `insert_mkt_matic`(image_value_matic TEXT, ath_value_matic INT UNSIGNED, atl_value_matic INT UNSIGNED, cur_price_value_matic INT UNSIGNED, market_cap_value_matic BIGINT UNSIGNED, market_cap_rank_value_matic INT UNSIGNED, name_value_matic CHAR(100), total_supply_value_matic BIGINT UNSIGNED, total_volume_value_matic BIGINT UNSIGNED)
    MODIFIES SQL DATA
BEGIN
	INSERT INTO market_data (images, ath, atl, current_price, market_cap, market_cap_rank, name, total_supply, total_volume) 
	VALUES (image_value_matic, ath_value_matic, atl_value_matic, cur_price_value_matic, market_cap_value_matic, market_cap_rank_value_matic, name_value_matic, total_supply_value_matic, total_volume_value_matic);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_mkt_sol` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`topdev`@`%` PROCEDURE `insert_mkt_sol`(image_value_sol TEXT, ath_value_sol INT UNSIGNED, atl_value_sol INT UNSIGNED, cur_price_value_sol INT UNSIGNED, market_cap_value_sol BIGINT UNSIGNED, market_cap_rank_value_sol INT UNSIGNED, name_value_sol CHAR(100), total_supply_value_sol BIGINT UNSIGNED, total_volume_value_sol BIGINT UNSIGNED)
    MODIFIES SQL DATA
BEGIN
	INSERT INTO market_data (images, ath, atl, current_price, market_cap, market_cap_rank, name, total_supply, total_volume) 
	VALUES (image_value_sol, ath_value_sol, atl_value_sol, cur_price_value_sol, market_cap_value_sol, market_cap_rank_value_sol, name_value_sol, total_supply_value_sol, total_volume_value_sol);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_mkt_uni` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`topdev`@`%` PROCEDURE `insert_mkt_uni`(image_value_uni TEXT, ath_value_uni DEC(10,2), atl_value_uni DEC(10,2), cur_price_value_uni DEC(10,2), market_cap_value_uni BIGINT UNSIGNED, market_cap_rank_value_uni INT UNSIGNED, name_value_uni CHAR(100), total_supply_value_uni BIGINT UNSIGNED, total_volume_value_uni BIGINT UNSIGNED)
BEGIN
	INSERT INTO market_data (images, ath, atl, current_price, market_cap, market_cap_rank, name, total_supply, total_volume) 
	VALUES (image_value_uni, ath_value_uni, atl_value_uni, cur_price_value_uni, market_cap_value_uni, market_cap_rank_value_uni, name_value_uni, total_supply_value_uni, total_volume_value_uni);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_mkt_usdt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`topdev`@`%` PROCEDURE `insert_mkt_usdt`(image_value_usdt TEXT, ath_value_usdt INT UNSIGNED, atl_value_usdt INT UNSIGNED, cur_price_value_usdt INT UNSIGNED, market_cap_value_usdt BIGINT UNSIGNED, market_cap_rank_value_usdt INT UNSIGNED, name_value_usdt CHAR(100), total_supply_value_usdt BIGINT UNSIGNED, total_volume_value_usdt BIGINT UNSIGNED)
    MODIFIES SQL DATA
BEGIN
	INSERT INTO market_data (images, ath, atl, current_price, market_cap, market_cap_rank, name, total_supply, total_volume) 
	VALUES (image_value_usdt, ath_value_usdt, atl_value_usdt, cur_price_value_usdt, market_cap_value_usdt, market_cap_rank_value_usdt, name_value_usdt, total_supply_value_usdt, total_volume_value_usdt);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `predict_price` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`topdev`@`%` PROCEDURE `predict_price`(IN client_id_input INT UNSIGNED, IN predicted_price_input DEC(10,2), IN duration_predict_input TIME, IN coin_input CHAR(50))
    MODIFIES SQL DATA
BEGIN
	DECLARE current_price DEC(10,2);
	DECLARE prediction_end DATETIME;
	DECLARE predict_result CHAR(100);
	DECLARE predicted_price DEC(10,2);
	DECLARE client_id INT UNSIGNED;
	DECLARE coin_name CHAR(50);
	DECLARE wait INT UNSIGNED;
	
	SET client_id = client_id_input;
	SET predicted_price = predicted_price_input;
	SET coin_name = coin_input;

	SELECT current_price INTO current_price FROM market_data WHERE coin_name = coin_input ORDER BY created_at DESC LIMIT 1;
	
	SELECT MAX(created_at) INTO prediction_end FROM market_data 
	WHERE coin_name = coin_input AND created_at <= NOW();
	SET prediction_end = DATE_ADD(prediction_end, INTERVAL duration_predict_input SECOND); 

	SET wait = SLEEP(60);
	REPEAT
		SET wait = SLEEP(60);
	UNTIL NOW() >= prediction_end END REPEAT;
	
	SELECT market_data.current_price INTO current_price FROM market_data 
	WHERE market_data.name = coin_input
	AND market_data.created_at <= prediction_end 
	ORDER BY market_data.created_at DESC LIMIT 1;

	IF current_price > predicted_price THEN
		SET predict_result = CONCAT('Prediction for ', coin_input, ', ', 'Client ', client_id, ', was below the current price.');
	ELSEIF current_price < predicted_price THEN  
		SET predict_result = CONCAT('Prediction for ', coin_input, ', ', 'Client ', client_id, ', was above the current price.');
	END IF;

	INSERT INTO predictions (client_id, predicted_price, duration_predict, predict_result, coin_name)
	VALUES (client_id_input, predicted_price_input, duration_predict_input, predict_result, coin_input);
-- 	UPDATE predictions p SET predict_result = predict_result
-- 	WHERE client_id = client_id_input AND predicted_price = predicted_price_input AND duration_predict = duration_predict_input;
	SELECT predict_result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `test_insert_data_from_gecko` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`topdev`@`%` PROCEDURE `test_insert_data_from_gecko`(image_value TEXT, ath_value INT UNSIGNED, atl_value INT UNSIGNED, cur_price_value INT UNSIGNED, market_cap_value BIGINT UNSIGNED, market_cap_rank_value INT UNSIGNED, name_value CHAR(100), total_supply_value BIGINT UNSIGNED, total_volume_value BIGINT UNSIGNED)
    MODIFIES SQL DATA
BEGIN
	INSERT INTO market_data (images, ath, atl, current_price, market_cap, market_cap_rank, name, total_supply, total_volume) 
	VALUES (image_value, ath_value, atl_value, cur_price_value, market_cap_value, market_cap_rank_value, name_value, total_supply_value, total_volume_value);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `verify_del_clients` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`topdev`@`%` PROCEDURE `verify_del_clients`(client_id_input INT UNSIGNED, token_input CHAR(45))
    MODIFIES SQL DATA
BEGIN
	SELECT COUNT(*) AS count_value FROM client_session WHERE client_id = client_id_input AND token = token_input;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `verify_del_folio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`topdev`@`%` PROCEDURE `verify_del_folio`(id_input INT UNSIGNED)
    MODIFIES SQL DATA
BEGIN
	SELECT COUNT(*) AS count_value FROM portfolio_tracker p WHERE p.id = id_input; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `verify_del_login_step1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`topdev`@`%` PROCEDURE `verify_del_login_step1`(client_id_input INT UNSIGNED, token_input CHAR(45))
    MODIFIES SQL DATA
BEGIN
	SELECT COUNT(*) AS count_value FROM client_session WHERE client_id = client_id_input AND token = token_input;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `verify_login_step2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`topdev`@`%` PROCEDURE `verify_login_step2`(client_id_value INT UNSIGNED)
    MODIFIES SQL DATA
BEGIN
	IF client_id_value IS NOT NULL THEN
		INSERT INTO client_session (client_id) VALUES (client_id_value);
		SELECT client_id, token FROM client_session WHERE id = LAST_INSERT_ID(); 
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-03-25 23:14:04
