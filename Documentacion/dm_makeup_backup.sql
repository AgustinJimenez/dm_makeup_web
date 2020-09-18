CREATE DATABASE  IF NOT EXISTS `dm_makeup` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `dm_makeup`;
-- MySQL dump 10.13  Distrib 5.7.19, for Linux (x86_64)
--
-- Host: localhost    Database: dm_makeup
-- ------------------------------------------------------
-- Server version	5.7.19-0ubuntu0.16.04.1

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
-- Table structure for table `activations`
--

DROP TABLE IF EXISTS `activations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `completed` tinyint(1) NOT NULL DEFAULT '0',
  `completed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activations`
--

LOCK TABLES `activations` WRITE;
/*!40000 ALTER TABLE `activations` DISABLE KEYS */;
INSERT INTO `activations` VALUES (1,1,'kTxDWYHJNAyVeXeZeGwP7Txb0d0RoGh2',1,'2017-08-28 06:13:42','2017-08-28 06:13:42','2017-08-28 06:13:42'),(2,2,'e8KjM5XTvkKL7hPIF2NknsCWLfWXoUv5',0,NULL,'2017-08-29 12:06:10','2017-08-29 12:06:10'),(3,2,'iDWVvAIetvqSucjryTstc9OHhPJg47lO',1,'2017-08-29 12:06:10','2017-08-29 12:06:10','2017-08-29 12:06:10'),(4,3,'wWDCGNMmG32HMoZx67OY2NYCzhq0RE4Q',0,NULL,'2017-08-29 12:14:48','2017-08-29 12:14:48'),(5,3,'ZyHQ4ZU9EzXijG5v5uger9CHGlkKkFoF',1,'2017-08-29 12:14:48','2017-08-29 12:14:48','2017-08-29 12:14:48'),(6,4,'HSig6FyQgMdEfIttpuxZ0G16BanhavNV',0,NULL,'2017-08-29 12:15:10','2017-08-29 12:15:10'),(7,4,'7O0NQZN8DrpOkVWRsZNtM2rLmu1HmJHu',1,'2017-08-29 12:15:10','2017-08-29 12:15:10','2017-08-29 12:15:10');
/*!40000 ALTER TABLE `activations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `caja_cajas`
--

DROP TABLE IF EXISTS `caja_cajas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `caja_cajas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cierre` datetime NOT NULL,
  `usuario_sistema_id` int(10) unsigned NOT NULL,
  `monto_inicial` bigint(20) NOT NULL,
  `activo` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `caja_cajas_usuario_sistema_id_index` (`usuario_sistema_id`),
  CONSTRAINT `caja_cajas_usuario_sistema_id_foreign` FOREIGN KEY (`usuario_sistema_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `caja_cajas`
--

LOCK TABLES `caja_cajas` WRITE;
/*!40000 ALTER TABLE `caja_cajas` DISABLE KEYS */;
INSERT INTO `caja_cajas` VALUES (1,'0000-00-00 00:00:00',1,1,1,'2017-08-28 06:22:22','2017-08-28 06:22:22');
/*!40000 ALTER TABLE `caja_cajas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `caja_movimiento`
--

DROP TABLE IF EXISTS `caja_movimiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `caja_movimiento` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tipo` enum('extraccion','deposito') COLLATE utf8_unicode_ci NOT NULL,
  `caja_id` int(10) unsigned NOT NULL,
  `usuario_sistema_id` int(10) unsigned NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `monto` bigint(20) NOT NULL,
  `motivo` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `caja_movimiento_caja_id_index` (`caja_id`),
  KEY `caja_movimiento_usuario_sistema_id_index` (`usuario_sistema_id`),
  CONSTRAINT `caja_movimiento_caja_id_foreign` FOREIGN KEY (`caja_id`) REFERENCES `caja_cajas` (`id`),
  CONSTRAINT `caja_movimiento_usuario_sistema_id_foreign` FOREIGN KEY (`usuario_sistema_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `caja_movimiento`
--

LOCK TABLES `caja_movimiento` WRITE;
/*!40000 ALTER TABLE `caja_movimiento` DISABLE KEYS */;
/*!40000 ALTER TABLE `caja_movimiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes__clientes`
--

DROP TABLE IF EXISTS `clientes__clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clientes__clientes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `razon_social` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `cedula` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ruc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `direccion` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `telefono` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `celular` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `activo` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes__clientes`
--

LOCK TABLES `clientes__clientes` WRITE;
/*!40000 ALTER TABLE `clientes__clientes` DISABLE KEYS */;
INSERT INTO `clientes__clientes` VALUES (1,'Jermey Douglas','3588901','50959','8342 Kelton View\nWest Theresamouth, ID 11397-4044','monty02@emmerich.com','2850165','2519729',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(2,'Aliyah Renner','4646872','28186','49741 Rachael Rest Apt. 795\nPort Darron, SC 10681-3997','ryleigh38@yahoo.com','2035103','8230991',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(3,'Arnulfo Stanton','3511398','72497','9991 Edmond Parkway Suite 314\nHilllmouth, GA 68998-5115','osborne.marquardt@cole.info','4763652','4603205',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(4,'Alfredo Trantow','5568140','75581','6150 Padberg Heights\nPort German, KY 56238-2982','gpfannerstill@becker.biz','5487532','4313679',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(5,'Adah Grant','5047503','39883','7027 Bo Meadow\nSouth Lilianfort, MN 86004-5609','dubuque.delilah@sanford.net','521039','1375592',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(6,'Norval Funk','4750594','49503','809 Leonora Neck\nStantonmouth, MI 05903-0080','stephania.schaden@sporer.biz','1586240','7933968',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(7,'Horace Bailey DDS','5824813','23735','3565 Darien Junction\nWaelchifurt, GA 71474','kautzer.jack@jakubowski.net','7719075','3760421',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(8,'Isaac Cruickshank','3890575','3323','7936 Rohan Inlet Apt. 499\nNew Kelley, NC 66459-4689','caden.hermiston@yahoo.com','5611608','8403968',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(9,'Mr. Dee Haag V','5266236','2110','619 Schmidt Fork\nRebekaberg, MA 27930','stephania.schmitt@weimann.info','6210668','1948514',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(10,'Clarabelle Ferry','4720649','63489','43491 Lavon Springs Apt. 500\nWebsterchester, WA 73688','ucorkery@nitzsche.com','2537366','2074810',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(11,'Dr. Berta Adams','5722251','1851','418 Leda Wall Apt. 453\nLake Verdieside, NV 30851','desmond74@yahoo.com','8370077','3281661',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(12,'Kianna Collier','4646465','14107','3275 Sallie Trail\nPort Reese, AZ 28432-6787','hjenkins@yahoo.com','1746820','4111455',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(13,'Adolf Koepp','5685091','44935','6541 Lind Ports\nDarionton, VT 10009','abraham.kerluke@dietrich.net','4698651','1865978',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(14,'Cydney Orn','4566914','43593','42235 Jacobs Plaza\nEast Francisco, CA 21244','kuhlman.kaci@yahoo.com','2670752','2662889',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(15,'Ms. Myrtle Jacobi DVM','3074107','83699','903 Weber Alley Suite 235\nGerardmouth, MO 87054','eflatley@bernhard.biz','6429775','3021086',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(16,'Hanna Weber','5429870','59945','95134 Bins Drive Suite 011\nPort Wilfredbury, GA 40099','adams.leanna@wiza.com','4429103','2328002',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(17,'Avis Wintheiser III','3338784','64698','35579 Eliane Inlet Suite 661\nCollierberg, ID 73158','feest.chance@hotmail.com','2240391','1118027',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(18,'Yadira Green MD','4727566','64724','7571 Lesch Station Apt. 473\nWest Nealhaven, MT 57684','wpagac@reichert.com','4701581','781170',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(19,'Melvina Thiel','5814850','59509','817 Heidenreich Expressway\nEast Brant, FL 02836-6550','hazle.will@gmail.com','5955969','5060639',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(20,'Mr. Elroy Prosacco DVM','5115018','53246','5338 Wehner Parkways Apt. 960\nToymouth, MS 80943-0815','hyatt.ned@hotmail.com','3160352','4936191',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(21,'Dr. Arely Nitzsche II','4083079','32754','62442 Klocko Trace\nSporerport, GA 66417-9141','koelpin.ethel@lebsack.com','1094831','350690',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(22,'Maurice Littel','5032214','28615','7737 Ferry Square\nNew Adam, VA 36347','xrutherford@price.com','7604828','7752665',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(23,'Izabella Schmeler','5405195','38678','61265 Waelchi Rapid\nSouth Raphaelle, CO 98360','fisher.ellis@lockman.org','7227448','6331903',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(24,'Eleazar Kuhic','4566824','31874','443 Reichel Ridges\nLake Mariamfort, TX 49793','angelina.schowalter@okeefe.com','8996282','521804',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(25,'Mr. Garett Spencer MD','3595286','50544','72452 Lueilwitz Viaduct Suite 158\nCarolynton, CA 36375','dmurray@aufderhar.com','8530394','3511761',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(26,'Miss Alisha Wiegand','4969548','79285','6103 Wiza Hill Suite 844\nLake Abigayle, WV 53250-9421','denesik.jazmyne@abbott.org','52917','4370094',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(27,'Kaelyn Hoppe','4319433','22596','657 Schmeler Points Apt. 453\nWest Bettyeborough, ND 72218-3720','marilyne.feil@yahoo.com','5507440','2947264',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(28,'Prof. Alana Casper','5119323','70444','867 Merlin Glens Suite 073\nWest Brainmouth, AZ 31050','jazmyn.stamm@gmail.com','375324','6800992',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(29,'Devon Steuber','5160408','34247','9263 Cruickshank Underpass Suite 017\nO\'Connermouth, MS 84192','adeckow@bahringer.com','4361620','5569863',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(30,'Prof. Aron Franecki','5392731','69169','1123 Nona Creek\nNew Dawnstad, LA 93332','coby46@abshire.com','7718732','473512',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(31,'Dr. Keshaun Torp IV','5227172','42110','21751 Jamie Viaduct\nSouth Eulah, VT 94141','marcelino20@bailey.com','2002897','495801',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(32,'Melisa Cummings Jr.','3615595','77295','3120 Itzel Square\nErynhaven, WY 34685-2191','vena61@bosco.com','6407852','3879520',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(33,'Alfred Goyette','5374972','55354','56735 Mary Fort\nBaileychester, TX 11629-3530','elmo29@morar.info','7863777','2527308',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(34,'Judge Beahan','4098082','61052','5925 Moen Prairie Suite 882\nWest Alialand, NE 37156','vveum@gmail.com','504763','7665226',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(35,'Carolyn Weissnat','3968069','33605','5776 Stiedemann Mill\nRevamouth, CO 71095-4077','cordie.kreiger@yahoo.com','2374503','839464',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(36,'Jaquelin Robel','4364707','68038','77933 Herman Lights\nPort Dominicland, CO 30378','shanie65@marvin.com','3311691','6693007',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(37,'Izaiah Gleason','3601243','29912','514 Moore Spurs\nEast Buckville, IN 92408-2619','jocelyn.rowe@torphy.com','3698330','2352139',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(38,'Prof. Herman Labadie','5853940','56748','588 Montana Flats\nSouth Vladimir, MA 42042-0838','marianne.langworth@hand.com','985948','1150725',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(39,'Mr. Cooper Schmitt','4130253','16727','8472 Schiller Meadows\nLake Elnashire, KY 21846','royal37@gmail.com','6952566','6498477',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(40,'Zakary Barton','3341052','9395','723 Hayes Forks Suite 133\nHammesberg, ND 08156','jaqueline.champlin@gmail.com','8797629','3314870',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(41,'Anita McClure','4290657','62454','3157 Mavis Avenue Suite 498\nShieldschester, VA 67062','tressie34@hotmail.com','3633145','260078',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(42,'Stan Hermann','5217667','23327','6244 Mante Street\nBrakusside, MD 07533-6406','azulauf@gmail.com','8325148','1553362',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(43,'Napoleon Mitchell','4068533','78928','38682 Kub Orchard Apt. 404\nFeeneyport, FL 71729','annabelle55@lockman.net','6077754','915025',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(44,'Hollis Johnson','4723661','35975','80635 Feil Summit\nNorth Reba, KS 84258-5692','morgan.schuster@schinner.com','6331436','8036560',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(45,'Dr. Magali Powlowski V','5914410','87532','4141 Hyman Skyway\nFloridafurt, MO 02161-9965','gpaucek@gmail.com','7252589','5486125',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(46,'Mrs. Karli Parker DDS','5037600','31009','513 Berry Glens Suite 649\nKiehnbury, MI 27340-0584','roob.kaylie@gmail.com','962782','1197964',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(47,'Adrienne Raynor DVM','4550807','68756','2325 McCullough Points Suite 597\nPort Taurean, AK 83361-0272','moriah.haley@shields.info','6856422','7373480',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(48,'Mr. Travis Thompson III','3466943','42296','2690 Jakubowski Garden\nRathport, VA 25996','gordon43@yahoo.com','4689916','6897329',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(49,'Prof. Sid Johnson','5486835','78080','7742 Lesly Crossroad Suite 517\nSouth Leo, WA 16630-2076','ernser.anabel@hotmail.com','5737795','3342572',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(50,'Emmett Erdman','4213773','80535','531 Anderson Canyon Suite 583\nWest Rexmouth, NM 74551-2260','jenifer.williamson@gmail.com','5623418','7829578',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(51,'Mona Funk','4718354','57922','92089 Evert Mill\nWest Magdalenmouth, NV 90892','cara.champlin@oberbrunner.biz','8687598','8230959',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(52,'Autumn Homenick','5638936','67336','94579 Grimes Spurs Apt. 701\nLake Duane, CT 68547','arno.schuppe@steuber.org','6995758','7802036',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(53,'Chanel Bergnaum','5485101','39289','3488 Elroy Neck\nPort Merleside, MT 76961','alayna.labadie@ondricka.com','5490239','4334689',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(54,'Rita Effertz PhD','5914634','64600','885 Darrin Viaduct\nLake Jewelborough, SD 46171','davis.andre@gaylord.com','4889310','8156328',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(55,'Jannie Will','5376755','45701','323 Predovic Isle\nSouth Jacinto, NE 09934-5625','addie89@hotmail.com','7159270','1578502',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(56,'Robert Ryan','3452863','4883','4615 Duane Squares Suite 070\nNew Muhammadmouth, NC 33462-7359','marquise74@gmail.com','1950015','4480441',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(57,'Prof. Erna Kunze','4439202','17435','85364 Queen Ports Apt. 594\nLucianochester, ID 78439-2430','mcdermott.tressa@stracke.net','8669720','4967838',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(58,'Name Heidenreich','5357091','17670','3948 Lauriane Turnpike\nValentinaside, GA 41204','wwitting@hotmail.com','1489221','6581589',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(59,'Sunny Dibbert','3039648','13842','6285 Wunsch Run\nValeriemouth, NC 69367','tweissnat@yahoo.com','2239644','2633994',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(60,'Mohamed Bechtelar','5341685','16656','63362 Dach Branch Suite 230\nPort Celiabury, MD 56477','rebeca.collier@hotmail.com','2512506','7880973',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(61,'Eldred Hermiston I','4841626','19235','844 Glover Fields Suite 953\nSolonborough, CA 44182','lauretta.kuhic@yahoo.com','3038818','7943484',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(62,'Beaulah Torp','5863050','36443','29954 Deckow Ways Suite 139\nKeelingborough, MA 67219','hodkiewicz.lois@franecki.com','3241299','3946063',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(63,'Prof. Brent Hoppe','5371795','10892','975 Bartoletti Loop Apt. 613\nSouth Joshuah, WY 68803','rey06@keebler.info','349524','8665118',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(64,'Freda Lemke PhD','4088250','41794','9250 Jaqueline Lake Apt. 749\nNorth Kayden, IN 09365-3332','xkris@hotmail.com','7139055','4215146',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(65,'Abdullah Spinka','3234280','54140','9849 Candace Junction Apt. 575\nNorth Eulashire, MT 03425','kristopher.quigley@fay.com','7270113','1542773',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(66,'Kristy Rodriguez I','3301114','41292','15842 Peyton Fork\nNorth Demond, AL 38123','gerardo26@rippin.com','1311440','8745319',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(67,'Carmela Murray','3177866','46635','6388 Lynch Terrace Suite 339\nWeimannberg, CA 14001-4201','gaylord.eryn@gmail.com','6983541','2701765',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(68,'Andreane Turner','3650424','51510','2002 Jessy Bridge\nSouth Karina, ID 36076-4887','wallace27@mohr.com','7716140','585037',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(69,'Dr. Chadd Raynor MD','3214037','30716','61571 Brando Station Suite 875\nEast Rahsaan, ME 36666','kuvalis.elza@gmail.com','8909394','362511',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(70,'Elnora Weimann','5692349','41947','26746 Auer Center Suite 194\nReichertfurt, WV 23144-2022','nicole.russel@hotmail.com','8436232','902848',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(71,'Rosina Mohr','3766923','12682','2094 Judah Well\nNorth Ebba, IN 76393-1542','fanny.spencer@hansen.com','4323429','4148485',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(72,'Kennedi Sporer','5520941','47113','3456 Shany Stream\nQuigleyton, WV 73940-8861','swatsica@mueller.com','3541226','7304654',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(73,'Ashton Haag','3501700','29726','2537 Hammes Causeway\nWeissnatville, HI 70093-9455','eva.lebsack@yahoo.com','650775','5474141',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(74,'Mrs. Audreanne Simonis V','3700299','65732','23583 Leola Key\nHomenickmouth, LA 69166-7016','mayert.zakary@kulas.info','219533','7456598',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(75,'Oswald Kunze','3911471','74564','791 Schinner Shores Apt. 822\nClintonhaven, VT 03976','aurelia64@nicolas.org','3078479','6797590',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(76,'Mrs. Gladyce Koch','5142984','59516','40154 Bernier Loaf\nHammeschester, IA 27403-8060','melvin47@prohaska.com','6044356','8312206',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(77,'Dino Skiles','3465279','73602','445 Lesch Locks Suite 781\nZiemeview, KY 42013-4218','tmcdermott@roob.org','74304','4211397',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(78,'Zaria Keeling','4273181','82302','746 Larkin Estates Suite 481\nEast Chanel, MN 17795-6435','luigi.waelchi@gmail.com','6320439','1492135',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(79,'Ms. Marta Emmerich','4390750','26423','3574 Carter Plains Suite 334\nTomasborough, UT 01797-6486','arianna11@gusikowski.com','6103053','88082',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(80,'Neil Hand','5674808','80639','5247 Adams Prairie Apt. 117\nBednarstad, HI 90975','ubergnaum@hotmail.com','4031346','1991933',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(81,'Kory Hammes','5045743','76801','314 Kirsten Views Apt. 192\nNorth Lina, SC 70790-9216','dbotsford@gmail.com','7392853','6019049',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(82,'Ms. Antonina Grimes III','3358668','37998','79352 Mraz Curve Suite 099\nJayside, NJ 43355','idurgan@yahoo.com','2695429','7244498',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(83,'Carson Fay III','5470264','40718','60110 Cristian Village\nEast Molly, MS 78030-4466','ytorp@sporer.com','2877130','5610329',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(84,'Myra Cruickshank II','5776751','13414','8558 Myles Pine Suite 129\nPort Meaganhaven, WY 41540-0631','gerardo37@davis.com','2328409','5987354',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(85,'Carlotta Schinner','4540873','47284','69827 Morgan Mall\nEast Arthurchester, ND 20822-5935','erwin.larson@borer.info','5746196','4197084',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(86,'Benny Bayer','4847077','77693','75756 Arjun Rapids Apt. 012\nRosalindaside, KY 57429','willms.braxton@turner.com','3079189','8718156',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(87,'Louisa Conroy','4640585','57803','235 Jamal Estate Suite 462\nNorth Guadalupeberg, MO 12351-4148','stehr.burley@yahoo.com','2210263','5581207',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(88,'Vernon Wolff','5920992','88614','1725 Miller Forks\nTarynstad, MA 07762','reilly48@yahoo.com','8340622','3848615',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(89,'Dr. Weldon Rosenbaum','3845817','35932','23837 Pollich Fords Apt. 128\nDorothyfort, HI 24566-9218','klein.naomi@hotmail.com','6457448','4389506',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(90,'Augustine Braun','4583282','50965','7561 Yessenia Shoals Apt. 582\nSchambergerfurt, AZ 94985','slubowitz@yahoo.com','2834463','3286211',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(91,'Norene Langosh','4421456','23054','15577 Emard Cape\nGerdaville, NE 58984','deshawn.hermiston@king.com','2120149','7433066',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(92,'Humberto Rowe','3895029','74408','3321 Paris Flat Suite 314\nNew Dawn, WI 61861-2214','haley.isaiah@hotmail.com','7491145','2415312',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(93,'Brannon Corkery DVM','5539753','5392','73813 Fisher Branch Apt. 347\nNew Deonteborough, MS 04981-1942','bheathcote@jones.com','3033026','8942194',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(94,'Vladimir Marquardt','5645070','17254','4442 Farrell Junctions Suite 881\nColliertown, TX 78361-8249','marquardt.grayson@gmail.com','4892329','4783259',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(95,'Grace Schneider','3091359','35827','1525 Lakin Ford Apt. 570\nNorth Margrethaven, FL 11831','pfannerstill.pauline@kris.org','6382860','3269789',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(96,'Percy Quigley DVM','5063631','10346','591 Hartmann Alley\nEast Tracyfort, WY 90217-0097','schuppe.rachael@trantow.org','7056628','7304326',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(97,'Sienna Cruickshank','3846301','13519','13985 June Manor Suite 031\nAlannatown, IL 61603','melyssa69@gmail.com','7148262','7663701',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(98,'Tanner Cremin PhD','3790151','18529','532 Smith Lodge\nJacobsshire, UT 91642','sammie44@jacobs.org','1448551','4638545',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(99,'Adriana Baumbach','5904328','20694','41126 Celine Dale Apt. 655\nUlicesside, SD 99068','chyatt@gmail.com','6662521','6521615',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(100,'Marcos Jast','3430227','25296','926 Herzog Ferry\nEast Micaela, RI 24410','gmurray@langworth.com','139541','188357',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(101,'Baylee Weissnat','4857951','54838','46268 Elias Drives\nEast Alvisfort, CO 55548','yquigley@hotmail.com','4018633','7725654',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(102,'Ansley Thompson','5209503','62737','3477 Nellie Walk\nNew Quincymouth, VA 56548-7691','mante.grant@gmail.com','387207','8486738',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(103,'Mr. Marco Herman I','4720403','8494','4907 Vicente Terrace\nJadashire, MO 68464','heidi.rutherford@ledner.org','8756295','1512658',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(104,'Trevor Klocko','3355691','29183','5267 Kassulke Grove\nAdamton, DE 08121-2766','roslyn74@quigley.org','7902219','1369337',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(105,'Miss Sallie Hickle','5350385','18614','12068 Walsh Falls Suite 669\nEast Efrenmouth, NM 71599','carole.koelpin@gerlach.org','7151413','6940966',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(106,'Elena Murray MD','5284983','33939','151 Okuneva Ridge Suite 134\nKellybury, WY 44927-0720','muller.finn@davis.com','308375','2562842',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(107,'Antonina Dooley','3623396','22207','9792 Vicky Cliffs Suite 509\nPort Omaland, UT 20684','kari.little@bergstrom.com','6298905','5937628',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(108,'Dr. Hunter Spencer MD','4858889','39585','969 Hamill Drive Apt. 475\nKuphalport, ND 94453','thompson.aaron@baumbach.com','1366871','121018',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(109,'Jake Kautzer Sr.','5499709','37645','46776 Jaren Route Apt. 483\nNew Leopoldoport, CO 10998','bernhard.kayley@gmail.com','1871574','340333',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(110,'Yasmin Gleason DDS','3131454','72303','64186 Yesenia Union\nLake Earnestineburgh, CT 31018-7321','angelo.emmerich@yahoo.com','8215280','8633431',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(111,'Ms. Lelia Adams','3975960','66422','2317 Brent Center\nOkunevachester, NH 37821-9285','pcollier@yahoo.com','8350511','3768439',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(112,'Ms. Evalyn Senger','4319625','31268','311 Yost Tunnel Apt. 339\nLake Weldonview, SD 25359','hester.upton@hotmail.com','709857','786569',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(113,'Albina Murray IV','5582503','43697','3387 Wiegand Neck Apt. 828\nJohnsonbury, WY 85056-1511','napoleon.towne@lebsack.org','799359','4273604',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(114,'Vergie Abshire','4314484','88679','477 Walsh Estate Apt. 201\nArdellamouth, FL 15697','caleigh.purdy@ortiz.com','6623241','785183',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(115,'Dr. Rhiannon Hamill DDS','3114426','43230','8190 Lesch Junction Suite 966\nNew Betteville, WY 93920-4074','kirsten81@gmail.com','8600613','6014215',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(116,'Simeon Nicolas','3556156','27586','733 Creola Views Apt. 812\nEast Silaschester, IN 99992-1841','schuyler86@gmail.com','7230145','6397582',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(117,'Eunice Jacobi V','5048555','9325','127 Hammes Groves Apt. 783\nBorerton, NY 84236-9823','serena79@hotmail.com','7168260','1618724',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(118,'Christy Gerhold','3969070','20185','483 Roberto Ways Suite 711\nNew Myraview, PA 92232','barton68@gmail.com','5933334','8854072',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(119,'Talia Wehner','4353760','87990','777 Sadye Street Suite 522\nNolabury, IA 70299-2277','krystina.ziemann@langworth.info','4651228','188723',1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(120,'Mrs. Barbara Torp','3247853','40434','768 Gottlieb Turnpike Apt. 117\nJacobsfort, ND 32033-2627','nyah14@yahoo.com','6984482','5301129',1,'0000-00-00 00:00:00','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `clientes__clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compras__compras`
--

DROP TABLE IF EXISTS `compras__compras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compras__compras` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tipo` enum('producto','cristal','servicio','otro') COLLATE utf8_unicode_ci NOT NULL,
  `nro_factura` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `timbrado` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `anulado` tinyint(1) NOT NULL,
  `proveedor_id` int(10) unsigned NOT NULL,
  `razon_social` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ruc_proveedor` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  `tipo_factura` enum('contado','credito') COLLATE utf8_unicode_ci NOT NULL,
  `monto_total` bigint(20) NOT NULL,
  `monto_total_letras` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `gravado_excenta` bigint(20) NOT NULL,
  `gravado_5` bigint(20) NOT NULL,
  `gravado_10` bigint(20) NOT NULL,
  `total_iva_5` bigint(20) NOT NULL,
  `total_iva_10` bigint(20) NOT NULL,
  `total_iva` bigint(20) NOT NULL,
  `observacion` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `total_pagado` bigint(20) NOT NULL,
  `comprobante` tinyint(1) NOT NULL,
  `moneda` enum('Guaranies','Dolares','Euros') COLLATE utf8_unicode_ci NOT NULL,
  `cambio` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `usuario_sistema_id` int(10) unsigned NOT NULL,
  `usuario_sistema_id_edit` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `compras__compras_proveedor_id_index` (`proveedor_id`),
  KEY `compras__compras_usuario_sistema_id_index` (`usuario_sistema_id`),
  KEY `compras__compras_usuario_sistema_id_edit_index` (`usuario_sistema_id_edit`),
  CONSTRAINT `compras__compras_proveedor_id_foreign` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedores__proveedors` (`id`),
  CONSTRAINT `compras__compras_usuario_sistema_id_edit_foreign` FOREIGN KEY (`usuario_sistema_id_edit`) REFERENCES `users` (`id`),
  CONSTRAINT `compras__compras_usuario_sistema_id_foreign` FOREIGN KEY (`usuario_sistema_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compras__compras`
--

LOCK TABLES `compras__compras` WRITE;
/*!40000 ALTER TABLE `compras__compras` DISABLE KEYS */;
/*!40000 ALTER TABLE `compras__compras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compras__detallecompras`
--

DROP TABLE IF EXISTS `compras__detallecompras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compras__detallecompras` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `compra_id` int(10) unsigned NOT NULL,
  `descripcion` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `producto_id` int(10) unsigned DEFAULT NULL,
  `cantidad` double(24,4) NOT NULL,
  `precio_unitario` bigint(20) NOT NULL,
  `iva` enum('10','5','excenta') COLLATE utf8_unicode_ci NOT NULL,
  `precio_total` bigint(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `compras__detallecompras_compra_id_index` (`compra_id`),
  KEY `compras__detallecompras_producto_id_index` (`producto_id`),
  CONSTRAINT `compras__detallecompras_compra_id_foreign` FOREIGN KEY (`compra_id`) REFERENCES `compras__compras` (`id`) ON DELETE CASCADE,
  CONSTRAINT `compras__detallecompras_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos__productos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compras__detallecompras`
--

LOCK TABLES `compras__detallecompras` WRITE;
/*!40000 ALTER TABLE `compras__detallecompras` DISABLE KEYS */;
/*!40000 ALTER TABLE `compras__detallecompras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compras_facturas`
--

DROP TABLE IF EXISTS `compras_facturas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compras_facturas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `compra_id` int(10) unsigned DEFAULT NULL,
  `nro_factura` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  `anulado` tinyint(1) NOT NULL,
  `forma_pago` enum('contado','credito') COLLATE utf8_unicode_ci NOT NULL,
  `usuario_sistema_id_create` int(10) unsigned NOT NULL,
  `usuario_sistema_id_edit` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `compras_facturas_compra_id_index` (`compra_id`),
  KEY `compras_facturas_usuario_sistema_id_create_index` (`usuario_sistema_id_create`),
  KEY `compras_facturas_usuario_sistema_id_edit_index` (`usuario_sistema_id_edit`),
  CONSTRAINT `compras_facturas_compra_id_foreign` FOREIGN KEY (`compra_id`) REFERENCES `compras__compras` (`id`) ON DELETE CASCADE,
  CONSTRAINT `compras_facturas_usuario_sistema_id_create_foreign` FOREIGN KEY (`usuario_sistema_id_create`) REFERENCES `users` (`id`),
  CONSTRAINT `compras_facturas_usuario_sistema_id_edit_foreign` FOREIGN KEY (`usuario_sistema_id_edit`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compras_facturas`
--

LOCK TABLES `compras_facturas` WRITE;
/*!40000 ALTER TABLE `compras_facturas` DISABLE KEYS */;
/*!40000 ALTER TABLE `compras_facturas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compras_facturas_config`
--

DROP TABLE IF EXISTS `compras_facturas_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compras_facturas_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nro_factura_1` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `nro_factura_2` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `nro_factura_ai` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compras_facturas_config`
--

LOCK TABLES `compras_facturas_config` WRITE;
/*!40000 ALTER TABLE `compras_facturas_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `compras_facturas_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compras_pagos`
--

DROP TABLE IF EXISTS `compras_pagos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compras_pagos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `compra_id` int(10) unsigned NOT NULL,
  `caja_id` int(10) unsigned NOT NULL,
  `fecha` date NOT NULL,
  `forma_pago` enum('efectivo','cheque','tarjeta_credito','tarjeta_debito') COLLATE utf8_unicode_ci NOT NULL,
  `monto` bigint(20) NOT NULL,
  `nro_recibo` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `observacion` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `compras_pagos_compra_id_index` (`compra_id`),
  KEY `compras_pagos_caja_id_index` (`caja_id`),
  CONSTRAINT `compras_pagos_caja_id_foreign` FOREIGN KEY (`caja_id`) REFERENCES `caja_cajas` (`id`),
  CONSTRAINT `compras_pagos_compra_id_foreign` FOREIGN KEY (`compra_id`) REFERENCES `compras__compras` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compras_pagos`
--

LOCK TABLES `compras_pagos` WRITE;
/*!40000 ALTER TABLE `compras_pagos` DISABLE KEYS */;
/*!40000 ALTER TABLE `compras_pagos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contabilidad__asientodetalles`
--

DROP TABLE IF EXISTS `contabilidad__asientodetalles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contabilidad__asientodetalles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `asiento_id` int(10) unsigned NOT NULL,
  `cuenta_id` int(10) unsigned NOT NULL,
  `debe` bigint(20) NOT NULL,
  `haber` bigint(20) NOT NULL,
  `observacion` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `contabilidad__asientodetalles_asiento_id_index` (`asiento_id`),
  KEY `contabilidad__asientodetalles_cuenta_id_index` (`cuenta_id`),
  CONSTRAINT `contabilidad__asientodetalles_asiento_id_foreign` FOREIGN KEY (`asiento_id`) REFERENCES `contabilidad__asientos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `contabilidad__asientodetalles_cuenta_id_foreign` FOREIGN KEY (`cuenta_id`) REFERENCES `contabilidad__cuentas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contabilidad__asientodetalles`
--

LOCK TABLES `contabilidad__asientodetalles` WRITE;
/*!40000 ALTER TABLE `contabilidad__asientodetalles` DISABLE KEYS */;
INSERT INTO `contabilidad__asientodetalles` VALUES (1,1,178,870000,0,'','2017-08-28 06:29:05','2017-08-28 06:29:05'),(2,1,123,0,792655,'','2017-08-28 06:29:05','2017-08-28 06:29:05'),(3,1,21,0,77345,'','2017-08-28 06:29:05','2017-08-28 06:29:05'),(4,2,178,200000,0,'','2017-08-28 18:33:30','2017-08-28 18:33:30'),(5,2,123,0,183367,'','2017-08-28 18:33:30','2017-08-28 18:33:30'),(6,2,21,0,16633,'','2017-08-28 18:33:30','2017-08-28 18:33:30'),(7,3,178,330000,0,'','2017-08-29 13:56:30','2017-08-29 13:56:30'),(8,3,123,0,307706,'','2017-08-29 13:56:30','2017-08-29 13:56:30'),(9,3,21,0,22294,'','2017-08-29 13:56:30','2017-08-29 13:56:30'),(10,4,178,205000,0,'','2017-08-29 13:59:41','2017-08-29 13:59:41'),(11,4,123,0,185889,'','2017-08-29 13:59:41','2017-08-29 13:59:41'),(12,4,21,0,19111,'','2017-08-29 13:59:41','2017-08-29 13:59:41'),(13,5,178,200000,0,'','2017-08-29 14:10:29','2017-08-29 14:10:29'),(14,5,123,0,183537,'','2017-08-29 14:10:29','2017-08-29 14:10:29'),(15,5,21,0,16463,'','2017-08-29 14:10:29','2017-08-29 14:10:29');
/*!40000 ALTER TABLE `contabilidad__asientodetalles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contabilidad__asientos`
--

DROP TABLE IF EXISTS `contabilidad__asientos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contabilidad__asientos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `operacion` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `observacion` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `usuario_create_id` int(10) unsigned DEFAULT NULL,
  `usuario_edit_id` int(10) unsigned DEFAULT NULL,
  `entidad_id` int(11) DEFAULT NULL,
  `entidad_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `contabilidad__asientos_usuario_create_id_index` (`usuario_create_id`),
  KEY `contabilidad__asientos_usuario_edit_id_index` (`usuario_edit_id`),
  CONSTRAINT `contabilidad__asientos_usuario_create_id_foreign` FOREIGN KEY (`usuario_create_id`) REFERENCES `users` (`id`),
  CONSTRAINT `contabilidad__asientos_usuario_edit_id_foreign` FOREIGN KEY (`usuario_edit_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contabilidad__asientos`
--

LOCK TABLES `contabilidad__asientos` WRITE;
/*!40000 ALTER TABLE `contabilidad__asientos` DISABLE KEYS */;
INSERT INTO `contabilidad__asientos` VALUES (1,'2017-08-28','Venta Contado','Venta al Contado  | Cliente:  Jermey Douglas | Factura Nro:  001 - 001 - 001 |  Sobre Nro:  17/1',1,NULL,1,'Modules\\Ventas\\Entities\\FacturaVenta','2017-08-28 06:29:05','2017-08-28 06:29:05'),(2,'2017-08-28','Venta Contado','Venta al Contado  | Cliente:  Cydney Orn | Factura Nro:  001 - 001 - 002 |  Sobre Nro:  17/2',1,NULL,2,'Modules\\Ventas\\Entities\\FacturaVenta','2017-08-28 18:33:30','2017-08-28 18:33:30'),(3,'2017-08-29','Venta Contado','Venta al Contado  | Cliente:  Ms. Myrtle Jacobi DVM | Factura Nro:  001 - 001 - 003 |  Sobre Nro:  17/3',2,NULL,3,'Modules\\Ventas\\Entities\\FacturaVenta','2017-08-29 13:56:30','2017-08-29 13:56:30'),(4,'2017-08-29','Venta Contado','Venta al Contado  | Cliente:  Adah Grant | Factura Nro:  001 - 001 - 004 |  Sobre Nro:  17/4',2,NULL,4,'Modules\\Ventas\\Entities\\FacturaVenta','2017-08-29 13:59:41','2017-08-29 13:59:41'),(5,'2017-08-29','Venta Contado','Venta al Contado  | Cliente:  Adah Grant | Factura Nro:  001 - 001 - 005 |  Sobre Nro:  17/5',2,NULL,5,'Modules\\Ventas\\Entities\\FacturaVenta','2017-08-29 14:10:29','2017-08-29 14:10:29');
/*!40000 ALTER TABLE `contabilidad__asientos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contabilidad__cuentas`
--

DROP TABLE IF EXISTS `contabilidad__cuentas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contabilidad__cuentas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `codigo` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `padre` int(11) DEFAULT NULL,
  `tiene_hijo` tinyint(1) NOT NULL,
  `activo` tinyint(1) NOT NULL,
  `tipo` int(10) unsigned NOT NULL,
  `profundidad` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `contabilidad__cuentas_tipo_index` (`tipo`),
  CONSTRAINT `contabilidad__cuentas_tipo_foreign` FOREIGN KEY (`tipo`) REFERENCES `contabilidad__tipocuentas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=179 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contabilidad__cuentas`
--

LOCK TABLES `contabilidad__cuentas` WRITE;
/*!40000 ALTER TABLE `contabilidad__cuentas` DISABLE KEYS */;
INSERT INTO `contabilidad__cuentas` VALUES (1,'01','Activo',NULL,1,1,1,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(2,'01.01','Activo Corriente',1,1,1,1,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(3,'01.01.01','Disponibilidad',2,1,1,1,3,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(4,'01.01.01.01','Recaudaciones a Depositar',3,0,1,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(5,'01.01.01.02','Caja',3,1,1,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(6,'01.01.01.03','Fondos Fijos',3,0,1,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(7,'01.01.01.04','Bancos',3,0,1,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(8,'01.01.02','Inversiones Temporarias',2,1,1,1,3,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(9,'01.01.02.01','Inversiones Financieras',8,0,1,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(10,'01.01.02.02','Inversiones en Entidades Vinculadas',8,0,0,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(11,'01.01.02.03','Otras Inversiones',8,0,1,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(12,'01.01.02.04','Intereses, Regalias y otros Rendimientos de Inversiones',8,0,1,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(13,'01.01.03','Creditos',2,1,1,1,3,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(14,'01.01.03.01','Deudores por Ventas',13,0,1,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(15,'01.01.03.02','Deudores por Prestamos',13,0,1,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(16,'01.01.03.03','Cuentas a Cobrar a Directores y Funcionarios',13,0,0,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(17,'01.01.03.04','Cuentas a Cobrar a Socios o Entidades Vinculadas',13,0,0,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(18,'01.01.03.05','Creditos por Impuestos Corrientes',13,1,1,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(19,'01.01.03.05.01','Anticipos y Retenciones de Impuesto a la Renta',18,0,1,1,5,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(20,'01.01.03.05.02','Retenciones de IVA',18,0,1,1,5,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(21,'01.01.03.05.03','IVA - Credito Fiscal',18,0,1,1,5,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(22,'01.01.03.06','Anticipos a Proveedores',13,1,1,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(23,'01.01.03.06.01','Anticipos a Proveedores Locales',22,0,1,1,5,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(24,'01.01.03.06.02','Anticipos a Proveedores del Exterior',22,0,1,1,5,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(25,'01.01.03.99','(-) PREVISIÓN PARA CRÉDITOS DE DUDOSO COBRO',13,0,1,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(26,'01.01.04','Inventarios',2,1,1,1,3,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(27,'01.01.04.01','Mercaderias',26,1,1,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(28,'01.01.04.01.01','Mercaderias gravadas por el IVA al 10%',27,0,1,1,5,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(29,'01.01.04.01.02','Mercaderias gravadas por el IVA al 5%',27,0,1,1,5,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(30,'01.01.04.01.03','Mercaderias gravadas Exentas de IVA',27,0,1,1,5,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(31,'01.01.04.02','Mercaderias Regimen Especiales',26,0,0,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(32,'01.01.04.03','Productos Terminados',26,0,0,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(33,'01.01.04.04','Productos en Procesos',26,0,0,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(34,'01.01.04.05','Materias Primas',26,0,0,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(35,'01.01.04.06','Materiales , Suministros y Repuestos',26,0,0,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(36,'01.01.04.07','Productos Agricolas',26,0,0,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(37,'01.01.04.08	','Productos Forestales',26,0,0,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(38,'01.01.04.09','Activos Biologicos en Produccion',26,0,0,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(39,'01.01.04.10','Activos Biologicos en Desarrollo',26,0,0,1,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(40,'01.01.04.11','Importaciones en Curso',26,0,1,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(41,'1.01.04.99','(-) PREVISIÓN POR DEVALUACIÓN DE INVENTARIOS',26,0,1,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(42,'01.01.04.11','Importaciones en Curso',26,0,1,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(43,'01.01.04.99','(-) PREVISIÓN POR DEVALUACIÓN DE INVENTARIOS',26,0,1,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(44,'01.01.05','Gastos Pagados por Adelantado',2,1,1,1,3,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(45,'01.01.05.01','Alquileres Pagados por Adelantado',44,0,1,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(46,'01.01.05.02','Seguros Devengar',44,0,1,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(47,'01.02','Activo No Corriente',1,1,1,1,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(48,'01.02.01','Creditos a largo Plazo',47,1,1,1,3,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(49,'01.02.01.01','Deudores por Venta',48,0,1,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(50,'01.02.01.02','Deudores por Prestamos',48,0,1,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(51,'01.02.01.03','Cuentas a Cobrar a Directores y Funcionarios',48,0,0,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(52,'01.02.01.04','Cuentas a Cobrar a socios o entidades Vinculadas',48,0,0,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(53,'01.02.01.05','Deudores en Gestion de Cobros - Morosos Similares',48,0,0,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(54,'01.02.01.06','Anticipo a Proveedores',48,1,1,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(55,'01.02.01.99','(-) Prevision para dudoso Cobro',48,1,1,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(56,'01.02.04','Propiedad, Planta y Equipo',47,1,1,1,3,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(57,'01.02.04.01','Inmueble',56,0,1,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(58,'01.02.04.02','Rodados Transportes',56,0,1,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(59,'01.02.04.03','Muebles, Utiles y Enseres',56,0,1,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(60,'01.02.04.04','Maquinarias',56,0,1,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(61,'01.02.04.05','Equipos',56,0,1,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(62,'01.02.04.06','Herramientas',56,0,1,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(63,'01.02.04.07','Bienes fuera de Operacion',56,0,1,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(64,'01.02.04.08','Mejoras en Predio Ajeno',56,0,1,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(65,'01.02.04.97','Bienes Incorporados al Amparo de la Ley N° 60/90',56,0,1,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(66,'01.02.04.98','Bienes de arrendamiento Finaciero',56,0,1,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(67,'01.02.04.99','Depreciacion Acumulada',56,0,1,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(68,'01.02.07','Activos Intangibles',47,1,1,1,3,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(69,'01.02.07.01','Licencias Marcas y Patentes',68,1,1,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(70,'01.02.07.02','Franquicias',68,1,0,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(71,'01.02.07.99','Amortizacion Acumulada',68,0,1,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(72,'02','Pasivo',NULL,1,1,2,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(73,'02.01','Pasivo Corriente',72,1,1,2,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(74,'02.01.01','Activo No Corriente',73,1,1,2,3,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(75,'02.01.01.01','Proveedores Locales',74,0,1,2,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(76,'02.01.01.02 ','Proveedores del Exterior',74,0,1,2,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(77,'2.01.01.03 ','Intereses a Pagar a Proveedores',74,0,0,2,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(78,'02.01.01.04','Otros Acreedores',74,0,1,2,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(79,'02.01.02','Deudas Financieras',72,1,1,2,3,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(80,'02.01.02.01','Prestamos de bancos y otras Entidades Financieras',79,0,1,2,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(81,'02.01.02.02','Prestamos del dueño, Socios o Entidades Vinculadas',79,0,1,2,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(82,'02.01.02.03','Arrendamientos Finacieros',79,0,1,1,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(83,'02.01.02.04','Otros Prestamos a Pagar',79,0,1,2,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(84,'02.01.02.05','Intereses a Pagar',79,0,1,2,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(85,'02.01.03','Otras Cuentas por Pagar',72,1,1,2,3,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(86,'02.01.03.01','Deudas Fiscales Corrientes',85,1,1,2,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(87,'02.01.03.01.01','Impuesto a la renta a Pagar',86,0,1,2,5,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(88,'02.01.03.01.02','IVA a Pagar',86,0,1,2,5,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(89,'02.01.03.01.03','Retenciones de Impuestos a Ingresar',86,0,1,2,5,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(90,'02.01.03.02','Obligaciones Laborales Y Cargas Sociales',85,0,1,2,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(91,'02.01.03.03','Dividendos a Pagar',85,1,1,2,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(92,'02.01.04','Provisiones',72,1,1,2,3,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(93,'02.01.05','Ingresos Diferidos',72,1,1,2,3,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(94,'02.01.05.01','Anticipos de Clientes',93,0,1,2,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(95,'02.02','Pasivo No Corriente',72,1,1,2,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(96,'02.02.01','Acreedores Comerciales a Largo Palzo',95,1,1,2,3,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(97,'02.02.01.01','Proveedores Locales',96,0,1,2,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(98,'02.02.01.02','Proveedores Exteriores',96,0,1,2,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(99,'02.02.01.04','Otros Acreedores',96,0,1,2,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(100,'02.02.02','Deudas Financieras a Largo Palzo',95,1,1,2,3,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(101,'02.02.02.01','Prestamos de Bancos y otras Entidades Financieras',100,0,1,2,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(102,'02.02.02.02','Prestamos de Socios',100,0,1,2,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(103,'02.02.02.03','Arrendamientos Financieros',100,0,1,2,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(104,'02.02.02.04','Otros Prestamos',100,0,1,2,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(105,'02.02.02.05','Intereses a Pagar',100,0,1,2,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(106,'02.02.03','Otras Cuentas por Pagar',95,1,1,2,3,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(107,'03','Patrimonio Neto',NULL,1,1,3,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(108,'03.01','Capital',107,1,1,3,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(109,'03.01.01','Capital Integrado',108,1,1,3,3,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(110,'03.01.01.01','Capital Suscripto',109,0,1,3,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(111,'03.01.01.02','(-) CAPITAL A INTEGRAR',109,0,1,3,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(112,'03.02','Reservas',107,1,1,3,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(113,'03.02.01','Reservas Legales',112,0,1,3,3,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(114,'03.02.02','Reserva de Revaluo',112,1,1,3,3,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(115,'03.02.02.01','Reservas Revaluo Fiscal',114,0,1,3,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(116,'03.02.02.02','Reservas Revaluo Tecnico',114,0,1,3,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(117,'03.02.03','Otras Reservas',112,0,1,3,3,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(118,'03.03','Reservas',107,1,1,3,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(119,'03.03.01','Resultados Acumulados',118,0,1,3,3,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(120,'03.03.01','Resultados del Ejercicio',118,0,1,3,3,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(121,'04','Ingresos',NULL,1,1,4,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(122,'04.01','Ventas de Mercaderias',121,1,1,4,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(123,'04.01.01','Ventas de Mercaderias Gravadas por el IVA',122,0,1,4,3,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(124,'04.01.02','Ventas de Mercaderias Exentas del IVA',122,0,1,4,3,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(125,'4.02','Ventas de Productos Agricolas',121,1,0,4,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(126,'4.03','Ventas de Ganados',121,1,0,4,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(127,'4.04','Ventas de Productos Fruticolas y Horticolas',121,1,0,4,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(128,'4.05','Ventas de Productos de la Explotacion Forestal',121,0,0,4,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(129,'4.06','Exportaciones de Productos Agricolas Exportados',121,0,0,4,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(130,'4.07','Exportaciones de Bienes Industrializados',121,0,0,4,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(131,'4.08','Exportaciones de otros Productos',121,0,0,4,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(132,'4.09','Ventas de Servicios Gravados',121,0,0,4,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(133,'4.10','Ventas de Bienes - Regimenes Especiales',121,0,0,4,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(134,'4.11','Otras Ventas Exentas del IVA',121,0,0,4,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(135,'04.98','(-) DESCUENTOS CONCEDIDOS',121,1,1,4,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(136,'04.99','(-) DEVOLUCIONES',121,1,1,4,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(137,'05','Egresos',NULL,1,1,5,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(138,'05.01','Costos de Mercaderias',137,1,1,5,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(139,'05.01.01','Costos de Mercaderias Gravadas por el IVA',138,0,1,5,3,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(140,'05.01.02','Costos de Mercaderias Exentas del IVA',138,0,1,5,3,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(141,'08','Otros Ingresos',NULL,1,1,4,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(142,'08.02','Intereses Ganados',141,0,1,4,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(143,'08.03','Descuentos Obtenidos',141,0,1,4,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(144,'08.04','Subvenciones',141,0,0,4,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(145,'08.05','Resultado por Diferencia de Cambio',141,0,1,4,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(146,'08.06','Ingresos Extraordinarios',141,0,1,4,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(147,'08','Otros Ingresos',NULL,1,1,4,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(148,'10.01','Sueldos y otras Remuneraciones al Personal',147,1,1,5,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(149,'10.01.01','Sueldos y Jornales',148,0,1,5,3,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(150,'10.01.02','Aporte Patronal',148,0,1,5,3,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(151,'10.01.03','Otros Beneficios al Personal',148,0,1,5,3,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(152,'10.02','Comisiones Pagadas Sobre venta',137,0,1,5,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(153,'10.03','Viatico de Vendedores',137,0,1,5,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(154,'10.04','Publicidad y Propaganda',137,0,1,5,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(155,'10.05','Fletes Pagados',137,0,1,5,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(156,'10.99','Otros Gastos de Ventas',137,0,1,5,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(157,'11.01','Gastos y otras Remuneraciones al Personal',137,1,1,5,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(158,'11.01.01','Sueldos y Jornales',157,0,1,5,3,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(159,'11.01.02','Aporte Patronal',157,0,1,5,3,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(160,'11.01.03','Otros Beneficios al Personal',157,0,1,5,3,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(161,'11.02','Remuneracion Personal Superior',137,0,1,5,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(162,'11.03','Gastos de Representacion',137,0,1,5,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(163,'11.04','Honorarios Profesionales',137,0,1,5,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(164,'11.05','Alquileres',137,0,1,5,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(165,'11.06','Agua, Luz, Telefono e Internet',137,0,1,5,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(166,'11.07','Movilidad',137,0,1,5,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(167,'11.08','Combustibles y Lubricantes',137,0,1,5,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(168,'11.09','Reparaciones y Mantenimiento',137,0,1,5,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(169,'11.10','Seguros Pagados',137,0,1,5,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(170,'11.11','Gastos No Deducibles',137,0,1,5,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(171,'11.12','Gastos Pagados en el Exterior',137,0,1,5,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(172,'11.13','Juicios y gastos Judiciales',137,0,1,5,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(173,'11.14','Gastos de Cobranza',137,0,1,5,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(174,'11.15','Donaciones y Contribuciones',137,0,1,5,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(175,'11.16','Comisiones y gastos Bancarios Operacionales',137,0,1,5,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(176,'11.17','Impuestos, Patentes, Tasas y otras Contribuciones',137,0,1,5,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(177,'11.18','Multas y Sanciones',137,0,1,5,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(178,'01.01.01.02.01','caja1',5,0,1,1,5,'2017-08-28 06:16:21','2017-08-28 06:16:21');
/*!40000 ALTER TABLE `contabilidad__cuentas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contabilidad__tipocuentas`
--

DROP TABLE IF EXISTS `contabilidad__tipocuentas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contabilidad__tipocuentas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `codigo` int(11) NOT NULL,
  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `naturaleza_cuenta` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contabilidad__tipocuentas`
--

LOCK TABLES `contabilidad__tipocuentas` WRITE;
/*!40000 ALTER TABLE `contabilidad__tipocuentas` DISABLE KEYS */;
INSERT INTO `contabilidad__tipocuentas` VALUES (1,1,'Activo','deudor','0000-00-00 00:00:00','0000-00-00 00:00:00'),(2,2,'Pasivo','acreedor','0000-00-00 00:00:00','0000-00-00 00:00:00'),(3,3,'Patrimonio Neto','acreedor','0000-00-00 00:00:00','0000-00-00 00:00:00'),(4,4,'Ingresos','acreedor','0000-00-00 00:00:00','0000-00-00 00:00:00'),(5,5,'Egresos','deudor','0000-00-00 00:00:00','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `contabilidad__tipocuentas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard__widgets`
--

DROP TABLE IF EXISTS `dashboard__widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dashboard__widgets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `widgets` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `dashboard__widgets_user_id_foreign` (`user_id`),
  CONSTRAINT `dashboard__widgets_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard__widgets`
--

LOCK TABLES `dashboard__widgets` WRITE;
/*!40000 ALTER TABLE `dashboard__widgets` DISABLE KEYS */;
/*!40000 ALTER TABLE `dashboard__widgets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleados__anticipos`
--

DROP TABLE IF EXISTS `empleados__anticipos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empleados__anticipos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `anulado` tinyint(1) NOT NULL,
  `pago_empleado_id` int(10) unsigned DEFAULT NULL,
  `empleado_id` int(10) unsigned NOT NULL,
  `fecha` date NOT NULL,
  `monto` bigint(20) NOT NULL,
  `observacion` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `descontado` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `empleados__anticipos_pago_empleado_id_index` (`pago_empleado_id`),
  KEY `empleados__anticipos_empleado_id_index` (`empleado_id`),
  CONSTRAINT `empleados__anticipos_empleado_id_foreign` FOREIGN KEY (`empleado_id`) REFERENCES `empleados__empleados` (`id`),
  CONSTRAINT `empleados__anticipos_pago_empleado_id_foreign` FOREIGN KEY (`pago_empleado_id`) REFERENCES `empleados__pagoempleados` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados__anticipos`
--

LOCK TABLES `empleados__anticipos` WRITE;
/*!40000 ALTER TABLE `empleados__anticipos` DISABLE KEYS */;
/*!40000 ALTER TABLE `empleados__anticipos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleados__empleados`
--

DROP TABLE IF EXISTS `empleados__empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empleados__empleados` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `apellido` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `cedula` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `cargo` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ruc` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `direccion` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `telefono` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `celular` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `activo` tinyint(1) NOT NULL,
  `salario` bigint(20) NOT NULL,
  `ips` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados__empleados`
--

LOCK TABLES `empleados__empleados` WRITE;
/*!40000 ALTER TABLE `empleados__empleados` DISABLE KEYS */;
INSERT INTO `empleados__empleados` VALUES (1,'Greg Lubowitz I','Laboriosam nobis vel provident. In numquam dolor rem quisquam assumenda quam laboriosam. Voluptatum accusantium officia voluptatem deleniti pariatur adipisci in quia.','45712','Occupational Therapist Aide','65263','281 Corwin Circle\nPort Luciusbury, MS 30610-6130','moore.colt@yahoo.com','5005698','8267730',0,5379217,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(2,'Missouri Abbott II','Iure omnis velit libero aliquid. Quisquam nam id consequuntur est omnis. Praesentium laboriosam ut a recusandae vero. Voluptatem inventore repellat facere laborum voluptatem voluptate pariatur.','38842','Technical Writer','63093','374 Ankunding Fork\nLake Veda, NE 65409-2267','terence.grady@hotmail.com','3440231','1180885',1,4117510,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(3,'Mikel Bahringer Sr.','Aut voluptatem et id commodi cum molestiae provident. Iure dolorem rerum excepturi nemo. Ratione provident quis quibusdam similique odio dolor eveniet.','84408','Music Composer','46214','5777 Frederique Burgs\nNew Archibaldmouth, KS 63652','obogisich@stroman.com','7820283','7922043',1,2184231,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(4,'Hilma Kuphal Jr.','Aut nihil veritatis et vel sed voluptatum. Consequatur tempore ducimus id qui et. Veritatis tenetur rem excepturi.','51446','Correspondence Clerk','43555','488 Moen Ferry Suite 023\nLake Russeltown, NV 68620','dannie.fay@jacobson.com','4228505','6986106',0,5089545,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(5,'Bradly Bechtelar','Fugiat nobis voluptatem illo beatae. Exercitationem distinctio aut cum. Sed rem distinctio molestiae soluta.','1572','Therapist','73846','743 Bednar Falls Suite 265\nMosciskiside, AR 17705-5095','gust54@zemlak.com','5127536','8072608',1,3356912,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(6,'Dr. Xzavier Casper','Enim quibusdam libero ducimus qui aut. Vel expedita fuga ipsa in est ut repellat. Qui et nulla mollitia eius ratione dolores eos.','78617','School Bus Driver','57429','7090 Labadie Crossing\nAutumnhaven, ND 20389','medhurst.kory@yahoo.com','4323346','1577161',0,5066288,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(7,'Lysanne Bartell DDS','Praesentium velit non et. Facilis et rem laboriosam animi expedita maiores. Labore nostrum occaecati enim et dolores commodi. Explicabo provident qui quos natus accusantium molestiae in perspiciatis.','68490','Architectural Drafter','4533','4353 Maritza Shores\nEffertzport, FL 20326-7289','xgibson@abernathy.net','4380781','3437986',0,4152453,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(8,'America Shields IV','Non quos voluptatem nisi. Blanditiis commodi eveniet numquam quis sed dolorum accusamus ut. Iusto odit quam dolorem aperiam rerum quas.','60307','Farmworker','51923','19339 Arthur Mews\nMeganetown, SC 23680-5655','dominic.bahringer@douglas.com','2020560','1336373',0,4882093,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(9,'Ms. Minnie Toy','Eaque rerum quo consequatur sed. Tenetur nostrum deserunt nostrum.','78544','Night Shift','5929','390 Strosin Burgs\nWest Stella, HI 52296-0633','westley20@bartell.biz','7759805','8511483',0,2934985,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(10,'Orlo Champlin','Reprehenderit accusamus cumque quasi nisi quo. Maxime enim modi sit ea. Autem suscipit ipsa laudantium necessitatibus sit itaque. Ullam exercitationem voluptate aut impedit.','8096','Supervisor of Customer Service','52139','433 Cole Stream Suite 088\nLake Brett, WY 97309-7898','lionel.okeefe@kovacek.com','2295024','5948983',0,3682840,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(11,'Dr. Darian Beer','Aut incidunt officia ea dolores quo. Nesciunt excepturi animi vel at totam consequatur. Nihil officiis quae dignissimos et asperiores dolorem.','34311','Plating Machine Operator','49832','6424 Hermiston Divide\nWest Frank, MT 22078-4067','haleigh.gorczany@yahoo.com','200942','930638',0,4279106,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(12,'Terence Wisoky','Nihil dolor tenetur quos accusantium omnis. Optio quos iure rerum sint quasi. Deleniti facere quia unde inventore neque voluptas exercitationem et. Expedita quidem accusamus neque aut.','33472','Maintenance Supervisor','18353','7396 Burnice Shore\nSouth Sonnyshire, ID 95837-0510','annie59@feil.net','7931534','5155646',0,5016943,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(13,'Seth Roberts','Laboriosam et aut a consequatur voluptatem. Voluptatem quia illum dignissimos animi. Porro quis architecto asperiores rerum.','59629','Oil and gas Operator','76605','532 Cale Pike Apt. 891\nEast Jayda, WV 53502-2888','carmel.wehner@macejkovic.com','1786222','3501775',0,2508064,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(14,'Shanie Kub MD','Autem maiores tenetur quam aut et repellat voluptas. Ab voluptatem est dolor porro enim omnis.','34120','Engineering Technician','59693','38728 Graciela Pass Suite 108\nWest Delia, IL 01916-8550','burnice.cummings@towne.com','4890471','7974601',0,2043333,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(15,'Imelda Tromp','Soluta voluptas occaecati porro incidunt vero consequuntur. Eveniet dolor sapiente ea et omnis blanditiis et non.','9940','Park Naturalist','41640','998 Shad Harbors\nSouth Myahshire, NC 15267-4963','ehauck@schultz.info','2356494','813369',1,5064936,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(16,'Mr. Dwight Strosin','Soluta iste autem sed voluptatem qui in. Error recusandae nobis ut excepturi voluptatem voluptatem. Qui et ut ratione qui harum facilis sed nam.','69451','Employment Interviewer','29991','880 Little Canyon\nKuhlmanborough, KS 06282','teresa77@yahoo.com','6010024','445230',1,4411704,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(17,'Davin Pagac','Adipisci a quo et ea ut aut consectetur. Quo sunt commodi rerum ut. Dolores in beatae ea sunt ea hic nesciunt.','42575','Computer Security Specialist','82787','3210 Mariana Wells Suite 096\nLake Pinkie, NC 88696','fmohr@botsford.com','6544145','1016863',1,2474816,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(18,'Jazlyn Altenwerth','Consectetur occaecati ullam amet et aut earum. Maxime omnis quaerat laudantium. Alias aliquam occaecati qui sit vel illum qui aperiam.','54577','Municipal Fire Fighting Supervisor','33418','865 Wilhelm Estates\nNew Florinebury, PA 80789','sven65@stamm.org','6569214','3625572',1,5363430,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(19,'Mr. Destin Koelpin','Dicta eaque aperiam nemo eligendi eligendi inventore veniam. Aut eveniet dolore consequuntur accusantium rerum.','47046','Advertising Sales Agent','54791','15526 Dickinson Key Apt. 432\nLake Corine, ME 91011','vgoldner@grant.net','7210483','4207999',0,4204201,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(20,'Elbert Towne','Rem non sed sint. Natus doloremque fuga sunt numquam eum. Omnis qui necessitatibus recusandae dolorum. Quasi cupiditate facere voluptatem nihil.','72381','Park Naturalist','35739','17459 Lakin Landing\nWest Julianaburgh, ID 94778','doyle.gutmann@yahoo.com','757164','510355',0,4864433,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(21,'Dr. Twila Weber','Cum quod cupiditate aspernatur molestiae soluta tempora voluptate saepe. Nulla atque quae omnis reprehenderit quis illo vero. Impedit pariatur alias maiores ab.','47047','Caption Writer','31250','2318 Larkin Fort\nWillstad, IA 48788-2044','kwehner@reichel.com','3694791','130151',1,5949465,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(22,'Miss Clotilde Price IV','Odit a sequi dolorum qui voluptatibus tenetur. Tempore ut cumque accusamus magnam ut asperiores delectus. Alias magnam culpa beatae. Nihil aut necessitatibus harum. Deleniti ab quis sint et aut.','34649','Lawn Service Manager','69922','7152 Gaylord Crossroad Suite 957\nVincentbury, WI 78209-0509','blanda.mina@yahoo.com','7276702','888160',1,5433261,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(23,'Dr. Leora Bogan IV','Quos hic ad veritatis quidem eum commodi blanditiis. Quia quas nostrum iusto tenetur dolor.\nEt nihil est quia tenetur. Quam sint inventore et id sit. Et aut quis ullam incidunt velit ipsam.','84200','Avionics Technician','14718','8923 Lemke Via Suite 265\nLake Makenna, KS 94538','qmann@kuphal.net','5528746','6164755',0,5683072,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(24,'Maryse West','Enim quaerat quia incidunt magni amet quia. Velit tempora aut tempore repellat ut libero debitis. Non ut et dolor voluptatem non.','58232','Crane and Tower Operator','39839','231 Bridie Rapid\nWest Evertborough, ND 62302-3546','donnelly.jaren@gmail.com','4865329','857548',0,5983529,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(25,'Leonora Littel','Enim blanditiis odit labore fugit. Culpa odit fugiat facere doloribus corrupti ut repellendus quos. Est non voluptas facere est non tenetur non deleniti.','78784','Fabric Pressers','4611','804 Maida Light\nAishatown, MA 80414-8298','reuben43@gmail.com','7505810','4115191',1,2977615,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(26,'Ms. Yvette Heathcote','Eligendi dolor rerum totam et. Nulla sapiente quam cum culpa et consequatur. Unde autem earum ullam.','8294','Highway Maintenance Worker','87814','58442 Audie Common Suite 085\nKuhicshire, AZ 38113-1044','rhea93@lind.com','7652486','7020039',1,2135938,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(27,'Dr. Neal Fritsch PhD','Unde sed sint aliquid deleniti nostrum sint. Omnis est non debitis natus accusamus. Et quaerat sed qui sit. Adipisci magnam necessitatibus alias vel eos et porro voluptatem.','37904','Graduate Teaching Assistant','13908','6734 Goodwin Knoll Suite 475\nEast Susanna, IA 89497','goyette.dejuan@hotmail.com','3427518','5017131',1,2734665,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(28,'Prof. Sigmund McDermott Sr.','Voluptatum asperiores ipsum consectetur sint. Qui pariatur ipsa nostrum vitae ab dolor deserunt.\nNeque animi possimus quas. Eos non iusto est sed. Fuga totam omnis voluptas a. Et omnis eius eum.','88552','Actor','57744','1311 Octavia Lock Apt. 607\nSouth Aurelie, NJ 85110-9561','stehr.elna@gmail.com','6295246','113286',1,3584407,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(29,'Parker Osinski','Accusamus dolorem accusamus et consequatur ut dignissimos. Et laudantium aut cum aut voluptas. Necessitatibus veniam nisi sit voluptatem quos optio est.','65903','Sheet Metal Worker','66002','862 Jaeden Forge Apt. 447\nWest Ronnytown, HI 41683-3776','myriam17@doyle.com','974841','1003579',1,2877279,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(30,'Effie Feest','Architecto eos est iure et dolor iusto dicta quis. Vel qui architecto dicta laborum labore asperiores maxime. Quo dolorum qui inventore sint et.','15538','Marking Clerk','37020','884 Waelchi Plaza Suite 332\nSouth Destini, NV 80235-4135','heidenreich.rosario@schmidt.com','4792660','7282702',0,5953426,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(31,'Cristopher Senger','Provident qui vitae voluptatibus. Autem numquam explicabo veniam et non molestiae deleniti.','72992','Computer-Controlled Machine Tool Operator','45904','50208 Bailey Passage Apt. 647\nParkertown, NE 49788-7805','jennyfer26@metz.com','6187966','6582386',1,5506830,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(32,'Rubye Hackett','Voluptas officia nesciunt incidunt. Voluptatem fuga veritatis natus sapiente aliquam eum. Tenetur quisquam ducimus nemo dolor et non.','29024','Mail Clerk','22832','6045 Balistreri Common\nEast Nikki, UT 64943','whansen@buckridge.com','3106186','8121527',0,5655373,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(33,'Providenci Dooley','Eligendi necessitatibus ea quibusdam est ut dolorum dolores. Ad rem ipsa omnis porro nostrum. Optio sapiente nihil facere. Et vitae dolores possimus praesentium consequatur.','27841','Watch Repairer','61307','654 Otha Dam\nWest Rosschester, WY 59883-9332','cody84@dickinson.com','1631547','364371',0,3829747,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(34,'Chad Quitzon','Eos et quas maxime sed soluta ipsum. Magnam vel a nihil at consequuntur est autem. Vitae consequatur aut doloribus exercitationem fugit omnis.','15548','Chemical Technician','12567','1968 Spencer Shores Apt. 042\nKarsonmouth, ID 23579','sipes.maurine@ferry.com','7392463','8138912',0,2306992,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(35,'Mara Cummerata','Enim vel expedita eum. Ut laudantium quos ipsa ducimus animi tempore. Hic inventore praesentium modi rerum.','65130','Physical Therapist','86284','74872 Donnie Vista Suite 740\nHayesburgh, ND 52152','luettgen.meggie@lind.com','4475969','8261212',0,2257788,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(36,'Jacky Erdman','Minus tempore corrupti rerum. Nostrum tempora corporis eos nihil tempore. Rerum incidunt sunt delectus eveniet vero culpa possimus.','71072','Forging Machine Setter','68515','12723 Jenkins Valley\nNorth Gerry, RI 32627-5825','elittel@lindgren.com','7621968','3670882',1,3197620,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(37,'Herbert Farrell','Blanditiis ducimus aut nesciunt. Libero voluptatem at fugiat velit aut. Distinctio cupiditate rerum omnis aut architecto consequatur non non.','79997','Library Technician','69306','78104 Mante Divide Suite 653\nSantinaburgh, NC 16946-8490','mcglynn.sage@ward.com','3663356','4982657',1,5041503,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(38,'Assunta Wuckert I','Omnis impedit omnis ad quos consectetur est eaque. Doloremque molestias pariatur eum aliquid. Tempore omnis quidem dolorum quo nemo.','59440','Claims Adjuster','41649','38681 Marquis Port\nPort Ellahaven, OR 85975','annabelle.kovacek@macejkovic.com','1441149','5023123',1,4784280,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(39,'Dr. Arne Blanda V','Consequatur magni dolor est in voluptatum. Vitae earum sit debitis voluptatibus quia quis voluptatem. Nulla magni eligendi id pariatur sunt.','61066','Government','32402','451 Streich Burg\nPort Aureliofort, MI 27923-4499','jordi27@renner.com','5991929','7424325',0,3316758,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(40,'Dr. Kevon Grady','Aut voluptatibus est fugit tempore et. Qui qui tenetur consequatur repellat distinctio sit. Repudiandae dolores earum dolorem eum tenetur. Voluptatum aperiam et laudantium sed.','40233','Postmasters','86271','4091 Eudora Plain\nBodestad, DE 77587-4677','robin88@gmail.com','7927307','1361591',0,4024199,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(41,'Dr. Leon Wehner','Quaerat quaerat eaque quia et et ad voluptatibus et. Rerum sed occaecati et laboriosam. Eveniet aut quidem fuga labore exercitationem nam incidunt quia.','28713','Engraver','17754','31015 Moen Skyway Apt. 544\nKeirahaven, OR 74928-1985','qbeer@gmail.com','5196031','4915545',0,4964720,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(42,'Ms. Nella Breitenberg Jr.','Ea numquam ea cupiditate. Voluptate illo sint quia molestiae error molestiae animi. Aut id velit est et autem rerum nobis. Pariatur est id rem provident. Omnis culpa commodi est et.','35843','Security Systems Installer OR Fire Alarm Systems Installer','33743','296 Lehner Villages\nTrantowborough, NE 55042-6484','aroberts@hotmail.com','3412332','7223806',0,3708946,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(43,'Mr. Jaylon Heidenreich','Eos dicta magnam soluta ex dignissimos animi. Animi sequi voluptas id ut dignissimos dolorem. Ut ipsa occaecati id sit et veniam amet.','68086','Personal Trainer','8641','4790 Shea Mountains\nNorth Madisenbury, NE 58951-0568','hudson.alfonzo@yahoo.com','7731354','6505775',0,5078575,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(44,'Lexi Lehner','Placeat fuga libero nam dolores. Autem explicabo laborum cumque vero ratione in. Excepturi veniam illo illo quas reiciendis sed.','60685','Optometrist','70368','87640 Mia Track\nLemkeville, ND 51054','camron24@dickens.biz','2585410','255632',0,3399408,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(45,'Ms. Tomasa Fritsch Jr.','Beatae vitae recusandae alias. Alias enim nesciunt ad. Et ut molestias qui laborum odio nesciunt et omnis.','19954','General Manager','85481','9370 Isabelle Meadow\nNew Derek, FL 40679','brakus.jairo@kuvalis.com','8028569','4278843',1,4321577,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(46,'Dejon Mante','Quo commodi voluptas aperiam nostrum cum ut. Recusandae dolorum facilis quos rerum quisquam deserunt.\nAccusantium accusantium dolorem voluptas et soluta maiores. Ut atque error modi qui.','88609','Admin','31728','59979 Alison Motorway\nWest Modesta, NC 42181','giovanny84@friesen.org','1517658','7965989',0,2925178,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(47,'Dr. Brenden Grimes PhD','Ea quo ut animi et. Eum est et nesciunt sit nam. Accusamus libero tempore nihil repudiandae. Amet occaecati suscipit sapiente est quas ut at magnam.','5260','Psychiatric Aide','63547','847 Titus Drives Apt. 212\nDannyport, LA 99515','brigitte.yundt@hirthe.info','605951','4517383',0,4376512,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(48,'Shaniya Auer','Impedit voluptatibus sapiente non assumenda numquam labore. Quod dicta sed architecto dolores maiores. Quis autem itaque neque est.','1877','Speech-Language Pathologist','61784','4948 Shawna Crescent Apt. 499\nDemetrisfurt, AZ 73784-3448','curtis72@hotmail.com','7282501','6516935',0,5203566,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(49,'Dr. Keon Homenick','Asperiores eaque ut sit laborum ex. Et aut rerum error sint et. Officia rerum doloremque qui culpa.','72748','Rail Yard Engineer','87256','8947 Bret Parkway Suite 851\nNorth Osvaldo, VA 77378','gquitzon@rosenbaum.net','7753196','2047177',1,2940977,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(50,'Miss Nola Hartmann Jr.','Sit eligendi tempore nemo vero in. Qui in natus vitae et totam quo. Qui et quidem aut quae beatae dolorem.','44578','Library Science Teacher','32769','6798 Rosenbaum Run\nLangworthton, TN 97522','herbert80@yahoo.com','8834552','8200993',1,3901820,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(51,'Dr. Violet Adams','Qui sunt magnam quis neque facere sit. Deserunt qui et in ea adipisci. Suscipit omnis non unde at nisi totam ipsa qui. Laudantium sint tenetur aut est.','74082','Photographic Process Worker','88982','79675 Dee Prairie Apt. 850\nJacobsonville, IA 22953-1603','colleen49@hammes.com','3371399','8100555',0,4098365,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(52,'Emanuel Kshlerin','Perspiciatis quidem dolore fugiat ex. Nesciunt magnam quia sapiente dolorem. Est vitae occaecati sunt quia aut natus vel. Minima saepe sit aut.','89308','Art Director','31567','1202 Everette Ridges\nPort Margarettatown, ME 91503-4130','ocie.mitchell@prohaska.net','1688383','5327133',1,4593474,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(53,'Garnett Feeney Jr.','Illum nulla ut voluptatem ea quam magni officia. Vel odit odit magnam modi. Voluptatem maiores aspernatur est harum soluta a.','81596','Personal Trainer','25151','459 Kamille Canyon Suite 907\nWest Nikita, AL 03766','abshire.emiliano@hotmail.com','3949899','7511280',1,5069194,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(54,'Tyreek Emmerich','Omnis cumque autem nulla similique. Molestias pariatur autem deleniti optio expedita voluptatibus. Voluptatem ducimus eius sunt temporibus eius expedita. Quos laboriosam in aut nostrum.','72358','Milling Machine Operator','53237','373 Moen Wall\nSouth Mortimerview, WA 68054','gmurazik@hotmail.com','7100278','2645502',1,2417520,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(55,'Ms. Amie Kertzmann','Officiis quae illum neque ratione rerum eum enim modi. Cupiditate quisquam nulla libero molestiae corporis sed. Et voluptate iusto exercitationem eaque.','54818','User Experience Manager','19848','55871 Maggio Squares\nPort Harmony, RI 31741','borer.kattie@aufderhar.org','7594926','1393270',1,4472122,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(56,'Ms. Vesta Schmidt Sr.','Neque voluptatem reiciendis voluptates odio. Et dolorem iure eos qui.','38365','Control Valve Installer','26157','35511 Beatty Alley Suite 649\nNew Coty, MI 15738','cicero44@yahoo.com','1281489','7548129',0,3727094,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(57,'Mr. Keon Ferry V','Sint sint voluptas laboriosam error voluptas. Asperiores fuga soluta sequi non eum non. Iste explicabo omnis alias neque vel rem. Ullam dolore delectus mollitia autem optio nobis.','27290','Grinder OR Polisher','33914','2253 Quitzon Springs\nTaylorville, HI 84985','zfranecki@hotmail.com','7188996','4081414',1,2512152,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(58,'Ms. Mercedes Mueller III','Non et nostrum explicabo quae. Asperiores quaerat libero officiis harum perferendis blanditiis. Fugit quas quasi cumque exercitationem vel ut placeat. Unde dicta sunt repellat rerum perspiciatis.','49601','Registered Nurse','25512','1048 Abshire Freeway\nBruenport, ND 07183','tbashirian@abbott.net','5327602','4524027',1,3800657,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(59,'Marcos Mante','Ut adipisci consequatur fuga eum aut modi ut. Voluptatibus in voluptates odit officiis expedita consequuntur ea. Occaecati voluptatem ipsam et.','9961','Taper','18301','59585 Jan Rest\nPort Wilburnstad, NV 16299','gaetano48@armstrong.com','4210802','7441549',0,5471936,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(60,'Dylan Renner III','Aliquid sint vel est perferendis rerum. Rerum hic velit assumenda quia. Ad distinctio voluptate sed labore aspernatur qui nostrum sed. Ad earum veritatis deserunt et ratione.','44637','Electrical Engineering Technician','31047','89592 Aracely Stream Apt. 291\nEast Jewellburgh, MN 27599','wpredovic@hotmail.com','8115321','2491268',1,2783565,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(61,'Katrine Corkery','Vel eum ad et. Et libero et et molestiae. Ipsum qui nostrum ut impedit.','29625','Insurance Policy Processing Clerk','76414','980 Furman Junction\nSouth Rudystad, IN 33734','ibrahim43@hyatt.biz','8583681','8933787',1,4268674,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(62,'Linnea Luettgen','Aut adipisci laudantium asperiores est eligendi esse provident. Minus praesentium non molestias porro adipisci quis quo. Voluptatibus ex maiores et.','21850','Painting Machine Operator','43359','8065 Champlin Pines Suite 631\nWest Chrisborough, MA 24314-2395','rubie39@gmail.com','3106200','6086095',1,2340654,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(63,'Dr. Desiree Will','Similique ex eius ratione et est cumque corporis. Voluptas ut sapiente unde quasi delectus iste.','30815','Fire Investigator','62649','1909 Gulgowski Ports Suite 087\nSouth Jaysonside, NJ 72769','yessenia.green@turcotte.info','3219121','247916',0,2954350,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(64,'Prof. Kassandra Hansen II','Nostrum nostrum sed mollitia inventore. Sapiente velit et aliquid molestiae nulla omnis. Nihil velit tenetur et illum modi alias.','53366','Forest Fire Fighting Supervisor','49137','5673 Dicki Throughway Suite 795\nWest Norbert, MN 21956-1168','kutch.kathlyn@yahoo.com','1312986','4702709',1,3913093,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(65,'Miss Loren Orn Jr.','Voluptatem qui quae illum quia. Architecto beatae dolore ut modi voluptas sit ut. Consequatur animi et et vero qui saepe quas.','7560','Legislator','10604','1099 Effertz Brook Suite 842\nPagachaven, GA 78384-7929','johann43@kulas.net','3272683','7316547',1,5940787,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(66,'Verna Feil','Sequi deleniti quia enim laborum vel id. Ratione soluta rem temporibus error qui voluptatem.','74391','Detective','41272','40698 Dorothea Rapids\nJuniusberg, NM 95912','demetris26@douglas.com','6241597','2755067',0,5315230,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(67,'Velva Casper','Doloribus quisquam aut voluptates. Omnis sint in totam veniam repellendus.','38980','Office Machine Operator','51669','5472 Wisozk Tunnel Suite 450\nMaggioshire, CA 46692-2841','gjenkins@hotmail.com','3639465','8498892',0,2205998,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(68,'Adrianna Reinger','Accusamus ex vel corporis culpa. Rerum nam aut tempore eos provident et. Enim laborum in sed maxime omnis sed aut.','39149','Physics Teacher','32576','673 Walter Throughway\nSouth Staceyport, NJ 37514-1258','graham.estefania@yost.net','2139905','6357146',1,5006300,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(69,'Shanel Pollich II','Sed dolores omnis voluptatem et et. Repellat autem necessitatibus in dolorem amet ipsa consectetur. Reiciendis earum cum voluptatem possimus dolorem. Consequatur dolorum maxime quaerat nihil itaque.','83993','Child Care','82413','3758 Kelly Oval Apt. 281\nHirtheside, CA 13560-6641','kira37@wiza.com','604041','838923',1,4808049,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(70,'Prof. Prince Anderson','Consequatur dolor sed ut recusandae dolorem eum odit. Sint maxime nobis nobis velit. Enim accusamus minima magni et qui doloremque. Eveniet officiis qui explicabo esse aliquam.','16591','Soldering Machine Setter','29218','65106 Turner Springs Apt. 451\nAugustatown, MN 42102-2903','lubowitz.thad@wiegand.net','1412168','3957853',0,3667908,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(71,'Kirsten Smitham','Ut facere quasi dolorem. Dolorem distinctio repudiandae qui vel perspiciatis minus. Laboriosam dolor et consequuntur minus molestias rerum. In quas voluptatum accusantium.','75847','Preschool Teacher','28130','44847 Ruecker Skyway Apt. 206\nBoyleland, WA 58551-6516','lsawayn@walsh.com','8634307','7735417',0,2983141,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(72,'Darion Bernier','Quibusdam ducimus atque voluptas perferendis deleniti molestiae. Delectus similique tempore necessitatibus praesentium eveniet dolorum. Aut magni quo et.','10606','Foundry Mold and Coremaker','14755','3012 Williamson Fords\nAdamsmouth, RI 34702-9263','feeney.cornelius@christiansen.org','4475821','5909063',0,2857760,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(73,'Taurean Jones','Rerum consequatur consequatur expedita asperiores deleniti. Veniam unde facere beatae. Maxime sit aspernatur eum distinctio non. Voluptatem facilis ut voluptas dolore saepe quidem voluptas.','5396','Motor Vehicle Operator','54301','6035 Stevie Hollow Apt. 670\nPort Blaiseland, MA 75494','harris.marcelino@sporer.com','5070543','8791969',1,4416544,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(74,'Vena Wolf','Error maxime cumque ut voluptas. Veniam illum illum omnis dolores.\nConsequatur et eius cumque exercitationem. Quis quia quia non exercitationem laborum.','16206','Avionics Technician','7484','13713 Brain Walks\nCrooksmouth, HI 75087-1660','koby90@yahoo.com','6138838','5752465',0,2820070,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(75,'Tessie Greenholt','Officiis id odit dolorum molestiae officia eum ex placeat. Reprehenderit quia hic similique sunt eos et minus. Ad voluptates sapiente quia et. Quaerat voluptatem non omnis a quas.','37147','Industrial Safety Engineer','18938','6141 Crist Glens Apt. 011\nBeattymouth, UT 25942','urempel@gmail.com','3049822','3093237',0,4652644,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(76,'Zelda Rosenbaum II','Eum nulla provident rerum est assumenda reprehenderit maiores. Sapiente amet eveniet iusto sequi et et voluptas. Dolor accusamus voluptatem non iste.','36677','Occupational Health Safety Specialist','28184','744 Rhianna Mountains\nWest Sylvester, MI 73166-9336','koby26@rutherford.org','7626027','5134942',0,4935209,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(77,'Nat Kuvalis','Ad magnam aut est. Nesciunt illo voluptatem repudiandae architecto et odio. Quos ratione qui deleniti consequatur eius. Ea sint ipsa consequatur minus sed ipsam.','70398','Nursing Instructor','32273','3673 Autumn Ranch Suite 754\nLake Emmanuel, MO 47071-6260','gusikowski.harry@hotmail.com','3949109','206335',0,2682097,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(78,'Meggie Walker Jr.','Culpa quo quia velit eos id tenetur. Doloribus ut corporis libero veritatis. Magnam qui in totam qui.','13914','Personal Service Worker','48122','436 Lebsack Flat\nWest Greta, KY 17853','dangelo23@gmail.com','708119','2695261',0,4178502,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(79,'Jeffry Kris','Iure inventore culpa eius quia et dolore. Doloremque odio ducimus voluptas modi temporibus architecto totam. Omnis itaque vitae ipsam reiciendis sit. Sit quasi id cum quidem aliquid aut.','88551','Public Relations Specialist','19320','422 Wolff Tunnel Apt. 292\nFrankmouth, IA 85343','rau.florine@hotmail.com','5451116','6057247',0,2433740,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(80,'Mr. Ayden Kertzmann Sr.','Cum error non voluptatem est nulla ipsam reiciendis ducimus. Qui et nostrum earum commodi. Rem repellat corporis beatae delectus illo et. Ut pariatur omnis molestiae quis enim voluptas velit.','59436','Railroad Switch Operator','77574','36358 Mikel Loop Suite 084\nEast Mae, MO 14997-5618','kristofer.thompson@sanford.com','8979743','7193660',0,2362760,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(81,'Dr. Reed Howe II','In fugiat et occaecati autem rerum rerum. Hic qui maxime illum dolorem commodi. Culpa aliquam qui velit pariatur eius et nihil.','5906','Carpenter Assembler and Repairer','65318','778 Carter Alley\nEmilianohaven, KS 56340','nathaniel47@lowe.com','3911405','2805786',0,5635269,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(82,'Mr. Clyde Terry','Et explicabo accusamus voluptatem veritatis. Nesciunt qui libero amet sequi hic laudantium temporibus. Enim deserunt sed quia ea corporis.','85897','Carpet Installer','2585','986 Dion Mountain Suite 107\nOmerborough, IN 60088','otrantow@effertz.com','4848106','5706595',0,5434014,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(83,'Adriana Ledner','Et ex eos quam dolores non. Nesciunt cupiditate quas itaque voluptatem laudantium corporis. Aut cumque ducimus non consequatur. Facere assumenda consequatur facilis tenetur quia error quia.','3269','Shampooer','17085','277 O\'Hara Station Apt. 355\nHanetown, IA 65532-5174','lucile16@hotmail.com','7738695','659161',1,3995114,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(84,'Edd Purdy','Voluptas possimus totam vel inventore voluptates. Assumenda labore est sed numquam qui cum aut. Placeat tenetur cum aperiam dolorem.','44665','Bulldozer Operator','24389','4814 Kaylie Extension\nPort Brianaville, MN 19347-8600','purdy.angus@morissette.info','2411382','635034',0,4113974,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(85,'Kayley Bartell','Porro eveniet praesentium labore aliquid. Quidem autem nihil explicabo aut voluptatem harum. Consequatur in est et eos quia. Quibusdam dolorem totam facilis voluptatem.','12346','Pressure Vessel Inspector','9141','3336 Columbus Wall Apt. 264\nRunteport, PA 18110-7489','bins.angelo@hotmail.com','8765192','27296',1,3689312,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(86,'Lina Schimmel','Similique in dolorum enim illum. Ratione et ab qui molestias minus cupiditate. Sed eligendi accusamus veritatis soluta dolorum et provident neque. Atque voluptatem ut beatae.','68451','Dental Hygienist','71899','381 Lewis Creek\nHamillport, NC 91263-1260','grimes.joan@willms.com','7389477','7707835',1,3484446,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(87,'Magali Hammes','Consequatur veniam magni voluptatum explicabo. Delectus explicabo at consequatur voluptatem maxime voluptas minus. Ipsa quas molestiae omnis vero.','79692','Social Work Teacher','40347','2977 Daron Trail\nWest Domenico, RI 83380-4570','kayli.ortiz@yahoo.com','1636375','8706125',0,2649788,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(88,'Aniyah Hodkiewicz','Optio laboriosam illum optio maxime et itaque. Est quas sit praesentium eaque. Officiis sint similique vel.','67825','Philosophy and Religion Teacher','35929','9359 Gavin Estate\nLake Madelynnbury, PA 95245','antonietta46@lakin.net','4291788','8837606',1,4053473,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(89,'Kay Grimes PhD','Omnis numquam assumenda nihil facilis doloribus recusandae. Soluta eligendi ut maxime totam sint sunt. Sint recusandae hic sit impedit deleniti.','88453','Title Examiner','32954','37696 Schmidt Route Apt. 040\nMaiyaland, IA 88886-5841','bertrand.auer@kris.com','5973765','3668297',0,3145177,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(90,'Clotilde Crona Jr.','Sit corporis et temporibus dolor. Quo aliquid assumenda dolorem dolorem esse rerum. Ducimus in recusandae sint aspernatur.','67990','Financial Examiner','79238','285 Collins Gateway\nBlickburgh, OR 05953','fkeeling@yahoo.com','5928396','8589095',0,2082645,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(91,'Edison Kshlerin','Et fuga nulla in tenetur est itaque aut maiores. Aut non totam minus quibusdam. Asperiores quidem voluptas itaque et. Error voluptas inventore vel reiciendis quaerat.','49626','Counsil','87075','899 Botsford Walks\nNorth Cecil, IA 33315-4351','qbailey@hammes.net','7999679','326313',1,3874031,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(92,'Mr. Regan Leffler Sr.','Debitis consequatur vel rerum voluptates. Nostrum ducimus natus deserunt magnam rerum. Tenetur voluptatem tempora voluptas tenetur. Cum cumque ipsa maxime id culpa.','15671','Statistician','78035','3402 Koss Ranch Suite 894\nSouth Eldora, NV 27484-4382','alysson71@gmail.com','8823391','3918646',1,2705055,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(93,'Dr. Josh Lesch','Quia velit blanditiis possimus omnis. Corrupti fugit quia non distinctio maxime.','59804','Credit Analyst','9119','1482 Ebert Plain\nMilfordstad, OR 51203-8748','malvina.white@schoen.com','5633203','840041',1,2754599,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(94,'Verdie Schmeler','Similique et eum facere consequatur nihil et ut. Laborum odio dignissimos velit tenetur veniam eos veniam. Ut debitis magnam cum quis ipsa modi sed. Illum quaerat nobis reiciendis aliquid.','33429','Sheriff','47851','580 Lubowitz Roads Apt. 841\nD\'Amoreshire, MA 20288-2622','jacobson.kayden@ward.info','7980751','8671851',0,4374621,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(95,'Dr. Erwin Brakus','Est officiis amet et ea quia qui molestiae. Enim commodi voluptatem et doloremque voluptatem. Sapiente recusandae et quas vero eos.','9143','Usher','82325','3297 Bartell Ferry Apt. 642\nPort Trey, VT 12300','rschuppe@jerde.org','7462237','6882699',1,2522677,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(96,'Dr. Judge Crist','Eveniet quis sunt blanditiis ab. Optio unde eveniet id dolorem est. Est optio ea minus quia magni.','36367','Chemistry Teacher','29913','5729 Jacques Junctions\nNew Kevinview, AL 16966','cthompson@auer.com','8118973','5749729',0,2283483,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(97,'Prof. Tara White III','Soluta ut facilis earum harum quo unde nostrum et. Quia non enim ut nobis. Pariatur ut dolor est cum laboriosam. Veniam nostrum est adipisci ad quo voluptate.','33942','Psychiatrist','56425','4819 Stamm Shore\nMaggioport, WA 26082-6905','hweimann@gmail.com','3989981','1597004',1,4266599,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(98,'Lindsey Torp IV','Aut dolorem laudantium corrupti soluta minima. Libero quos et sequi molestiae asperiores veritatis incidunt. Nulla sint velit veniam dolor. Assumenda ullam voluptatem ut et.','34605','Personal Financial Advisor','27292','3025 Muller Cape Apt. 832\nSchuppeton, SD 45135-1608','lcollins@wilkinson.com','5632416','2399668',1,4962401,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(99,'Reese Schiller','Quo rerum tempora sit iure sit id quo. Explicabo impedit officia qui sequi vel mollitia. Maxime ipsa qui sequi assumenda ut impedit.','60661','Electrical Drafter','61385','85066 Hermann Way\nNorth Erlingbury, NV 48350-8571','stoltenberg.eulah@west.com','8332379','2887904',0,2400617,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(100,'Gus Mohr','Voluptate nisi iusto voluptatem eos. Omnis quia sed expedita qui quis. Commodi asperiores officiis sapiente omnis ullam magni. Quibusdam blanditiis aut itaque vel voluptatem possimus.','2047','Lifeguard','15060','27235 Lueilwitz Way\nSouth Madisenhaven, IL 81013','ekozey@rutherford.com','2083611','6356549',0,4133899,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(101,'Mr. Marcus Gleichner','Qui et corrupti quae voluptas iusto. Quo saepe quia dolores consequatur maxime enim voluptatibus. Sit odio omnis et distinctio aut ex voluptas. Qui non tenetur rerum et commodi rem corrupti fuga.','66783','Personal Financial Advisor','43181','234 Stamm Unions Suite 025\nNicklauschester, CA 02866-5474','langosh.coby@gmail.com','620316','6779159',0,5745560,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(102,'Emerson Kihn','Ut ea consectetur cum et amet. Accusamus quia iusto hic inventore. Dolor sint eaque qui vitae consequatur vitae.','86585','Educational Counselor OR Vocationall Counselor','51762','6246 Littel Keys Apt. 520\nMarcelinaburgh, SD 17426','cummerata.elaina@kuphal.com','8784672','2612416',1,5653180,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(103,'Shania Veum','Perspiciatis voluptas sed aspernatur rem. Expedita eligendi quos alias nihil.','9751','Diagnostic Medical Sonographer','43291','332 Audrey Terrace Apt. 789\nSouth Karsonview, MI 47822','everett33@feeney.com','2056598','1751769',0,2586698,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(104,'Prof. Abel Crona III','Nisi eum voluptatem eveniet qui exercitationem asperiores. Occaecati qui reiciendis ullam sapiente libero aliquam.\nEt est adipisci omnis aut placeat itaque. Omnis repudiandae quos quis.','46060','Engineering Teacher','47756','284 Beier Viaduct Suite 686\nLake Fredy, AZ 79194-0305','simone.johnston@carter.com','3507537','2465673',0,4755816,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(105,'Mireille Kunze','Non labore ex voluptas magnam sed. Consequatur commodi accusantium ad sint.','68954','Landscape Artist','45114','730 Mariano Mountains\nSouth Rico, CO 99341','miller.archibald@hotmail.com','7698324','4151217',0,3394474,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(106,'Clement Collins','Quos ut asperiores eos voluptatem. Ipsum sed a velit molestias aut provident nemo et. Illo a veniam voluptate nemo sunt suscipit iure. Libero voluptatibus voluptatem quo. Quia sit eum maiores.','78260','Electronics Engineering Technician','12109','61794 Ida Passage\nNew Edyth, CO 45337-5281','williamson.jackeline@pfeffer.com','7980574','7874842',1,3328847,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(107,'Dario Conn','Similique asperiores fugit est. Id eos temporibus consequatur eaque voluptate consequuntur quia quis. Et in nemo et magni doloribus repellat ducimus qui. Minus unde ut distinctio dolorum.','3379','Civil Drafter','14076','986 Stephon Path Apt. 862\nNew Mckayla, OH 99310','immanuel.lesch@yahoo.com','5030487','8800221',1,2792335,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(108,'Jalon Stehr','Dolor odio ipsam recusandae maiores quod omnis velit consequatur. In architecto dicta quis quia optio sequi maxime. Animi est tenetur et facere suscipit perspiciatis ut tempora.','63312','Deburring Machine Operator','32925','962 Elenor Wells\nKylieville, WI 61377','gardner95@hotmail.com','3291250','574423',0,3754877,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(109,'Laila Block','Voluptatem quos consequatur sed sint et consectetur. Cupiditate neque vel voluptatem inventore aliquam molestiae. Non omnis quia corrupti ex.','6607','Construction Manager','25026','72213 O\'Hara Brooks Apt. 500\nRubyside, MD 99380-4113','steuber.verna@hotmail.com','8619704','2729337',0,5954993,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(110,'Lucius Stanton','Tempora non voluptate magnam beatae quam. Possimus quis facilis aut nihil qui accusamus voluptatem ea.','71652','Ship Mates','46204','572 Bailey Mall Suite 887\nNikolausmouth, NH 05302-1861','yost.carmine@harber.org','2461610','7762060',0,3764386,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(111,'Ethyl Purdy','Perferendis officia dolorem earum dolores impedit. Libero quidem ullam aperiam cupiditate suscipit dolor quia error. Hic doloremque vero sint dignissimos.','76345','Glass Cutting Machine Operator','40380','6871 Kyleigh Viaduct Apt. 331\nNorth Lynn, NV 22369','winston.lynch@heidenreich.info','6776255','1678045',0,3741539,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(112,'Janae Pagac','Et quae sapiente et numquam. Similique nemo laudantium deserunt eum. Vero ut reiciendis praesentium necessitatibus eos possimus explicabo quasi.','63222','Exhibit Designer','55538','98947 Mraz Ports Apt. 570\nArjunland, AL 43107-4232','quitzon.blanche@senger.com','6497400','7671734',0,3386996,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(113,'Rosalee Rutherford','Fuga aut enim incidunt molestias ab et assumenda magni. Eos doloribus at et voluptatem quas quod. Veniam quo dignissimos cum vel optio. Deleniti non minima numquam neque in.','69420','Brickmason','37752','483 Medhurst Hill Apt. 812\nPort Rodrickbury, PA 33174-3060','okuneva.scarlett@gmail.com','8362115','1671953',1,5245562,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(114,'Felicity Cronin','Accusantium pariatur aliquid delectus veritatis neque dolor consequatur. Cumque omnis temporibus dolores est quo non. Qui et qui omnis sit aut deleniti dicta. Sed similique quis dolore molestias.','39901','Credit Analyst','55445','4591 Schuster Centers\nFritzview, TN 05580','block.elouise@gmail.com','2442186','3428194',0,5478023,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(115,'Dr. Travon Harris DDS','Molestiae ea doloremque autem autem necessitatibus voluptate consequatur. Molestiae veritatis consectetur tempore non et.','7815','Food Preparation and Serving Worker','69261','93544 Schuppe Cove\nPort Zackary, PA 18603-2840','vyundt@hotmail.com','2370577','8628701',1,2945040,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(116,'Lucius Becker','Deleniti cupiditate iusto et non nesciunt. Iste architecto eaque reiciendis consectetur suscipit ut.','3803','Professional Photographer','32147','8154 Petra Shoals Suite 542\nLindgrenberg, ID 68363-1925','jayde68@yahoo.com','2317147','1683869',1,5797640,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(117,'Wilhelmine Spinka','Voluptatem nesciunt doloremque reiciendis velit voluptatem. Voluptatem aliquam officiis et aspernatur et voluptas pariatur.\nRerum deserunt harum itaque ut in. Provident sit vero sit voluptas.','33519','Industrial Equipment Maintenance','36894','874 Torphy Views Apt. 691\nUllrichton, NM 05646','jast.glenda@rolfson.info','985696','3258536',0,2883311,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(118,'Dr. Jamar Stracke IV','Voluptatem est ea dicta voluptatem vero. Occaecati est exercitationem quam odit. Qui iste sunt repudiandae et et.','42615','Visual Designer','86598','772 Vince Squares Apt. 617\nNew Elvieburgh, IA 48201-8744','hauck.yoshiko@kling.com','302412','4491275',0,3373740,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(119,'Ernestina Ondricka','Atque eum est quo ut. Quia est est ut repudiandae quo dolores aspernatur. Et exercitationem et omnis et laborum aut.','72052','Janitorial Supervisor','72134','55625 Oran Mount Suite 939\nLeuschketon, MT 84798','leonora.huels@borer.info','5269795','8503754',1,4271871,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(120,'Dr. Dewitt Hettinger','Iure earum et tenetur recusandae dolore. Omnis nobis quam aperiam porro magnam. Dolorem reprehenderit sequi ipsa culpa molestiae. Quo nulla temporibus voluptas blanditiis laudantium fugit in.','20088','User Experience Researcher','40933','368 Mayert Port\nLake Gudrun, NH 09416-3138','kertzmann.sheridan@hotmail.com','7345045','910319',0,4300730,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(121,'Lou Streich II','Atque iusto est autem ab dolor sit. Odit nemo est voluptates non. Aperiam veniam perferendis temporibus id eveniet. Vel nihil distinctio voluptas nulla ipsa commodi.','29856','Dancer','71160','913 Lamont Groves Apt. 046\nWest Barrett, FL 33880-8567','zhirthe@gutkowski.org','4329863','3949639',0,5533881,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(122,'Alfredo Rogahn','Nihil praesentium voluptatem velit totam voluptas. Qui qui iste eaque earum omnis sapiente. Animi quod voluptatem et voluptatibus sit dolorum.','18855','Physical Therapist Aide','88702','9472 Deondre Port\nRutherfordhaven, WV 19443-4437','eulah.kautzer@yahoo.com','2855168','6844187',0,3160029,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(123,'Dr. Destinee Mills V','Suscipit voluptatem eum aut animi. Rem eaque facere aut porro modi deleniti. Quibusdam quo ipsam nisi quis. A rerum possimus hic sit sint.','52830','Annealing Machine Operator','34836','94158 Halvorson Village\nAdriannamouth, OR 26488-0662','yessenia.runolfsson@turcotte.info','3546480','5614906',1,3109947,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(124,'Rahsaan Beatty','Pariatur at eos fuga assumenda in maxime. Beatae ut veniam culpa qui non blanditiis aliquid veniam. Harum aliquam voluptatem eos debitis.','86552','Welder-Fitter','14273','37248 Tyrell Course Suite 966\nNorth Jovanyfort, DE 34789','stephanie.murphy@rodriguez.com','895201','5451050',0,4061096,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(125,'Ms. Breana Stanton MD','Voluptatem aut officia est nisi dolor quaerat et totam. Culpa ipsum omnis quisquam atque maiores. Et est saepe excepturi cumque est. Et sit vitae ut dolor soluta maiores sed.','7226','Visual Designer','83227','6180 Angelica Center\nMicheleburgh, IA 82882','kemmer.abner@rutherford.com','3274043','4676155',1,5078681,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(126,'Prof. Hyman Jaskolski II','Esse illo facilis ea. Eum labore quasi voluptas quo omnis qui dolores. Consectetur reprehenderit commodi eos qui aut nemo.','23981','Bartender','64623','116 Kessler Club Apt. 495\nWest Jaunita, VT 58726-7419','chadrick.nikolaus@dach.org','5890546','3658091',1,5024493,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(127,'Aida Funk','Repellat et recusandae velit aperiam. Voluptatibus quo dicta quas voluptas cum. Aut et incidunt vel aut a natus nesciunt.','31686','Elementary and Secondary School Administrators','42254','5754 Hassan Drives Apt. 212\nOlsonshire, MD 05214-9834','cjohnson@wisoky.com','1324865','6165194',0,4430562,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(128,'Rudolph Marvin','Aliquid ullam assumenda aut alias praesentium. Non tempore recusandae dolorem et dolor dicta quia. Enim consequatur hic neque sunt voluptatem.','61334','Entertainment Attendant','46395','6146 Waters Lights Suite 890\nKertzmannberg, IL 26377-0394','azulauf@mante.net','1033930','448022',1,4363655,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(129,'Randy Boyle II','Animi nihil facilis error iste quas. Sunt rerum dolorum dolor. Natus est et aliquid dolorum aliquam provident quia.','23470','Vocational Education Teacher','48217','5957 Dallin Ridges\nHortensebury, LA 24525','heathcote.gianni@johnson.com','5983842','2248647',1,5938581,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(130,'Antonette Hyatt','Magni et dolore vel minus aliquam perspiciatis ea. Iure in libero atque. Iste vel a veritatis et.\nBeatae minus eum qui error libero. Corporis ut quia ut officiis. Dolorem fuga in omnis sapiente est.','22989','Fire-Prevention Engineer','65105','59400 Granville Orchard Suite 912\nBryonfurt, AR 95307','bogan.ricardo@hammes.org','7429687','4364448',0,4766091,0,'0000-00-00 00:00:00','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `empleados__empleados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleados__pagoempleados`
--

DROP TABLE IF EXISTS `empleados__pagoempleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empleados__pagoempleados` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `salario` bigint(20) NOT NULL,
  `anulado` tinyint(1) NOT NULL,
  `monto_ips` bigint(20) NOT NULL,
  `extra` bigint(20) NOT NULL,
  `total` bigint(20) NOT NULL,
  `fecha` date NOT NULL,
  `observacion` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `empleado_id` int(10) unsigned NOT NULL,
  `usuario_sistema_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `empleados__pagoempleados_empleado_id_index` (`empleado_id`),
  KEY `empleados__pagoempleados_usuario_sistema_id_index` (`usuario_sistema_id`),
  CONSTRAINT `empleados__pagoempleados_empleado_id_foreign` FOREIGN KEY (`empleado_id`) REFERENCES `empleados__empleados` (`id`),
  CONSTRAINT `empleados__pagoempleados_usuario_sistema_id_foreign` FOREIGN KEY (`usuario_sistema_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados__pagoempleados`
--

LOCK TABLES `empleados__pagoempleados` WRITE;
/*!40000 ALTER TABLE `empleados__pagoempleados` DISABLE KEYS */;
/*!40000 ALTER TABLE `empleados__pagoempleados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media__file_translations`
--

DROP TABLE IF EXISTS `media__file_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media__file_translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `file_id` int(10) unsigned NOT NULL,
  `locale` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `alt_attribute` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `keywords` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `media__file_translations_file_id_locale_unique` (`file_id`,`locale`),
  KEY `media__file_translations_locale_index` (`locale`),
  CONSTRAINT `media__file_translations_file_id_foreign` FOREIGN KEY (`file_id`) REFERENCES `media__files` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media__file_translations`
--

LOCK TABLES `media__file_translations` WRITE;
/*!40000 ALTER TABLE `media__file_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `media__file_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media__files`
--

DROP TABLE IF EXISTS `media__files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media__files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `path` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `extension` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `mimetype` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `filesize` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `folder_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media__files`
--

LOCK TABLES `media__files` WRITE;
/*!40000 ALTER TABLE `media__files` DISABLE KEYS */;
/*!40000 ALTER TABLE `media__files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media__imageables`
--

DROP TABLE IF EXISTS `media__imageables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media__imageables` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `file_id` int(11) NOT NULL,
  `imageable_id` int(11) NOT NULL,
  `imageable_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `zone` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `order` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media__imageables`
--

LOCK TABLES `media__imageables` WRITE;
/*!40000 ALTER TABLE `media__imageables` DISABLE KEYS */;
/*!40000 ALTER TABLE `media__imageables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu__menu_translations`
--

DROP TABLE IF EXISTS `menu__menu_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu__menu_translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `menu_id` int(10) unsigned NOT NULL,
  `locale` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `menu__menu_translations_menu_id_locale_unique` (`menu_id`,`locale`),
  KEY `menu__menu_translations_locale_index` (`locale`),
  CONSTRAINT `menu__menu_translations_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menu__menus` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu__menu_translations`
--

LOCK TABLES `menu__menu_translations` WRITE;
/*!40000 ALTER TABLE `menu__menu_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `menu__menu_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu__menuitem_translations`
--

DROP TABLE IF EXISTS `menu__menuitem_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu__menuitem_translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `menuitem_id` int(10) unsigned NOT NULL,
  `locale` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uri` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `menu__menuitem_translations_menuitem_id_locale_unique` (`menuitem_id`,`locale`),
  KEY `menu__menuitem_translations_locale_index` (`locale`),
  CONSTRAINT `menu__menuitem_translations_menuitem_id_foreign` FOREIGN KEY (`menuitem_id`) REFERENCES `menu__menuitems` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu__menuitem_translations`
--

LOCK TABLES `menu__menuitem_translations` WRITE;
/*!40000 ALTER TABLE `menu__menuitem_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `menu__menuitem_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu__menuitems`
--

DROP TABLE IF EXISTS `menu__menuitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu__menuitems` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `menu_id` int(10) unsigned NOT NULL,
  `page_id` int(10) unsigned DEFAULT NULL,
  `position` int(10) unsigned NOT NULL DEFAULT '0',
  `target` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `module_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `lft` int(11) DEFAULT NULL,
  `rgt` int(11) DEFAULT NULL,
  `depth` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `is_root` tinyint(1) NOT NULL DEFAULT '0',
  `icon` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `menu__menuitems_menu_id_foreign` (`menu_id`),
  CONSTRAINT `menu__menuitems_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menu__menus` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu__menuitems`
--

LOCK TABLES `menu__menuitems` WRITE;
/*!40000 ALTER TABLE `menu__menuitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `menu__menuitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu__menus`
--

DROP TABLE IF EXISTS `menu__menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu__menus` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `primary` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu__menus`
--

LOCK TABLES `menu__menus` WRITE;
/*!40000 ALTER TABLE `menu__menus` DISABLE KEYS */;
/*!40000 ALTER TABLE `menu__menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES ('2014_07_02_230147_migration_cartalyst_sentinel',1),('2016_12_23_150707854898_create_clientes_clientes_table',2),('2016_12_23_160737262032_create_proveedores_proveedors_table',3),('2016_12_27_120059634871_create_productos_categoriaproductos_table',4),('2016_12_27_120100649616_create_productos_marcas_table',4),('2016_12_27_120100649616_create_productos_productos_table',4),('2016_12_27_120101154874_create_productos_altabajaproductos_table',4),('2016_12_26_195736310271_create_servicios_servicios_table',5),('2017_03_10_204422407789_create_caja_cajas_table',6),('2017_03_31_144014_create_caja_movimiento_table',6),('2017_08_24_095936909531_create_visitas_visitas_table',7),('2017_08_24_095937504722_create_visitas_stockretirados_table',7),('2017_01_04_213903369895_create_ventas_ventas_table',8),('2017_01_04_213904381191_create_ventas_facturaventas_table',8),('2017_01_04_313903875902_create_ventas_detalleventas_table',8),('2017_02_07_195446_create_ventas_config_factura_table',8),('2017_03_06_202759_create_ventas_config_seguimiento_table',8),('2017_03_13_193556895919_create_pagofacturascredito_pagofacturacreditos_table',8),('2013_04_09_062329_create_revisions_table',9),('2015_11_20_184604486385_create_translation_translations_table',9),('2015_11_20_184604743083_create_translation_translation_translations_table',9),('2015_12_01_094031_update_translation_translations_table_with_index',9),('2014_10_14_200250_create_settings_table',10),('2014_10_15_191204_create_setting_translations_table',10),('2015_06_18_170048_make_settings_value_text_field',10),('2015_10_22_130947_make_settings_name_unique',10),('2014_11_03_160015_create_menus_table',11),('2014_11_03_160138_create_menu-translations_table',11),('2014_11_03_160753_create_menuitems_table',11),('2014_11_03_160804_create_menuitem_translation_table',11),('2014_12_17_185301_add_root_column_to_menus_table',11),('2015_09_05_100142_add_icon_column_to_menuitems_table',11),('2016_01_26_102307_update_icon_column_on_menuitems_table',11),('2014_10_26_162751_create_files_table',12),('2014_10_26_162811_create_file_translations_table',12),('2015_02_27_105241_create_image_links_table',12),('2015_12_19_143643_add_sortable',12),('2017_01_04_272530300132_create_empleados_empleados_table',13),('2017_01_04_272530805865_create_empleados_pagoempleados_table',13),('2017_06_15_141959_create_empleados_anticipos_table',13),('2015_04_02_184200_create_widgets_table',14),('2017_01_16_161423788426_create_contabilidad_tipocuentas_table',15),('2017_01_18_161423788427_create_contabilidad_cuentas_table',15),('2017_01_18_161424297182_create_contabilidad_asientos_table',15),('2017_01_18_192825226511_create_contabilidad_asientodetalles_table',15),('2017_01_11_165319027385_create_compras_compras_table',16),('2017_01_11_165319537229_create_compras_detallecompras_table',16),('2017_03_09_185426_create_compras_facturas_table',16),('2017_03_09_190143_create_compras_facturas_config_table',16),('2017_03_23_141425_create_compras_pagos_table',16),('2014_11_30_191858_create_pages_tables',17);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page__page_translations`
--

DROP TABLE IF EXISTS `page__page_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page__page_translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `page_id` int(10) unsigned NOT NULL,
  `locale` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `meta_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `meta_description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `og_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `og_description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `og_image` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `og_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `page__page_translations_page_id_locale_unique` (`page_id`,`locale`),
  KEY `page__page_translations_locale_index` (`locale`),
  CONSTRAINT `page__page_translations_page_id_foreign` FOREIGN KEY (`page_id`) REFERENCES `page__pages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page__page_translations`
--

LOCK TABLES `page__page_translations` WRITE;
/*!40000 ALTER TABLE `page__page_translations` DISABLE KEYS */;
INSERT INTO `page__page_translations` VALUES (1,1,'en','Home page','home',1,'<p><strong>You made it!</strong></p>\n<p>You&#39;ve installed AsgardCMS and are ready to proceed to the <a href=\"/en/backend\">administration area</a>.</p>\n<h2>What&#39;s next ?</h2>\n<p>Learn how you can develop modules for AsgardCMS by reading our <a href=\"https://github.com/AsgardCms/Documentation\">documentation</a>.</p>\n','Home page',NULL,NULL,NULL,NULL,NULL,'2017-08-28 06:13:43','2017-08-28 06:13:43');
/*!40000 ALTER TABLE `page__page_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page__pages`
--

DROP TABLE IF EXISTS `page__pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page__pages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_home` tinyint(1) NOT NULL DEFAULT '0',
  `template` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page__pages`
--

LOCK TABLES `page__pages` WRITE;
/*!40000 ALTER TABLE `page__pages` DISABLE KEYS */;
INSERT INTO `page__pages` VALUES (1,1,'home','2017-08-28 06:13:43','2017-08-28 06:13:43');
/*!40000 ALTER TABLE `page__pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `persistences`
--

DROP TABLE IF EXISTS `persistences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `persistences` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `persistences_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persistences`
--

LOCK TABLES `persistences` WRITE;
/*!40000 ALTER TABLE `persistences` DISABLE KEYS */;
INSERT INTO `persistences` VALUES (1,1,'SK4GB7P2Xxig6C7jS1hraik5hCLP6Fwv','2017-08-28 06:15:08','2017-08-28 06:15:08'),(2,1,'c2sKH0UwraBJfwd9XkOXH870IzJJivLr','2017-08-28 08:46:46','2017-08-28 08:46:46'),(3,1,'WeIIhVSOn1EG6OXYLLv2rA5QW7MTn4Qk','2017-08-28 13:39:36','2017-08-28 13:39:36'),(4,1,'uP5BPH66Esqc4uQ33QDCp3Owy8BKESQ3','2017-08-28 16:09:28','2017-08-28 16:09:28'),(9,2,'xOGDRzmDrR4riVnYuSyDs7RXpmkknE2l','2017-08-29 13:51:12','2017-08-29 13:51:12'),(10,3,'O9p3Py5s9HnqjdcTexLfa1DLNixddMfC','2017-08-29 13:58:35','2017-08-29 13:58:35');
/*!40000 ALTER TABLE `persistences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos__altabajaproductos`
--

DROP TABLE IF EXISTS `productos__altabajaproductos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productos__altabajaproductos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `operacion` enum('alta','baja') COLLATE utf8_unicode_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `cantidad` double(25,5) NOT NULL,
  `fecha` date NOT NULL,
  `producto_id` int(10) unsigned NOT NULL,
  `usuario_sistema_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `productos__altabajaproductos_producto_id_index` (`producto_id`),
  KEY `productos__altabajaproductos_usuario_sistema_id_index` (`usuario_sistema_id`),
  CONSTRAINT `productos__altabajaproductos_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos__productos` (`id`),
  CONSTRAINT `productos__altabajaproductos_usuario_sistema_id_foreign` FOREIGN KEY (`usuario_sistema_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos__altabajaproductos`
--

LOCK TABLES `productos__altabajaproductos` WRITE;
/*!40000 ALTER TABLE `productos__altabajaproductos` DISABLE KEYS */;
/*!40000 ALTER TABLE `productos__altabajaproductos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos__categoriaproductos`
--

DROP TABLE IF EXISTS `productos__categoriaproductos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productos__categoriaproductos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `codigo` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos__categoriaproductos`
--

LOCK TABLES `productos__categoriaproductos` WRITE;
/*!40000 ALTER TABLE `productos__categoriaproductos` DISABLE KEYS */;
INSERT INTO `productos__categoriaproductos` VALUES (1,'angela.keeling','stamm','Triple-buffered clear-thinking project','0000-00-00 00:00:00','0000-00-00 00:00:00'),(2,'delia76','koch','Focused foreground success','0000-00-00 00:00:00','0000-00-00 00:00:00'),(3,'ddamore','miller','Devolved systemic localareanetwork','0000-00-00 00:00:00','0000-00-00 00:00:00'),(4,'malinda69','tremblay','Fundamental didactic complexity','0000-00-00 00:00:00','0000-00-00 00:00:00'),(5,'mturcotte','robel','Intuitive secondary website','0000-00-00 00:00:00','0000-00-00 00:00:00'),(6,'kcrooks','lind','Devolved scalable functionalities','0000-00-00 00:00:00','0000-00-00 00:00:00'),(7,'efrain02','macejkovic','Cloned stable systemengine','0000-00-00 00:00:00','0000-00-00 00:00:00'),(8,'domenick.watsica','wisoky','Open-architected neutral challenge','0000-00-00 00:00:00','0000-00-00 00:00:00'),(9,'hcassin','cassin','Profound leadingedge installation','0000-00-00 00:00:00','0000-00-00 00:00:00'),(10,'hoppe.nikita','kuhn','Managed bottom-line systemengine','0000-00-00 00:00:00','0000-00-00 00:00:00'),(11,'satterfield.eduardo','bins','Adaptive modular collaboration','0000-00-00 00:00:00','0000-00-00 00:00:00'),(12,'nikki77','lindgren','Phased asynchronous leverage','0000-00-00 00:00:00','0000-00-00 00:00:00'),(13,'kessler.watson','towne','Ergonomic solution-oriented capacity','0000-00-00 00:00:00','0000-00-00 00:00:00'),(14,'thaddeus44','kunze','Triple-buffered incremental contingency','0000-00-00 00:00:00','0000-00-00 00:00:00'),(15,'zpurdy','beier','Cross-platform mobile extranet','0000-00-00 00:00:00','0000-00-00 00:00:00'),(16,'neha83','hills','Automated global model','0000-00-00 00:00:00','0000-00-00 00:00:00'),(17,'iliana70','farrell','Implemented static groupware','0000-00-00 00:00:00','0000-00-00 00:00:00'),(18,'dortha.kunde','lang','Monitored tangible success','0000-00-00 00:00:00','0000-00-00 00:00:00'),(19,'ezekiel50','mertz','Multi-channelled composite pricingstructure','0000-00-00 00:00:00','0000-00-00 00:00:00'),(20,'hrath','von','Vision-oriented systematic structure','0000-00-00 00:00:00','0000-00-00 00:00:00'),(21,'dickens.arvilla','kilback','Pre-emptive global task-force','0000-00-00 00:00:00','0000-00-00 00:00:00'),(22,'htrantow','stoltenberg','Switchable real-time service-desk','0000-00-00 00:00:00','0000-00-00 00:00:00'),(23,'krempel','schumm','Organized actuating systemengine','0000-00-00 00:00:00','0000-00-00 00:00:00'),(24,'moen.gudrun','corwin','Pre-emptive motivating strategy','0000-00-00 00:00:00','0000-00-00 00:00:00'),(25,'ulises82','spinka','Decentralized value-added circuit','0000-00-00 00:00:00','0000-00-00 00:00:00'),(26,'novella.ryan','mayert','Diverse content-based hardware','0000-00-00 00:00:00','0000-00-00 00:00:00'),(27,'cmonahan','reichel','Re-engineered impactful synergy','0000-00-00 00:00:00','0000-00-00 00:00:00'),(28,'arvilla26','willms','Versatile uniform capability','0000-00-00 00:00:00','0000-00-00 00:00:00'),(29,'nyah76','schowalter','Triple-buffered user-facing migration','0000-00-00 00:00:00','0000-00-00 00:00:00'),(30,'evie.mayert','fadel','Profound static structure','0000-00-00 00:00:00','0000-00-00 00:00:00'),(31,'emmerich.antwon','barrows','Down-sized systematic synergy','0000-00-00 00:00:00','0000-00-00 00:00:00'),(32,'gerhold.leone','turcotte','Optimized transitional emulation','0000-00-00 00:00:00','0000-00-00 00:00:00'),(33,'srosenbaum','beahan','Triple-buffered content-based structure','0000-00-00 00:00:00','0000-00-00 00:00:00'),(34,'yjaskolski','pollich','User-friendly global analyzer','0000-00-00 00:00:00','0000-00-00 00:00:00'),(35,'hilll.kirstin','kovacek','User-centric homogeneous access','0000-00-00 00:00:00','0000-00-00 00:00:00'),(36,'okuhn','gaylord','Ergonomic dynamic forecast','0000-00-00 00:00:00','0000-00-00 00:00:00'),(37,'xgutmann','heidenreich','Grass-roots responsive protocol','0000-00-00 00:00:00','0000-00-00 00:00:00'),(38,'brooks.hessel','carter','Re-contextualized maximized monitoring','0000-00-00 00:00:00','0000-00-00 00:00:00'),(39,'morissette.bessie','smitham','Centralized executive systemengine','0000-00-00 00:00:00','0000-00-00 00:00:00'),(40,'sydney.harris','batz','Configurable zerotolerance openarchitecture','0000-00-00 00:00:00','0000-00-00 00:00:00'),(41,'kira.lebsack','huel','User-centric maximized database','0000-00-00 00:00:00','0000-00-00 00:00:00'),(42,'conn.rossie','pagac','Team-oriented hybrid adapter','0000-00-00 00:00:00','0000-00-00 00:00:00'),(43,'maiya.pollich','runolfsson','Fully-configurable dedicated flexibility','0000-00-00 00:00:00','0000-00-00 00:00:00'),(44,'cronin.edwin','watsica','Robust 24/7 support','0000-00-00 00:00:00','0000-00-00 00:00:00'),(45,'dale48','green','Streamlined value-added artificialintelligence','0000-00-00 00:00:00','0000-00-00 00:00:00'),(46,'lstokes','barton','Organic mission-critical GraphicalUserInterface','0000-00-00 00:00:00','0000-00-00 00:00:00'),(47,'wward','torphy','Automated directional throughput','0000-00-00 00:00:00','0000-00-00 00:00:00'),(48,'dolly81','bruen','Advanced coherent orchestration','0000-00-00 00:00:00','0000-00-00 00:00:00'),(49,'opadberg','upton','Centralized transitional application','0000-00-00 00:00:00','0000-00-00 00:00:00'),(50,'tbraun','kub','Business-focused explicit capability','0000-00-00 00:00:00','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `productos__categoriaproductos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos__marcas`
--

DROP TABLE IF EXISTS `productos__marcas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productos__marcas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `codigo` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos__marcas`
--

LOCK TABLES `productos__marcas` WRITE;
/*!40000 ALTER TABLE `productos__marcas` DISABLE KEYS */;
INSERT INTO `productos__marcas` VALUES (1,'furt 5462','Herzog 0','Customizable bottom-line GraphicalUserInterface','2017-08-28 06:25:18','2017-08-28 06:25:18'),(2,'mouth 23294','Ondricka 1','Devolved national array','2017-08-28 06:25:18','2017-08-28 06:25:18'),(3,'fort 1958','Frami 2','Universal intangible opensystem','2017-08-28 06:25:19','2017-08-28 06:25:19'),(4,'land 6744','Lubowitz 3','Inverse contextually-based securedline','2017-08-28 06:25:19','2017-08-28 06:25:19'),(5,'borough 950','Miller 4','Balanced methodical projection','2017-08-28 06:25:19','2017-08-28 06:25:19'),(6,'ton 2131','Aufderhar 5','Balanced context-sensitive methodology','2017-08-28 06:25:19','2017-08-28 06:25:19'),(7,'town 548','Buckridge 6','Extended bottom-line paradigm','2017-08-28 06:25:19','2017-08-28 06:25:19'),(8,'borough 9777','Haag 7','Synchronised executive migration','2017-08-28 06:25:19','2017-08-28 06:25:19'),(9,'chester 6354','Walter 8','Ameliorated scalable structure','2017-08-28 06:25:19','2017-08-28 06:25:19'),(10,'chester 8235','Spinka 9','Cross-group optimal instructionset','2017-08-28 06:25:19','2017-08-28 06:25:19'),(11,'mouth 4032','Lueilwitz 10','Progressive multimedia GraphicInterface','2017-08-28 06:25:19','2017-08-28 06:25:19'),(12,'mouth 12338','Boyle 11','Visionary user-facing GraphicInterface','2017-08-28 06:25:19','2017-08-28 06:25:19'),(13,'chester 465','Feil 12','Universal bi-directional knowledgeuser','2017-08-28 06:25:19','2017-08-28 06:25:19'),(14,'fort 93188','Shields 13','Realigned motivating help-desk','2017-08-28 06:25:19','2017-08-28 06:25:19'),(15,'ville 12698','Thiel 14','Optional fault-tolerant solution','2017-08-28 06:25:19','2017-08-28 06:25:19'),(16,'side 10258','Skiles 15','Seamless holistic capacity','2017-08-28 06:25:19','2017-08-28 06:25:19'),(17,'town 8596','Lockman 16','Switchable high-level processimprovement','2017-08-28 06:25:19','2017-08-28 06:25:19'),(18,'port 8072','Mayer 17','Monitored multi-tasking conglomeration','2017-08-28 06:25:19','2017-08-28 06:25:19'),(19,'mouth 2853','Grady 18','Synergistic foreground structure','2017-08-28 06:25:19','2017-08-28 06:25:19'),(20,'berg 74448','Cruickshank 19','Assimilated object-oriented function','2017-08-28 06:25:19','2017-08-28 06:25:19'),(21,'view 7170','Bode 20','Virtual value-added implementation','2017-08-28 06:25:19','2017-08-28 06:25:19'),(22,'town 223','Hodkiewicz 21','Reduced content-based budgetarymanagement','2017-08-28 06:25:19','2017-08-28 06:25:19'),(23,'ville 7657','Krajcik 22','Versatile encompassing functionalities','2017-08-28 06:25:19','2017-08-28 06:25:19'),(24,'mouth 7344','Cremin 23','Switchable foreground definition','2017-08-28 06:25:19','2017-08-28 06:25:19'),(25,'borough 2223','Borer 24','Configurable homogeneous application','2017-08-28 06:25:19','2017-08-28 06:25:19'),(26,'ton 1572','Labadie 25','Seamless assymetric definition','2017-08-28 06:25:19','2017-08-28 06:25:19'),(27,'ton 7261','Torp 26','Innovative tertiary superstructure','2017-08-28 06:25:19','2017-08-28 06:25:19'),(28,'stad 4413','Considine 27','Exclusive 24hour encryption','2017-08-28 06:25:19','2017-08-28 06:25:19'),(29,'ton 5957','Sanford 28','Universal national orchestration','2017-08-28 06:25:20','2017-08-28 06:25:20'),(30,'shire 423','Weber 29','Advanced well-modulated extranet','2017-08-28 06:25:20','2017-08-28 06:25:20'),(31,'ton 4878','Bogisich 30','Organic assymetric standardization','2017-08-28 06:25:20','2017-08-28 06:25:20'),(32,'town 4657','Beahan 31','Multi-channelled 3rdgeneration intranet','2017-08-28 06:25:20','2017-08-28 06:25:20'),(33,'shire 6563','Grimes 32','Horizontal responsive neural-net','2017-08-28 06:25:20','2017-08-28 06:25:20'),(34,'land 9092','Gleason 33','Inverse incremental ability','2017-08-28 06:25:20','2017-08-28 06:25:20'),(35,'mouth 31865','Gleichner 34','Extended optimal instructionset','2017-08-28 06:25:20','2017-08-28 06:25:20'),(36,'shire 326','Crist 35','Polarised static array','2017-08-28 06:25:20','2017-08-28 06:25:20'),(37,'bury 57640','Moore 36','Multi-layered hybrid internetsolution','2017-08-28 06:25:20','2017-08-28 06:25:20'),(38,'ville 4848','Keebler 37','Persistent transitional strategy','2017-08-28 06:25:20','2017-08-28 06:25:20'),(39,'stad 9208','Steuber 38','Organized incremental monitoring','2017-08-28 06:25:20','2017-08-28 06:25:20'),(40,'land 630','Hilll 39','Vision-oriented leadingedge superstructure','2017-08-28 06:25:20','2017-08-28 06:25:20'),(41,'mouth 68913','Cormier 40','Automated neutral leverage','2017-08-28 06:25:20','2017-08-28 06:25:20'),(42,'bury 959','Ferry 41','Balanced composite productivity','2017-08-28 06:25:20','2017-08-28 06:25:20'),(43,'mouth 630','Kozey 42','Innovative background utilisation','2017-08-28 06:25:20','2017-08-28 06:25:20'),(44,'chester 782','Kertzmann 43','Horizontal transitional circuit','2017-08-28 06:25:20','2017-08-28 06:25:20'),(45,'side 5974','Block 44','Seamless non-volatile benchmark','2017-08-28 06:25:20','2017-08-28 06:25:20'),(46,'land 856','Doyle 45','Fundamental fault-tolerant paradigm','2017-08-28 06:25:20','2017-08-28 06:25:20'),(47,'stad 60809','Bernier 46','Horizontal intermediate conglomeration','2017-08-28 06:25:20','2017-08-28 06:25:20'),(48,'mouth 759','Schultz 47','Fully-configurable composite circuit','2017-08-28 06:25:20','2017-08-28 06:25:20'),(49,'fort 6160','Upton 48','Digitized object-oriented hub','2017-08-28 06:25:20','2017-08-28 06:25:20'),(50,'chester 14778','Klein 49','Down-sized attitude-oriented forecast','2017-08-28 06:25:20','2017-08-28 06:25:20');
/*!40000 ALTER TABLE `productos__marcas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos__productos`
--

DROP TABLE IF EXISTS `productos__productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productos__productos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `codigo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `precio_compra` bigint(20) NOT NULL,
  `precio_compra_promedio` double(25,5) NOT NULL,
  `precio_venta` bigint(20) NOT NULL,
  `fecha_compra` date NOT NULL,
  `stock` double(25,5) NOT NULL,
  `stock_minimo` double(25,5) NOT NULL,
  `activo` tinyint(1) NOT NULL,
  `archivo` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `mime` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `categoria_id` int(10) unsigned NOT NULL,
  `marca_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `productos__productos_categoria_id_index` (`categoria_id`),
  KEY `productos__productos_marca_id_index` (`marca_id`),
  CONSTRAINT `productos__productos_categoria_id_foreign` FOREIGN KEY (`categoria_id`) REFERENCES `productos__categoriaproductos` (`id`),
  CONSTRAINT `productos__productos_marca_id_foreign` FOREIGN KEY (`marca_id`) REFERENCES `productos__marcas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos__productos`
--

LOCK TABLES `productos__productos` WRITE;
/*!40000 ALTER TABLE `productos__productos` DISABLE KEYS */;
INSERT INTO `productos__productos` VALUES (1,'Producto vandervort','CA',56018,56018.00000,61351,'2011-08-28',49.00000,7.00000,0,'','',20,14,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(2,'Producto klocko','AR',58169,58169.00000,64583,'2013-12-04',93.00000,8.00000,0,'','',16,40,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(3,'Producto kilback','AK',55249,55249.00000,67304,'2015-06-25',91.00000,7.00000,1,'','',23,14,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(4,'Producto kub','UT',58838,58838.00000,65048,'2013-11-09',149.00000,1.00000,0,'','',20,38,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(5,'Producto bergnaum','CT',52996,52996.00000,72857,'2015-03-03',67.00000,4.00000,0,'','',17,21,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(6,'Producto streich','IA',53893,53893.00000,77308,'2011-11-09',185.00000,9.00000,0,'','',42,10,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(7,'Producto corkery','WY',53528,53528.00000,74921,'2010-07-28',56.00000,9.00000,1,'','',17,34,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(8,'Producto grady','DC',57465,57465.00000,61662,'2012-03-10',166.00000,9.00000,1,'','',36,13,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(9,'Producto wuckert','OH',54629,54629.00000,74475,'2013-01-20',158.00000,10.00000,1,'','',25,18,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(10,'Producto leuschke','NE',57278,57278.00000,69472,'2010-04-23',158.00000,8.00000,1,'','',3,48,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(11,'Producto swaniawski','ID',58675,58675.00000,70428,'2014-11-09',107.00000,2.00000,0,'','',21,6,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(12,'Producto nikolaus','MA',59271,59271.00000,61245,'2017-12-26',25.00000,2.00000,1,'','',30,26,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(13,'Producto waelchi','DE',54992,54992.00000,69733,'2010-09-21',141.00000,7.00000,0,'','',34,39,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(14,'Producto roberts','RI',50975,50975.00000,67735,'2012-10-13',151.00000,7.00000,0,'','',44,37,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(15,'Producto conroy','ME',55715,55715.00000,62081,'2014-08-03',158.00000,1.00000,0,'','',32,10,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(16,'Producto wunsch','WA',57129,57129.00000,68869,'2016-06-27',45.00000,10.00000,1,'','',11,14,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(17,'Producto yundt','AZ',50884,50884.00000,74752,'2017-06-28',74.00000,2.00000,1,'','',2,46,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(18,'Producto hamill','PA',56743,56743.00000,75030,'2010-10-18',192.00000,5.00000,1,'','',36,33,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(19,'Producto runte','GA',57590,57590.00000,78101,'2011-01-26',11.00000,4.00000,0,'','',47,28,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(20,'Producto jast','FL',50093,50093.00000,66307,'2018-09-27',15.00000,8.00000,0,'','',27,3,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(21,'Producto johnson','MT',55800,55800.00000,61759,'2010-09-22',184.00000,3.00000,0,'','',1,39,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(22,'Producto douglas','NC',52205,52205.00000,69539,'2010-04-24',100.00000,8.00000,1,'','',8,49,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(23,'Producto satterfield','NJ',53574,53574.00000,78962,'2015-09-18',162.00000,10.00000,0,'','',27,31,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(24,'Producto hermann','AL',56169,56169.00000,75480,'2010-04-07',177.00000,9.00000,0,'','',28,22,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(25,'Producto damore','CO',52219,52219.00000,69674,'2016-04-27',53.00000,3.00000,0,'','',40,35,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(26,'Producto beatty','NM',58794,58794.00000,76604,'2016-01-09',27.00000,1.00000,0,'','',22,9,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(27,'Producto skiles','WV',50793,50793.00000,77206,'2012-05-10',46.00000,7.00000,0,'','',22,6,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(28,'Producto carter','MD',53659,53659.00000,74654,'2016-05-22',180.00000,8.00000,0,'','',4,45,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(29,'Producto pfannerstill','NY',55194,55194.00000,69035,'2015-10-06',94.00000,4.00000,1,'','',3,45,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(30,'Producto fahey','IL',52759,52759.00000,73850,'2011-10-10',52.00000,10.00000,0,'','',11,15,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(31,'Producto torp','IN',59073,59073.00000,61281,'2011-10-01',101.00000,6.00000,1,'','',47,20,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(32,'Producto fadel','TX',59161,59161.00000,65230,'2013-11-06',127.00000,3.00000,1,'','',21,37,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(33,'Producto kshlerin','ND',55234,55234.00000,79437,'2012-02-23',104.00000,3.00000,0,'','',24,30,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(34,'Producto king','VT',54752,54752.00000,75494,'2014-11-28',47.00000,2.00000,1,'','',29,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(35,'Producto bernhard','SC',51617,51617.00000,60220,'2013-09-01',164.00000,1.00000,1,'','',48,36,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(36,'Producto hackett','OK',51520,51520.00000,61039,'2011-11-01',71.00000,7.00000,1,'','',24,22,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(37,'Producto jerde','TN',58525,58525.00000,74402,'2011-09-21',119.00000,2.00000,1,'','',2,33,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(38,'Producto jakubowski','MS',57911,57911.00000,72707,'2012-03-12',115.00000,4.00000,1,'','',2,16,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(39,'Producto gerlach','NH',58274,58274.00000,77056,'2014-03-10',137.00000,9.00000,1,'','',21,45,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(40,'Producto krajcik','OR',54968,54968.00000,69329,'2017-08-16',76.00000,6.00000,0,'','',5,31,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(41,'Producto ondricka','WI',52868,52868.00000,60678,'2015-01-16',137.00000,10.00000,0,'','',21,30,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(42,'Producto daniel','SD',52737,52737.00000,76002,'2017-08-24',165.00000,5.00000,1,'','',6,15,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(43,'Producto barton','KS',51362,51362.00000,62348,'2012-02-19',72.00000,3.00000,0,'','',33,27,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(44,'Producto nolan','VA',50616,50616.00000,70973,'2018-11-07',103.00000,7.00000,0,'','',44,25,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(45,'Producto frami','HI',53366,53366.00000,70773,'2011-01-10',113.00000,5.00000,1,'','',15,29,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(46,'Producto oconnell','KY',58148,58148.00000,75847,'2017-05-21',166.00000,6.00000,0,'','',6,35,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(47,'Producto christiansen','NV',58183,58183.00000,75369,'2013-01-26',106.00000,6.00000,0,'','',48,32,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(48,'Producto abbott','MI',54760,54760.00000,61469,'2016-10-10',100.00000,3.00000,0,'','',40,18,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(49,'Producto altenwerth','LA',55590,55590.00000,72996,'2011-11-03',74.00000,1.00000,0,'','',26,30,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(50,'Producto schaefer','MO',51125,51125.00000,78573,'2010-05-03',30.00000,2.00000,0,'','',18,39,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(51,'Producto grant','MN',59210,59210.00000,72420,'2013-08-27',40.00000,4.00000,0,'','',45,1,'0000-00-00 00:00:00','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `productos__productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedores__proveedors`
--

DROP TABLE IF EXISTS `proveedores__proveedors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proveedores__proveedors` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `razon_social` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ruc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `categoria` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `direccion` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `telefono` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `celular` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fax` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contacto` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedores__proveedors`
--

LOCK TABLES `proveedores__proveedors` WRITE;
/*!40000 ALTER TABLE `proveedores__proveedors` DISABLE KEYS */;
/*!40000 ALTER TABLE `proveedores__proveedors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reminders`
--

DROP TABLE IF EXISTS `reminders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reminders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `completed` tinyint(1) NOT NULL DEFAULT '0',
  `completed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reminders`
--

LOCK TABLES `reminders` WRITE;
/*!40000 ALTER TABLE `reminders` DISABLE KEYS */;
/*!40000 ALTER TABLE `reminders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `revisions`
--

DROP TABLE IF EXISTS `revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `revisions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `revisionable_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `revisionable_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `old_value` text COLLATE utf8_unicode_ci,
  `new_value` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `revisions_revisionable_id_revisionable_type_index` (`revisionable_id`,`revisionable_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `revisions`
--

LOCK TABLES `revisions` WRITE;
/*!40000 ALTER TABLE `revisions` DISABLE KEYS */;
/*!40000 ALTER TABLE `revisions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_users`
--

DROP TABLE IF EXISTS `role_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_users` (
  `user_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_users`
--

LOCK TABLES `role_users` WRITE;
/*!40000 ALTER TABLE `role_users` DISABLE KEYS */;
INSERT INTO `role_users` VALUES (1,1,'2017-08-28 06:13:42','2017-08-28 06:13:42');
/*!40000 ALTER TABLE `role_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `permissions` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'admin','Admin','{\"caja.cajas.index\":true,\"caja.cajas.create\":true,\"caja.cajas.store\":true,\"caja.cajas.edit\":true,\"caja.cajas.update\":true,\"caja.cajas.destroy\":true,\"caja.cajas.index_ajax\":true,\"caja.cajas.pdf\":true,\"caja.cajas.index_movimientos\":true,\"caja.cajas.create_movimiento\":true,\"caja.cajas.store_movimiento\":true,\"caja.cajas.edit_movimiento\":true,\"caja.cajas.update_movimiento\":true,\"caja.cajas.index_movimientos_activo\":true,\"caja.cajas.index_cajas\":true,\"clientes.clientes.index\":true,\"clientes.clientes.create\":true,\"clientes.clientes.store\":true,\"clientes.clientes.edit\":true,\"clientes.clientes.update\":true,\"clientes.clientes.destroy\":true,\"clientes.clientes.index_ajax\":true,\"clientes.clientes.search_cliente\":true,\"clientes.clientes.upload_cliente_xls\":true,\"clientes.clientes.upload_cliente_xls_store\":true,\"clientes.clientes.descargar_ejemplo\":true,\"Permisos Especiales Clientes.Ver boton de cargar clientes desde excel\":true,\"Permisos Especiales Clientes.Ver boton de descargar ejemplo excel\":true,\"compras.compras.index\":true,\"compras.compras.create\":true,\"compras.compras.store\":true,\"compras.compras.edit\":true,\"compras.compras.update\":true,\"compras.compras.destroy\":true,\"compras.compras.seleccion\":true,\"compras.compras.index_ajax\":true,\"compras.compras.edit_config_factura\":true,\"compras.compras.update_config_factura\":true,\"compras.compras.reporte_gastos_performance\":true,\"compras.compras.reporte_gastos\":true,\"compras.compras.reporte_gastos_ajax\":true,\"compras.compras.categorias_reporte_gastos_ajax\":true,\"compras.compras.reporte_xls\":true,\"compras.compras.categorias_reporte_xls\":true,\"compras.compras.index_pendientes\":true,\"compras.compras.factura\":true,\"compras.compras.factura_update\":true,\"compras.compras.pago_create\":true,\"compras.compras.pago_store\":true,\"compras.compras.cuenta_change\":true,\"compras.detallecompras.index\":true,\"compras.detallecompras.create\":true,\"compras.detallecompras.store\":true,\"compras.detallecompras.edit\":true,\"compras.detallecompras.update\":true,\"compras.detallecompras.destroy\":true,\"compras.comprapago.destroypago\":true,\"Permisos Especiales Compras.Ver detalles de otras compras\":true,\"contabilidad.tipocuentas.index\":true,\"contabilidad.tipocuentas.create\":true,\"contabilidad.tipocuentas.store\":true,\"contabilidad.tipocuentas.edit\":true,\"contabilidad.tipocuentas.update\":true,\"contabilidad.tipocuentas.destroy\":true,\"contabilidad.cuentas.index\":true,\"contabilidad.cuentas.create\":true,\"contabilidad.cuentas.store\":true,\"contabilidad.cuentas.edit\":true,\"contabilidad.cuentas.update\":true,\"contabilidad.cuentas.destroy\":true,\"contabilidad.cuentas.search_padre\":true,\"contabilidad.cuentas.search_cuenta_asiento\":true,\"contabilidad.cuentas.index_ajax_filter\":true,\"contabilidad.cuentas.historial\":true,\"contabilidad.cuentas.historial_ajax\":true,\"contabilidad.cuentas.historial_excel\":true,\"contabilidad.cuentas.historial-solo-caja-ita\":false,\"contabilidad.cuentas.cuenta_exist\":true,\"contabilidad.asientos.index\":true,\"contabilidad.asientos.create\":true,\"contabilidad.asientos.store\":true,\"contabilidad.asientos.edit\":true,\"contabilidad.asientos.update\":true,\"contabilidad.asientos.destroy\":true,\"contabilidad.asientos.index_ajax_asientos\":true,\"contabilidad.asientos.anular\":true,\"contabilidad.asientodetalles.index\":true,\"contabilidad.asientodetalles.create\":true,\"contabilidad.asientodetalles.store\":true,\"contabilidad.asientodetalles.edit\":true,\"contabilidad.asientodetalles.update\":true,\"contabilidad.asientodetalles.destroy\":true,\"contabilidad.ejercicio.index\":true,\"contabilidad.ejercicio.create\":true,\"contabilidad.ejercicio.store\":true,\"contabilidad.ejercicio.edit\":true,\"contabilidad.ejercicio.update\":true,\"contabilidad.ejercicio.destroy\":true,\"contabilidad.reportes.libro_mayor\":true,\"contabilidad.reportes.libro_mayor_index\":true,\"contabilidad.reportes.libro_mayor_pdf\":true,\"contabilidad.reportes.libro_mayor_xls\":true,\"contabilidad.reportes.balance\":true,\"contabilidad.reportes.balance_activos\":true,\"contabilidad.reportes.balance_pasivos\":true,\"contabilidad.reportes.balance_patrimonio\":true,\"contabilidad.reportes.balance_pdf\":true,\"contabilidad.reportes.estado_resultado\":true,\"contabilidad.reportes.estado_resultado_ingresos\":true,\"contabilidad.reportes.estado_resultado_egresos\":true,\"contabilidad.reportes.estado_resultado_pdf\":true,\"contabilidad.reportes.libro_venta\":true,\"contabilidad.reportes.libro_venta_pdf\":true,\"contabilidad.reportes.libro_venta_excel\":true,\"contabilidad.reportes.libro_compra\":true,\"contabilidad.reportes.libro_compra_pdf\":true,\"contabilidad.reportes.libro_compra_excel\":true,\"contabilidad.reportes.ingreso_egreso\":true,\"contabilidad.reportes.ingreso_egreso_ajax\":true,\"contabilidad.reportes.ingreso_egreso_xls\":true,\"contabilidad.reportes.ingreso_egreso_config\":true,\"contabilidad.reportes.flujo_caja\":true,\"contabilidad.reportes.flujo_caja_config\":true,\"contabilidad.reportes.libro_compra_performance\":true,\"contabilidad.reportes.libro_venta_performance\":true,\"contabilidad.reportes.cajas\":true,\"contabilidad.reportes.flujo_efectivo\":true,\"contabilidad.reportes.flujo_efectivo_ajax\":true,\"contabilidad.reportes.flujo_efectivo_excel\":true,\"contabilidad.reportes.flujo_efectivo_detalles\":true,\"contabilidad.reportes.flujo_efectivo_detalles_ajax\":true,\"contabilidad.reportes.flujo_efectivo_detalles_excel\":true,\"Permisos Especiales Contabilidad.Ver Contabilidad en Sidebar\":true,\"Permisos Especiales Reportes.Ver Reportes en Sidebar\":true,\"dashboard.grid.save\":true,\"dashboard.grid.reset\":true,\"dashboard.index\":true,\"dashboard.ejercicio.ejercicio\":true,\"empleados.empleados.index\":true,\"empleados.empleados.create\":true,\"empleados.empleados.store\":true,\"empleados.empleados.edit\":true,\"empleados.empleados.update\":true,\"empleados.empleados.destroy\":true,\"empleados.empleados.indexAjax\":true,\"empleados.pagoempleados.index\":true,\"empleados.pagoempleados.create\":true,\"empleados.pagoempleados.store\":true,\"empleados.pagoempleados.edit\":true,\"empleados.pagoempleados.update\":true,\"empleados.pagoempleados.destroy\":true,\"empleados.pagoempleados.indexAjax\":true,\"empleados.pagoempleados.seleccionEmpleado\":true,\"empleados.pagoempleados.anular_asientos\":true,\"empleados.anticipos.index\":true,\"empleados.anticipos.create\":true,\"empleados.anticipos.store\":true,\"empleados.anticipos.edit\":true,\"empleados.anticipos.update\":true,\"empleados.anticipos.anular\":true,\"Permisos Especiales Empleados.Ver Empleados en Sidebar\":true,\"media.media.index\":true,\"media.media.create\":true,\"media.media.store\":true,\"media.media.edit\":true,\"media.media.update\":true,\"media.media.destroy\":true,\"media.media-grid.index\":true,\"media.media-grid.ckIndex\":true,\"menu.menus.index\":true,\"menu.menus.create\":true,\"menu.menus.store\":true,\"menu.menus.edit\":true,\"menu.menus.update\":true,\"menu.menus.destroy\":true,\"menu.menuitem.index\":true,\"menu.menuitem.create\":true,\"menu.menuitem.store\":true,\"menu.menuitem.edit\":true,\"menu.menuitem.update\":true,\"menu.menuitem.destroy\":true,\"page.pages.index\":true,\"page.pages.create\":true,\"page.pages.store\":true,\"page.pages.edit\":true,\"page.pages.update\":true,\"page.pages.destroy\":true,\"pagofacturascredito.pagofacturacreditos.index\":true,\"pagofacturascredito.pagofacturacreditos.create\":true,\"pagofacturascredito.pagofacturacreditos.store\":true,\"pagofacturascredito.pagofacturacreditos.edit\":true,\"pagofacturascredito.pagofacturacreditos.update\":true,\"pagofacturascredito.pagofacturacreditos.destroy\":true,\"pagofacturascredito.pagofacturacreditos.index_ajax\":true,\"productos.categoriaproductos.index\":true,\"productos.categoriaproductos.create\":true,\"productos.categoriaproductos.store\":true,\"productos.categoriaproductos.edit\":true,\"productos.categoriaproductos.update\":true,\"productos.categoriaproductos.destroy\":true,\"productos.productos.index\":true,\"productos.productos.create\":true,\"productos.productos.store\":true,\"productos.productos.edit\":true,\"productos.productos.update\":true,\"productos.productos.destroy\":true,\"productos.productos.search_producto\":true,\"productos.productos.index_ajax\":true,\"productos.productos.inventario_producto_pdf\":true,\"productos.productos.inventario_producto_performance\":true,\"productos.productos.productos_vendidos\":true,\"productos.productos.productos_vendidos_ajax\":true,\"productos.productos.productos_vendidos_query\":true,\"productos.productos.productos_vendidos_xls\":true,\"productos.productos.index_stock_critico\":true,\"productos.productos.cargar_productos_desde_excel\":true,\"productos.productos.store_productos_desde_excel\":true,\"productos.marcas.index\":true,\"productos.marcas.create\":true,\"productos.marcas.store\":true,\"productos.marcas.edit\":true,\"productos.marcas.update\":true,\"productos.marcas.destroy\":true,\"productos.altabajaproductos.index\":true,\"productos.altabajaproductos.create\":true,\"productos.altabajaproductos.store\":true,\"productos.altabajaproductos.edit\":true,\"productos.altabajaproductos.update\":true,\"productos.altabajaproductos.destroy\":true,\"productos.altabajaproductos.seleccionProductos\":true,\"productos.altabajaproductos.indexAjax\":true,\"Permisos Especiales Productos.Ver Precios de Compra\":true,\"proveedores.proveedors.index\":true,\"proveedores.proveedors.create\":true,\"proveedores.proveedors.store\":true,\"proveedores.proveedors.edit\":true,\"proveedores.proveedors.update\":true,\"proveedores.proveedors.destroy\":true,\"proveedores.proveedors.indexAjax\":true,\"proveedores.proveedors.search_proveedor\":true,\"servicios.servicios.index\":true,\"servicios.servicios.create\":true,\"servicios.servicios.store\":true,\"servicios.servicios.edit\":true,\"servicios.servicios.update\":true,\"servicios.servicios.destroy\":true,\"servicios.servicios.indexAjax\":true,\"servicios.servicios.search_servicio\":true,\"setting.settings.index\":true,\"setting.settings.getModuleSettings\":true,\"setting.settings.store\":true,\"translation.translations.index\":true,\"translation.translations.update\":true,\"translation.translations.export\":true,\"translation.translations.import\":true,\"user.users.index\":true,\"user.users.create\":true,\"user.users.store\":true,\"user.users.edit\":true,\"user.users.update\":true,\"user.users.destroy\":true,\"user.users.backup\":true,\"user.roles.index\":true,\"user.roles.create\":true,\"user.roles.store\":true,\"user.roles.edit\":true,\"user.roles.update\":true,\"user.roles.destroy\":true,\"ventas.ventas.index\":true,\"ventas.ventas.create\":true,\"ventas.ventas.store\":true,\"ventas.ventas.edit\":true,\"ventas.ventas.update\":true,\"ventas.ventas.destroy\":true,\"ventas.ventas.search_venta_cliente\":true,\"ventas.ventas.search_venta_producto\":true,\"ventas.ventas.search_venta_servicio\":true,\"ventas.ventas.search_venta_cristal\":true,\"ventas.ventas.detalle_venta_ajax\":true,\"ventas.ventas.seleccion\":true,\"ventas.ventas.indexAjax\":true,\"ventas.ventas.nro_seguimiento_exist\":true,\"ventas.ventas.edit_nro_seguimiento\":true,\"ventas.ventas.update_nro_seguimiento\":true,\"ventas.ventas.reporte\":true,\"ventas.ventas.reporte_ajax\":true,\"ventas.ventas.reporte_pdf\":true,\"ventas.ventas.reporte_xls\":true,\"ventas.ventas.query_reporte\":true,\"ventas.ventas.reporte_ganancias\":true,\"ventas.ventas.reporte_ganancias_ajax\":true,\"ventas.ventas.reporte_ganancias_query\":true,\"ventas.ventas.reporte_ganancias_xls\":true,\"ventas.ventas.index_preventa\":true,\"ventas.ventas.anular_factura\":true,\"ventas.ventas.cuenta_change\":true,\"ventas.ventas.anular_asientos_preventa\":true,\"ventas.ventas.preventa_agregar_items\":true,\"ventas.detalleventas.index\":true,\"ventas.detalleventas.create\":true,\"ventas.detalleventas.store\":true,\"ventas.detalleventas.edit\":true,\"ventas.detalleventas.update\":true,\"ventas.detalleventas.destroy\":true,\"ventas.facturaventas.index\":true,\"ventas.facturaventas.create\":true,\"ventas.facturaventas.store\":true,\"ventas.facturaventas.edit\":true,\"ventas.facturaventas.update\":true,\"ventas.facturaventas.destroy\":true,\"ventas.facturaventas.edit_nro_factura\":true,\"ventas.facturaventas.update_nro_factura\":true,\"ventas.facturaventas.index_ajax\":true,\"ventas.facturaventas.generar_facturas_vacias\":true,\"ventas.facturaventas.crear_facturas_vacias\":true,\"ventas.otras_ventas.index\":true,\"ventas.otras_ventas.index_ajax\":true,\"Permisos Especiales Ventas.Editar nro de sobre en Completar Venta\":true,\"visitas.visitas.index\":true,\"visitas.visitas.create\":true,\"visitas.visitas.store\":true,\"visitas.visitas.edit\":true,\"visitas.visitas.update\":true,\"visitas.visitas.destroy\":true,\"visitas.visitas.agregar_productos\":true,\"visitas.visitas.visita_productos_ajax\":true,\"visitas.visitas.index_ajax\":true,\"visitas.visitas.update_ajax\":true,\"visitas.visitas.destroy_ajax\":true,\"visitas.visitas.resumen\":true,\"visitas.stockretirados.index\":true,\"visitas.stockretirados.create\":true,\"visitas.stockretirados.store\":true,\"visitas.stockretirados.edit\":true,\"visitas.stockretirados.update\":true,\"visitas.stockretirados.destroy\":true,\"visitas.stockretirados.destroy_ajax\":true,\"visitas.comisiones.index\":true,\"visitas.comisiones.index_ajax\":true,\"visitas.comisiones.marcar_comisiones\":true,\"workshop.modules.index\":true,\"workshop.modules.show\":true,\"workshop.modules.disable\":true,\"workshop.modules.enable\":true,\"workshop.themes.index\":true,\"workshop.themes.show\":true}','2017-08-28 06:13:25','2017-08-29 12:51:37'),(2,'user','User','{\"dashboard.index\":true}','2017-08-28 06:13:25','2017-08-28 06:13:25');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servicios__servicios`
--

DROP TABLE IF EXISTS `servicios__servicios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servicios__servicios` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `codigo` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `precio_venta` bigint(20) NOT NULL,
  `activo` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicios__servicios`
--

LOCK TABLES `servicios__servicios` WRITE;
/*!40000 ALTER TABLE `servicios__servicios` DISABLE KEYS */;
INSERT INTO `servicios__servicios` VALUES (1,'Multi-tiered web-enabled concept','EE780139654587639934','While she was peering about anxiously among the people near the looking-glass. There was no \'One, two, three, and away,\' but they were nice grand words to say.) Presently she began again: \'Ou est ma.',701259,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(2,'Devolved 4thgeneration matrix','BH50IJQZHSUH1ISCKV8G2R','CHORUS. \'Wow! wow! wow!\' \'Here! you may SIT down,\' the King said, turning to the jury, and the White Rabbit blew three blasts on the Duchess\'s knee, while plates and dishes crashed around it--once.',409634,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(3,'Decentralized executive website','IL731971582146208183663','Alice, in a melancholy tone. \'Nobody seems to like her, down here, that I should think you might catch a bad cold if she were looking up into the jury-box, or they would die. \'The trial cannot.',389472,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(4,'Versatile needs-based pricingstructure','GB21GZXF92341603851195','She had already heard her sentence three of the cakes, and was coming back to finish his story. CHAPTER IV. The Rabbit Sends in a trembling voice to a shriek, \'and just as well as the rest of the.',770260,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(5,'Upgradable optimal processimprovement','NO9875853397943','And he got up this morning, but I don\'t want to stay with it as a drawing of a globe of goldfish she had peeped into the court, arm-in-arm with the Gryphon. \'It\'s all about as much as serpents do,.',342045,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(6,'Monitored foreground support','AL10338656956P82G620ZV58I266','Gryphon added \'Come, let\'s try Geography. London is the reason is--\' here the Mock Turtle a little girl she\'ll think me at home! Why, I wouldn\'t say anything about it, you know--\' She had quite.',538822,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(7,'Open-architected assymetric migration','VG84PCHO1911085243465214','Alice remained looking thoughtfully at the bottom of the Nile On every golden scale! \'How cheerfully he seems to grin, How neatly spread his claws, And welcome little fishes in With gently smiling.',359808,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(8,'Advanced holistic superstructure','HU58063014778371165862940650','Then she went on. \'Would you tell me,\' said Alice, quite forgetting in the sea!\' cried the Mock Turtle. \'And how many hours a day is very confusing.\' \'It isn\'t,\' said the Gryphon: and it said in a.',691009,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(9,'Cross-group 5thgeneration budgetarymanagement','IS298382916984509937672604','Gryphon interrupted in a great thistle, to keep herself from being run over; and the fan, and skurried away into the open air. \'IF I don\'t like it, yer honour, at all, as the game began. Alice gave.',361735,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(10,'Multi-channelled analyzing database','SM55G0329492956U27P4A2K9ORK','OUTSIDE.\' He unfolded the paper as he said do. Alice looked very anxiously into its face to see anything; then she walked down the chimney close above her: then, saying to her great disappointment.',369886,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(11,'Realigned impactful budgetarymanagement','SA30746I742PTY847NM86Y07','Alice, who was peeping anxiously into her eyes; and once she remembered how small she was nine feet high. \'Whoever lives there,\' thought Alice, \'and those twelve creatures,\' (she was obliged to have.',305800,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(12,'Ameliorated homogeneous model','LV24VJWLC978R8IYJO178','I think--\' (for, you see, Miss, we\'re doing our best, afore she comes, to--\' At this the White Rabbit: it was over at last: \'and I wish you were or might have been that,\' said the Hatter said,.',640346,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(13,'Operative bottom-line core','PT51969606917309979833629','Mouse to tell them something more. \'You promised to tell its age, there was no longer to be no chance of this, so that they would go, and making faces at him as he said in a thick wood. \'The first.',694241,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(14,'Fully-configurable hybrid encryption','EE136452409044304407','Alice: \'three inches is such a capital one for catching mice you can\'t swim, can you?\' he added, turning to Alice. \'Only a thimble,\' said Alice in a frightened tone. \'The Queen of Hearts, she made.',825622,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(15,'Advanced 6thgeneration support','TR25707765B7YPJ3M460Y5JAM0','Five, \'and I\'ll tell him--it was for bringing the cook took the hookah out of its mouth and yawned once or twice, and shook itself. Then it got down off the subjects on his knee, and the Mock.',469809,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(16,'Optimized client-server product','AT135782265493001203','King and Queen of Hearts, who only bowed and smiled in reply. \'Please come back and finish your story!\' Alice called after her. \'I\'ve something important to say!\' This sounded promising, certainly:.',534767,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(17,'Centralized 24hour matrices','PK81IYFG4V5OE12E8N7K507D','However, she got up and walking away. \'You insult me by talking such nonsense!\' \'I didn\'t mean it!\' pleaded poor Alice. \'But you\'re so easily offended!\' \'You\'ll get used up.\' \'But what happens when.',759481,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(18,'Cross-platform disintermediate superstructure','TN9021239446301908018620','YOUR table,\' said Alice; \'I can\'t go no lower,\' said the Hatter. \'He won\'t stand beating. Now, if you could only see her. She is such a thing as \"I get what I say,\' the Mock Turtle at last, and they.',665130,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(19,'Fully-configurable directional encryption','AD9428949366XV86OI2I3X29','Duchess; \'and most of \'em do.\' \'I don\'t know much,\' said Alice; \'all I know all the same, shedding gallons of tears, until there was Mystery,\' the Mock Turtle. \'Hold your tongue!\' added the Gryphon,.',723569,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(20,'Total holistic conglomeration','PL82070462435502312390525967','Alice. \'That\'s very curious.\' \'It\'s all her riper years, the simple rules their friends had taught them: such as, \'Sure, I don\'t put my arm round your waist,\' the Duchess was sitting between them,.',567716,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(21,'Networked multimedia capacity','AT963282867900120412','I can\'t take LESS,\' said the Mock Turtle said with a deep sigh, \'I was a bright idea came into Alice\'s shoulder as he spoke, and added with a sudden burst of tears, \'I do wish I had our Dinah here,.',581428,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(22,'Horizontal nextgeneration product','FR8857016447007811401826077','As they walked off together, Alice heard it before,\' said the Queen, pointing to Alice for protection. \'You shan\'t be able! I shall only look up in a rather offended tone, \'Hm! No accounting for.',361496,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(23,'User-friendly motivating hub','MT28SPCG886976N0B4D1W3D92Q84S4N','King, and he checked himself suddenly: the others took the opportunity of taking it away. She did it at all,\' said the Caterpillar. Alice folded her hands, wondering if anything would EVER happen in.',533795,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(24,'Centralized coherent structure','EE831351791351374639','Then it got down off the subjects on his spectacles and looked at it, busily painting them red. Alice thought she might as well wait, as she could. \'No,\' said the Mock Turtle had just begun to.',546215,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(25,'Ergonomic 6thgeneration extranet','TN0456898780288715992038','Turtle.\' These words were followed by a very grave voice, \'until all the while, and fighting for the next moment she felt unhappy. \'It was the Duchess\'s cook. She carried the pepper-box in her.',461175,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(26,'Networked reciprocal policy','GE30UX4496060195555582','So she stood watching them, and all would change (she knew) to the law, And argued each case with my wife; And the Gryphon never learnt it.\' \'Hadn\'t time,\' said the Caterpillar called after it; and.',414746,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(27,'Networked even-keeled focusgroup','BG79EEID981992ZDG3ZU0C','Mouse. \'--I proceed. \"Edwin and Morcar, the earls of Mercia and Northumbria, declared for him: and even Stigand, the patriotic archbishop of Canterbury, found it very hard indeed to make the arches..',813174,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(28,'De-engineered systemic solution','IL059439460689451307823','The Hatter was the cat.) \'I hope they\'ll remember her saucer of milk at tea-time. Dinah my dear! I shall have somebody to talk to.\' \'How are you getting on?\' said Alice, in a tone of great dismay,.',561612,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(29,'Fully-configurable well-modulated challenge','RS74216836897563544802','Duchess, as she ran. \'How surprised he\'ll be when he finds out who was beginning to see anything; then she remembered that she had this fit) An obstacle that came between Him, and ourselves, and it..',331223,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(30,'Exclusive full-range infrastructure','ME74013160039759231197','Queen. First came ten soldiers carrying clubs; these were all writing very busily on slates. \'What are tarts made of?\' Alice asked in a low voice. \'Not at first, perhaps,\' said the Mock Turtle.',791864,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(31,'Public-key logistical website','PT13469834291707959999381','SAID was, \'Why is a raven like a serpent. She had not gone far before they saw Alice coming. \'There\'s PLENTY of room!\' said Alice very politely; but she added, to herself, \'I wonder what CAN have.',438982,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(32,'Optional interactive time-frame','AL486181104261M98Y2S0F8U291Q','RED rose-tree, and we put a white one in by mistake; and if I might venture to go and take it away!\' There was a most extraordinary noise going on shrinking rapidly: she soon made out that she had.',466863,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(33,'De-engineered web-enabled algorithm','HU97952312292266235247853463','Mock Turtle: \'why, if a fish came to the other, looking uneasily at the door-- Pray, what is the same solemn tone, only changing the order of the Mock Turtle, capering wildly about. \'Change lobsters.',402806,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(34,'Multi-channelled 4thgeneration intranet','TN2255608275668024120160','I ever heard!\' \'Yes, I think you\'d better finish the story for yourself.\' \'No, please go on!\' Alice said nothing: she had not noticed before, and she said this, she looked down at her own ears for.',663171,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(35,'Multi-lateral 6thgeneration emulation','RS49478799306618593012','The hedgehog was engaged in a solemn tone, only changing the order of the creature, but on the second verse of the tea--\' \'The twinkling of the moment she felt that she had made out the verses the.',418327,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(36,'Grass-roots actuating firmware','CZ7575420691740088393822','Mock Turtle went on, turning to the porpoise, \"Keep back, please: we don\'t want YOU with us!\"\' \'They were learning to draw,\' the Dormouse turned out, and, by the hedge!\' then silence, and then she.',369719,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(37,'Distributed 6thgeneration paradigm','AE061944782049673530505','King said to herself; \'his eyes are so VERY remarkable in that; nor did Alice think it would not allow without knowing how old it was, even before she gave her answer. \'They\'re done with a deep.',495122,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(38,'Compatible multi-state attitude','LI1453001K1YU0C42VW3R','Caterpillar; and it sat for a dunce? Go on!\' \'I\'m a poor man, your Majesty,\' he began. \'You\'re a very little way forwards each time and a great hurry to change the subject,\' the March Hare went \'Sh!.',755626,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(39,'Re-engineered multimedia opensystem','VG52NTUY3631145435855180','And certainly there was hardly room for YOU, and no room to grow to my jaw, Has lasted the rest of the jurors had a bone in his throat,\' said the Duchess: \'what a clear way you can;--but I must be.',704543,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(40,'Reverse-engineered bandwidth-monitored projection','PS95KFBAB7C1S8KD68WNLO28H4626','Alice, \'or perhaps they won\'t walk the way YOU manage?\' Alice asked. The Hatter was the only difficulty was, that anything that had slipped in like herself. \'Would it be murder to leave it behind?\'.',524402,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(41,'Switchable national structure','PK04ZGUS3O3020P85ZPQ5EM8','There are no mice in the pool of tears which she had never done such a very humble tone, going down on one of the bread-and-butter. Just at this corner--No, tie \'em together first--they don\'t reach.',707635,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(42,'Visionary logistical archive','GE69KN2117046582648974','Allow me to introduce some other subject of conversation. While she was ready to make the arches. The chief difficulty Alice found at first was moderate. But the insolence of his pocket, and was.',859548,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(43,'Re-contextualized directional parallelism','RS87639171731031808778','Alice heard it say to this: so she bore it as she could, \'If you can\'t swim, can you?\' he added, turning to Alice: he had a bone in his note-book, cackled out \'Silence!\' and read out from his book,.',853712,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(44,'Implemented even-keeled algorithm','TN5108112504915228295773','Alice went on, very much pleased at having found out a new idea to Alice, and she thought it had entirely disappeared; so the King said, turning to Alice as she could see, as well to introduce it.\'.',842435,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(45,'Multi-channelled holistic pricingstructure','BR0460886448194096242380420H3','I\'m sure I don\'t think,\' Alice went on, \'What HAVE you been doing here?\' \'May it please your Majesty,\' said the Lory. Alice replied very readily: \'but that\'s because it stays the same as they all.',516965,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(46,'Advanced even-keeled access','BR9790955222580780337130790F7','You see the earth takes twenty-four hours to turn into a sort of way to change them--\' when she got to come once a week: HE taught us Drawling, Stretching, and Fainting in Coils.\' \'What was that?\'.',535477,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(47,'Enhanced dynamic archive','EE355314319325663777','Sir, With no jury or judge, would be a Caucus-race.\' \'What IS the fun?\' said Alice. \'Come, let\'s try Geography. London is the reason and all must have imitated somebody else\'s hand,\' said the Dodo..',310609,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(48,'Intuitive exuding time-frame','RO51VGQW9KUP308CU805Y72V','But they HAVE their tails in their mouths. So they got their tails in their mouths--and they\'re all over with diamonds, and walked off; the Dormouse said--\' the Hatter added as an explanation. \'Oh,.',455391,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(49,'Customer-focused static middleware','FR4239879091135P4YWS3JUI146','Queen. \'I never was so long since she had never seen such a tiny golden key, and unlocking the door and went to school in the direction it pointed to, without trying to put it to his son, \'I feared.',440548,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(50,'Configurable real-time openarchitecture','TR406801225A0ZPT3ZI183UT48','Soon her eye fell upon a Gryphon, lying fast asleep in the world am I? Ah, THAT\'S the great wonder is, that I\'m doubtful about the same words as before, \'It\'s all her life. Indeed, she had put on.',796406,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(51,'Networked needs-based complexity','DE77717322632206433679','Puss,\' she began, in a dreamy sort of meaning in it, and finding it very hard indeed to make ONE respectable person!\' Soon her eye fell on a crimson velvet cushion; and, last of all the players,.',620167,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(52,'Facetoface heuristic attitude','AZ80VSWI2E7K6E7902A0V5L832B5','I almost wish I\'d gone to see its meaning. \'And just as well as she went on at last, and managed to swallow a morsel of the table. \'Nothing can be clearer than THAT. Then again--\"BEFORE SHE HAD THIS.',830543,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(53,'Ergonomic bandwidth-monitored interface','GR9002582577KM1K66XISYYQPAD','Hatter: \'let\'s all move one place on.\' He moved on as he spoke, and the small ones choked and had no pictures or conversations in it, and very neatly and simply arranged; the only difficulty was,.',314221,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(54,'Phased disintermediate benchmark','AD8300807126M29PRHU6JWMT','March Hare,) \'--it was at in all directions, \'just like a serpent. She had not long to doubt, for the immediate adoption of more broken glass.) \'Now tell me, please, which way it was only the pepper.',780506,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(55,'Pre-emptive assymetric orchestration','BR0448084278499738577099829P1','I look like it?\' he said, turning to Alice again. \'No, I give it up,\' Alice replied: \'what\'s the answer?\' \'I haven\'t the least notice of her head to hide a smile: some of the window, and on it were.',833311,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(56,'User-centric global focusgroup','LB6808351L96KZX01PPCKLZC3TPX','YOU do it!--That I won\'t, then!--Bill\'s to go down the chimney, and said to herself how this same little sister of hers that you couldn\'t cut off a bit afraid of interrupting him,) \'I\'ll give him.',799771,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(57,'Automated background application','PS18HJALY9XNE273418P91DN6CP49','Alice\'s side as she could not possibly reach it: she could guess, she was looking at the picture.) \'Up, lazy thing!\' said Alice, (she had kept a piece of bread-and-butter in the chimney as she had.',585059,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(58,'Team-oriented object-oriented emulation','RS92619905664187159854','THEN--she found herself at last the Dodo replied very solemnly. Alice was too late to wish that! She went on so long that they could not help thinking there MUST be more to do it.\' (And, as you are;.',822642,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(59,'Open-source client-driven utilisation','AD11450835322134KKPMAXA0','Cheshire cat,\' said the youth, \'one would hardly suppose That your eye was as much right,\' said the King. (The jury all brightened up at this corner--No, tie \'em together first--they don\'t reach.',389733,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(60,'Total real-time strategy','SK1611599126196818291582','The Duchess took no notice of her sister, as well wait, as she swam nearer to watch them, and all sorts of things, and she, oh! she knows such a rule at processions; \'and besides, what would happen.',733245,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(61,'Re-engineered motivating policy','AZ35DMAHM684D51YW7PG5DG70Z2A','Alice\'s shoulder, and it said nothing. \'This here young lady,\' said the Dormouse. \'Write that down,\' the King said, turning to the Gryphon. \'How the creatures argue. It\'s enough to look for her, and.',675754,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(62,'Synchronised 3rdgeneration help-desk','GI67FWYSFNPAG8K2JBM3K74','But she went on, \'you throw the--\' \'The lobsters!\' shouted the Queen, and in his turn; and both creatures hid their faces in their mouths; and the Queen ordering off her head!\' about once in a.',615652,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(63,'Enhanced asynchronous access','CH59402895D8401G14903','There could be beheaded, and that is rather a complaining tone, \'and they all quarrel so dreadfully one can\'t hear oneself speak--and they don\'t seem to see if he were trying to put it into his.',461940,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(64,'Streamlined empowering adapter','GB32KESY44085345142447','You see the Mock Turtle in a piteous tone. And she began nibbling at the window, and some of them attempted to explain it is right?\' \'In my youth,\' Father William replied to his son, \'I feared it.',846108,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(65,'Configurable responsive attitude','NO7629774379241','White Rabbit, jumping up in such confusion that she did not venture to go from here?\' \'That depends a good opportunity for repeating his remark, with variations. \'I shall sit here,\' he said, \'on and.',848521,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(66,'Focused transitional task-force','KZ12523IWK5W6A8VLMYN','And the Gryphon replied very solemnly. Alice was very nearly carried it out to the general conclusion, that wherever you go on? It\'s by far the most important piece of bread-and-butter in the.',894412,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(67,'Switchable dynamic protocol','AD1837771124FHRJ45K9325L','As soon as it turned a corner, \'Oh my ears and whiskers, how late it\'s getting!\' She was walking by the time it all is! I\'ll try if I fell off the mushroom, and crawled away in the trial done,\' she.',356191,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(68,'Optimized intermediate architecture','PL87377042259022770519536700','King sharply. \'Do you mean \"purpose\"?\' said Alice. \'Anything you like,\' said the Cat. \'I\'d nearly forgotten that I\'ve got back to the Knave of Hearts, he stole those tarts, And took them quite.',436729,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(69,'Managed client-server neural-net','PL87610181378278169115722543','I only wish it was,\' said the Gryphon repeated impatiently: \'it begins \"I passed by his face only, she would catch a bad cold if she did not dare to laugh; and, as the jury wrote it down into a.',894575,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(70,'Automated maximized hierarchy','MK49005JL19UO976934','Ann! Mary Ann!\' said the Footman, \'and that for two reasons. First, because I\'m on the trumpet, and called out, \'Sit down, all of you, and listen to her. \'I can see you\'re trying to box her own.',721126,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(71,'Cross-platform motivating matrices','KZ06345N32G8AZFU146C','Alice, \'shall I NEVER get any older than I am in the air, and came back again. \'Keep your temper,\' said the King, with an M--\' \'Why with an important air, \'are you all ready? This is the capital of.',736066,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(72,'Object-based neutral throughput','PL91994162918824490339607692','French lesson-book. The Mouse only growled in reply. \'Please come back and see what this bottle was a little bottle that stood near. The three soldiers wandered about in the night? Let me see: four.',621935,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(73,'Digitized client-server core','CH97246356CXW974NLUM5','And certainly there was no one could possibly hear you.\' And certainly there was a different person then.\' \'Explain all that,\' said the Mock Turtle yawned and shut his note-book hastily. \'Consider.',334048,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(74,'Visionary interactive groupware','GT6169OIDPT15O5EXH630BK945F4','I\'ll be jury,\" Said cunning old Fury: \"I\'ll try the effect: the next witness. It quite makes my forehead ache!\' Alice watched the White Rabbit, trotting slowly back again, and the words a little,.',376099,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(75,'Open-architected coherent moratorium','SA833975L3FZ4RCK6DO0YZ39','Alice, \'it\'ll never do to come yet, please your Majesty!\' the Duchess sneezed occasionally; and as Alice could not possibly reach it: she could not answer without a moment\'s pause. The only things.',811713,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(76,'Operative eco-centric opensystem','MK29425S0A64E3X0V33','The Queen had ordered. They very soon finished off the top of it. Presently the Rabbit came near her, she began, in a VERY turn-up nose, much more like a candle. I wonder who will put on her lap as.',890072,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(77,'Polarised solution-oriented processimprovement','GE91ZO1414694812707633','Caterpillar sternly. \'Explain yourself!\' \'I can\'t remember things as I used--and I don\'t take this child away with me,\' thought Alice, \'as all the jurors had a large plate came skimming out,.',779335,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(78,'Reverse-engineered dedicated firmware','ME24419574857155490471','The King turned pale, and shut his eyes.--\'Tell her about the right words,\' said poor Alice, that she was trying to box her own courage. \'It\'s no use their putting their heads down and looked at it.',396550,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(79,'Customizable scalable knowledgeuser','TR62858200152GOBR98Z37XA78','We must have been ill.\' \'So they were,\' said the Hatter: \'I\'m on the bank--the birds with draggled feathers, the animals with their fur clinging close to the table to measure herself by it, and.',675785,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(80,'Visionary static capacity','IT28A42298277772N817XFF2VWC','Alice; \'that\'s not at all know whether it would be very likely it can be,\' said the White Rabbit; \'in fact, there\'s nothing written on the stairs. Alice knew it was all dark overhead; before her was.',378846,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(81,'Exclusive real-time extranet','DK6424404080838004','My notion was that it was the fan and a Long Tale They were indeed a queer-looking party that assembled on the top with its wings. \'Serpent!\' screamed the Queen. First came ten soldiers carrying.',476416,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(82,'Sharable dynamic synergy','NO0491509684635','Alice, swallowing down her flamingo, and began to cry again. \'You ought to speak, and no one to listen to her. The Cat only grinned when it grunted again, so violently, that she never knew so much.',455522,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(83,'Automated bifurcated algorithm','ES7198487902176858566551','I\'LL soon make you grow shorter.\' \'One side of WHAT?\' thought Alice to herself. \'Of the mushroom,\' said the Hatter. \'You MUST remember,\' remarked the King, \'unless it was looking up into hers--she.',645393,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(84,'Optional object-oriented budgetarymanagement','LT718524624674405038','Pigeon. \'I can hardly breathe.\' \'I can\'t help it,\' said the Caterpillar sternly. \'Explain yourself!\' \'I can\'t go no lower,\' said the Duchess: you\'d better finish the story for yourself.\' \'No, please.',491885,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(85,'Reduced dynamic core','LT858128798756644794','IS a Caucus-race?\' said Alice; \'it\'s laid for a great thistle, to keep herself from being broken. She hastily put down her anger as well as the jury wrote it down into its mouth and began bowing to.',664331,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(86,'Mandatory systematic migration','SE0929348919999445435352','However, this bottle does. I do it again and again.\' \'You are all pardoned.\' \'Come, THAT\'S a good deal worse off than before, as the question was evidently meant for her. \'Yes!\' shouted Alice. \'Come.',331644,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(87,'Polarised mission-critical functionalities','EE835835211748948535','March Hare said to the Mock Turtle. \'Hold your tongue, Ma!\' said the Hatter: \'I\'m on the stairs. Alice knew it was good practice to say \'creatures,\' you see, so many tea-things are put out here?\'.',415940,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(88,'Diverse tertiary encryption','CZ9728326656414141131651','Cat remarked. \'Don\'t be impertinent,\' said the Mock Turtle, and to stand on your head-- Do you think I can creep under the window, and on it were white, but there were three gardeners who were.',854808,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(89,'Customer-focused bandwidth-monitored synergy','GT7923H7IOR5F7SW0MYK495772YH','Alice gently remarked; \'they\'d have been a holiday?\' \'Of course they were\', said the Cat. \'I said pig,\' replied Alice; \'and I wish you were or might have been that,\' said the Cat. \'--so long as it.',355482,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(90,'Networked context-sensitive pricingstructure','MC417499346066551D79CXR5161','Alice coming. \'There\'s PLENTY of room!\' said Alice timidly. \'Would you tell me,\' said Alice, who felt very curious to know when the White Rabbit, \'but it doesn\'t matter a bit,\' she thought it.',554413,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(91,'Centralized multimedia GraphicInterface','LV16INKW8Q429W4K2Y527','Hatter. \'Nor I,\' said the Mock Turtle a little startled when she found she could not possibly reach it: she could even make out that it was all about, and shouting \'Off with her arms folded,.',483049,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(92,'Multi-lateral zerodefect focusgroup','MK40722XDI5707U7C46','Alice replied very politely, \'if I had our Dinah here, I know THAT well enough; and what does it matter to me whether you\'re nervous or not.\' \'I\'m a poor man, your Majesty,\' said Alice doubtfully:.',369502,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(93,'Universal explicit concept','ME69559725866612232791','Was kindly permitted to pocket the spoon: While the Duchess sang the second thing is to find her in a rather offended tone, \'was, that the cause of this pool? I am now? That\'ll be a person of.',639427,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(94,'Facetoface even-keeled instructionset','BR1659070910147193418747442HW','Gryphon. \'They can\'t have anything to say, she simply bowed, and took the opportunity of adding, \'You\'re looking for eggs, I know I have to ask the question?\' said the Dodo said, \'EVERYBODY has won,.',403831,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(95,'Fundamental national migration','KZ643806D0332NGJLE8L','I!\' said the Duck: \'it\'s generally a ridge or furrow in the flurry of the jurymen. \'It isn\'t directed at all,\' said the King, the Queen, who was sitting on a little hot tea upon its forehead (the.',332998,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(96,'Profound multimedia securedline','MR2225665500823175161460817','I can creep under the hedge. In another moment down went Alice after it, never once considering how in the pictures of him), while the Mouse was speaking, and this time the Queen was in the.',494394,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(97,'Programmable zerotolerance strategy','PK94NBZOHL3FUKHD7CL1K38T','Presently she began again. \'I should have liked teaching it tricks very much, if--if I\'d only been the right word) \'--but I shall think nothing of the tea--\' \'The twinkling of the wood--(she.',528932,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(98,'Re-contextualized systematic core','HR4932070425424018988','After a time she had hurt the poor child, \'for I never knew so much already, that it would be very likely it can talk: at any rate I\'ll never go THERE again!\' said Alice indignantly, and she very.',700009,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(99,'Front-line asynchronous workforce','PK68EAUPN7EP44158J476GQ4','King in a hurry. \'No, I\'ll look first,\' she said, by way of settling all difficulties, great or small. \'Off with his head!\' or \'Off with her head!\' Those whom she sentenced were taken into custody.',385007,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(100,'Quality-focused 24/7 structure','IS679449369556343518737317','YOU with us!\"\' \'They were learning to draw,\' the Dormouse began in a frightened tone. \'The Queen of Hearts, she made some tarts, All on a little recovered from the Gryphon, and all sorts of.',628473,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(101,'Cross-group high-level budgetarymanagement','AD5950352078G342N3B6F3WB','When I used to do:-- \'How doth the little door, had vanished completely. Very soon the Rabbit say, \'A barrowful will do, to begin with,\' said the Duchess, the Duchess! Oh! won\'t she be savage if.',696537,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(102,'Reactive zerodefect ability','DE78266925468406054121','HAVE tasted eggs, certainly,\' said Alice indignantly. \'Ah! then yours wasn\'t a really good school,\' said the King. The next witness would be worth the trouble of getting up and to stand on your.',407243,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(103,'Down-sized bandwidth-monitored task-force','ES1461943444568821487492','ARE OLD, FATHER WILLIAM,\"\' said the Caterpillar. \'Well, perhaps you haven\'t found it very hard indeed to make out exactly what they WILL do next! If they had settled down in a low voice, \'Why the.',899263,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(104,'Networked optimizing matrix','MT80BVOO29506EZV8GT48BSJ67M77Y2','King put on his slate with one eye; \'I seem to dry me at home! Why, I do so like that curious song about the crumbs,\' said the Mock Turtle went on, half to herself, as she could. \'The Dormouse is.',804127,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(105,'Expanded background analyzer','SA371526826E8045NA586945','March Hare. \'It was much pleasanter at home,\' thought poor Alice, \'when one wasn\'t always growing larger and smaller, and being ordered about in all my limbs very supple By the use of repeating all.',842004,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(106,'Inverse intangible task-force','PS97NLOQQ9OM2VS73052O7BRHK94W','Majesty,\' said the Dormouse; \'VERY ill.\' Alice tried to open her mouth; but she got into the roof of the evening, beautiful Soup! Beau--ootiful Soo--oop! Soo--oop of the court with a knife, it.',307455,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(107,'Extended 6thgeneration knowledgebase','CR4694782704634013739','Hatter, who turned pale and fidgeted. \'Give your evidence,\' said the King. \'It began with the bones and the Queen\'s hedgehog just now, only it ran away when it saw Alice. It looked good-natured, she.',745406,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(108,'Multi-channelled transitional synergy','AD3542634114Y0K7W7M3K97Z','Alice. \'Call it what you were me?\' \'Well, perhaps you haven\'t found it so quickly that the best thing to eat the comfits: this caused some noise and confusion, as the large birds complained that.',410668,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(109,'Grass-roots full-range interface','GB46AMUD61844111218021','Alice did not like to have changed since her swim in the air: it puzzled her a good way off, panting, with its legs hanging down, but generally, just as usual. \'Come, there\'s no use denying it. I.',659286,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(110,'Total 4thgeneration infrastructure','BA982075765850826996','As she said to herself that perhaps it was too slippery; and when she found a little bit of the players to be a great deal too far off to the tarts on the trumpet, and then quietly marched off after.',428627,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(111,'Sharable scalable data-warehouse','GI68SRGM37A0S9UY2C3JT14','White Rabbit, who said in a frightened tone. \'The Queen of Hearts, who only bowed and smiled in reply. \'Idiot!\' said the Gryphon. \'I mean, what makes them sour--and camomile that makes people.',774285,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(112,'Object-based cohesive localareanetwork','PT86380437780119733428268','He says it kills all the things between whiles.\' \'Then you shouldn\'t talk,\' said the Eaglet. \'I don\'t think they play at all for any lesson-books!\' And so it was too much overcome to do that,\' said.',730540,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(113,'Synchronised contextually-based synergy','AT755424312464348524','I suppose?\' said Alice. \'Why, SHE,\' said the Mock Turtle: \'why, if a dish or kettle had been anything near the centre of the tail, and ending with the edge of her knowledge. \'Just think of anything.',370008,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(114,'Intuitive executive moratorium','BR5471097727900040871875268S5','Soon her eye fell upon a Gryphon, lying fast asleep in the way wherever she wanted much to know, but the Dodo solemnly presented the thimble, saying \'We beg your pardon,\' said Alice indignantly, and.',567991,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(115,'Innovative user-facing internetsolution','DE34282134021476149052','Hatter: \'let\'s all move one place on.\' He moved on as he spoke, \'we were trying--\' \'I see!\' said the White Rabbit, jumping up and beg for its dinner, and all the rest, Between yourself and me.\'.',389494,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(116,'Phased 24hour neural-net','DO03911Y45353440956927463388','Alice did not get hold of its mouth, and addressed her in such a very little! Besides, SHE\'S she, and I\'m I, and--oh dear, how puzzling it all seemed quite dull and stupid for life to go near the.',759067,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(117,'Distributed contextually-based methodology','GI45BYDYMRIY2C00NUZ14J6','King said to live. \'I\'ve seen hatters before,\' she said this, she came in with a great deal too far off to the Dormouse, and repeated her question. \'Why did they live at the moment, \'My dear! I.',899802,0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(118,'Business-focused zerotolerance artificialintelligence','MD609V2RWS294UO7LS7M5473','Off with his tea spoon at the place where it had gone. \'Well! I\'ve often seen a rabbit with either a waistcoat-pocket, or a serpent?\' \'It matters a good deal worse off than before, as the March.',492275,1,'0000-00-00 00:00:00','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `servicios__servicios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `setting__setting_translations`
--

DROP TABLE IF EXISTS `setting__setting_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `setting__setting_translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `setting_id` int(10) unsigned NOT NULL,
  `locale` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `setting__setting_translations_setting_id_locale_unique` (`setting_id`,`locale`),
  KEY `setting__setting_translations_locale_index` (`locale`),
  CONSTRAINT `setting__setting_translations_setting_id_foreign` FOREIGN KEY (`setting_id`) REFERENCES `setting__settings` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `setting__setting_translations`
--

LOCK TABLES `setting__setting_translations` WRITE;
/*!40000 ALTER TABLE `setting__setting_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `setting__setting_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `setting__settings`
--

DROP TABLE IF EXISTS `setting__settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `setting__settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `plainValue` text COLLATE utf8_unicode_ci,
  `isTranslatable` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `setting__settings_name_unique` (`name`),
  KEY `setting__settings_name_index` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `setting__settings`
--

LOCK TABLES `setting__settings` WRITE;
/*!40000 ALTER TABLE `setting__settings` DISABLE KEYS */;
INSERT INTO `setting__settings` VALUES (1,'core::template','Flatly',0,'2017-08-28 06:13:43','2017-08-28 06:13:43'),(2,'core::locales','[\"en\"]',0,'2017-08-28 06:13:43','2017-08-28 06:13:43');
/*!40000 ALTER TABLE `setting__settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `throttle`
--

DROP TABLE IF EXISTS `throttle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `throttle` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `throttle_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `throttle`
--

LOCK TABLES `throttle` WRITE;
/*!40000 ALTER TABLE `throttle` DISABLE KEYS */;
/*!40000 ALTER TABLE `throttle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `translation__translation_translations`
--

DROP TABLE IF EXISTS `translation__translation_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `translation__translation_translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `value` text COLLATE utf8_unicode_ci NOT NULL,
  `translation_id` int(10) unsigned NOT NULL,
  `locale` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `translations_trans_id_locale_unique` (`translation_id`,`locale`),
  KEY `translation__translation_translations_locale_index` (`locale`),
  CONSTRAINT `translation__translation_translations_translation_id_foreign` FOREIGN KEY (`translation_id`) REFERENCES `translation__translations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `translation__translation_translations`
--

LOCK TABLES `translation__translation_translations` WRITE;
/*!40000 ALTER TABLE `translation__translation_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `translation__translation_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `translation__translations`
--

DROP TABLE IF EXISTS `translation__translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `translation__translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `translation__translations_key_index` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `translation__translations`
--

LOCK TABLES `translation__translations` WRITE;
/*!40000 ALTER TABLE `translation__translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `translation__translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `permissions` text COLLATE utf8_unicode_ci,
  `last_login` timestamp NULL DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'zentcode@zentcode.com','$2y$10$aZ8B44ivUh1f0spHQtqNCuTCUINAbwnRXv0K9FDhjIGcoLYFW0Gl6',NULL,'2017-08-29 13:50:59','zent','code','2017-08-28 06:13:42','2017-08-29 13:50:59'),(2,'prueba1@prueba1.com','$2y$10$luqT2Go5y1fLkBpehQ3n1.XofnguTYnUPur2zCyj3YpRZ6UIyIX7W','{\"caja.cajas.index\":true,\"caja.cajas.create\":true,\"caja.cajas.store\":true,\"caja.cajas.edit\":true,\"caja.cajas.update\":true,\"caja.cajas.destroy\":true,\"caja.cajas.index_ajax\":true,\"caja.cajas.pdf\":true,\"caja.cajas.index_movimientos\":true,\"caja.cajas.create_movimiento\":true,\"caja.cajas.store_movimiento\":true,\"caja.cajas.edit_movimiento\":true,\"caja.cajas.update_movimiento\":true,\"caja.cajas.index_movimientos_activo\":true,\"caja.cajas.index_cajas\":true,\"clientes.clientes.index\":true,\"clientes.clientes.create\":true,\"clientes.clientes.store\":true,\"clientes.clientes.edit\":true,\"clientes.clientes.update\":true,\"clientes.clientes.destroy\":true,\"clientes.clientes.index_ajax\":true,\"clientes.clientes.search_cliente\":true,\"clientes.clientes.upload_cliente_xls\":true,\"clientes.clientes.upload_cliente_xls_store\":true,\"clientes.clientes.descargar_ejemplo\":true,\"Permisos Especiales Clientes.Ver boton de cargar clientes desde excel\":true,\"Permisos Especiales Clientes.Ver boton de descargar ejemplo excel\":true,\"compras.compras.index\":true,\"compras.compras.create\":true,\"compras.compras.store\":true,\"compras.compras.edit\":true,\"compras.compras.update\":true,\"compras.compras.destroy\":true,\"compras.compras.seleccion\":true,\"compras.compras.index_ajax\":true,\"compras.compras.edit_config_factura\":true,\"compras.compras.update_config_factura\":true,\"compras.compras.reporte_gastos_performance\":true,\"compras.compras.reporte_gastos\":true,\"compras.compras.reporte_gastos_ajax\":true,\"compras.compras.categorias_reporte_gastos_ajax\":true,\"compras.compras.reporte_xls\":true,\"compras.compras.categorias_reporte_xls\":true,\"compras.compras.index_pendientes\":true,\"compras.compras.factura\":true,\"compras.compras.factura_update\":true,\"compras.compras.pago_create\":true,\"compras.compras.pago_store\":true,\"compras.compras.cuenta_change\":true,\"compras.detallecompras.index\":true,\"compras.detallecompras.create\":true,\"compras.detallecompras.store\":true,\"compras.detallecompras.edit\":true,\"compras.detallecompras.update\":true,\"compras.detallecompras.destroy\":true,\"compras.comprapago.destroypago\":true,\"Permisos Especiales Compras.Ver detalles de otras compras\":true,\"contabilidad.tipocuentas.index\":true,\"contabilidad.tipocuentas.create\":true,\"contabilidad.tipocuentas.store\":true,\"contabilidad.tipocuentas.edit\":true,\"contabilidad.tipocuentas.update\":true,\"contabilidad.tipocuentas.destroy\":true,\"contabilidad.cuentas.index\":true,\"contabilidad.cuentas.create\":true,\"contabilidad.cuentas.store\":true,\"contabilidad.cuentas.edit\":true,\"contabilidad.cuentas.update\":true,\"contabilidad.cuentas.destroy\":true,\"contabilidad.cuentas.search_padre\":true,\"contabilidad.cuentas.search_cuenta_asiento\":true,\"contabilidad.cuentas.index_ajax_filter\":true,\"contabilidad.cuentas.historial\":true,\"contabilidad.cuentas.historial_ajax\":true,\"contabilidad.cuentas.historial_excel\":true,\"contabilidad.cuentas.historial-solo-caja-ita\":true,\"contabilidad.cuentas.cuenta_exist\":true,\"contabilidad.asientos.index\":true,\"contabilidad.asientos.create\":true,\"contabilidad.asientos.store\":true,\"contabilidad.asientos.edit\":true,\"contabilidad.asientos.update\":true,\"contabilidad.asientos.destroy\":true,\"contabilidad.asientos.index_ajax_asientos\":true,\"contabilidad.asientos.anular\":true,\"contabilidad.asientodetalles.index\":true,\"contabilidad.asientodetalles.create\":true,\"contabilidad.asientodetalles.store\":true,\"contabilidad.asientodetalles.edit\":true,\"contabilidad.asientodetalles.update\":true,\"contabilidad.asientodetalles.destroy\":true,\"contabilidad.ejercicio.index\":true,\"contabilidad.ejercicio.create\":true,\"contabilidad.ejercicio.store\":true,\"contabilidad.ejercicio.edit\":true,\"contabilidad.ejercicio.update\":true,\"contabilidad.ejercicio.destroy\":true,\"contabilidad.reportes.libro_mayor\":true,\"contabilidad.reportes.libro_mayor_index\":true,\"contabilidad.reportes.libro_mayor_pdf\":true,\"contabilidad.reportes.libro_mayor_xls\":true,\"contabilidad.reportes.balance\":true,\"contabilidad.reportes.balance_activos\":true,\"contabilidad.reportes.balance_pasivos\":true,\"contabilidad.reportes.balance_patrimonio\":true,\"contabilidad.reportes.balance_pdf\":true,\"contabilidad.reportes.estado_resultado\":true,\"contabilidad.reportes.estado_resultado_ingresos\":true,\"contabilidad.reportes.estado_resultado_egresos\":true,\"contabilidad.reportes.estado_resultado_pdf\":true,\"contabilidad.reportes.libro_venta\":true,\"contabilidad.reportes.libro_venta_pdf\":true,\"contabilidad.reportes.libro_venta_excel\":true,\"contabilidad.reportes.libro_compra\":true,\"contabilidad.reportes.libro_compra_pdf\":true,\"contabilidad.reportes.libro_compra_excel\":true,\"contabilidad.reportes.ingreso_egreso\":true,\"contabilidad.reportes.ingreso_egreso_ajax\":true,\"contabilidad.reportes.ingreso_egreso_xls\":true,\"contabilidad.reportes.ingreso_egreso_config\":true,\"contabilidad.reportes.flujo_caja\":true,\"contabilidad.reportes.flujo_caja_config\":true,\"contabilidad.reportes.libro_compra_performance\":true,\"contabilidad.reportes.libro_venta_performance\":true,\"contabilidad.reportes.cajas\":true,\"contabilidad.reportes.flujo_efectivo\":true,\"contabilidad.reportes.flujo_efectivo_ajax\":true,\"contabilidad.reportes.flujo_efectivo_excel\":true,\"contabilidad.reportes.flujo_efectivo_detalles\":true,\"contabilidad.reportes.flujo_efectivo_detalles_ajax\":true,\"contabilidad.reportes.flujo_efectivo_detalles_excel\":true,\"Permisos Especiales Contabilidad.Ver Contabilidad en Sidebar\":true,\"Permisos Especiales Reportes.Ver Reportes en Sidebar\":true,\"dashboard.grid.save\":true,\"dashboard.grid.reset\":true,\"dashboard.index\":true,\"dashboard.ejercicio.ejercicio\":true,\"empleados.empleados.index\":true,\"empleados.empleados.create\":true,\"empleados.empleados.store\":true,\"empleados.empleados.edit\":true,\"empleados.empleados.update\":true,\"empleados.empleados.destroy\":true,\"empleados.empleados.indexAjax\":true,\"empleados.pagoempleados.index\":true,\"empleados.pagoempleados.create\":true,\"empleados.pagoempleados.store\":true,\"empleados.pagoempleados.edit\":true,\"empleados.pagoempleados.update\":true,\"empleados.pagoempleados.destroy\":true,\"empleados.pagoempleados.indexAjax\":true,\"empleados.pagoempleados.seleccionEmpleado\":true,\"empleados.pagoempleados.anular_asientos\":true,\"empleados.anticipos.index\":true,\"empleados.anticipos.create\":true,\"empleados.anticipos.store\":true,\"empleados.anticipos.edit\":true,\"empleados.anticipos.update\":true,\"empleados.anticipos.anular\":true,\"Permisos Especiales Empleados.Ver Empleados en Sidebar\":true,\"media.media.index\":true,\"media.media.create\":true,\"media.media.store\":true,\"media.media.edit\":true,\"media.media.update\":true,\"media.media.destroy\":true,\"media.media-grid.index\":true,\"media.media-grid.ckIndex\":true,\"menu.menus.index\":true,\"menu.menus.create\":true,\"menu.menus.store\":true,\"menu.menus.edit\":true,\"menu.menus.update\":true,\"menu.menus.destroy\":true,\"menu.menuitem.index\":true,\"menu.menuitem.create\":true,\"menu.menuitem.store\":true,\"menu.menuitem.edit\":true,\"menu.menuitem.update\":true,\"menu.menuitem.destroy\":true,\"page.pages.index\":true,\"page.pages.create\":true,\"page.pages.store\":true,\"page.pages.edit\":true,\"page.pages.update\":true,\"page.pages.destroy\":true,\"pagofacturascredito.pagofacturacreditos.index\":true,\"pagofacturascredito.pagofacturacreditos.create\":true,\"pagofacturascredito.pagofacturacreditos.store\":true,\"pagofacturascredito.pagofacturacreditos.edit\":true,\"pagofacturascredito.pagofacturacreditos.update\":true,\"pagofacturascredito.pagofacturacreditos.destroy\":true,\"pagofacturascredito.pagofacturacreditos.index_ajax\":true,\"productos.categoriaproductos.index\":true,\"productos.categoriaproductos.create\":true,\"productos.categoriaproductos.store\":true,\"productos.categoriaproductos.edit\":true,\"productos.categoriaproductos.update\":true,\"productos.categoriaproductos.destroy\":true,\"productos.productos.index\":true,\"productos.productos.create\":true,\"productos.productos.store\":true,\"productos.productos.edit\":true,\"productos.productos.update\":true,\"productos.productos.destroy\":true,\"productos.productos.search_producto\":true,\"productos.productos.index_ajax\":true,\"productos.productos.inventario_producto_pdf\":true,\"productos.productos.inventario_producto_performance\":true,\"productos.productos.productos_vendidos\":true,\"productos.productos.productos_vendidos_ajax\":true,\"productos.productos.productos_vendidos_query\":true,\"productos.productos.productos_vendidos_xls\":true,\"productos.productos.index_stock_critico\":true,\"productos.productos.cargar_productos_desde_excel\":true,\"productos.productos.store_productos_desde_excel\":true,\"productos.marcas.index\":true,\"productos.marcas.create\":true,\"productos.marcas.store\":true,\"productos.marcas.edit\":true,\"productos.marcas.update\":true,\"productos.marcas.destroy\":true,\"productos.altabajaproductos.index\":true,\"productos.altabajaproductos.create\":true,\"productos.altabajaproductos.store\":true,\"productos.altabajaproductos.edit\":true,\"productos.altabajaproductos.update\":true,\"productos.altabajaproductos.destroy\":true,\"productos.altabajaproductos.seleccionProductos\":true,\"productos.altabajaproductos.indexAjax\":true,\"Permisos Especiales Productos.Ver Precios de Compra\":true,\"proveedores.proveedors.index\":true,\"proveedores.proveedors.create\":true,\"proveedores.proveedors.store\":true,\"proveedores.proveedors.edit\":true,\"proveedores.proveedors.update\":true,\"proveedores.proveedors.destroy\":true,\"proveedores.proveedors.indexAjax\":true,\"proveedores.proveedors.search_proveedor\":true,\"servicios.servicios.index\":true,\"servicios.servicios.create\":true,\"servicios.servicios.store\":true,\"servicios.servicios.edit\":true,\"servicios.servicios.update\":true,\"servicios.servicios.destroy\":true,\"servicios.servicios.indexAjax\":true,\"servicios.servicios.search_servicio\":true,\"setting.settings.index\":true,\"setting.settings.getModuleSettings\":true,\"setting.settings.store\":true,\"translation.translations.index\":true,\"translation.translations.update\":true,\"translation.translations.export\":true,\"translation.translations.import\":true,\"user.users.index\":true,\"user.users.create\":true,\"user.users.store\":true,\"user.users.edit\":true,\"user.users.update\":true,\"user.users.destroy\":true,\"user.users.backup\":true,\"user.roles.index\":true,\"user.roles.create\":true,\"user.roles.store\":true,\"user.roles.edit\":true,\"user.roles.update\":true,\"user.roles.destroy\":true,\"ventas.ventas.index\":true,\"ventas.ventas.create\":true,\"ventas.ventas.store\":true,\"ventas.ventas.edit\":true,\"ventas.ventas.update\":true,\"ventas.ventas.destroy\":true,\"ventas.ventas.search_venta_cliente\":true,\"ventas.ventas.search_venta_producto\":true,\"ventas.ventas.search_venta_servicio\":true,\"ventas.ventas.search_venta_cristal\":true,\"ventas.ventas.detalle_venta_ajax\":true,\"ventas.ventas.seleccion\":true,\"ventas.ventas.indexAjax\":true,\"ventas.ventas.nro_seguimiento_exist\":true,\"ventas.ventas.edit_nro_seguimiento\":true,\"ventas.ventas.update_nro_seguimiento\":true,\"ventas.ventas.reporte\":true,\"ventas.ventas.reporte_ajax\":true,\"ventas.ventas.reporte_pdf\":true,\"ventas.ventas.reporte_xls\":true,\"ventas.ventas.query_reporte\":true,\"ventas.ventas.reporte_ganancias\":true,\"ventas.ventas.reporte_ganancias_ajax\":true,\"ventas.ventas.reporte_ganancias_query\":true,\"ventas.ventas.reporte_ganancias_xls\":true,\"ventas.ventas.index_preventa\":true,\"ventas.ventas.anular_factura\":true,\"ventas.ventas.cuenta_change\":true,\"ventas.ventas.anular_asientos_preventa\":true,\"ventas.ventas.preventa_agregar_items\":true,\"ventas.detalleventas.index\":true,\"ventas.detalleventas.create\":true,\"ventas.detalleventas.store\":true,\"ventas.detalleventas.edit\":true,\"ventas.detalleventas.update\":true,\"ventas.detalleventas.destroy\":true,\"ventas.facturaventas.index\":true,\"ventas.facturaventas.create\":true,\"ventas.facturaventas.store\":true,\"ventas.facturaventas.edit\":true,\"ventas.facturaventas.update\":true,\"ventas.facturaventas.destroy\":true,\"ventas.facturaventas.edit_nro_factura\":true,\"ventas.facturaventas.update_nro_factura\":true,\"ventas.facturaventas.index_ajax\":true,\"ventas.facturaventas.generar_facturas_vacias\":true,\"ventas.facturaventas.crear_facturas_vacias\":true,\"ventas.otras_ventas.index\":true,\"ventas.otras_ventas.index_ajax\":true,\"Permisos Especiales Ventas.Editar nro de sobre en Completar Venta\":true,\"visitas.visitas.index\":true,\"visitas.visitas.create\":true,\"visitas.visitas.store\":true,\"visitas.visitas.edit\":true,\"visitas.visitas.update\":true,\"visitas.visitas.destroy\":true,\"visitas.visitas.agregar_productos\":true,\"visitas.visitas.visita_productos_ajax\":true,\"visitas.visitas.index_ajax\":true,\"visitas.visitas.update_ajax\":true,\"visitas.visitas.destroy_ajax\":true,\"visitas.visitas.resumen\":true,\"visitas.stockretirados.index\":true,\"visitas.stockretirados.create\":true,\"visitas.stockretirados.store\":true,\"visitas.stockretirados.edit\":true,\"visitas.stockretirados.update\":true,\"visitas.stockretirados.destroy\":true,\"visitas.stockretirados.destroy_ajax\":true,\"visitas.comisiones.index\":true,\"visitas.comisiones.index_ajax\":true,\"visitas.comisiones.marcar_comisiones\":true,\"workshop.modules.index\":true,\"workshop.modules.show\":true,\"workshop.modules.disable\":true,\"workshop.modules.enable\":true,\"workshop.themes.index\":true,\"workshop.themes.show\":true}','2017-08-29 13:51:12','prueba1','prueba1','2017-08-29 12:06:10','2017-08-29 13:51:12'),(3,'prueba2@prueba2.com','$2y$10$fAhak8rUVm/omEIB1CotQutI3HwxFRTTUXzDcRuqH4fXfR0w5.alW','{\"caja.cajas.index\":true,\"caja.cajas.create\":true,\"caja.cajas.store\":true,\"caja.cajas.edit\":true,\"caja.cajas.update\":true,\"caja.cajas.destroy\":true,\"caja.cajas.index_ajax\":true,\"caja.cajas.pdf\":true,\"caja.cajas.index_movimientos\":true,\"caja.cajas.create_movimiento\":true,\"caja.cajas.store_movimiento\":true,\"caja.cajas.edit_movimiento\":true,\"caja.cajas.update_movimiento\":true,\"caja.cajas.index_movimientos_activo\":true,\"caja.cajas.index_cajas\":true,\"clientes.clientes.index\":true,\"clientes.clientes.create\":true,\"clientes.clientes.store\":true,\"clientes.clientes.edit\":true,\"clientes.clientes.update\":true,\"clientes.clientes.destroy\":true,\"clientes.clientes.index_ajax\":true,\"clientes.clientes.search_cliente\":true,\"clientes.clientes.upload_cliente_xls\":true,\"clientes.clientes.upload_cliente_xls_store\":true,\"clientes.clientes.descargar_ejemplo\":true,\"Permisos Especiales Clientes.Ver boton de cargar clientes desde excel\":true,\"Permisos Especiales Clientes.Ver boton de descargar ejemplo excel\":true,\"compras.compras.index\":true,\"compras.compras.create\":true,\"compras.compras.store\":true,\"compras.compras.edit\":true,\"compras.compras.update\":true,\"compras.compras.destroy\":true,\"compras.compras.seleccion\":true,\"compras.compras.index_ajax\":true,\"compras.compras.edit_config_factura\":true,\"compras.compras.update_config_factura\":true,\"compras.compras.reporte_gastos_performance\":true,\"compras.compras.reporte_gastos\":true,\"compras.compras.reporte_gastos_ajax\":true,\"compras.compras.categorias_reporte_gastos_ajax\":true,\"compras.compras.reporte_xls\":true,\"compras.compras.categorias_reporte_xls\":true,\"compras.compras.index_pendientes\":true,\"compras.compras.factura\":true,\"compras.compras.factura_update\":true,\"compras.compras.pago_create\":true,\"compras.compras.pago_store\":true,\"compras.compras.cuenta_change\":true,\"compras.detallecompras.index\":true,\"compras.detallecompras.create\":true,\"compras.detallecompras.store\":true,\"compras.detallecompras.edit\":true,\"compras.detallecompras.update\":true,\"compras.detallecompras.destroy\":true,\"compras.comprapago.destroypago\":true,\"Permisos Especiales Compras.Ver detalles de otras compras\":true,\"contabilidad.tipocuentas.index\":true,\"contabilidad.tipocuentas.create\":true,\"contabilidad.tipocuentas.store\":true,\"contabilidad.tipocuentas.edit\":true,\"contabilidad.tipocuentas.update\":true,\"contabilidad.tipocuentas.destroy\":true,\"contabilidad.cuentas.index\":true,\"contabilidad.cuentas.create\":true,\"contabilidad.cuentas.store\":true,\"contabilidad.cuentas.edit\":true,\"contabilidad.cuentas.update\":true,\"contabilidad.cuentas.destroy\":true,\"contabilidad.cuentas.search_padre\":true,\"contabilidad.cuentas.search_cuenta_asiento\":true,\"contabilidad.cuentas.index_ajax_filter\":true,\"contabilidad.cuentas.historial\":true,\"contabilidad.cuentas.historial_ajax\":true,\"contabilidad.cuentas.historial_excel\":true,\"contabilidad.cuentas.historial-solo-caja-ita\":true,\"contabilidad.cuentas.cuenta_exist\":true,\"contabilidad.asientos.index\":true,\"contabilidad.asientos.create\":true,\"contabilidad.asientos.store\":true,\"contabilidad.asientos.edit\":true,\"contabilidad.asientos.update\":true,\"contabilidad.asientos.destroy\":true,\"contabilidad.asientos.index_ajax_asientos\":true,\"contabilidad.asientos.anular\":true,\"contabilidad.asientodetalles.index\":true,\"contabilidad.asientodetalles.create\":true,\"contabilidad.asientodetalles.store\":true,\"contabilidad.asientodetalles.edit\":true,\"contabilidad.asientodetalles.update\":true,\"contabilidad.asientodetalles.destroy\":true,\"contabilidad.ejercicio.index\":true,\"contabilidad.ejercicio.create\":true,\"contabilidad.ejercicio.store\":true,\"contabilidad.ejercicio.edit\":true,\"contabilidad.ejercicio.update\":true,\"contabilidad.ejercicio.destroy\":true,\"contabilidad.reportes.libro_mayor\":true,\"contabilidad.reportes.libro_mayor_index\":true,\"contabilidad.reportes.libro_mayor_pdf\":true,\"contabilidad.reportes.libro_mayor_xls\":true,\"contabilidad.reportes.balance\":true,\"contabilidad.reportes.balance_activos\":true,\"contabilidad.reportes.balance_pasivos\":true,\"contabilidad.reportes.balance_patrimonio\":true,\"contabilidad.reportes.balance_pdf\":true,\"contabilidad.reportes.estado_resultado\":true,\"contabilidad.reportes.estado_resultado_ingresos\":true,\"contabilidad.reportes.estado_resultado_egresos\":true,\"contabilidad.reportes.estado_resultado_pdf\":true,\"contabilidad.reportes.libro_venta\":true,\"contabilidad.reportes.libro_venta_pdf\":true,\"contabilidad.reportes.libro_venta_excel\":true,\"contabilidad.reportes.libro_compra\":true,\"contabilidad.reportes.libro_compra_pdf\":true,\"contabilidad.reportes.libro_compra_excel\":true,\"contabilidad.reportes.ingreso_egreso\":true,\"contabilidad.reportes.ingreso_egreso_ajax\":true,\"contabilidad.reportes.ingreso_egreso_xls\":true,\"contabilidad.reportes.ingreso_egreso_config\":true,\"contabilidad.reportes.flujo_caja\":true,\"contabilidad.reportes.flujo_caja_config\":true,\"contabilidad.reportes.libro_compra_performance\":true,\"contabilidad.reportes.libro_venta_performance\":true,\"contabilidad.reportes.cajas\":true,\"contabilidad.reportes.flujo_efectivo\":true,\"contabilidad.reportes.flujo_efectivo_ajax\":true,\"contabilidad.reportes.flujo_efectivo_excel\":true,\"contabilidad.reportes.flujo_efectivo_detalles\":true,\"contabilidad.reportes.flujo_efectivo_detalles_ajax\":true,\"contabilidad.reportes.flujo_efectivo_detalles_excel\":true,\"Permisos Especiales Contabilidad.Ver Contabilidad en Sidebar\":true,\"Permisos Especiales Reportes.Ver Reportes en Sidebar\":true,\"dashboard.grid.save\":true,\"dashboard.grid.reset\":true,\"dashboard.index\":true,\"dashboard.ejercicio.ejercicio\":true,\"empleados.empleados.index\":true,\"empleados.empleados.create\":true,\"empleados.empleados.store\":true,\"empleados.empleados.edit\":true,\"empleados.empleados.update\":true,\"empleados.empleados.destroy\":true,\"empleados.empleados.indexAjax\":true,\"empleados.pagoempleados.index\":true,\"empleados.pagoempleados.create\":true,\"empleados.pagoempleados.store\":true,\"empleados.pagoempleados.edit\":true,\"empleados.pagoempleados.update\":true,\"empleados.pagoempleados.destroy\":true,\"empleados.pagoempleados.indexAjax\":true,\"empleados.pagoempleados.seleccionEmpleado\":true,\"empleados.pagoempleados.anular_asientos\":true,\"empleados.anticipos.index\":true,\"empleados.anticipos.create\":true,\"empleados.anticipos.store\":true,\"empleados.anticipos.edit\":true,\"empleados.anticipos.update\":true,\"empleados.anticipos.anular\":true,\"Permisos Especiales Empleados.Ver Empleados en Sidebar\":true,\"media.media.index\":true,\"media.media.create\":true,\"media.media.store\":true,\"media.media.edit\":true,\"media.media.update\":true,\"media.media.destroy\":true,\"media.media-grid.index\":true,\"media.media-grid.ckIndex\":true,\"menu.menus.index\":true,\"menu.menus.create\":true,\"menu.menus.store\":true,\"menu.menus.edit\":true,\"menu.menus.update\":true,\"menu.menus.destroy\":true,\"menu.menuitem.index\":true,\"menu.menuitem.create\":true,\"menu.menuitem.store\":true,\"menu.menuitem.edit\":true,\"menu.menuitem.update\":true,\"menu.menuitem.destroy\":true,\"page.pages.index\":true,\"page.pages.create\":true,\"page.pages.store\":true,\"page.pages.edit\":true,\"page.pages.update\":true,\"page.pages.destroy\":true,\"pagofacturascredito.pagofacturacreditos.index\":true,\"pagofacturascredito.pagofacturacreditos.create\":true,\"pagofacturascredito.pagofacturacreditos.store\":true,\"pagofacturascredito.pagofacturacreditos.edit\":true,\"pagofacturascredito.pagofacturacreditos.update\":true,\"pagofacturascredito.pagofacturacreditos.destroy\":true,\"pagofacturascredito.pagofacturacreditos.index_ajax\":true,\"productos.categoriaproductos.index\":true,\"productos.categoriaproductos.create\":true,\"productos.categoriaproductos.store\":true,\"productos.categoriaproductos.edit\":true,\"productos.categoriaproductos.update\":true,\"productos.categoriaproductos.destroy\":true,\"productos.productos.index\":true,\"productos.productos.create\":true,\"productos.productos.store\":true,\"productos.productos.edit\":true,\"productos.productos.update\":true,\"productos.productos.destroy\":true,\"productos.productos.search_producto\":true,\"productos.productos.index_ajax\":true,\"productos.productos.inventario_producto_pdf\":true,\"productos.productos.inventario_producto_performance\":true,\"productos.productos.productos_vendidos\":true,\"productos.productos.productos_vendidos_ajax\":true,\"productos.productos.productos_vendidos_query\":true,\"productos.productos.productos_vendidos_xls\":true,\"productos.productos.index_stock_critico\":true,\"productos.productos.cargar_productos_desde_excel\":true,\"productos.productos.store_productos_desde_excel\":true,\"productos.marcas.index\":true,\"productos.marcas.create\":true,\"productos.marcas.store\":true,\"productos.marcas.edit\":true,\"productos.marcas.update\":true,\"productos.marcas.destroy\":true,\"productos.altabajaproductos.index\":true,\"productos.altabajaproductos.create\":true,\"productos.altabajaproductos.store\":true,\"productos.altabajaproductos.edit\":true,\"productos.altabajaproductos.update\":true,\"productos.altabajaproductos.destroy\":true,\"productos.altabajaproductos.seleccionProductos\":true,\"productos.altabajaproductos.indexAjax\":true,\"Permisos Especiales Productos.Ver Precios de Compra\":true,\"proveedores.proveedors.index\":true,\"proveedores.proveedors.create\":true,\"proveedores.proveedors.store\":true,\"proveedores.proveedors.edit\":true,\"proveedores.proveedors.update\":true,\"proveedores.proveedors.destroy\":true,\"proveedores.proveedors.indexAjax\":true,\"proveedores.proveedors.search_proveedor\":true,\"servicios.servicios.index\":true,\"servicios.servicios.create\":true,\"servicios.servicios.store\":true,\"servicios.servicios.edit\":true,\"servicios.servicios.update\":true,\"servicios.servicios.destroy\":true,\"servicios.servicios.indexAjax\":true,\"servicios.servicios.search_servicio\":true,\"setting.settings.index\":true,\"setting.settings.getModuleSettings\":true,\"setting.settings.store\":true,\"translation.translations.index\":true,\"translation.translations.update\":true,\"translation.translations.export\":true,\"translation.translations.import\":true,\"user.users.index\":true,\"user.users.create\":true,\"user.users.store\":true,\"user.users.edit\":true,\"user.users.update\":true,\"user.users.destroy\":true,\"user.users.backup\":true,\"user.roles.index\":true,\"user.roles.create\":true,\"user.roles.store\":true,\"user.roles.edit\":true,\"user.roles.update\":true,\"user.roles.destroy\":true,\"ventas.ventas.index\":true,\"ventas.ventas.create\":true,\"ventas.ventas.store\":true,\"ventas.ventas.edit\":true,\"ventas.ventas.update\":true,\"ventas.ventas.destroy\":true,\"ventas.ventas.search_venta_cliente\":true,\"ventas.ventas.search_venta_producto\":true,\"ventas.ventas.search_venta_servicio\":true,\"ventas.ventas.search_venta_cristal\":true,\"ventas.ventas.detalle_venta_ajax\":true,\"ventas.ventas.seleccion\":true,\"ventas.ventas.indexAjax\":true,\"ventas.ventas.nro_seguimiento_exist\":true,\"ventas.ventas.edit_nro_seguimiento\":true,\"ventas.ventas.update_nro_seguimiento\":true,\"ventas.ventas.reporte\":true,\"ventas.ventas.reporte_ajax\":true,\"ventas.ventas.reporte_pdf\":true,\"ventas.ventas.reporte_xls\":true,\"ventas.ventas.query_reporte\":true,\"ventas.ventas.reporte_ganancias\":true,\"ventas.ventas.reporte_ganancias_ajax\":true,\"ventas.ventas.reporte_ganancias_query\":true,\"ventas.ventas.reporte_ganancias_xls\":true,\"ventas.ventas.index_preventa\":true,\"ventas.ventas.anular_factura\":true,\"ventas.ventas.cuenta_change\":true,\"ventas.ventas.anular_asientos_preventa\":true,\"ventas.ventas.preventa_agregar_items\":true,\"ventas.detalleventas.index\":true,\"ventas.detalleventas.create\":true,\"ventas.detalleventas.store\":true,\"ventas.detalleventas.edit\":true,\"ventas.detalleventas.update\":true,\"ventas.detalleventas.destroy\":true,\"ventas.facturaventas.index\":true,\"ventas.facturaventas.create\":true,\"ventas.facturaventas.store\":true,\"ventas.facturaventas.edit\":true,\"ventas.facturaventas.update\":true,\"ventas.facturaventas.destroy\":true,\"ventas.facturaventas.edit_nro_factura\":true,\"ventas.facturaventas.update_nro_factura\":true,\"ventas.facturaventas.index_ajax\":true,\"ventas.facturaventas.generar_facturas_vacias\":true,\"ventas.facturaventas.crear_facturas_vacias\":true,\"ventas.otras_ventas.index\":true,\"ventas.otras_ventas.index_ajax\":true,\"Permisos Especiales Ventas.Editar nro de sobre en Completar Venta\":true,\"visitas.visitas.index\":true,\"visitas.visitas.create\":true,\"visitas.visitas.store\":true,\"visitas.visitas.edit\":true,\"visitas.visitas.update\":true,\"visitas.visitas.destroy\":true,\"visitas.visitas.agregar_productos\":true,\"visitas.visitas.visita_productos_ajax\":true,\"visitas.visitas.index_ajax\":true,\"visitas.visitas.update_ajax\":true,\"visitas.visitas.destroy_ajax\":true,\"visitas.visitas.resumen\":true,\"visitas.stockretirados.index\":true,\"visitas.stockretirados.create\":true,\"visitas.stockretirados.store\":true,\"visitas.stockretirados.edit\":true,\"visitas.stockretirados.update\":true,\"visitas.stockretirados.destroy\":true,\"visitas.stockretirados.destroy_ajax\":true,\"visitas.comisiones.index\":true,\"visitas.comisiones.index_ajax\":true,\"visitas.comisiones.marcar_comisiones\":true,\"workshop.modules.index\":true,\"workshop.modules.show\":true,\"workshop.modules.disable\":true,\"workshop.modules.enable\":true,\"workshop.themes.index\":true,\"workshop.themes.show\":true}','2017-08-29 13:58:35','prueba2','prueba2','2017-08-29 12:14:48','2017-08-29 13:58:35'),(4,'prueba3@prueba3.com','$2y$10$VsVmw8CZy1axNLoANZyhsedYZtlx.jWX38bwaXMfBnKAGADMunYZG','{\"caja.cajas.index\":true,\"caja.cajas.create\":true,\"caja.cajas.store\":true,\"caja.cajas.edit\":true,\"caja.cajas.update\":true,\"caja.cajas.destroy\":true,\"caja.cajas.index_ajax\":true,\"caja.cajas.pdf\":true,\"caja.cajas.index_movimientos\":true,\"caja.cajas.create_movimiento\":true,\"caja.cajas.store_movimiento\":true,\"caja.cajas.edit_movimiento\":true,\"caja.cajas.update_movimiento\":true,\"caja.cajas.index_movimientos_activo\":true,\"caja.cajas.index_cajas\":true,\"clientes.clientes.index\":true,\"clientes.clientes.create\":true,\"clientes.clientes.store\":true,\"clientes.clientes.edit\":true,\"clientes.clientes.update\":true,\"clientes.clientes.destroy\":true,\"clientes.clientes.index_ajax\":true,\"clientes.clientes.search_cliente\":true,\"clientes.clientes.upload_cliente_xls\":true,\"clientes.clientes.upload_cliente_xls_store\":true,\"clientes.clientes.descargar_ejemplo\":true,\"Permisos Especiales Clientes.Ver boton de cargar clientes desde excel\":true,\"Permisos Especiales Clientes.Ver boton de descargar ejemplo excel\":true,\"compras.compras.index\":true,\"compras.compras.create\":true,\"compras.compras.store\":true,\"compras.compras.edit\":true,\"compras.compras.update\":true,\"compras.compras.destroy\":true,\"compras.compras.seleccion\":true,\"compras.compras.index_ajax\":true,\"compras.compras.edit_config_factura\":true,\"compras.compras.update_config_factura\":true,\"compras.compras.reporte_gastos_performance\":true,\"compras.compras.reporte_gastos\":true,\"compras.compras.reporte_gastos_ajax\":true,\"compras.compras.categorias_reporte_gastos_ajax\":true,\"compras.compras.reporte_xls\":true,\"compras.compras.categorias_reporte_xls\":true,\"compras.compras.index_pendientes\":true,\"compras.compras.factura\":true,\"compras.compras.factura_update\":true,\"compras.compras.pago_create\":true,\"compras.compras.pago_store\":true,\"compras.compras.cuenta_change\":true,\"compras.detallecompras.index\":true,\"compras.detallecompras.create\":true,\"compras.detallecompras.store\":true,\"compras.detallecompras.edit\":true,\"compras.detallecompras.update\":true,\"compras.detallecompras.destroy\":true,\"compras.comprapago.destroypago\":true,\"Permisos Especiales Compras.Ver detalles de otras compras\":true,\"contabilidad.tipocuentas.index\":true,\"contabilidad.tipocuentas.create\":true,\"contabilidad.tipocuentas.store\":true,\"contabilidad.tipocuentas.edit\":true,\"contabilidad.tipocuentas.update\":true,\"contabilidad.tipocuentas.destroy\":true,\"contabilidad.cuentas.index\":true,\"contabilidad.cuentas.create\":true,\"contabilidad.cuentas.store\":true,\"contabilidad.cuentas.edit\":true,\"contabilidad.cuentas.update\":true,\"contabilidad.cuentas.destroy\":true,\"contabilidad.cuentas.search_padre\":true,\"contabilidad.cuentas.search_cuenta_asiento\":true,\"contabilidad.cuentas.index_ajax_filter\":true,\"contabilidad.cuentas.historial\":true,\"contabilidad.cuentas.historial_ajax\":true,\"contabilidad.cuentas.historial_excel\":true,\"contabilidad.cuentas.historial-solo-caja-ita\":true,\"contabilidad.cuentas.cuenta_exist\":true,\"contabilidad.asientos.index\":true,\"contabilidad.asientos.create\":true,\"contabilidad.asientos.store\":true,\"contabilidad.asientos.edit\":true,\"contabilidad.asientos.update\":true,\"contabilidad.asientos.destroy\":true,\"contabilidad.asientos.index_ajax_asientos\":true,\"contabilidad.asientos.anular\":true,\"contabilidad.asientodetalles.index\":true,\"contabilidad.asientodetalles.create\":true,\"contabilidad.asientodetalles.store\":true,\"contabilidad.asientodetalles.edit\":true,\"contabilidad.asientodetalles.update\":true,\"contabilidad.asientodetalles.destroy\":true,\"contabilidad.ejercicio.index\":true,\"contabilidad.ejercicio.create\":true,\"contabilidad.ejercicio.store\":true,\"contabilidad.ejercicio.edit\":true,\"contabilidad.ejercicio.update\":true,\"contabilidad.ejercicio.destroy\":true,\"contabilidad.reportes.libro_mayor\":true,\"contabilidad.reportes.libro_mayor_index\":true,\"contabilidad.reportes.libro_mayor_pdf\":true,\"contabilidad.reportes.libro_mayor_xls\":true,\"contabilidad.reportes.balance\":true,\"contabilidad.reportes.balance_activos\":true,\"contabilidad.reportes.balance_pasivos\":true,\"contabilidad.reportes.balance_patrimonio\":true,\"contabilidad.reportes.balance_pdf\":true,\"contabilidad.reportes.estado_resultado\":true,\"contabilidad.reportes.estado_resultado_ingresos\":true,\"contabilidad.reportes.estado_resultado_egresos\":true,\"contabilidad.reportes.estado_resultado_pdf\":true,\"contabilidad.reportes.libro_venta\":true,\"contabilidad.reportes.libro_venta_pdf\":true,\"contabilidad.reportes.libro_venta_excel\":true,\"contabilidad.reportes.libro_compra\":true,\"contabilidad.reportes.libro_compra_pdf\":true,\"contabilidad.reportes.libro_compra_excel\":true,\"contabilidad.reportes.ingreso_egreso\":true,\"contabilidad.reportes.ingreso_egreso_ajax\":true,\"contabilidad.reportes.ingreso_egreso_xls\":true,\"contabilidad.reportes.ingreso_egreso_config\":true,\"contabilidad.reportes.flujo_caja\":true,\"contabilidad.reportes.flujo_caja_config\":true,\"contabilidad.reportes.libro_compra_performance\":true,\"contabilidad.reportes.libro_venta_performance\":true,\"contabilidad.reportes.cajas\":true,\"contabilidad.reportes.flujo_efectivo\":true,\"contabilidad.reportes.flujo_efectivo_ajax\":true,\"contabilidad.reportes.flujo_efectivo_excel\":true,\"contabilidad.reportes.flujo_efectivo_detalles\":true,\"contabilidad.reportes.flujo_efectivo_detalles_ajax\":true,\"contabilidad.reportes.flujo_efectivo_detalles_excel\":true,\"Permisos Especiales Contabilidad.Ver Contabilidad en Sidebar\":true,\"Permisos Especiales Reportes.Ver Reportes en Sidebar\":true,\"dashboard.grid.save\":true,\"dashboard.grid.reset\":true,\"dashboard.index\":true,\"dashboard.ejercicio.ejercicio\":true,\"empleados.empleados.index\":true,\"empleados.empleados.create\":true,\"empleados.empleados.store\":true,\"empleados.empleados.edit\":true,\"empleados.empleados.update\":true,\"empleados.empleados.destroy\":true,\"empleados.empleados.indexAjax\":true,\"empleados.pagoempleados.index\":true,\"empleados.pagoempleados.create\":true,\"empleados.pagoempleados.store\":true,\"empleados.pagoempleados.edit\":true,\"empleados.pagoempleados.update\":true,\"empleados.pagoempleados.destroy\":true,\"empleados.pagoempleados.indexAjax\":true,\"empleados.pagoempleados.seleccionEmpleado\":true,\"empleados.pagoempleados.anular_asientos\":true,\"empleados.anticipos.index\":true,\"empleados.anticipos.create\":true,\"empleados.anticipos.store\":true,\"empleados.anticipos.edit\":true,\"empleados.anticipos.update\":true,\"empleados.anticipos.anular\":true,\"Permisos Especiales Empleados.Ver Empleados en Sidebar\":true,\"media.media.index\":true,\"media.media.create\":true,\"media.media.store\":true,\"media.media.edit\":true,\"media.media.update\":true,\"media.media.destroy\":true,\"media.media-grid.index\":true,\"media.media-grid.ckIndex\":true,\"menu.menus.index\":true,\"menu.menus.create\":true,\"menu.menus.store\":true,\"menu.menus.edit\":true,\"menu.menus.update\":true,\"menu.menus.destroy\":true,\"menu.menuitem.index\":true,\"menu.menuitem.create\":true,\"menu.menuitem.store\":true,\"menu.menuitem.edit\":true,\"menu.menuitem.update\":true,\"menu.menuitem.destroy\":true,\"page.pages.index\":true,\"page.pages.create\":true,\"page.pages.store\":true,\"page.pages.edit\":true,\"page.pages.update\":true,\"page.pages.destroy\":true,\"pagofacturascredito.pagofacturacreditos.index\":true,\"pagofacturascredito.pagofacturacreditos.create\":true,\"pagofacturascredito.pagofacturacreditos.store\":true,\"pagofacturascredito.pagofacturacreditos.edit\":true,\"pagofacturascredito.pagofacturacreditos.update\":true,\"pagofacturascredito.pagofacturacreditos.destroy\":true,\"pagofacturascredito.pagofacturacreditos.index_ajax\":true,\"productos.categoriaproductos.index\":true,\"productos.categoriaproductos.create\":true,\"productos.categoriaproductos.store\":true,\"productos.categoriaproductos.edit\":true,\"productos.categoriaproductos.update\":true,\"productos.categoriaproductos.destroy\":true,\"productos.productos.index\":true,\"productos.productos.create\":true,\"productos.productos.store\":true,\"productos.productos.edit\":true,\"productos.productos.update\":true,\"productos.productos.destroy\":true,\"productos.productos.search_producto\":true,\"productos.productos.index_ajax\":true,\"productos.productos.inventario_producto_pdf\":true,\"productos.productos.inventario_producto_performance\":true,\"productos.productos.productos_vendidos\":true,\"productos.productos.productos_vendidos_ajax\":true,\"productos.productos.productos_vendidos_query\":true,\"productos.productos.productos_vendidos_xls\":true,\"productos.productos.index_stock_critico\":true,\"productos.productos.cargar_productos_desde_excel\":true,\"productos.productos.store_productos_desde_excel\":true,\"productos.marcas.index\":true,\"productos.marcas.create\":true,\"productos.marcas.store\":true,\"productos.marcas.edit\":true,\"productos.marcas.update\":true,\"productos.marcas.destroy\":true,\"productos.altabajaproductos.index\":true,\"productos.altabajaproductos.create\":true,\"productos.altabajaproductos.store\":true,\"productos.altabajaproductos.edit\":true,\"productos.altabajaproductos.update\":true,\"productos.altabajaproductos.destroy\":true,\"productos.altabajaproductos.seleccionProductos\":true,\"productos.altabajaproductos.indexAjax\":true,\"Permisos Especiales Productos.Ver Precios de Compra\":true,\"proveedores.proveedors.index\":true,\"proveedores.proveedors.create\":true,\"proveedores.proveedors.store\":true,\"proveedores.proveedors.edit\":true,\"proveedores.proveedors.update\":true,\"proveedores.proveedors.destroy\":true,\"proveedores.proveedors.indexAjax\":true,\"proveedores.proveedors.search_proveedor\":true,\"servicios.servicios.index\":true,\"servicios.servicios.create\":true,\"servicios.servicios.store\":true,\"servicios.servicios.edit\":true,\"servicios.servicios.update\":true,\"servicios.servicios.destroy\":true,\"servicios.servicios.indexAjax\":true,\"servicios.servicios.search_servicio\":true,\"setting.settings.index\":true,\"setting.settings.getModuleSettings\":true,\"setting.settings.store\":true,\"translation.translations.index\":true,\"translation.translations.update\":true,\"translation.translations.export\":true,\"translation.translations.import\":true,\"user.users.index\":true,\"user.users.create\":true,\"user.users.store\":true,\"user.users.edit\":true,\"user.users.update\":true,\"user.users.destroy\":true,\"user.users.backup\":true,\"user.roles.index\":true,\"user.roles.create\":true,\"user.roles.store\":true,\"user.roles.edit\":true,\"user.roles.update\":true,\"user.roles.destroy\":true,\"ventas.ventas.index\":true,\"ventas.ventas.create\":true,\"ventas.ventas.store\":true,\"ventas.ventas.edit\":true,\"ventas.ventas.update\":true,\"ventas.ventas.destroy\":true,\"ventas.ventas.search_venta_cliente\":true,\"ventas.ventas.search_venta_producto\":true,\"ventas.ventas.search_venta_servicio\":true,\"ventas.ventas.search_venta_cristal\":true,\"ventas.ventas.detalle_venta_ajax\":true,\"ventas.ventas.seleccion\":true,\"ventas.ventas.indexAjax\":true,\"ventas.ventas.nro_seguimiento_exist\":true,\"ventas.ventas.edit_nro_seguimiento\":true,\"ventas.ventas.update_nro_seguimiento\":true,\"ventas.ventas.reporte\":true,\"ventas.ventas.reporte_ajax\":true,\"ventas.ventas.reporte_pdf\":true,\"ventas.ventas.reporte_xls\":true,\"ventas.ventas.query_reporte\":true,\"ventas.ventas.reporte_ganancias\":true,\"ventas.ventas.reporte_ganancias_ajax\":true,\"ventas.ventas.reporte_ganancias_query\":true,\"ventas.ventas.reporte_ganancias_xls\":true,\"ventas.ventas.index_preventa\":true,\"ventas.ventas.anular_factura\":true,\"ventas.ventas.cuenta_change\":true,\"ventas.ventas.anular_asientos_preventa\":true,\"ventas.ventas.preventa_agregar_items\":true,\"ventas.detalleventas.index\":true,\"ventas.detalleventas.create\":true,\"ventas.detalleventas.store\":true,\"ventas.detalleventas.edit\":true,\"ventas.detalleventas.update\":true,\"ventas.detalleventas.destroy\":true,\"ventas.facturaventas.index\":true,\"ventas.facturaventas.create\":true,\"ventas.facturaventas.store\":true,\"ventas.facturaventas.edit\":true,\"ventas.facturaventas.update\":true,\"ventas.facturaventas.destroy\":true,\"ventas.facturaventas.edit_nro_factura\":true,\"ventas.facturaventas.update_nro_factura\":true,\"ventas.facturaventas.index_ajax\":true,\"ventas.facturaventas.generar_facturas_vacias\":true,\"ventas.facturaventas.crear_facturas_vacias\":true,\"ventas.otras_ventas.index\":true,\"ventas.otras_ventas.index_ajax\":true,\"Permisos Especiales Ventas.Editar nro de sobre en Completar Venta\":true,\"visitas.visitas.index\":true,\"visitas.visitas.create\":true,\"visitas.visitas.store\":true,\"visitas.visitas.edit\":true,\"visitas.visitas.update\":true,\"visitas.visitas.destroy\":true,\"visitas.visitas.agregar_productos\":true,\"visitas.visitas.visita_productos_ajax\":true,\"visitas.visitas.index_ajax\":true,\"visitas.visitas.update_ajax\":true,\"visitas.visitas.destroy_ajax\":true,\"visitas.visitas.resumen\":true,\"visitas.stockretirados.index\":true,\"visitas.stockretirados.create\":true,\"visitas.stockretirados.store\":true,\"visitas.stockretirados.edit\":true,\"visitas.stockretirados.update\":true,\"visitas.stockretirados.destroy\":true,\"visitas.stockretirados.destroy_ajax\":true,\"visitas.comisiones.index\":true,\"visitas.comisiones.index_ajax\":true,\"visitas.comisiones.marcar_comisiones\":true,\"workshop.modules.index\":true,\"workshop.modules.show\":true,\"workshop.modules.disable\":true,\"workshop.modules.enable\":true,\"workshop.themes.index\":true,\"workshop.themes.show\":true}',NULL,'prueba3','prueba3','2017-08-29 12:15:10','2017-08-29 13:50:52');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas__detalleventas`
--

DROP TABLE IF EXISTS `ventas__detalleventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ventas__detalleventas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `venta_id` int(10) unsigned NOT NULL,
  `producto_id` int(10) unsigned DEFAULT NULL,
  `servicio_id` int(10) unsigned DEFAULT NULL,
  `descripcion` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cantidad` double(25,5) NOT NULL,
  `iva` enum('11','21','0') COLLATE utf8_unicode_ci NOT NULL,
  `precio_unitario` bigint(20) NOT NULL,
  `costo_unitario` double(12,5) NOT NULL,
  `precio_total` bigint(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `ventas__detalleventas_venta_id_index` (`venta_id`),
  KEY `ventas__detalleventas_producto_id_index` (`producto_id`),
  KEY `ventas__detalleventas_servicio_id_index` (`servicio_id`),
  CONSTRAINT `ventas__detalleventas_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos__productos` (`id`),
  CONSTRAINT `ventas__detalleventas_servicio_id_foreign` FOREIGN KEY (`servicio_id`) REFERENCES `servicios__servicios` (`id`),
  CONSTRAINT `ventas__detalleventas_venta_id_foreign` FOREIGN KEY (`venta_id`) REFERENCES `ventas__ventas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas__detalleventas`
--

LOCK TABLES `ventas__detalleventas` WRITE;
/*!40000 ALTER TABLE `ventas__detalleventas` DISABLE KEYS */;
INSERT INTO `ventas__detalleventas` VALUES (1,1,35,NULL,'Producto bernhard -codigo: SC -marca: Crist 35 -stock: 165',1.00000,'21',60220,51617.00000,60220,'2017-08-28 06:29:05','2017-08-28 06:29:05'),(2,1,NULL,2,'',2.00000,'11',409634,0.00000,819268,'2017-08-28 06:29:05','2017-08-28 06:29:05'),(3,3,32,NULL,'Producto fadel -codigo: TX -marca: Moore 36 -stock: 128',1.00000,'21',65230,59161.00000,65230,'2017-08-28 18:33:30','2017-08-28 18:33:30'),(4,3,37,NULL,'Producto jerde -codigo: TN -marca: Grimes 32 -stock: 123',2.00000,'11',74402,58525.00000,148804,'2017-08-28 18:33:30','2017-08-28 18:33:30'),(5,4,9,NULL,'Producto wuckert -codigo: OH -marca: Mayer 17 -stock: 162',2.00000,'11',74475,54629.00000,148950,'2017-08-29 13:56:30','2017-08-29 13:56:30'),(6,4,31,NULL,'Producto torp -codigo: IN -marca: Cruickshank 19 -stock: 105',3.00000,'21',61281,59073.00000,183843,'2017-08-29 13:56:30','2017-08-29 13:56:30'),(7,5,9,NULL,'Producto wuckert -codigo: OH -marca: Mayer 17 -stock: 160',2.00000,'11',74475,54629.00000,148950,'2017-08-29 13:59:41','2017-08-29 13:59:41'),(8,5,31,NULL,'Producto torp -codigo: IN -marca: Cruickshank 19 -stock: 102',1.00000,'11',61281,59073.00000,61281,'2017-08-29 13:59:41','2017-08-29 13:59:41'),(9,6,8,NULL,'Producto grady -codigo: DC -marca: Feil 12 -stock: 167',1.00000,'21',61662,57465.00000,61662,'2017-08-29 14:10:29','2017-08-29 14:10:29'),(10,6,37,NULL,'Producto jerde -codigo: TN -marca: Grimes 32 -stock: 121',2.00000,'11',74402,58525.00000,148804,'2017-08-29 14:10:29','2017-08-29 14:10:29');
/*!40000 ALTER TABLE `ventas__detalleventas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas__facturaventas`
--

DROP TABLE IF EXISTS `ventas__facturaventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ventas__facturaventas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `venta_id` int(10) unsigned DEFAULT NULL,
  `nro_factura` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  `anulado` tinyint(1) NOT NULL,
  `tipo_factura` enum('contado','credito') COLLATE utf8_unicode_ci NOT NULL,
  `usuario_sistema_id_create` int(10) unsigned NOT NULL,
  `usuario_sistema_id_edit` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `ventas__facturaventas_venta_id_index` (`venta_id`),
  KEY `ventas__facturaventas_usuario_sistema_id_create_index` (`usuario_sistema_id_create`),
  KEY `ventas__facturaventas_usuario_sistema_id_edit_index` (`usuario_sistema_id_edit`),
  CONSTRAINT `ventas__facturaventas_usuario_sistema_id_create_foreign` FOREIGN KEY (`usuario_sistema_id_create`) REFERENCES `users` (`id`),
  CONSTRAINT `ventas__facturaventas_usuario_sistema_id_edit_foreign` FOREIGN KEY (`usuario_sistema_id_edit`) REFERENCES `users` (`id`),
  CONSTRAINT `ventas__facturaventas_venta_id_foreign` FOREIGN KEY (`venta_id`) REFERENCES `ventas__ventas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas__facturaventas`
--

LOCK TABLES `ventas__facturaventas` WRITE;
/*!40000 ALTER TABLE `ventas__facturaventas` DISABLE KEYS */;
INSERT INTO `ventas__facturaventas` VALUES (1,1,'001 - 001 - 001','2017-08-28',0,'contado',1,NULL,'2017-08-28 06:29:05','2017-08-28 06:29:05'),(2,3,'001 - 001 - 002','2017-08-28',0,'contado',1,NULL,'2017-08-28 18:33:30','2017-08-28 18:33:30'),(3,4,'001 - 001 - 003','2017-08-29',0,'contado',2,NULL,'2017-08-29 13:56:30','2017-08-29 13:56:30'),(4,5,'001 - 001 - 004','2017-08-29',0,'contado',2,NULL,'2017-08-29 13:59:41','2017-08-29 13:59:41'),(5,6,'001 - 001 - 005','2017-08-29',0,'contado',2,NULL,'2017-08-29 14:10:29','2017-08-29 14:10:29');
/*!40000 ALTER TABLE `ventas__facturaventas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas__ventas`
--

DROP TABLE IF EXISTS `ventas__ventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ventas__ventas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tipo` enum('venta','preventa','otros') COLLATE utf8_unicode_ci NOT NULL,
  `estado` enum('preventa','terminado') COLLATE utf8_unicode_ci NOT NULL,
  `anulado` tinyint(1) NOT NULL,
  `usuario_sistema_id_create` int(10) unsigned NOT NULL,
  `usuario_sistema_id_edit` int(10) unsigned DEFAULT NULL,
  `cliente_id` int(10) unsigned NOT NULL,
  `caja_id` int(10) unsigned NOT NULL,
  `nro_seguimiento` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `fecha_venta` date NOT NULL,
  `fecha_entrega` date DEFAULT NULL,
  `monto_total` bigint(20) NOT NULL,
  `descuento_total` bigint(20) DEFAULT NULL,
  `monto_total_letras` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `gravado_excenta` bigint(20) NOT NULL,
  `gravado_5` bigint(20) NOT NULL,
  `gravado_10` bigint(20) NOT NULL,
  `total_iva_5` bigint(20) NOT NULL,
  `total_iva_10` bigint(20) NOT NULL,
  `total_iva` bigint(20) NOT NULL,
  `observacion_venta` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
  `entrega` bigint(20) DEFAULT NULL,
  `pago_final` bigint(20) DEFAULT NULL,
  `total_pagado` bigint(20) DEFAULT NULL,
  `descuento_porcentaje` int(11) DEFAULT NULL,
  `visita_id` int(10) unsigned DEFAULT NULL,
  `comision_pagada` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `ventas__ventas_usuario_sistema_id_create_index` (`usuario_sistema_id_create`),
  KEY `ventas__ventas_usuario_sistema_id_edit_index` (`usuario_sistema_id_edit`),
  KEY `ventas__ventas_cliente_id_index` (`cliente_id`),
  KEY `ventas__ventas_caja_id_index` (`caja_id`),
  KEY `ventas__ventas_visita_id_index` (`visita_id`),
  CONSTRAINT `ventas__ventas_caja_id_foreign` FOREIGN KEY (`caja_id`) REFERENCES `caja_cajas` (`id`),
  CONSTRAINT `ventas__ventas_cliente_id_foreign` FOREIGN KEY (`cliente_id`) REFERENCES `clientes__clientes` (`id`),
  CONSTRAINT `ventas__ventas_usuario_sistema_id_create_foreign` FOREIGN KEY (`usuario_sistema_id_create`) REFERENCES `users` (`id`),
  CONSTRAINT `ventas__ventas_usuario_sistema_id_edit_foreign` FOREIGN KEY (`usuario_sistema_id_edit`) REFERENCES `users` (`id`),
  CONSTRAINT `ventas__ventas_visita_id_foreign` FOREIGN KEY (`visita_id`) REFERENCES `visitas__visitas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas__ventas`
--

LOCK TABLES `ventas__ventas` WRITE;
/*!40000 ALTER TABLE `ventas__ventas` DISABLE KEYS */;
INSERT INTO `ventas__ventas` VALUES (1,'venta','terminado',0,1,NULL,1,1,'17/1','2017-08-28','2017-08-28',870000,9488,'OCHOCIENTOS SETENTA MIL  GUARANÍES ',0,57353,744790,2867,74478,77345,'',NULL,NULL,870000,NULL,1,0,'2017-08-28 06:29:05','2017-08-29 13:30:28'),(3,'venta','terminado',0,1,NULL,14,1,'17/2','2017-08-28','2017-08-28',200000,14034,'DOSCIENTOS  MIL  GUARANÍES ',0,62124,135277,3106,13527,16633,'',NULL,NULL,200000,NULL,NULL,0,'2017-08-28 18:33:30','2017-08-28 18:33:30'),(4,'venta','terminado',0,2,NULL,15,1,'17/3','2017-08-29','2017-08-29',330000,2793,'TRESCIENTOS TREINTA MIL  GUARANÍES ',0,175089,135410,8754,13540,22294,'',NULL,NULL,330000,NULL,3,1,'2017-08-29 13:56:30','2017-08-29 14:27:48'),(5,'venta','terminado',0,2,NULL,5,1,'17/4','2017-08-27','2017-08-29',205000,5231,'DOSCIENTOS CINCO MIL  GUARANÍES ',0,0,191120,0,19111,19111,'',NULL,NULL,205000,NULL,3,1,'2017-08-29 13:59:41','2017-08-29 14:27:48'),(6,'venta','terminado',0,2,NULL,5,1,'17/5','2017-08-28','2017-08-29',200000,10466,'DOSCIENTOS  MIL  GUARANÍES ',0,58726,135277,2936,13527,16463,'',NULL,NULL,200000,NULL,3,1,'2017-08-29 14:10:29','2017-08-29 14:27:48');
/*!40000 ALTER TABLE `ventas__ventas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas_config_factura`
--

DROP TABLE IF EXISTS `ventas_config_factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ventas_config_factura` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `identificador` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `valor` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas_config_factura`
--

LOCK TABLES `ventas_config_factura` WRITE;
/*!40000 ALTER TABLE `ventas_config_factura` DISABLE KEYS */;
INSERT INTO `ventas_config_factura` VALUES (1,'nro_factura_1','factura_inicio','001','2017-08-28 06:22:35','2017-08-28 06:22:35'),(2,'nro_factura_2','factura_medio','001','2017-08-28 06:22:35','2017-08-28 06:22:35'),(3,'nro_factura_3','factura_final','6','2017-08-28 06:22:35','2017-08-29 14:10:29');
/*!40000 ALTER TABLE `ventas_config_factura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas_config_seguimiento`
--

DROP TABLE IF EXISTS `ventas_config_seguimiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ventas_config_seguimiento` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nro_1` bigint(20) NOT NULL,
  `nro_2` bigint(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas_config_seguimiento`
--

LOCK TABLES `ventas_config_seguimiento` WRITE;
/*!40000 ALTER TABLE `ventas_config_seguimiento` DISABLE KEYS */;
INSERT INTO `ventas_config_seguimiento` VALUES (1,17,6,'2017-08-28 06:22:35','2017-08-29 14:10:29');
/*!40000 ALTER TABLE `ventas_config_seguimiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas_pago_factura_credito`
--

DROP TABLE IF EXISTS `ventas_pago_factura_credito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ventas_pago_factura_credito` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `venta_id` int(10) unsigned NOT NULL,
  `caja_id` int(10) unsigned NOT NULL,
  `fecha` date NOT NULL,
  `forma_pago` enum('efectivo','cheque','tarjeta_credito','tarjeta_debito') COLLATE utf8_unicode_ci NOT NULL,
  `monto` bigint(20) NOT NULL,
  `nro_recibo` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `observacion` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `ventas_pago_factura_credito_venta_id_index` (`venta_id`),
  KEY `ventas_pago_factura_credito_caja_id_index` (`caja_id`),
  CONSTRAINT `ventas_pago_factura_credito_caja_id_foreign` FOREIGN KEY (`caja_id`) REFERENCES `caja_cajas` (`id`),
  CONSTRAINT `ventas_pago_factura_credito_venta_id_foreign` FOREIGN KEY (`venta_id`) REFERENCES `ventas__ventas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas_pago_factura_credito`
--

LOCK TABLES `ventas_pago_factura_credito` WRITE;
/*!40000 ALTER TABLE `ventas_pago_factura_credito` DISABLE KEYS */;
INSERT INTO `ventas_pago_factura_credito` VALUES (1,1,1,'2017-08-28','efectivo',870000,'','','2017-08-28 06:29:05','2017-08-28 06:29:05'),(2,3,1,'2017-08-28','efectivo',200000,'','','2017-08-28 18:33:30','2017-08-28 18:33:30'),(3,4,1,'2017-08-29','efectivo',330000,'','','2017-08-29 13:56:30','2017-08-29 13:56:30'),(4,5,1,'2017-08-29','efectivo',205000,'','','2017-08-29 13:59:41','2017-08-29 13:59:41'),(5,6,1,'2017-08-29','efectivo',200000,'','','2017-08-29 14:10:29','2017-08-29 14:10:29');
/*!40000 ALTER TABLE `ventas_pago_factura_credito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visitas__stocks_retirados`
--

DROP TABLE IF EXISTS `visitas__stocks_retirados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visitas__stocks_retirados` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `visita_id` int(10) unsigned NOT NULL,
  `producto_id` int(10) unsigned NOT NULL,
  `cantidad` double(25,5) NOT NULL DEFAULT '0.00000',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `visitas__stocks_retirados_visita_id_index` (`visita_id`),
  KEY `visitas__stocks_retirados_producto_id_index` (`producto_id`),
  CONSTRAINT `visitas__stocks_retirados_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos__productos` (`id`),
  CONSTRAINT `visitas__stocks_retirados_visita_id_foreign` FOREIGN KEY (`visita_id`) REFERENCES `visitas__visitas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visitas__stocks_retirados`
--

LOCK TABLES `visitas__stocks_retirados` WRITE;
/*!40000 ALTER TABLE `visitas__stocks_retirados` DISABLE KEYS */;
INSERT INTO `visitas__stocks_retirados` VALUES (1,1,3,2.00000,'2017-08-28 06:26:50','2017-08-28 06:26:50'),(2,1,17,1.00000,'2017-08-28 06:27:15','2017-08-28 06:27:15'),(3,1,31,3.00000,'2017-08-28 06:27:27','2017-08-28 06:27:27'),(4,1,35,2.00000,'2017-08-28 18:07:40','2017-08-28 18:07:40'),(5,3,31,2.00000,'2017-08-29 13:51:48','2017-08-29 13:51:48'),(6,3,35,1.00000,'2017-08-29 13:51:55','2017-08-29 13:51:55'),(8,3,9,4.00000,'2017-08-29 13:54:49','2017-08-29 13:54:49');
/*!40000 ALTER TABLE `visitas__stocks_retirados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visitas__visitas`
--

DROP TABLE IF EXISTS `visitas__visitas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visitas__visitas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `lugar` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `estado` enum('abierta','cerrada') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'abierta',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `visitas__visitas_user_id_index` (`user_id`),
  CONSTRAINT `visitas__visitas_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visitas__visitas`
--

LOCK TABLES `visitas__visitas` WRITE;
/*!40000 ALTER TABLE `visitas__visitas` DISABLE KEYS */;
INSERT INTO `visitas__visitas` VALUES (1,'Luque','2017-08-28',1,'abierta','2017-08-28 06:24:51','2017-08-28 18:26:12'),(2,'Asuncion','2017-08-22',1,'cerrada','2017-08-28 06:30:18','2017-08-29 14:07:16'),(3,'Fernando de la Mora','2017-08-29',2,'abierta','2017-08-29 13:51:36','2017-08-29 13:51:36');
/*!40000 ALTER TABLE `visitas__visitas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-08-29 10:38:16
