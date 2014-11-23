/*
Navicat MySQL Data Transfer

Source Server         : Wamp SQL
Source Server Version : 50520
Source Host           : localhost:3306
Source Database       : entre_aide

Target Server Type    : MYSQL
Target Server Version : 50520
File Encoding         : 65001

Date: 2014-11-23 16:57:32
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `aide`
-- ----------------------------
DROP TABLE IF EXISTS `aide`;
CREATE TABLE `aide` (
  `id_util` int(11) NOT NULL,
  `id_mat` int(11) NOT NULL,
  `id_niveau` int(11) NOT NULL,
  `id_spec` int(11) NOT NULL,
  `type_aide` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id_util`,`id_mat`,`id_niveau`,`id_spec`),
  KEY `fk_aide_niveau` (`id_niveau`),
  KEY `fk_aide_specialiter` (`id_spec`),
  KEY `fk_aide_matiere` (`id_mat`),
  CONSTRAINT `fk_aide_matiere` FOREIGN KEY (`id_mat`) REFERENCES `matiere` (`id_mat`),
  CONSTRAINT `fk_aide_niveau` FOREIGN KEY (`id_niveau`) REFERENCES `niveau` (`id_niveau`),
  CONSTRAINT `fk_aide_specialiter` FOREIGN KEY (`id_spec`) REFERENCES `specialiter` (`id_spec`),
  CONSTRAINT `fk_aide_util` FOREIGN KEY (`id_util`) REFERENCES `utilisateur` (`Id_util`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of aide
-- ----------------------------
INSERT INTO `aide` VALUES ('2', '1', '1', '1', 'Propose');
INSERT INTO `aide` VALUES ('2', '2', '1', '2', 'Propose');
INSERT INTO `aide` VALUES ('2', '3', '4', '2', 'Propose');
INSERT INTO `aide` VALUES ('3', '4', '4', '2', 'Propose');
INSERT INTO `aide` VALUES ('4', '1', '7', '1', 'Propose');

-- ----------------------------
-- Table structure for `matiere`
-- ----------------------------
DROP TABLE IF EXISTS `matiere`;
CREATE TABLE `matiere` (
  `id_mat` int(11) NOT NULL,
  `nom` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id_mat`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of matiere
-- ----------------------------
INSERT INTO `matiere` VALUES ('1', 'Anglais');
INSERT INTO `matiere` VALUES ('2', 'Mathematique');
INSERT INTO `matiere` VALUES ('3', 'Informatique');
INSERT INTO `matiere` VALUES ('4', 'Francais');

-- ----------------------------
-- Table structure for `niveau`
-- ----------------------------
DROP TABLE IF EXISTS `niveau`;
CREATE TABLE `niveau` (
  `id_niveau` int(11) NOT NULL,
  `nom_niv` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id_niveau`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of niveau
-- ----------------------------
INSERT INTO `niveau` VALUES ('1', '6');
INSERT INTO `niveau` VALUES ('2', '5');
INSERT INTO `niveau` VALUES ('3', '4');
INSERT INTO `niveau` VALUES ('4', '3');
INSERT INTO `niveau` VALUES ('5', 'seconde');
INSERT INTO `niveau` VALUES ('6', 'premiere');
INSERT INTO `niveau` VALUES ('7', 'terminal');

-- ----------------------------
-- Table structure for `specialiter`
-- ----------------------------
DROP TABLE IF EXISTS `specialiter`;
CREATE TABLE `specialiter` (
  `id_spec` int(11) NOT NULL,
  `nom` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id_spec`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of specialiter
-- ----------------------------
INSERT INTO `specialiter` VALUES ('1', 'Rien');
INSERT INTO `specialiter` VALUES ('2', 'Approfondie');

-- ----------------------------
-- Table structure for `utilisateur`
-- ----------------------------
DROP TABLE IF EXISTS `utilisateur`;
CREATE TABLE `utilisateur` (
  `Id_util` int(11) NOT NULL,
  `login` varchar(30) DEFAULT NULL,
  `nom` varchar(30) DEFAULT NULL,
  `motdepasse` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`Id_util`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of utilisateur
-- ----------------------------
INSERT INTO `utilisateur` VALUES ('0', null, null, null);
INSERT INTO `utilisateur` VALUES ('1', 'geroge', 'dodo', null);
INSERT INTO `utilisateur` VALUES ('2', 'test', 'test', 'dGVzdA==');
INSERT INTO `utilisateur` VALUES ('3', 'testdd', 'test', '');
INSERT INTO `utilisateur` VALUES ('4', 'testdddzqdzq', 'test', 'dGVzdA==');

-- ----------------------------
-- Procedure structure for `insert_utilisateur`
-- ----------------------------
DROP PROCEDURE IF EXISTS `insert_utilisateur`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_utilisateur`( in login varchar(30),in pass varchar(50),in nom varchar(30))
begin
	declare id int;
	select max(id_util) into id from utilisateur;
	insert into utilisateur
	values(id+1, login, nom, pass);
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `proposer`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proposer`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proposer`( in id_util int,in mat varchar(50) ,in niv varchar(30) ,in spec varchar(30))
begin
	declare idmat int;
	declare idniv int;
	declare idspec int;
	select id_mat into idmat from matiere where nom like mat;
	select id_niveau into idniv from niveau where nom_niv like niv;
	select id_spec into idspec from specialiter where nom like spec;
	insert into aide
	values(id_util,idmat, idniv, idspec,"Propose");
end
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `test`
-- ----------------------------
DROP FUNCTION IF EXISTS `test`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `test`( Log varchar(50),pass varchar(50)) RETURNS int(11)
    READS SQL DATA
begin
	declare var_test int;
	select count(*) into var_test from utilisateur where login like Log and motdepasse like pass;
	return var_test;
end
;;
DELIMITER ;
