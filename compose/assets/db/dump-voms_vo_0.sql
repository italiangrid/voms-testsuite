-- MySQL dump 10.14  Distrib 5.5.68-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: voms_vo_0
-- ------------------------------------------------------
-- Server version	5.5.68-MariaDB

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
-- Table structure for table `acl2`
--

DROP TABLE IF EXISTS `acl2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl2` (
  `acl_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` bigint(20) NOT NULL,
  `defaultACL` bit(1) NOT NULL,
  `role_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`acl_id`),
  UNIQUE KEY `UKmxqha2vekx9onuat2cfxvra2k` (`group_id`,`defaultACL`,`role_id`),
  KEY `FK36y80adik6mv1d1x3vdfj0x8b` (`role_id`),
  CONSTRAINT `FK36y80adik6mv1d1x3vdfj0x8b` FOREIGN KEY (`role_id`) REFERENCES `roles` (`rid`),
  CONSTRAINT `FKk71anwbppnb3hjddf4mr8bgdw` FOREIGN KEY (`group_id`) REFERENCES `groups` (`gid`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl2`
--

LOCK TABLES `acl2` WRITE;
/*!40000 ALTER TABLE `acl2` DISABLE KEYS */;
INSERT INTO `acl2` VALUES (1,1,'\0',NULL),(2,1,'\0',1),(14,1,'\0',2),(22,1,'\0',3),(30,1,'\0',4),(3,2,'\0',NULL),(4,2,'\0',1),(17,2,'\0',2),(23,2,'\0',3),(29,2,'\0',4),(5,3,'\0',NULL),(6,3,'\0',1),(16,3,'\0',2),(19,3,'\0',3),(27,3,'\0',4),(7,4,'\0',NULL),(8,4,'\0',1),(13,4,'\0',2),(21,4,'\0',3),(28,4,'\0',4),(9,5,'\0',NULL),(10,5,'\0',1),(18,5,'\0',2),(24,5,'\0',3),(25,5,'\0',4),(11,6,'\0',NULL),(12,6,'\0',1),(15,6,'\0',2),(20,6,'\0',3),(26,6,'\0',4);
/*!40000 ALTER TABLE `acl2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acl2_permissions`
--

DROP TABLE IF EXISTS `acl2_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl2_permissions` (
  `acl_id` bigint(20) NOT NULL,
  `admin_id` bigint(20) NOT NULL,
  `permissions` int(11) DEFAULT NULL,
  PRIMARY KEY (`acl_id`,`admin_id`),
  KEY `FKci84ttqcam9l962h22n3nva5l` (`admin_id`),
  CONSTRAINT `FKci84ttqcam9l962h22n3nva5l` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`adminid`),
  CONSTRAINT `FKgoqq3x8shmjip1jy01e4wdoug` FOREIGN KEY (`acl_id`) REFERENCES `acl2` (`acl_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acl2_permissions`
--

LOCK TABLES `acl2_permissions` WRITE;
/*!40000 ALTER TABLE `acl2_permissions` DISABLE KEYS */;
INSERT INTO `acl2_permissions` VALUES (1,1,16383),(1,2,16383),(1,4,5),(1,6,16383),(1,7,16383),(2,1,16383),(2,2,16383),(2,4,5),(2,6,16383),(2,7,16383),(3,1,16383),(3,2,16383),(3,4,5),(3,6,16383),(3,7,16383),(4,1,16383),(4,2,16383),(4,4,5),(4,6,16383),(4,7,16383),(5,1,16383),(5,2,16383),(5,4,5),(5,6,16383),(5,7,16383),(6,1,16383),(6,2,16383),(6,4,5),(6,6,16383),(6,7,16383),(7,1,16383),(7,2,16383),(7,4,5),(7,6,16383),(7,7,16383),(8,1,16383),(8,2,16383),(8,4,5),(8,6,16383),(8,7,16383),(9,1,16383),(9,2,16383),(9,4,5),(9,6,16383),(9,7,16383),(10,1,16383),(10,2,16383),(10,4,5),(10,6,16383),(10,7,16383),(11,1,16383),(11,2,16383),(11,4,5),(11,6,16383),(11,7,16383),(12,1,16383),(12,2,16383),(12,4,5),(12,6,16383),(12,7,16383),(13,1,16383),(13,2,16383),(13,4,5),(13,6,16383),(13,7,16383),(14,1,16383),(14,2,16383),(14,4,5),(14,6,16383),(14,7,16383),(15,1,16383),(15,2,16383),(15,4,5),(15,6,16383),(15,7,16383),(16,1,16383),(16,2,16383),(16,4,5),(16,6,16383),(16,7,16383),(17,1,16383),(17,2,16383),(17,4,5),(17,6,16383),(17,7,16383),(18,1,16383),(18,2,16383),(18,4,5),(18,6,16383),(18,7,16383),(19,1,16383),(19,2,16383),(19,4,5),(19,6,16383),(19,7,16383),(20,1,16383),(20,2,16383),(20,4,5),(20,6,16383),(20,7,16383),(21,1,16383),(21,2,16383),(21,4,5),(21,6,16383),(21,7,16383),(22,1,16383),(22,2,16383),(22,4,5),(22,6,16383),(22,7,16383),(23,1,16383),(23,2,16383),(23,4,5),(23,6,16383),(23,7,16383),(24,1,16383),(24,2,16383),(24,4,5),(24,6,16383),(24,7,16383),(25,1,16383),(25,2,16383),(25,4,5),(25,6,16383),(25,7,16383),(26,1,16383),(26,2,16383),(26,4,5),(26,6,16383),(26,7,16383),(27,1,16383),(27,2,16383),(27,4,5),(27,6,16383),(27,7,16383),(28,1,16383),(28,2,16383),(28,4,5),(28,6,16383),(28,7,16383),(29,1,16383),(29,2,16383),(29,4,5),(29,6,16383),(29,7,16383),(30,1,16383),(30,2,16383),(30,4,5),(30,6,16383),(30,7,16383);
/*!40000 ALTER TABLE `acl2_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admins` (
  `adminid` bigint(20) NOT NULL AUTO_INCREMENT,
  `dn` varchar(255) NOT NULL,
  `email_address` varchar(255) DEFAULT NULL,
  `ca` smallint(6) NOT NULL,
  PRIMARY KEY (`adminid`),
  UNIQUE KEY `UK_40k3ldiov4eh6w3vk8046lic` (`dn`),
  KEY `FKi8ufrgbtqk5f2oo91c5i8w05n` (`ca`),
  CONSTRAINT `FKi8ufrgbtqk5f2oo91c5i8w05n` FOREIGN KEY (`ca`) REFERENCES `ca` (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (1,'/O=VOMS/O=System/CN=Internal VOMS Process',NULL,86),(2,'/O=VOMS/O=System/CN=Local Database Administrator',NULL,86),(3,'/O=VOMS/O=System/CN=Absolutely Anyone',NULL,86),(4,'/O=VOMS/O=System/CN=Any Authenticated User',NULL,86),(5,'/O=VOMS/O=System/CN=Unauthenticated Client',NULL,86),(6,'/vo.0/Role=VO-Admin',NULL,88),(7,'/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it',NULL,22);
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attributes`
--

DROP TABLE IF EXISTS `attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attributes` (
  `a_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `a_desc` text,
  `a_name` varchar(255) NOT NULL,
  `a_uniq` bit(1) NOT NULL,
  PRIMARY KEY (`a_id`),
  UNIQUE KEY `UK_te3q7e0mmi8w1n1plitp07wo3` (`a_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attributes`
--

LOCK TABLES `attributes` WRITE;
/*!40000 ALTER TABLE `attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audit_event`
--

DROP TABLE IF EXISTS `audit_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audit_event` (
  `event_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `principal` varchar(255) NOT NULL,
  `event_timestamp` datetime NOT NULL,
  `event_type` varchar(255) NOT NULL,
  PRIMARY KEY (`event_id`),
  KEY `ae_principal_idx` (`principal`,`event_timestamp`),
  KEY `ae_type_idx` (`event_timestamp`,`event_type`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_event`
--

LOCK TABLES `audit_event` WRITE;
/*!40000 ALTER TABLE `audit_event` DISABLE KEYS */;
INSERT INTO `audit_event` VALUES (1,'/O=VOMS/O=System/CN=Internal VOMS Process','2022-12-29 15:41:32','org.glite.security.voms.admin.event.vo.group.GroupCreatedEvent'),(2,'/O=VOMS/O=System/CN=Internal VOMS Process','2022-12-29 15:41:32','org.glite.security.voms.admin.event.vo.admin.AdminCreatedEvent'),(3,'/O=VOMS/O=System/CN=Internal VOMS Process','2022-12-29 15:41:32','org.glite.security.voms.admin.event.vo.admin.AdminCreatedEvent'),(4,'/O=VOMS/O=System/CN=Internal VOMS Process','2022-12-29 15:41:32','org.glite.security.voms.admin.event.vo.admin.AdminCreatedEvent'),(5,'/O=VOMS/O=System/CN=Internal VOMS Process','2022-12-29 15:41:32','org.glite.security.voms.admin.event.vo.admin.AdminCreatedEvent'),(6,'/O=VOMS/O=System/CN=Internal VOMS Process','2022-12-29 15:41:32','org.glite.security.voms.admin.event.vo.admin.AdminCreatedEvent'),(7,'/O=VOMS/O=System/CN=Internal VOMS Process','2022-12-29 15:41:32','org.glite.security.voms.admin.event.vo.role.RoleCreatedEvent'),(8,'/O=VOMS/O=System/CN=Internal VOMS Process','2022-12-29 15:41:32','org.glite.security.voms.admin.event.vo.admin.AdminCreatedEvent'),(9,'/O=VOMS/O=System/CN=Internal VOMS Process','2022-12-29 15:41:32','org.glite.security.voms.admin.event.vo.acl.ACLCreatedEvent'),(10,'/O=VOMS/O=System/CN=Internal VOMS Process','2022-12-29 15:41:32','org.glite.security.voms.admin.event.vo.acl.ACLCreatedEvent'),(11,'/O=VOMS/O=System/CN=Internal VOMS Process','2022-12-29 15:41:32','org.glite.security.voms.admin.event.vo.aup.AUPCreatedEvent'),(12,'/O=VOMS/O=System/CN=Internal VOMS Process','2022-12-29 15:41:35','org.glite.security.voms.admin.event.vo.admin.AdminCreatedEvent'),(13,'/O=VOMS/O=System/CN=Internal VOMS Process','2022-12-29 15:41:35','org.glite.security.voms.admin.event.vo.acl.ACLUpdatedEvent'),(14,'/O=VOMS/O=System/CN=Internal VOMS Process','2022-12-29 15:41:35','org.glite.security.voms.admin.event.vo.acl.ACLUpdatedEvent'),(15,'/O=VOMS/O=System/CN=Internal VOMS Process','2022-12-29 15:41:38','org.glite.security.voms.admin.event.vo.acl.ACLUpdatedEvent'),(16,'/O=VOMS/O=System/CN=Internal VOMS Process','2022-12-29 15:41:38','org.glite.security.voms.admin.event.vo.acl.ACLUpdatedEvent'),(17,'/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it','2022-12-29 15:55:35','org.glite.security.voms.admin.event.user.UserCreatedEvent'),(18,'/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it','2022-12-29 15:55:35','org.glite.security.voms.admin.event.user.aup.UserSignedAUPEvent'),(19,'/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it','2022-12-29 15:55:35','org.glite.security.voms.admin.event.user.UserCreatedEvent'),(20,'/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it','2022-12-29 15:55:35','org.glite.security.voms.admin.event.user.aup.UserSignedAUPEvent'),(21,'/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it','2022-12-29 15:55:35','org.glite.security.voms.admin.event.user.UserCreatedEvent'),(22,'/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it','2022-12-29 15:55:35','org.glite.security.voms.admin.event.user.aup.UserSignedAUPEvent'),(23,'/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it','2022-12-29 15:55:36','org.glite.security.voms.admin.event.vo.group.GroupCreatedEvent'),(24,'/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it','2022-12-29 15:55:36','org.glite.security.voms.admin.event.vo.acl.ACLCreatedEvent'),(25,'/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it','2022-12-29 15:55:36','org.glite.security.voms.admin.event.vo.group.GroupCreatedEvent'),(26,'/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it','2022-12-29 15:55:36','org.glite.security.voms.admin.event.vo.acl.ACLCreatedEvent'),(27,'/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it','2022-12-29 15:55:36','org.glite.security.voms.admin.event.vo.group.GroupCreatedEvent'),(28,'/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it','2022-12-29 15:55:36','org.glite.security.voms.admin.event.vo.acl.ACLCreatedEvent'),(29,'/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it','2022-12-29 15:55:36','org.glite.security.voms.admin.event.vo.group.GroupCreatedEvent'),(30,'/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it','2022-12-29 15:55:36','org.glite.security.voms.admin.event.vo.acl.ACLCreatedEvent'),(31,'/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it','2022-12-29 15:55:37','org.glite.security.voms.admin.event.vo.group.GroupCreatedEvent'),(32,'/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it','2022-12-29 15:55:37','org.glite.security.voms.admin.event.vo.acl.ACLCreatedEvent'),(33,'/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it','2022-12-29 15:55:37','org.glite.security.voms.admin.event.vo.role.RoleCreatedEvent'),(34,'/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it','2022-12-29 15:55:37','org.glite.security.voms.admin.event.vo.role.RoleCreatedEvent'),(35,'/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it','2022-12-29 15:55:38','org.glite.security.voms.admin.event.vo.role.RoleCreatedEvent'),(36,'/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it','2022-12-29 15:55:38','org.glite.security.voms.admin.event.user.membership.UserAddedToGroupEvent'),(37,'/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it','2022-12-29 15:55:38','org.glite.security.voms.admin.event.user.membership.UserAddedToGroupEvent'),(38,'/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it','2022-12-29 15:55:38','org.glite.security.voms.admin.event.user.membership.UserAddedToGroupEvent'),(39,'/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it','2022-12-29 15:55:39','org.glite.security.voms.admin.event.user.membership.UserAddedToGroupEvent'),(40,'/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it','2022-12-29 15:55:39','org.glite.security.voms.admin.event.user.membership.UserAddedToGroupEvent'),(41,'/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it','2022-12-29 15:55:39','org.glite.security.voms.admin.event.user.membership.UserAddedToGroupEvent'),(42,'/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it','2022-12-29 15:55:39','org.glite.security.voms.admin.event.user.membership.UserAddedToGroupEvent'),(43,'/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it','2022-12-29 15:55:39','org.glite.security.voms.admin.event.user.membership.RoleAssignedEvent'),(44,'/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it','2022-12-29 15:55:40','org.glite.security.voms.admin.event.user.membership.RoleAssignedEvent');
/*!40000 ALTER TABLE `audit_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audit_event_data`
--

DROP TABLE IF EXISTS `audit_event_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audit_event_data` (
  `event_id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` varchar(512) NOT NULL,
  PRIMARY KEY (`event_id`,`name`,`value`),
  KEY `aed_value_idx` (`value`),
  KEY `aed_name_idx` (`name`),
  CONSTRAINT `FK3f7u6552j7p9fy4wkjtqpdgdx` FOREIGN KEY (`event_id`) REFERENCES `audit_event` (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_event_data`
--

LOCK TABLES `audit_event_data` WRITE;
/*!40000 ALTER TABLE `audit_event_data` DISABLE KEYS */;
INSERT INTO `audit_event_data` VALUES (1,'groupDescription','<null>'),(1,'groupName','/vo.0'),(2,'ca','/O=VOMS/O=System/CN=Dummy Certificate Authority'),(2,'dn','/O=VOMS/O=System/CN=Internal VOMS Process'),(3,'ca','/O=VOMS/O=System/CN=Dummy Certificate Authority'),(3,'dn','/O=VOMS/O=System/CN=Local Database Administrator'),(4,'ca','/O=VOMS/O=System/CN=Dummy Certificate Authority'),(4,'dn','/O=VOMS/O=System/CN=Absolutely Anyone'),(5,'ca','/O=VOMS/O=System/CN=Dummy Certificate Authority'),(5,'dn','/O=VOMS/O=System/CN=Any Authenticated User'),(6,'ca','/O=VOMS/O=System/CN=Dummy Certificate Authority'),(6,'dn','/O=VOMS/O=System/CN=Unauthenticated Client'),(7,'roleName','VO-Admin'),(8,'ca','/O=VOMS/O=System/CN=VOMS Role'),(8,'dn','/vo.0/Role=VO-Admin'),(9,'aclContext','/vo.0'),(9,'aclIsDefault','false'),(9,'aclPermission0','[dn=/vo.0/Role=VO-Admin, ca=/O=VOMS/O=System/CN=VOMS Role, emailAddress=null] : ALL'),(9,'aclPermission1','[dn=/O=VOMS/O=System/CN=Internal VOMS Process, ca=/O=VOMS/O=System/CN=Dummy Certificate Authority, emailAddress=null] : ALL'),(9,'aclPermission2','[dn=/O=VOMS/O=System/CN=Local Database Administrator, ca=/O=VOMS/O=System/CN=Dummy Certificate Authority, emailAddress=null] : ALL'),(10,'aclContext','/vo.0/Role=VO-Admin'),(10,'aclIsDefault','false'),(10,'aclPermission0','[dn=/O=VOMS/O=System/CN=Internal VOMS Process, ca=/O=VOMS/O=System/CN=Dummy Certificate Authority, emailAddress=null] : ALL'),(10,'aclPermission1','[dn=/vo.0/Role=VO-Admin, ca=/O=VOMS/O=System/CN=VOMS Role, emailAddress=null] : ALL'),(10,'aclPermission2','[dn=/O=VOMS/O=System/CN=Local Database Administrator, ca=/O=VOMS/O=System/CN=Dummy Certificate Authority, emailAddress=null] : ALL'),(11,'aupActiveVersion','1.0'),(11,'aupName','VO-AUP'),(11,'aupReacceptancePeriod','365'),(12,'ca','/C=NL/O=GEANT Vereniging/CN=GEANT eScience SSL CA 4'),(12,'dn','/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it'),(13,'aclContext','/vo.0/Role=VO-Admin'),(13,'aclIsDefault','false'),(13,'aclPermission0','[dn=/vo.0/Role=VO-Admin, ca=/O=VOMS/O=System/CN=VOMS Role, emailAddress=null] : ALL'),(13,'aclPermission1','[dn=/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it, ca=/C=NL/O=GEANT Vereniging/CN=GEANT eScience SSL CA 4, emailAddress=null] : ALL'),(13,'aclPermission2','[dn=/O=VOMS/O=System/CN=Internal VOMS Process, ca=/O=VOMS/O=System/CN=Dummy Certificate Authority, emailAddress=null] : ALL'),(13,'aclPermission3','[dn=/O=VOMS/O=System/CN=Local Database Administrator, ca=/O=VOMS/O=System/CN=Dummy Certificate Authority, emailAddress=null] : ALL'),(14,'aclContext','/vo.0'),(14,'aclIsDefault','false'),(14,'aclPermission0','[dn=/vo.0/Role=VO-Admin, ca=/O=VOMS/O=System/CN=VOMS Role, emailAddress=null] : ALL'),(14,'aclPermission1','[dn=/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it, ca=/C=NL/O=GEANT Vereniging/CN=GEANT eScience SSL CA 4, emailAddress=null] : ALL'),(14,'aclPermission2','[dn=/O=VOMS/O=System/CN=Internal VOMS Process, ca=/O=VOMS/O=System/CN=Dummy Certificate Authority, emailAddress=null] : ALL'),(14,'aclPermission3','[dn=/O=VOMS/O=System/CN=Local Database Administrator, ca=/O=VOMS/O=System/CN=Dummy Certificate Authority, emailAddress=null] : ALL'),(15,'aclContext','/vo.0/Role=VO-Admin'),(15,'aclIsDefault','false'),(15,'aclPermission0','[dn=/vo.0/Role=VO-Admin, ca=/O=VOMS/O=System/CN=VOMS Role, emailAddress=null] : ALL'),(15,'aclPermission1','[dn=/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it, ca=/C=NL/O=GEANT Vereniging/CN=GEANT eScience SSL CA 4, emailAddress=null] : ALL'),(15,'aclPermission2','[dn=/O=VOMS/O=System/CN=Internal VOMS Process, ca=/O=VOMS/O=System/CN=Dummy Certificate Authority, emailAddress=null] : ALL'),(15,'aclPermission3','[dn=/O=VOMS/O=System/CN=Any Authenticated User, ca=/O=VOMS/O=System/CN=Dummy Certificate Authority, emailAddress=null] : CONTAINER_READ,MEMBERSHIP_READ'),(15,'aclPermission4','[dn=/O=VOMS/O=System/CN=Local Database Administrator, ca=/O=VOMS/O=System/CN=Dummy Certificate Authority, emailAddress=null] : ALL'),(16,'aclContext','/vo.0'),(16,'aclIsDefault','false'),(16,'aclPermission0','[dn=/vo.0/Role=VO-Admin, ca=/O=VOMS/O=System/CN=VOMS Role, emailAddress=null] : ALL'),(16,'aclPermission1','[dn=/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it, ca=/C=NL/O=GEANT Vereniging/CN=GEANT eScience SSL CA 4, emailAddress=null] : ALL'),(16,'aclPermission2','[dn=/O=VOMS/O=System/CN=Internal VOMS Process, ca=/O=VOMS/O=System/CN=Dummy Certificate Authority, emailAddress=null] : ALL'),(16,'aclPermission3','[dn=/O=VOMS/O=System/CN=Any Authenticated User, ca=/O=VOMS/O=System/CN=Dummy Certificate Authority, emailAddress=null] : CONTAINER_READ,MEMBERSHIP_READ'),(16,'aclPermission4','[dn=/O=VOMS/O=System/CN=Local Database Administrator, ca=/O=VOMS/O=System/CN=Dummy Certificate Authority, emailAddress=null] : ALL'),(17,'userAddress','<null>'),(17,'userCertificate0','(/C=IT/O=IGI/CN=test0, /C=IT/O=IGI/CN=Test CA)'),(17,'userEmailAddress','andrea.ceccanti@cnaf.infn.it'),(17,'userId','1'),(17,'userInstitution','<null>'),(17,'userIsSuspended','false'),(17,'userMembershipExpirationDate','Fri Dec 29 15:55:35 CET 2023'),(17,'userName','<null>'),(17,'userOrgDbId','<null>'),(17,'userPhoneNumber','<null>'),(17,'userSurname','<null>'),(17,'userSuspensionReason','<null>'),(17,'userSuspensionReasonCode','<null>'),(18,'aupName','VO-AUP'),(18,'aupVersion','1.0'),(18,'userAddress','<null>'),(18,'userCertificate0','(/C=IT/O=IGI/CN=test0, /C=IT/O=IGI/CN=Test CA)'),(18,'userEmailAddress','andrea.ceccanti@cnaf.infn.it'),(18,'userId','1'),(18,'userInstitution','<null>'),(18,'userIsSuspended','false'),(18,'userMembershipExpirationDate','Fri Dec 29 15:55:35 CET 2023'),(18,'userName','<null>'),(18,'userOrgDbId','<null>'),(18,'userPhoneNumber','<null>'),(18,'userSurname','<null>'),(18,'userSuspensionReason','<null>'),(18,'userSuspensionReasonCode','<null>'),(19,'userAddress','<null>'),(19,'userCertificate0','(/C=IT/O=IGI/CN=test1, /C=IT/O=IGI/CN=Test CA)'),(19,'userEmailAddress','andrea.ceccanti@cnaf.infn.it'),(19,'userId','2'),(19,'userInstitution','<null>'),(19,'userIsSuspended','false'),(19,'userMembershipExpirationDate','Fri Dec 29 15:55:35 CET 2023'),(19,'userName','<null>'),(19,'userOrgDbId','<null>'),(19,'userPhoneNumber','<null>'),(19,'userSurname','<null>'),(19,'userSuspensionReason','<null>'),(19,'userSuspensionReasonCode','<null>'),(20,'aupName','VO-AUP'),(20,'aupVersion','1.0'),(20,'userAddress','<null>'),(20,'userCertificate0','(/C=IT/O=IGI/CN=test1, /C=IT/O=IGI/CN=Test CA)'),(20,'userEmailAddress','andrea.ceccanti@cnaf.infn.it'),(20,'userId','2'),(20,'userInstitution','<null>'),(20,'userIsSuspended','false'),(20,'userMembershipExpirationDate','Fri Dec 29 15:55:35 CET 2023'),(20,'userName','<null>'),(20,'userOrgDbId','<null>'),(20,'userPhoneNumber','<null>'),(20,'userSurname','<null>'),(20,'userSuspensionReason','<null>'),(20,'userSuspensionReasonCode','<null>'),(21,'userAddress','<null>'),(21,'userCertificate0','(/C=IT/O=IGI/CN=(Parenthesis), /C=IT/O=IGI/CN=Test CA)'),(21,'userEmailAddress','andrea.ceccanti@cnaf.infn.it'),(21,'userId','3'),(21,'userInstitution','<null>'),(21,'userIsSuspended','false'),(21,'userMembershipExpirationDate','Fri Dec 29 15:55:35 CET 2023'),(21,'userName','<null>'),(21,'userOrgDbId','<null>'),(21,'userPhoneNumber','<null>'),(21,'userSurname','<null>'),(21,'userSuspensionReason','<null>'),(21,'userSuspensionReasonCode','<null>'),(22,'aupName','VO-AUP'),(22,'aupVersion','1.0'),(22,'userAddress','<null>'),(22,'userCertificate0','(/C=IT/O=IGI/CN=(Parenthesis), /C=IT/O=IGI/CN=Test CA)'),(22,'userEmailAddress','andrea.ceccanti@cnaf.infn.it'),(22,'userId','3'),(22,'userInstitution','<null>'),(22,'userIsSuspended','false'),(22,'userMembershipExpirationDate','Fri Dec 29 15:55:35 CET 2023'),(22,'userName','<null>'),(22,'userOrgDbId','<null>'),(22,'userPhoneNumber','<null>'),(22,'userSurname','<null>'),(22,'userSuspensionReason','<null>'),(22,'userSuspensionReasonCode','<null>'),(23,'groupDescription','<null>'),(23,'groupName','/vo.0/G1'),(24,'aclContext','/vo.0/G1'),(24,'aclIsDefault','false'),(24,'aclPermission0','[dn=/O=VOMS/O=System/CN=Internal VOMS Process, ca=/O=VOMS/O=System/CN=Dummy Certificate Authority, emailAddress=null] : ALL'),(24,'aclPermission1','[dn=/O=VOMS/O=System/CN=Any Authenticated User, ca=/O=VOMS/O=System/CN=Dummy Certificate Authority, emailAddress=null] : CONTAINER_READ,MEMBERSHIP_READ'),(24,'aclPermission2','[dn=/vo.0/Role=VO-Admin, ca=/O=VOMS/O=System/CN=VOMS Role, emailAddress=null] : ALL'),(24,'aclPermission3','[dn=/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it, ca=/C=NL/O=GEANT Vereniging/CN=GEANT eScience SSL CA 4, emailAddress=null] : ALL'),(24,'aclPermission4','[dn=/O=VOMS/O=System/CN=Local Database Administrator, ca=/O=VOMS/O=System/CN=Dummy Certificate Authority, emailAddress=null] : ALL'),(25,'groupDescription','<null>'),(25,'groupName','/vo.0/G2'),(26,'aclContext','/vo.0/G2'),(26,'aclIsDefault','false'),(26,'aclPermission0','[dn=/O=VOMS/O=System/CN=Internal VOMS Process, ca=/O=VOMS/O=System/CN=Dummy Certificate Authority, emailAddress=null] : ALL'),(26,'aclPermission1','[dn=/O=VOMS/O=System/CN=Any Authenticated User, ca=/O=VOMS/O=System/CN=Dummy Certificate Authority, emailAddress=null] : CONTAINER_READ,MEMBERSHIP_READ'),(26,'aclPermission2','[dn=/vo.0/Role=VO-Admin, ca=/O=VOMS/O=System/CN=VOMS Role, emailAddress=null] : ALL'),(26,'aclPermission3','[dn=/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it, ca=/C=NL/O=GEANT Vereniging/CN=GEANT eScience SSL CA 4, emailAddress=null] : ALL'),(26,'aclPermission4','[dn=/O=VOMS/O=System/CN=Local Database Administrator, ca=/O=VOMS/O=System/CN=Dummy Certificate Authority, emailAddress=null] : ALL'),(27,'groupDescription','<null>'),(27,'groupName','/vo.0/G2/G3'),(28,'aclContext','/vo.0/G2/G3'),(28,'aclIsDefault','false'),(28,'aclPermission0','[dn=/O=VOMS/O=System/CN=Internal VOMS Process, ca=/O=VOMS/O=System/CN=Dummy Certificate Authority, emailAddress=null] : ALL'),(28,'aclPermission1','[dn=/O=VOMS/O=System/CN=Any Authenticated User, ca=/O=VOMS/O=System/CN=Dummy Certificate Authority, emailAddress=null] : CONTAINER_READ,MEMBERSHIP_READ'),(28,'aclPermission2','[dn=/vo.0/Role=VO-Admin, ca=/O=VOMS/O=System/CN=VOMS Role, emailAddress=null] : ALL'),(28,'aclPermission3','[dn=/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it, ca=/C=NL/O=GEANT Vereniging/CN=GEANT eScience SSL CA 4, emailAddress=null] : ALL'),(28,'aclPermission4','[dn=/O=VOMS/O=System/CN=Local Database Administrator, ca=/O=VOMS/O=System/CN=Dummy Certificate Authority, emailAddress=null] : ALL'),(29,'groupDescription','<null>'),(29,'groupName','/vo.0/G1/G4'),(30,'aclContext','/vo.0/G1/G4'),(30,'aclIsDefault','false'),(30,'aclPermission0','[dn=/O=VOMS/O=System/CN=Internal VOMS Process, ca=/O=VOMS/O=System/CN=Dummy Certificate Authority, emailAddress=null] : ALL'),(30,'aclPermission1','[dn=/O=VOMS/O=System/CN=Any Authenticated User, ca=/O=VOMS/O=System/CN=Dummy Certificate Authority, emailAddress=null] : CONTAINER_READ,MEMBERSHIP_READ'),(30,'aclPermission2','[dn=/vo.0/Role=VO-Admin, ca=/O=VOMS/O=System/CN=VOMS Role, emailAddress=null] : ALL'),(30,'aclPermission3','[dn=/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it, ca=/C=NL/O=GEANT Vereniging/CN=GEANT eScience SSL CA 4, emailAddress=null] : ALL'),(30,'aclPermission4','[dn=/O=VOMS/O=System/CN=Local Database Administrator, ca=/O=VOMS/O=System/CN=Dummy Certificate Authority, emailAddress=null] : ALL'),(31,'groupDescription','<null>'),(31,'groupName','/vo.0/G1/G4/G5'),(32,'aclContext','/vo.0/G1/G4/G5'),(32,'aclIsDefault','false'),(32,'aclPermission0','[dn=/O=VOMS/O=System/CN=Internal VOMS Process, ca=/O=VOMS/O=System/CN=Dummy Certificate Authority, emailAddress=null] : ALL'),(32,'aclPermission1','[dn=/O=VOMS/O=System/CN=Any Authenticated User, ca=/O=VOMS/O=System/CN=Dummy Certificate Authority, emailAddress=null] : CONTAINER_READ,MEMBERSHIP_READ'),(32,'aclPermission2','[dn=/vo.0/Role=VO-Admin, ca=/O=VOMS/O=System/CN=VOMS Role, emailAddress=null] : ALL'),(32,'aclPermission3','[dn=/DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=meteora.cloud.cnaf.infn.it, ca=/C=NL/O=GEANT Vereniging/CN=GEANT eScience SSL CA 4, emailAddress=null] : ALL'),(32,'aclPermission4','[dn=/O=VOMS/O=System/CN=Local Database Administrator, ca=/O=VOMS/O=System/CN=Dummy Certificate Authority, emailAddress=null] : ALL'),(33,'roleName','R1'),(34,'roleName','R2'),(35,'roleName','R3'),(36,'groupName','/vo.0/G1'),(36,'userAddress','<null>'),(36,'userCertificate0','(/C=IT/O=IGI/CN=test0, /C=IT/O=IGI/CN=Test CA)'),(36,'userEmailAddress','andrea.ceccanti@cnaf.infn.it'),(36,'userId','1'),(36,'userInstitution','<null>'),(36,'userIsSuspended','false'),(36,'userMembershipExpirationDate','2023-12-29 15:55:35.0'),(36,'userName','<null>'),(36,'userOrgDbId','<null>'),(36,'userPhoneNumber','<null>'),(36,'userSurname','<null>'),(36,'userSuspensionReason','<null>'),(36,'userSuspensionReasonCode','<null>'),(37,'groupName','/vo.0/G2'),(37,'userAddress','<null>'),(37,'userCertificate0','(/C=IT/O=IGI/CN=test0, /C=IT/O=IGI/CN=Test CA)'),(37,'userEmailAddress','andrea.ceccanti@cnaf.infn.it'),(37,'userId','1'),(37,'userInstitution','<null>'),(37,'userIsSuspended','false'),(37,'userMembershipExpirationDate','2023-12-29 15:55:35.0'),(37,'userName','<null>'),(37,'userOrgDbId','<null>'),(37,'userPhoneNumber','<null>'),(37,'userSurname','<null>'),(37,'userSuspensionReason','<null>'),(37,'userSuspensionReasonCode','<null>'),(38,'groupName','/vo.0/G2/G3'),(38,'userAddress','<null>'),(38,'userCertificate0','(/C=IT/O=IGI/CN=test0, /C=IT/O=IGI/CN=Test CA)'),(38,'userEmailAddress','andrea.ceccanti@cnaf.infn.it'),(38,'userId','1'),(38,'userInstitution','<null>'),(38,'userIsSuspended','false'),(38,'userMembershipExpirationDate','2023-12-29 15:55:35.0'),(38,'userName','<null>'),(38,'userOrgDbId','<null>'),(38,'userPhoneNumber','<null>'),(38,'userSurname','<null>'),(38,'userSuspensionReason','<null>'),(38,'userSuspensionReasonCode','<null>'),(39,'groupName','/vo.0/G2'),(39,'userAddress','<null>'),(39,'userCertificate0','(/C=IT/O=IGI/CN=test1, /C=IT/O=IGI/CN=Test CA)'),(39,'userEmailAddress','andrea.ceccanti@cnaf.infn.it'),(39,'userId','2'),(39,'userInstitution','<null>'),(39,'userIsSuspended','false'),(39,'userMembershipExpirationDate','2023-12-29 15:55:35.0'),(39,'userName','<null>'),(39,'userOrgDbId','<null>'),(39,'userPhoneNumber','<null>'),(39,'userSurname','<null>'),(39,'userSuspensionReason','<null>'),(39,'userSuspensionReasonCode','<null>'),(40,'groupName','/vo.0/G1'),(40,'userAddress','<null>'),(40,'userCertificate0','(/C=IT/O=IGI/CN=test1, /C=IT/O=IGI/CN=Test CA)'),(40,'userEmailAddress','andrea.ceccanti@cnaf.infn.it'),(40,'userId','2'),(40,'userInstitution','<null>'),(40,'userIsSuspended','false'),(40,'userMembershipExpirationDate','2023-12-29 15:55:35.0'),(40,'userName','<null>'),(40,'userOrgDbId','<null>'),(40,'userPhoneNumber','<null>'),(40,'userSurname','<null>'),(40,'userSuspensionReason','<null>'),(40,'userSuspensionReasonCode','<null>'),(41,'groupName','/vo.0/G1/G4'),(41,'userAddress','<null>'),(41,'userCertificate0','(/C=IT/O=IGI/CN=test1, /C=IT/O=IGI/CN=Test CA)'),(41,'userEmailAddress','andrea.ceccanti@cnaf.infn.it'),(41,'userId','2'),(41,'userInstitution','<null>'),(41,'userIsSuspended','false'),(41,'userMembershipExpirationDate','2023-12-29 15:55:35.0'),(41,'userName','<null>'),(41,'userOrgDbId','<null>'),(41,'userPhoneNumber','<null>'),(41,'userSurname','<null>'),(41,'userSuspensionReason','<null>'),(41,'userSuspensionReasonCode','<null>'),(42,'groupName','/vo.0/G1/G4/G5'),(42,'userAddress','<null>'),(42,'userCertificate0','(/C=IT/O=IGI/CN=test1, /C=IT/O=IGI/CN=Test CA)'),(42,'userEmailAddress','andrea.ceccanti@cnaf.infn.it'),(42,'userId','2'),(42,'userInstitution','<null>'),(42,'userIsSuspended','false'),(42,'userMembershipExpirationDate','2023-12-29 15:55:35.0'),(42,'userName','<null>'),(42,'userOrgDbId','<null>'),(42,'userPhoneNumber','<null>'),(42,'userSurname','<null>'),(42,'userSuspensionReason','<null>'),(42,'userSuspensionReasonCode','<null>'),(43,'groupName','/vo.0/G1'),(43,'roleName','R1'),(43,'userAddress','<null>'),(43,'userCertificate0','(/C=IT/O=IGI/CN=test0, /C=IT/O=IGI/CN=Test CA)'),(43,'userEmailAddress','andrea.ceccanti@cnaf.infn.it'),(43,'userId','1'),(43,'userInstitution','<null>'),(43,'userIsSuspended','false'),(43,'userMembershipExpirationDate','2023-12-29 15:55:35.0'),(43,'userName','<null>'),(43,'userOrgDbId','<null>'),(43,'userPhoneNumber','<null>'),(43,'userSurname','<null>'),(43,'userSuspensionReason','<null>'),(43,'userSuspensionReasonCode','<null>'),(44,'groupName','/vo.0/G2'),(44,'roleName','R1'),(44,'userAddress','<null>'),(44,'userCertificate0','(/C=IT/O=IGI/CN=test0, /C=IT/O=IGI/CN=Test CA)'),(44,'userEmailAddress','andrea.ceccanti@cnaf.infn.it'),(44,'userId','1'),(44,'userInstitution','<null>'),(44,'userIsSuspended','false'),(44,'userMembershipExpirationDate','2023-12-29 15:55:35.0'),(44,'userName','<null>'),(44,'userOrgDbId','<null>'),(44,'userPhoneNumber','<null>'),(44,'userSurname','<null>'),(44,'userSuspensionReason','<null>'),(44,'userSuspensionReasonCode','<null>');
/*!40000 ALTER TABLE `audit_event_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aup`
--

DROP TABLE IF EXISTS `aup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aup` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `reacceptancePeriod` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_ir7101qg1b3bd3lf404nbvv8o` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aup`
--

LOCK TABLES `aup` WRITE;
/*!40000 ALTER TABLE `aup` DISABLE KEYS */;
INSERT INTO `aup` VALUES (1,'VO-AUP','',365);
/*!40000 ALTER TABLE `aup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aup_acc_record`
--

DROP TABLE IF EXISTS `aup_acc_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aup_acc_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `aup_version_id` bigint(20) NOT NULL,
  `usr_id` bigint(20) NOT NULL,
  `last_acceptance_date` datetime NOT NULL,
  `valid` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK77iplyjx00443ic578om7c5w3` (`aup_version_id`,`usr_id`),
  KEY `FKdrqi221poxtbmojk90vcwro7v` (`usr_id`),
  CONSTRAINT `FKdrqi221poxtbmojk90vcwro7v` FOREIGN KEY (`usr_id`) REFERENCES `usr` (`userid`),
  CONSTRAINT `FKifxjljj0ajvbnhi5ldfam0wiw` FOREIGN KEY (`aup_version_id`) REFERENCES `aup_version` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aup_acc_record`
--

LOCK TABLES `aup_acc_record` WRITE;
/*!40000 ALTER TABLE `aup_acc_record` DISABLE KEYS */;
INSERT INTO `aup_acc_record` VALUES (1,1,1,'2022-12-29 15:55:35',''),(2,1,2,'2022-12-29 15:55:35',''),(3,1,3,'2022-12-29 15:55:35','');
/*!40000 ALTER TABLE `aup_acc_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aup_version`
--

DROP TABLE IF EXISTS `aup_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aup_version` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `aup_id` bigint(20) NOT NULL,
  `version` varchar(255) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `text` varchar(255) DEFAULT NULL,
  `creationTime` datetime NOT NULL,
  `lastForcedReacceptanceTime` datetime DEFAULT NULL,
  `active` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKbrom0m14bdqt48ajkwej9g98s` (`aup_id`,`version`),
  CONSTRAINT `fk_aup_version_aup` FOREIGN KEY (`aup_id`) REFERENCES `aup` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aup_version`
--

LOCK TABLES `aup_version` WRITE;
/*!40000 ALTER TABLE `aup_version` DISABLE KEYS */;
INSERT INTO `aup_version` VALUES (1,1,'1.0','file:/etc/voms-admin/vo.0/vo-aup.txt',NULL,'2022-12-29 15:41:32',NULL,'');
/*!40000 ALTER TABLE `aup_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ca`
--

DROP TABLE IF EXISTS `ca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ca` (
  `cid` smallint(6) NOT NULL AUTO_INCREMENT,
  `creation_time` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `subject_string` varchar(255) NOT NULL,
  PRIMARY KEY (`cid`),
  UNIQUE KEY `UK_ijcshg7boq2uao038mecrhyo7` (`subject_string`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ca`
--

LOCK TABLES `ca` WRITE;
/*!40000 ALTER TABLE `ca` DISABLE KEYS */;
INSERT INTO `ca` VALUES (1,'2022-12-29 15:41:31',NULL,'/C=IT/O=IGI/CN=Test CA'),(2,'2022-12-29 15:41:31',NULL,'/C=UK/O=eScienceRoot/OU=Authority/CN=UK e-Science Root'),(3,'2022-12-29 15:41:31',NULL,'/DC=cz/DC=cesnet-ca/O=CESNET CA/CN=CESNET CA Root'),(4,'2022-12-29 15:41:31',NULL,'/C=US/O=DigiCert Inc/OU=www.digicert.com/CN=DigiCert Assured ID Root CA'),(5,'2022-12-29 15:41:31',NULL,'/C=ch/O=CERN/CN=CERN Root Certification Authority 2'),(6,'2022-12-29 15:41:31',NULL,'/DC=ch/DC=cern/CN=CERN Grid Certification Authority'),(7,'2022-12-29 15:41:31',NULL,'/DC=com/DC=DigiCert-Grid/O=DigiCert Grid/CN=DigiCert Grid Root CA'),(8,'2022-12-29 15:41:31',NULL,'/DC=ke/DC=kenet/O=Kenya Education Network Trust/OU=Research Services/CN=KENET ROOT CA'),(9,'2022-12-29 15:41:31',NULL,'/C=US/ST=New Jersey/L=Jersey City/O=The USERTRUST Network/CN=USERTrust RSA Certification Authority'),(10,'2022-12-29 15:41:31',NULL,'/C=AE/O=DigitalTrust L.L.C./CN=DigitalTrust Private Root CA G4'),(11,'2022-12-29 15:41:31',NULL,'/C=US/ST=New Jersey/L=Jersey City/O=The USERTRUST Network/CN=USERTrust ECC Certification Authority'),(12,'2022-12-29 15:41:31',NULL,'/C=AE/O=DigitalTrust L.L.C./CN=DigitalTrust IGTF CA'),(13,'2022-12-29 15:41:31',NULL,'/C=GB/ST=Greater Manchester/L=Salford/O=COMODO CA Limited/CN=COMODO RSA Certification Authority'),(14,'2022-12-29 15:41:31',NULL,'/C=AE/O=Digital Trust L.L.C./CN=DigitalTrust Secure CA G3  [Run by the Issuer]'),(15,'2022-12-29 15:41:31',NULL,'/DC=cz/DC=cesnet-ca/O=CESNET CA/CN=CESNET CA 4'),(16,'2022-12-29 15:41:31',NULL,'/C=US/O=Internet2/OU=InCommon/CN=InCommon IGTF Server CA'),(17,'2022-12-29 15:41:31',NULL,'/C=AE/O=Digital Trust L.L.C./CN=DigitalTrust Assured CA G3  [Run by the Issuer]'),(18,'2022-12-29 15:41:31',NULL,'/DC=com/DC=DigiCert-Grid/O=DigiCert Grid/CN=DigiCert Grid CA-1'),(19,'2022-12-29 15:41:31',NULL,'/C=NL/O=GEANT Vereniging/CN=GEANT eScience SSL ECC CA 4'),(20,'2022-12-29 15:41:31',NULL,'/DC=com/DC=DigiCert-Grid/O=DigiCert Grid/CN=DigiCert Grid CA-1 G2'),(21,'2022-12-29 15:41:31',NULL,'/C=AE/O=Digital Trust L.L.C./CN=DigitalTrust Assured CA G4  [Run by the Issuer]'),(22,'2022-12-29 15:41:31',NULL,'/C=NL/O=GEANT Vereniging/CN=GEANT eScience SSL CA 4'),(23,'2022-12-29 15:41:31',NULL,'/C=UK/O=eScienceCA/OU=Authority/CN=UK e-Science CA 2B'),(24,'2022-12-29 15:41:31',NULL,'/C=NL/O=GEANT Vereniging/CN=GEANT eScience Personal ECC CA 4'),(25,'2022-12-29 15:41:31',NULL,'/C=AE/O=Digital Trust L.L.C./CN=DigitalTrust Secure CA G4  [Run by the Issuer]'),(26,'2022-12-29 15:41:31',NULL,'/DC=ke/DC=kenet/O=Kenya Education Network Trust/OU=Research Services/CN=KENET CA'),(27,'2022-12-29 15:41:31',NULL,'/C=NL/O=GEANT Vereniging/CN=GEANT eScience Personal CA 4'),(28,'2022-12-29 15:41:31',NULL,'/C=NL/ST=Noord-Holland/L=Amsterdam/O=TERENA/CN=TERENA eScience Personal CA 3'),(29,'2022-12-29 15:41:31',NULL,'/C=US/O=DigiCert, Inc./CN=DigiCert Assured ID Grid Client RSA2048 SHA256 2022 CA1'),(30,'2022-12-29 15:41:31',NULL,'/C=US/O=DigiCert Grid/OU=www.digicert.com/CN=DigiCert Grid Trust CA'),(31,'2022-12-29 15:41:31',NULL,'/C=NL/ST=Noord-Holland/L=Amsterdam/O=TERENA/CN=TERENA eScience SSL CA 3'),(32,'2022-12-29 15:41:31',NULL,'/C=US/O=DigiCert, Inc./CN=DigiCert Assured ID Grid TLS RSA2048 SHA256 2022 CA1'),(33,'2022-12-29 15:41:31',NULL,'/DC=me/DC=ac/DC=MREN/CN=MREN-CA'),(34,'2022-12-29 15:41:31',NULL,'/C=RU/O=RDIG/CN=Russian Data-Intensive Grid CA'),(35,'2022-12-29 15:41:31',NULL,'/C=HR/O=edu/OU=srce/CN=SRCE CA'),(36,'2022-12-29 15:41:31',NULL,'/C=SI/O=SiGNET/CN=SiGNET CA'),(37,'2022-12-29 15:41:31',NULL,'/C=FR/O=MENESR/OU=GRID-FR/CN=AC GRID-FR Personnels'),(38,'2022-12-29 15:41:31',NULL,'/C=FR/O=MENESR/OU=GRID-FR/CN=AC GRID-FR'),(39,'2022-12-29 15:41:31',NULL,'/C=US/O=DigiCert Grid/OU=www.digicert.com/CN=DigiCert Grid Trust CA G2'),(40,'2022-12-29 15:41:31',NULL,'/C=RS/O=AEGIS/CN=AEGIS-CA'),(41,'2022-12-29 15:41:31',NULL,'/C=BR/O=ANSP/OU=ANSPGrid CA/CN=ANSPGrid CA'),(42,'2022-12-29 15:41:31',NULL,'/C=MA/O=MaGrid/CN=MaGrid CA'),(43,'2022-12-29 15:41:31',NULL,'/C=KR/O=KISTI/CN=KISTI Certification Authority'),(44,'2022-12-29 15:41:31',NULL,'/C=PT/O=LIPCA/CN=LIP Certification Authority'),(45,'2022-12-29 15:41:31',NULL,'/C=HU/O=NIIF/OU=Certificate Authorities/CN=NIIF Root CA 2'),(46,'2022-12-29 15:41:31',NULL,'/C=JP/O=NII/OU=HPCI/CN=HPCI CA'),(47,'2022-12-29 15:41:31',NULL,'/DC=bg/DC=acad/CN=BG.ACAD CA'),(48,'2022-12-29 15:41:31',NULL,'/C=PL/O=GRID/CN=Polish Grid CA 2019'),(49,'2022-12-29 15:41:31',NULL,'/DC=ORG/DC=SEE-GRID/CN=SEE-GRID CA 2013'),(50,'2022-12-29 15:41:31',NULL,'/C=FR/O=MENESR/OU=GRID-FR/CN=AC GRID-FR Services'),(51,'2022-12-29 15:41:31',NULL,'/DC=nl/DC=dutchgrid/O=Certification Authorities/CN=DCA Root G1 CA'),(52,'2022-12-29 15:41:31',NULL,'/DC=org/DC=cilogon/C=US/O=CILogon/CN=CILogon Silver CA 1'),(53,'2022-12-29 15:41:31',NULL,'/C=BM/O=QuoVadis Limited/CN=QuoVadis Root CA 3 G3'),(54,'2022-12-29 15:41:31',NULL,'/C=DE/O=GermanGrid/CN=GridKa-CA'),(55,'2022-12-29 15:41:31',NULL,'/C=MK/O=MARGI/CN=MARGI-CA'),(56,'2022-12-29 15:41:31',NULL,'/DC=CN/DC=Grid/CN=Root Certificate Authority at CNIC'),(57,'2022-12-29 15:41:31',NULL,'/DC=org/DC=ugrid/CN=UGRID CA G2'),(58,'2022-12-29 15:41:31',NULL,'/C=CA/O=Grid/CN=Grid Canada Certificate Authority'),(59,'2022-12-29 15:41:31',NULL,'/C=NL/O=NIKHEF/CN=NIKHEF medium-security certification auth'),(60,'2022-12-29 15:41:31',NULL,'/C=BM/O=QuoVadis Limited/CN=QuoVadis Grid ICA G2'),(61,'2022-12-29 15:41:31',NULL,'/C=CN/O=HEP/CN=Institute of High Energy Physics Certification Authority'),(62,'2022-12-29 15:41:31',NULL,'/DC=HK/DC=HKU/DC=GRID/CN=HKU Grid CA 2'),(63,'2022-12-29 15:41:31',NULL,'/DC=DZ/DC=ARN/O=DZ e-Science GRID/CN=DZ e-Science CA'),(64,'2022-12-29 15:41:31',NULL,'/DC=RO/DC=RomanianGRID/O=ROSA/OU=Certification Authority/CN=RomanianGRID CA'),(65,'2022-12-29 15:41:31',NULL,'/C=TR/O=TRGrid/CN=TR-Grid CA'),(66,'2022-12-29 15:41:31',NULL,'/C=FR/O=MENESR/OU=GRID-FR/CN=AC GRID-FR Robots'),(67,'2022-12-29 15:41:31',NULL,'/DC=CN/DC=Grid/DC=SDG/CN=Scientific Data Grid CA - G2'),(68,'2022-12-29 15:41:31',NULL,'/C=AM/O=ArmeSFo/CN=ArmeSFo CA'),(69,'2022-12-29 15:41:31',NULL,'/C=BM/O=QuoVadis Limited/CN=QuoVadis Root CA 2 G3'),(70,'2022-12-29 15:41:31',NULL,'/DC=GE/DC=TSU/CN=TSU Root CA'),(71,'2022-12-29 15:41:31',NULL,'/C=PK/O=NCP/CN=PK-GRID-CA'),(72,'2022-12-29 15:41:31',NULL,'/C=GR/O=HellasGrid/OU=Certification Authorities/CN=HellasGrid CA 2016'),(73,'2022-12-29 15:41:31',NULL,'/C=JP/O=KEK/OU=CRC/CN=KEK GRID Certificate Authority'),(74,'2022-12-29 15:41:31',NULL,'/DC=by/DC=grid/O=uiip.bas-net.by/CN=Belarusian Grid Certification Authority'),(75,'2022-12-29 15:41:31',NULL,'/O=Grid/O=NorduGrid/CN=NorduGrid Certification Authority 2015'),(76,'2022-12-29 15:41:31',NULL,'/DC=IN/DC=GARUDAINDIA/CN=Indian Grid Certification Authority 2'),(77,'2022-12-29 15:41:31',NULL,'/C=MX/O=UNAMgrid/OU=UNAM/CN=CA'),(78,'2022-12-29 15:41:31',NULL,'/C=BM/O=QuoVadis Limited/CN=QuoVadis Root CA 2'),(79,'2022-12-29 15:41:31',NULL,'/C=DE/O=DFN-Verein/OU=DFN-PKI/CN=DFN-Verein PCA Grid - G01'),(80,'2022-12-29 15:41:31',NULL,'/C=SK/O=SlovakGrid/CN=SlovakGrid CA'),(81,'2022-12-29 15:41:31',NULL,'/C=MX/O=UNAM/OU=UNAMgrid/CN=PKIUNAMgrid'),(82,'2022-12-29 15:41:31',NULL,'/C=AR/O=e-Ciencia/OU=UNLP/L=CeSPI/CN=PKIGrid'),(83,'2022-12-29 15:41:31',NULL,'/C=TW/O=AS/CN=Academia Sinica Grid Computing Certification Authority Mercury'),(84,'2022-12-29 15:41:31',NULL,'/C=IR/O=IPM/OU=GCG/CN=IRAN-GRID-G2 CA'),(85,'2022-12-29 15:41:31',NULL,'/C=CL/O=REUNACA/CN=REUNA Certification Authority'),(86,'2022-12-29 15:41:32','A dummy CA for local mainteneance','/O=VOMS/O=System/CN=Dummy Certificate Authority'),(87,'2022-12-29 15:41:32','A virtual CA for VOMS groups.','/O=VOMS/O=System/CN=VOMS Group'),(88,'2022-12-29 15:41:32','A virtual CA for VOMS roles.','/O=VOMS/O=System/CN=VOMS Role'),(89,'2022-12-29 15:41:32','A virtual CA for authz manager attributes','/O=VOMS/O=System/CN=Authorization Manager Attributes');
/*!40000 ALTER TABLE `ca` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `certificate`
--

DROP TABLE IF EXISTS `certificate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `certificate` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `creation_time` datetime NOT NULL,
  `subject_string` varchar(255) NOT NULL,
  `suspended` bit(1) NOT NULL,
  `suspended_reason` varchar(255) DEFAULT NULL,
  `suspension_reason_code` varchar(255) DEFAULT NULL,
  `ca_id` smallint(6) NOT NULL,
  `usr_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_6ysgpq5puh6xqy1usr4onuoev` (`ca_id`,`subject_string`),
  KEY `FKkb7e54la0ccr3ab5y4h9lij70` (`usr_id`),
  CONSTRAINT `FKkb7e54la0ccr3ab5y4h9lij70` FOREIGN KEY (`usr_id`) REFERENCES `usr` (`userid`),
  CONSTRAINT `FKel2r2kdcrb505i3y13forh2so` FOREIGN KEY (`ca_id`) REFERENCES `ca` (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certificate`
--

LOCK TABLES `certificate` WRITE;
/*!40000 ALTER TABLE `certificate` DISABLE KEYS */;
INSERT INTO `certificate` VALUES 
  (1,'2022-12-29 15:55:35','/C=IT/O=IGI/CN=test0','\0',NULL,NULL,1,1),
  (2,'2022-12-29 15:55:35','/C=IT/O=IGI/CN=test1','\0',NULL,NULL,1,2),
  (3,'2022-12-29 15:55:35','/C=IT/O=IGI/CN=(Parenthesis)','\0',NULL,NULL,1,3),
  (4,'2022-12-29 15:55:35','/C=IT/O=IGI/CN=test2','\1',NULL,NULL,1,4);
/*!40000 ALTER TABLE `certificate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `certificate_request`
--

DROP TABLE IF EXISTS `certificate_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `certificate_request` (
  `certificate` tinyblob,
  `certificateIssuer` varchar(255) NOT NULL,
  `certificateSubject` varchar(255) NOT NULL,
  `request_id` bigint(20) NOT NULL,
  PRIMARY KEY (`request_id`),
  CONSTRAINT `FKffx6byd23uwqyfbxbh0ukkjxf` FOREIGN KEY (`request_id`) REFERENCES `req` (`request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certificate_request`
--

LOCK TABLES `certificate_request` WRITE;
/*!40000 ALTER TABLE `certificate_request` DISABLE KEYS */;
/*!40000 ALTER TABLE `certificate_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_attrs`
--

DROP TABLE IF EXISTS `group_attrs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_attrs` (
  `a_value` varchar(255) DEFAULT NULL,
  `g_id` bigint(20) NOT NULL,
  `a_id` bigint(20) NOT NULL,
  PRIMARY KEY (`g_id`,`a_id`),
  KEY `FK1xa2c20386u0svawqoluhxsmn` (`a_id`),
  CONSTRAINT `FK1xa2c20386u0svawqoluhxsmn` FOREIGN KEY (`a_id`) REFERENCES `attributes` (`a_id`),
  CONSTRAINT `FKbrbcvfn7vl89v9tosar71x2kk` FOREIGN KEY (`g_id`) REFERENCES `groups` (`gid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_attrs`
--

LOCK TABLES `group_attrs` WRITE;
/*!40000 ALTER TABLE `group_attrs` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_attrs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_membership_req`
--

DROP TABLE IF EXISTS `group_membership_req`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_membership_req` (
  `groupName` varchar(255) NOT NULL,
  `request_id` bigint(20) NOT NULL,
  PRIMARY KEY (`request_id`),
  CONSTRAINT `FKjt7yiemmk5x70mraypjyic2yo` FOREIGN KEY (`request_id`) REFERENCES `req` (`request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_membership_req`
--

LOCK TABLES `group_membership_req` WRITE;
/*!40000 ALTER TABLE `group_membership_req` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_membership_req` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `gid` bigint(20) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `must` bit(1) NOT NULL,
  `dn` varchar(255) NOT NULL,
  `restricted` bit(1) DEFAULT NULL,
  `parent` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`gid`),
  UNIQUE KEY `UK_p6xd8jw7fskeettouu94wvenw` (`dn`),
  KEY `FK8bdxib4gdcu5wnu5rdktblnw4` (`parent`),
  CONSTRAINT `FK8bdxib4gdcu5wnu5rdktblnw4` FOREIGN KEY (`parent`) REFERENCES `groups` (`gid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES (1,NULL,'','/vo.0','\0',1),(2,NULL,'','/vo.0/G1','\0',1),(3,NULL,'','/vo.0/G2','\0',1),(4,NULL,'','/vo.0/G2/G3','\0',3),(5,NULL,'','/vo.0/G1/G4','\0',2),(6,NULL,'','/vo.0/G1/G4/G5','\0',5);
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m`
--

DROP TABLE IF EXISTS `m`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m` (
  `mapping_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `gid` bigint(20) NOT NULL,
  `rid` bigint(20) DEFAULT NULL,
  `userid` bigint(20) NOT NULL,
  PRIMARY KEY (`mapping_id`),
  UNIQUE KEY `UK_s0kk4vf74glrevn178jul85lv` (`gid`,`rid`,`userid`),
  KEY `fk_m_roles` (`rid`),
  KEY `fk_m_usr` (`userid`),
  CONSTRAINT `fk_m_usr` FOREIGN KEY (`userid`) REFERENCES `usr` (`userid`),
  CONSTRAINT `fk_m_groups` FOREIGN KEY (`gid`) REFERENCES `groups` (`gid`),
  CONSTRAINT `fk_m_roles` FOREIGN KEY (`rid`) REFERENCES `roles` (`rid`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m`
--

LOCK TABLES `m` WRITE;
/*!40000 ALTER TABLE `m` DISABLE KEYS */;
INSERT INTO `m` VALUES (1,1,NULL,1),(2,1,NULL,2),(3,1,NULL,3),(4,2,NULL,1),(8,2,NULL,2),(11,2,2,1),(5,3,NULL,1),(7,3,NULL,2),(12,3,2,1),(6,4,NULL,1),(9,5,NULL,2),(10,6,NULL,2);
/*!40000 ALTER TABLE `m` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `managers`
--

DROP TABLE IF EXISTS `managers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `managers` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) NOT NULL,
  `email_address` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_q9ry7h5fjsr34faplpi9q9pfb` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `managers`
--

LOCK TABLES `managers` WRITE;
/*!40000 ALTER TABLE `managers` DISABLE KEYS */;
/*!40000 ALTER TABLE `managers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `managers_groups`
--

DROP TABLE IF EXISTS `managers_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `managers_groups` (
  `manager_id` bigint(20) NOT NULL,
  `group_id` bigint(20) NOT NULL,
  PRIMARY KEY (`manager_id`,`group_id`),
  KEY `FK98y9ptn3n9put3itw2bvoskq5` (`group_id`),
  CONSTRAINT `FK96p7kx5f0wom81jok7lni54g5` FOREIGN KEY (`manager_id`) REFERENCES `managers` (`id`),
  CONSTRAINT `FK98y9ptn3n9put3itw2bvoskq5` FOREIGN KEY (`group_id`) REFERENCES `groups` (`gid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `managers_groups`
--

LOCK TABLES `managers_groups` WRITE;
/*!40000 ALTER TABLE `managers_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `managers_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `membership_rem_req`
--

DROP TABLE IF EXISTS `membership_rem_req`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `membership_rem_req` (
  `reason` varchar(255) NOT NULL,
  `request_id` bigint(20) NOT NULL,
  PRIMARY KEY (`request_id`),
  CONSTRAINT `FKh322dmay39iphthnt34pl67qf` FOREIGN KEY (`request_id`) REFERENCES `req` (`request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `membership_rem_req`
--

LOCK TABLES `membership_rem_req` WRITE;
/*!40000 ALTER TABLE `membership_rem_req` DISABLE KEYS */;
/*!40000 ALTER TABLE `membership_rem_req` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `creation_time` datetime NOT NULL,
  `handler_id` varchar(255) DEFAULT NULL,
  `message` text NOT NULL,
  `messageType` varchar(512) NOT NULL,
  `status` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `notification_msg_type_idx` (`messageType`),
  KEY `notification_status_idx` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_delivery`
--

DROP TABLE IF EXISTS `notification_delivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_delivery` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `delivery_timestamp` datetime NOT NULL,
  `error_message` text,
  `handler_id` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `notification_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `nd_handler_id_idx` (`handler_id`),
  KEY `nd_status_idx` (`status`),
  KEY `FK9lrx02ouc003xoktuuvlqf15a` (`notification_id`),
  CONSTRAINT `FK9lrx02ouc003xoktuuvlqf15a` FOREIGN KEY (`notification_id`) REFERENCES `notification` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_delivery`
--

LOCK TABLES `notification_delivery` WRITE;
/*!40000 ALTER TABLE `notification_delivery` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_delivery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_recipients`
--

DROP TABLE IF EXISTS `notification_recipients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_recipients` (
  `Notification_id` bigint(20) NOT NULL,
  `element` varchar(255) DEFAULT NULL,
  KEY `FKfw4jvcyr9ic0iwgw1k0j9hwtv` (`Notification_id`),
  CONSTRAINT `FKfw4jvcyr9ic0iwgw1k0j9hwtv` FOREIGN KEY (`Notification_id`) REFERENCES `notification` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_recipients`
--

LOCK TABLES `notification_recipients` WRITE;
/*!40000 ALTER TABLE `notification_recipients` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_recipients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `periodic_notifications`
--

DROP TABLE IF EXISTS `periodic_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `periodic_notifications` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `lastNotificationTime` datetime NOT NULL,
  `notificationType` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_olkk7xin2f0ysnp14v7v2jbgd` (`notificationType`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `periodic_notifications`
--

LOCK TABLES `periodic_notifications` WRITE;
/*!40000 ALTER TABLE `periodic_notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `periodic_notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_info`
--

DROP TABLE IF EXISTS `personal_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personal_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `value` varchar(255) DEFAULT NULL,
  `visible` bit(1) DEFAULT NULL,
  `personal_info_type_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK871fyo7g5aq5y8ppso5a07m5j` (`personal_info_type_id`),
  CONSTRAINT `FK871fyo7g5aq5y8ppso5a07m5j` FOREIGN KEY (`personal_info_type_id`) REFERENCES `personal_info_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_info`
--

LOCK TABLES `personal_info` WRITE;
/*!40000 ALTER TABLE `personal_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_info_type`
--

DROP TABLE IF EXISTS `personal_info_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personal_info_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_3onn6dnqn27la7vwg6mqd1lih` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_info_type`
--

LOCK TABLES `personal_info_type` WRITE;
/*!40000 ALTER TABLE `personal_info_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_info_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `req`
--

DROP TABLE IF EXISTS `req`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `req` (
  `request_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `approver_ca` varchar(255) DEFAULT NULL,
  `approver_dn` varchar(255) DEFAULT NULL,
  `completionDate` datetime DEFAULT NULL,
  `creationDate` datetime DEFAULT NULL,
  `expirationDate` datetime DEFAULT NULL,
  `explanation` varchar(512) DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `user_message` varchar(512) DEFAULT NULL,
  `requester_info_id` bigint(20) NOT NULL,
  PRIMARY KEY (`request_id`),
  UNIQUE KEY `UK_fgvo7hipyqlarsyya5l7syjwc` (`requester_info_id`),
  CONSTRAINT `FKaj00l1e8rkndd7jr9v6gtove5` FOREIGN KEY (`requester_info_id`) REFERENCES `requester_info` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `req`
--

LOCK TABLES `req` WRITE;
/*!40000 ALTER TABLE `req` DISABLE KEYS */;
/*!40000 ALTER TABLE `req` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `requester_info`
--

DROP TABLE IF EXISTS `requester_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `requester_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `certificateIssuer` varchar(255) NOT NULL,
  `certificateSubject` varchar(255) NOT NULL,
  `emailAddress` varchar(255) NOT NULL,
  `institution` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `phoneNumber` varchar(255) DEFAULT NULL,
  `surname` varchar(255) DEFAULT NULL,
  `voMember` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `requester_info`
--

LOCK TABLES `requester_info` WRITE;
/*!40000 ALTER TABLE `requester_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `requester_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `requester_personal_info`
--

DROP TABLE IF EXISTS `requester_personal_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `requester_personal_info` (
  `requester_id` bigint(20) NOT NULL,
  `pi_value` varchar(255) DEFAULT NULL,
  `pi_key` varchar(255) NOT NULL,
  PRIMARY KEY (`requester_id`,`pi_key`),
  CONSTRAINT `FKjj70k7i0ty2hrp24t6uo1qdlg` FOREIGN KEY (`requester_id`) REFERENCES `requester_info` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `requester_personal_info`
--

LOCK TABLES `requester_personal_info` WRITE;
/*!40000 ALTER TABLE `requester_personal_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `requester_personal_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_attrs`
--

DROP TABLE IF EXISTS `role_attrs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_attrs` (
  `a_value` varchar(255) DEFAULT NULL,
  `r_id` bigint(20) NOT NULL,
  `g_id` bigint(20) NOT NULL,
  `a_id` bigint(20) NOT NULL,
  PRIMARY KEY (`r_id`,`g_id`,`a_id`),
  KEY `FK257mewjga6jno1an0o74sexd2` (`g_id`),
  KEY `FKbdijpvun5uf4xabxoke24ga1i` (`a_id`),
  CONSTRAINT `FKbdijpvun5uf4xabxoke24ga1i` FOREIGN KEY (`a_id`) REFERENCES `attributes` (`a_id`),
  CONSTRAINT `FK257mewjga6jno1an0o74sexd2` FOREIGN KEY (`g_id`) REFERENCES `groups` (`gid`),
  CONSTRAINT `FKjl70f40fjs92trmdrfv30bar8` FOREIGN KEY (`r_id`) REFERENCES `roles` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_attrs`
--

LOCK TABLES `role_attrs` WRITE;
/*!40000 ALTER TABLE `role_attrs` DISABLE KEYS */;
/*!40000 ALTER TABLE `role_attrs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_membership_req`
--

DROP TABLE IF EXISTS `role_membership_req`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_membership_req` (
  `groupName` varchar(255) DEFAULT NULL,
  `roleName` varchar(255) DEFAULT NULL,
  `request_id` bigint(20) NOT NULL,
  PRIMARY KEY (`request_id`),
  CONSTRAINT `FKr0x8sn6bh5l91m1f387jpq7wu` FOREIGN KEY (`request_id`) REFERENCES `req` (`request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_membership_req`
--

LOCK TABLES `role_membership_req` WRITE;
/*!40000 ALTER TABLE `role_membership_req` DISABLE KEYS */;
/*!40000 ALTER TABLE `role_membership_req` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `rid` bigint(20) NOT NULL AUTO_INCREMENT,
  `role` varchar(255) NOT NULL,
  PRIMARY KEY (`rid`),
  UNIQUE KEY `UK_g50w4r0ru3g9uf6i6fr4kpro8` (`role`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (2,'R1'),(3,'R2'),(4,'R3'),(1,'VO-Admin');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sign_aup_task`
--

DROP TABLE IF EXISTS `sign_aup_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sign_aup_task` (
  `last_notification_time` datetime DEFAULT NULL,
  `task_id` bigint(20) NOT NULL,
  `aup_id` bigint(20) NOT NULL,
  PRIMARY KEY (`task_id`),
  KEY `FKb67h1fmkxbtqdnoytpx8lrrp2` (`aup_id`),
  CONSTRAINT `FK458mckroyg0q6fr8g2vw325do` FOREIGN KEY (`task_id`) REFERENCES `task` (`task_id`),
  CONSTRAINT `FKb67h1fmkxbtqdnoytpx8lrrp2` FOREIGN KEY (`aup_id`) REFERENCES `aup` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sign_aup_task`
--

LOCK TABLES `sign_aup_task` WRITE;
/*!40000 ALTER TABLE `sign_aup_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `sign_aup_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task` (
  `task_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `completionDate` datetime DEFAULT NULL,
  `creationDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `admin_id` bigint(20) DEFAULT NULL,
  `task_type_id` bigint(20) NOT NULL,
  `usr_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`task_id`),
  KEY `FK27qusnaedvo1xl69yutnkixsu` (`admin_id`),
  KEY `FK7pubtrvmiv3ul001yhj7lq89k` (`task_type_id`),
  KEY `FK70lg450vhgn8yvceqdj4c3hd9` (`usr_id`),
  CONSTRAINT `FK70lg450vhgn8yvceqdj4c3hd9` FOREIGN KEY (`usr_id`) REFERENCES `usr` (`userid`),
  CONSTRAINT `FK27qusnaedvo1xl69yutnkixsu` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`adminid`),
  CONSTRAINT `FK7pubtrvmiv3ul001yhj7lq89k` FOREIGN KEY (`task_type_id`) REFERENCES `task_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_lock`
--

DROP TABLE IF EXISTS `task_lock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_lock` (
  `task_name` varchar(64) NOT NULL,
  `created_at` datetime NOT NULL,
  `finished_at` datetime DEFAULT NULL,
  `service_id` varchar(255) NOT NULL,
  PRIMARY KEY (`task_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_lock`
--

LOCK TABLES `task_lock` WRITE;
/*!40000 ALTER TABLE `task_lock` DISABLE KEYS */;
INSERT INTO `task_lock` VALUES ('CancelSignAUPTasksForExpiredUsersTask','2023-01-23 16:47:35','2023-01-23 16:47:35','meteora.cloud.cnaf.infn.it:8443'),('ExpiredRequestsPurgerTask','2023-01-23 16:52:35','2023-01-23 16:52:35','meteora.cloud.cnaf.infn.it:8443'),('ExpiredUserCleanupTask','2023-01-23 16:47:36','2023-01-23 16:47:36','meteora.cloud.cnaf.infn.it:8443'),('MembershipCheckerTask','2023-01-23 16:47:36','2023-01-23 16:47:36','meteora.cloud.cnaf.infn.it:8443'),('SignAUPReminderCheckTask','2023-01-23 16:47:35','2023-01-23 16:47:35','meteora.cloud.cnaf.infn.it:8443'),('TaskStatusUpdater','2023-01-23 16:52:35','2023-01-23 16:52:35','meteora.cloud.cnaf.infn.it:8443'),('UpdateCATask','2023-01-23 16:47:36','2023-01-23 16:47:36','meteora.cloud.cnaf.infn.it:8443'),('UserStatsTask','2023-01-23 16:47:36','2023-01-23 16:47:36','meteora.cloud.cnaf.infn.it:8443');
/*!40000 ALTER TABLE `task_lock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_log_record`
--

DROP TABLE IF EXISTS `task_log_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_log_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `adminDn` varchar(255) DEFAULT NULL,
  `creation_time` datetime NOT NULL,
  `event` varchar(255) NOT NULL,
  `userDn` varchar(255) DEFAULT NULL,
  `task_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKshwhxt353ifnwpq7e36cyl6px` (`task_id`),
  CONSTRAINT `FKshwhxt353ifnwpq7e36cyl6px` FOREIGN KEY (`task_id`) REFERENCES `task` (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_log_record`
--

LOCK TABLES `task_log_record` WRITE;
/*!40000 ALTER TABLE `task_log_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_log_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_type`
--

DROP TABLE IF EXISTS `task_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_s65lx142vjv7nra6n8d9edfnf` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_type`
--

LOCK TABLES `task_type` WRITE;
/*!40000 ALTER TABLE `task_type` DISABLE KEYS */;
INSERT INTO `task_type` VALUES (1,'Tasks of this type are assigned to users that need to sign, or resign an AUP.','SignAUPTask'),(2,'Tasks of this type are assigned to VO admins that need to approve users\' requests.','ApproveUserRequestTask');
/*!40000 ALTER TABLE `task_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_request_task`
--

DROP TABLE IF EXISTS `user_request_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_request_task` (
  `task_id` bigint(20) NOT NULL,
  `req_id` bigint(20) NOT NULL,
  PRIMARY KEY (`task_id`),
  KEY `FKcvlhe8n34jxy3g53on93uihuf` (`req_id`),
  CONSTRAINT `FK8rwvt5u7qndmprmupdiqila9s` FOREIGN KEY (`task_id`) REFERENCES `task` (`task_id`),
  CONSTRAINT `FKcvlhe8n34jxy3g53on93uihuf` FOREIGN KEY (`req_id`) REFERENCES `req` (`request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_request_task`
--

LOCK TABLES `user_request_task` WRITE;
/*!40000 ALTER TABLE `user_request_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_request_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usr`
--

DROP TABLE IF EXISTS `usr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usr` (
  `userid` bigint(20) NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `creation_time` datetime NOT NULL,
  `dn` varchar(255) DEFAULT NULL,
  `email_address` varchar(255) NOT NULL,
  `end_time` datetime DEFAULT NULL,
  `institution` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `orgdb_id` bigint(20) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `surname` varchar(255) DEFAULT NULL,
  `suspended` bit(1) DEFAULT NULL,
  `suspension_reason` varchar(255) DEFAULT NULL,
  `suspension_reason_code` varchar(255) DEFAULT NULL,
  `ca` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`userid`),
  KEY `FKlftmj115y05xwwytefm6u73v0` (`ca`),
  CONSTRAINT `FKlftmj115y05xwwytefm6u73v0` FOREIGN KEY (`ca`) REFERENCES `ca` (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usr`
--

LOCK TABLES `usr` WRITE;
/*!40000 ALTER TABLE `usr` DISABLE KEYS */;
INSERT INTO `usr` VALUES 
  (1,NULL,'2022-12-29 15:55:35','/C=IT/O=IGI/CN=test0','test0@cnaf.infn.it','2023-12-29 15:55:35',NULL,NULL,NULL,NULL,NULL,'\0',NULL,NULL,NULL),
  (2,NULL,'2022-12-29 15:55:35','/C=IT/O=IGI/CN=test1','test1@cnaf.infn.it','2023-12-29 15:55:35',NULL,NULL,NULL,NULL,NULL,'\0',NULL,NULL,NULL),
  (3,NULL,'2022-12-29 15:55:35','/C=IT/O=IGI/CN=(Parenthesis)','(Parenthesis)@cnaf.infn.it','2023-12-29 15:55:35',NULL,NULL,NULL,NULL,NULL,'\0',NULL,NULL,NULL),
  (4,NULL,'2022-12-29 15:55:35','/C=IT/O=IGI/CN=test2','test2@cnaf.infn.it','2023-12-29 15:55:35',NULL,NULL,NULL,NULL,NULL,'\1',NULL,NULL,NULL);
/*!40000 ALTER TABLE `usr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usr_attrs`
--

DROP TABLE IF EXISTS `usr_attrs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usr_attrs` (
  `a_value` varchar(255) DEFAULT NULL,
  `u_id` bigint(20) NOT NULL,
  `a_id` bigint(20) NOT NULL,
  PRIMARY KEY (`u_id`,`a_id`),
  KEY `ua_value_idx` (`a_id`,`a_value`),
  CONSTRAINT `FK4r0mjfx0msm39hgg7ufy1bri1` FOREIGN KEY (`a_id`) REFERENCES `attributes` (`a_id`),
  CONSTRAINT `FKsie7arnxufe6xk498dw9t1l24` FOREIGN KEY (`u_id`) REFERENCES `usr` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usr_attrs`
--

LOCK TABLES `usr_attrs` WRITE;
/*!40000 ALTER TABLE `usr_attrs` DISABLE KEYS */;
/*!40000 ALTER TABLE `usr_attrs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `version`
--

DROP TABLE IF EXISTS `version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `version` (
  `version` int(11) NOT NULL,
  `admin_version` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `version`
--

LOCK TABLES `version` WRITE;
/*!40000 ALTER TABLE `version` DISABLE KEYS */;
INSERT INTO `version` VALUES (3,'6');
/*!40000 ALTER TABLE `version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vo_membership_req`
--

DROP TABLE IF EXISTS `vo_membership_req`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vo_membership_req` (
  `confirmId` varchar(255) NOT NULL,
  `request_id` bigint(20) NOT NULL,
  PRIMARY KEY (`request_id`),
  CONSTRAINT `FK23qljqxn4q46y0t2iv4a9vy40` FOREIGN KEY (`request_id`) REFERENCES `req` (`request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vo_membership_req`
--

LOCK TABLES `vo_membership_req` WRITE;
/*!40000 ALTER TABLE `vo_membership_req` DISABLE KEYS */;
/*!40000 ALTER TABLE `vo_membership_req` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-01-23 16:52:59
