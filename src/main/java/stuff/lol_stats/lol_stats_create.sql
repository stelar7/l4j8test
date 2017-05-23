-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema leagueoflegends
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema leagueoflegends
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `leagueoflegends` DEFAULT CHARACTER SET utf8 ;
USE `leagueoflegends` ;

-- -----------------------------------------------------
-- Table `leagueoflegends`.`matches`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `leagueoflegends`.`matches` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `gameid` BIGINT(20) NOT NULL,
  `platformid` VARCHAR(5) CHARACTER SET 'utf8' NOT NULL,
  `queueid` SMALLINT(6) NOT NULL,
  `seasonid` TINYINT(4) NOT NULL,
  `duration` INT(11) NOT NULL,
  `creation` BIGINT(20) NOT NULL,
  `version` VARCHAR(20) CHARACTER SET 'utf8' NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `gp` (`gameid` ASC, `platformid` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 25821
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_swedish_ci;


-- -----------------------------------------------------
-- Table `leagueoflegends`.`matchmasterypage`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `leagueoflegends`.`matchmasterypage` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 34234
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_swedish_ci;


-- -----------------------------------------------------
-- Table `leagueoflegends`.`participants`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `leagueoflegends`.`participants` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `match` BIGINT(20) UNSIGNED NOT NULL,
  `participantid` TINYINT(4) NOT NULL,
  `championid` MEDIUMINT(9) NOT NULL,
  `spell1` TINYINT(4) NOT NULL,
  `spell2` TINYINT(4) NOT NULL,
  `role` VARCHAR(15) CHARACTER SET 'utf8' NOT NULL,
  `lane` VARCHAR(15) CHARACTER SET 'utf8' NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `p_m_idx` (`match` ASC),
  CONSTRAINT `p_m`
    FOREIGN KEY (`match`)
    REFERENCES `leagueoflegends`.`matches` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 257183
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_swedish_ci;


-- -----------------------------------------------------
-- Table `leagueoflegends`.`matchmasteries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `leagueoflegends`.`matchmasteries` (
  `participant` BIGINT(20) UNSIGNED NOT NULL,
  `page` INT(11) NOT NULL,
  PRIMARY KEY (`participant`, `page`),
  INDEX `mm_mmp_idx` (`page` ASC),
  CONSTRAINT `mm_mmp`
    FOREIGN KEY (`page`)
    REFERENCES `leagueoflegends`.`matchmasterypage` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `mm_p`
    FOREIGN KEY (`participant`)
    REFERENCES `leagueoflegends`.`participants` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_swedish_ci;


-- -----------------------------------------------------
-- Table `leagueoflegends`.`matchmasteries_in_page`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `leagueoflegends`.`matchmasteries_in_page` (
  `page` INT(11) NOT NULL,
  `masteryid` SMALLINT(6) NOT NULL,
  `rank` TINYINT(4) NOT NULL,
  UNIQUE INDEX `unique` (`masteryid` ASC, `rank` ASC, `page` ASC),
  INDEX `fk_index` (`page` ASC),
  CONSTRAINT `mmip_mmp`
    FOREIGN KEY (`page`)
    REFERENCES `leagueoflegends`.`matchmasterypage` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_swedish_ci;


-- -----------------------------------------------------
-- Table `leagueoflegends`.`matchrunepage`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `leagueoflegends`.`matchrunepage` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 52015
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_swedish_ci;


-- -----------------------------------------------------
-- Table `leagueoflegends`.`matchrunes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `leagueoflegends`.`matchrunes` (
  `participant` BIGINT(20) UNSIGNED NOT NULL,
  `page` INT(11) NOT NULL,
  PRIMARY KEY (`participant`, `page`),
  INDEX `mr_mrp_idx` (`page` ASC),
  CONSTRAINT `mr_mrp`
    FOREIGN KEY (`page`)
    REFERENCES `leagueoflegends`.`matchrunepage` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `mr_p`
    FOREIGN KEY (`participant`)
    REFERENCES `leagueoflegends`.`participants` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_swedish_ci;


-- -----------------------------------------------------
-- Table `leagueoflegends`.`matchrunes_in_page`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `leagueoflegends`.`matchrunes_in_page` (
  `page` INT(11) NOT NULL,
  `runeid` SMALLINT(6) NOT NULL,
  `rank` TINYINT(4) NOT NULL,
  UNIQUE INDEX `unique` (`rank` ASC, `page` ASC, `runeid` ASC),
  INDEX `fk_index` (`page` ASC),
  CONSTRAINT `mrip_mrp`
    FOREIGN KEY (`page`)
    REFERENCES `leagueoflegends`.`matchrunepage` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_swedish_ci;


-- -----------------------------------------------------
-- Table `leagueoflegends`.`summoners`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `leagueoflegends`.`summoners` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `accountid` INT(11) NOT NULL,
  `summonerid` INT(11) NOT NULL,
  `platformid` VARCHAR(45) CHARACTER SET 'latin1' NOT NULL,
  `name` VARCHAR(45) CHARACTER SET 'utf8' NOT NULL,
  `profileicon` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `acc_pla` (`accountid` ASC, `platformid` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 189735
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_swedish_ci;


-- -----------------------------------------------------
-- Table `leagueoflegends`.`participantidentity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `leagueoflegends`.`participantidentity` (
  `participant` BIGINT(20) UNSIGNED NOT NULL,
  `summoner` BIGINT(20) UNSIGNED NOT NULL,
  PRIMARY KEY (`participant`, `summoner`),
  INDEX `pi_s_idx` (`summoner` ASC),
  CONSTRAINT `pi_p`
    FOREIGN KEY (`participant`)
    REFERENCES `leagueoflegends`.`participants` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `pi_s`
    FOREIGN KEY (`summoner`)
    REFERENCES `leagueoflegends`.`summoners` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_swedish_ci;


-- -----------------------------------------------------
-- Table `leagueoflegends`.`participantstats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `leagueoflegends`.`participantstats` (
  `participant` BIGINT(20) UNSIGNED NOT NULL,
  `win` TINYINT(1) NULL DEFAULT NULL,
  `item0` SMALLINT(6) NULL DEFAULT NULL,
  `item1` SMALLINT(6) NULL DEFAULT NULL,
  `item2` SMALLINT(6) NULL DEFAULT NULL,
  `item3` SMALLINT(6) NULL DEFAULT NULL,
  `item4` SMALLINT(6) NULL DEFAULT NULL,
  `item5` SMALLINT(6) NULL DEFAULT NULL,
  `item6` SMALLINT(6) NULL DEFAULT NULL,
  `kills` SMALLINT(6) NULL DEFAULT NULL,
  `deaths` SMALLINT(6) NULL DEFAULT NULL,
  `assists` SMALLINT(6) NULL DEFAULT NULL,
  `largestkillingspree` SMALLINT(6) NULL DEFAULT NULL,
  `largestmultikill` SMALLINT(6) NULL DEFAULT NULL,
  `killingsprees` SMALLINT(6) NULL DEFAULT NULL,
  `longesttimespentliving` SMALLINT(6) NULL DEFAULT NULL,
  `doublekills` SMALLINT(6) NULL DEFAULT NULL,
  `triplekills` SMALLINT(6) NULL DEFAULT NULL,
  `quadrakills` SMALLINT(6) NULL DEFAULT NULL,
  `pentakills` SMALLINT(6) NULL DEFAULT NULL,
  `unrealkills` SMALLINT(6) NULL DEFAULT NULL,
  `totaldamagedealt` INT(11) NULL DEFAULT NULL,
  `magicdamagedealt` INT(11) NULL DEFAULT NULL,
  `physicaldamagedealt` INT(11) NULL DEFAULT NULL,
  `truedamagedealt` INT(11) NULL DEFAULT NULL,
  `largestcriticalstrike` INT(11) NULL DEFAULT NULL,
  `totaldamagedealttochampions` INT(11) NULL DEFAULT NULL,
  `magicdamagedealttochampions` INT(11) NULL DEFAULT NULL,
  `physicaldamagedealttochampions` INT(11) NULL DEFAULT NULL,
  `truedamagedealttochampions` INT(11) NULL DEFAULT NULL,
  `totalheal` INT(11) NULL DEFAULT NULL,
  `toalunitshealed` TINYINT(4) NULL DEFAULT NULL,
  `damageselfmitigated` INT(11) NULL DEFAULT NULL,
  `damagedealttoobjectives` INT(11) NULL DEFAULT NULL,
  `damagedealttoturrets` INT(11) NULL DEFAULT NULL,
  `visionscore` INT(11) NULL DEFAULT NULL,
  `timeccingothers` INT(11) NULL DEFAULT NULL,
  `totaldamagetaken` INT(11) NULL DEFAULT NULL,
  `magicaldamagetaken` INT(11) NULL DEFAULT NULL,
  `physicaldamagetaken` INT(11) NULL DEFAULT NULL,
  `truedamagetaken` INT(11) NULL DEFAULT NULL,
  `goldearned` INT(11) NULL DEFAULT NULL,
  `goldspent` INT(11) NULL DEFAULT NULL,
  `turretkills` TINYINT(4) NULL DEFAULT NULL,
  `inhibitorkills` TINYINT(4) NULL DEFAULT NULL,
  `totalminionskilled` SMALLINT(6) NULL DEFAULT NULL,
  `neutralminionskilled` SMALLINT(6) NULL DEFAULT NULL,
  `neutralminionskilledteamjungle` SMALLINT(6) NULL DEFAULT NULL,
  `neutralminionskilledenemyjungle` SMALLINT(6) NULL DEFAULT NULL,
  `totaltimecrowdcontrolldealt` SMALLINT(6) NULL DEFAULT NULL,
  `champlevel` TINYINT(4) NULL DEFAULT NULL,
  `visionwardsboughtingame` TINYINT(4) UNSIGNED NULL DEFAULT NULL,
  `sightwardsboughtingame` TINYINT(4) UNSIGNED NULL DEFAULT NULL,
  `wardsplaced` SMALLINT(5) UNSIGNED NULL DEFAULT NULL,
  `wardskilled` TINYINT(4) UNSIGNED NULL DEFAULT NULL,
  `firstbloodkill` TINYINT(1) NULL DEFAULT NULL,
  `firstbloodassist` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`participant`),
  CONSTRAINT `ps_p`
    FOREIGN KEY (`participant`)
    REFERENCES `leagueoflegends`.`participants` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_swedish_ci;


-- -----------------------------------------------------
-- Table `leagueoflegends`.`teambans`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `leagueoflegends`.`teambans` (
  `match` BIGINT(20) UNSIGNED NOT NULL,
  `teamid` TINYINT(4) UNSIGNED NOT NULL,
  `championid` SMALLINT(6) NOT NULL,
  `pickturn` TINYINT(4) NOT NULL,
  PRIMARY KEY (`match`, `teamid`, `pickturn`),
  CONSTRAINT `tb_m`
    FOREIGN KEY (`match`)
    REFERENCES `leagueoflegends`.`matches` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_swedish_ci;


-- -----------------------------------------------------
-- Table `leagueoflegends`.`teamstats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `leagueoflegends`.`teamstats` (
  `match` BIGINT(20) UNSIGNED NOT NULL,
  `teamid` TINYINT(3) UNSIGNED NOT NULL,
  `firstblood` TINYINT(1) NOT NULL,
  `firsttower` TINYINT(1) NOT NULL,
  `firstinhibitor` TINYINT(1) NOT NULL,
  `firstbaron` TINYINT(1) NOT NULL,
  `firstdragon` TINYINT(1) NOT NULL,
  `firstriftherald` TINYINT(1) NOT NULL,
  `towerkills` TINYINT(4) NOT NULL,
  `inhibitorkills` TINYINT(4) NOT NULL,
  `baronkills` TINYINT(4) NOT NULL,
  `dragonkills` TINYINT(4) NOT NULL,
  `riftheraldkills` TINYINT(4) NOT NULL,
  PRIMARY KEY (`match`, `teamid`),
  CONSTRAINT `ts_m`
    FOREIGN KEY (`match`)
    REFERENCES `leagueoflegends`.`matches` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_swedish_ci;

USE `leagueoflegends` ;

-- -----------------------------------------------------
-- Placeholder table for view `leagueoflegends`.`best_masterypage`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `leagueoflegends`.`best_masterypage` (`page` INT, `count` INT);

-- -----------------------------------------------------
-- Placeholder table for view `leagueoflegends`.`best_runepage`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `leagueoflegends`.`best_runepage` (`page` INT, `count` INT);

-- -----------------------------------------------------
-- Placeholder table for view `leagueoflegends`.`most_used_mastery_page`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `leagueoflegends`.`most_used_mastery_page` (`database_page` INT, `mastery` INT, `count` INT);

-- -----------------------------------------------------
-- Placeholder table for view `leagueoflegends`.`most_used_rune_page`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `leagueoflegends`.`most_used_rune_page` (`database_page` INT, `rune` INT, `count` INT);

-- -----------------------------------------------------
-- Placeholder table for view `leagueoflegends`.`select_all_stats_by_name`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `leagueoflegends`.`select_all_stats_by_name` (`summonerName` INT, `season` INT, `queue` INT, `creation` INT, `participant` INT, `win` INT, `item0` INT, `item1` INT, `item2` INT, `item3` INT, `item4` INT, `item5` INT, `item6` INT, `kills` INT, `deaths` INT, `assists` INT, `largestkillingspree` INT, `largestmultikill` INT, `killingsprees` INT, `longesttimespentliving` INT, `doublekills` INT, `triplekills` INT, `quadrakills` INT, `pentakills` INT, `unrealkills` INT, `totaldamagedealt` INT, `magicdamagedealt` INT, `physicaldamagedealt` INT, `truedamagedealt` INT, `largestcriticalstrike` INT, `totaldamagedealttochampions` INT, `magicdamagedealttochampions` INT, `physicaldamagedealttochampions` INT, `truedamagedealttochampions` INT, `totalheal` INT, `toalunitshealed` INT, `damageselfmitigated` INT, `damagedealttoobjectives` INT, `damagedealttoturrets` INT, `visionscore` INT, `timeccingothers` INT, `totaldamagetaken` INT, `magicaldamagetaken` INT, `physicaldamagetaken` INT, `truedamagetaken` INT, `goldearned` INT, `goldspent` INT, `turretkills` INT, `inhibitorkills` INT, `totalminionskilled` INT, `neutralminionskilled` INT, `neutralminionskilledteamjungle` INT, `neutralminionskilledenemyjungle` INT, `totaltimecrowdcontrolldealt` INT, `champlevel` INT, `visionwardsboughtingame` INT, `sightwardsboughtingame` INT, `wardsplaced` INT, `wardskilled` INT, `firstbloodkill` INT, `firstbloodassist` INT);

-- -----------------------------------------------------
-- View `leagueoflegends`.`best_masterypage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `leagueoflegends`.`best_masterypage`;
USE `leagueoflegends`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `leagueoflegends`.`best_masterypage` AS select `leagueoflegends`.`matchmasteries`.`page` AS `page`,count(`leagueoflegends`.`matchmasteries`.`page`) AS `count` from `leagueoflegends`.`matchmasteries` group by `leagueoflegends`.`matchmasteries`.`page` order by count(`leagueoflegends`.`matchmasteries`.`page`) desc limit 1;

-- -----------------------------------------------------
-- View `leagueoflegends`.`best_runepage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `leagueoflegends`.`best_runepage`;
USE `leagueoflegends`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `leagueoflegends`.`best_runepage` AS select `leagueoflegends`.`matchrunes`.`page` AS `page`,count(`leagueoflegends`.`matchrunes`.`page`) AS `count` from `leagueoflegends`.`matchrunes` group by `leagueoflegends`.`matchrunes`.`page` order by count(`leagueoflegends`.`matchrunes`.`page`) desc limit 1;

-- -----------------------------------------------------
-- View `leagueoflegends`.`most_used_mastery_page`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `leagueoflegends`.`most_used_mastery_page`;
USE `leagueoflegends`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `leagueoflegends`.`most_used_mastery_page` AS select `leagueoflegends`.`matchmasteries_in_page`.`page` AS `database_page`,`leagueoflegends`.`matchmasteries_in_page`.`masteryid` AS `mastery`,`leagueoflegends`.`matchmasteries_in_page`.`rank` AS `count` from `leagueoflegends`.`matchmasteries_in_page` where (`leagueoflegends`.`matchmasteries_in_page`.`page` = (select `best_masterypage`.`page` from `leagueoflegends`.`best_masterypage`));

-- -----------------------------------------------------
-- View `leagueoflegends`.`most_used_rune_page`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `leagueoflegends`.`most_used_rune_page`;
USE `leagueoflegends`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `leagueoflegends`.`most_used_rune_page` AS select `leagueoflegends`.`matchrunes_in_page`.`page` AS `database_page`,`leagueoflegends`.`matchrunes_in_page`.`runeid` AS `rune`,`leagueoflegends`.`matchrunes_in_page`.`rank` AS `count` from `leagueoflegends`.`matchrunes_in_page` where (`leagueoflegends`.`matchrunes_in_page`.`page` = (select `best_runepage`.`page` from `leagueoflegends`.`best_runepage`));

-- -----------------------------------------------------
-- View `leagueoflegends`.`select_all_stats_by_name`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `leagueoflegends`.`select_all_stats_by_name`;
USE `leagueoflegends`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `leagueoflegends`.`select_all_stats_by_name` AS select `s`.`name` AS `summonerName`,`m`.`seasonid` AS `season`,`m`.`queueid` AS `queue`,`m`.`creation` AS `creation`,`ps`.`participant` AS `participant`,`ps`.`win` AS `win`,`ps`.`item0` AS `item0`,`ps`.`item1` AS `item1`,`ps`.`item2` AS `item2`,`ps`.`item3` AS `item3`,`ps`.`item4` AS `item4`,`ps`.`item5` AS `item5`,`ps`.`item6` AS `item6`,`ps`.`kills` AS `kills`,`ps`.`deaths` AS `deaths`,`ps`.`assists` AS `assists`,`ps`.`largestkillingspree` AS `largestkillingspree`,`ps`.`largestmultikill` AS `largestmultikill`,`ps`.`killingsprees` AS `killingsprees`,`ps`.`longesttimespentliving` AS `longesttimespentliving`,`ps`.`doublekills` AS `doublekills`,`ps`.`triplekills` AS `triplekills`,`ps`.`quadrakills` AS `quadrakills`,`ps`.`pentakills` AS `pentakills`,`ps`.`unrealkills` AS `unrealkills`,`ps`.`totaldamagedealt` AS `totaldamagedealt`,`ps`.`magicdamagedealt` AS `magicdamagedealt`,`ps`.`physicaldamagedealt` AS `physicaldamagedealt`,`ps`.`truedamagedealt` AS `truedamagedealt`,`ps`.`largestcriticalstrike` AS `largestcriticalstrike`,`ps`.`totaldamagedealttochampions` AS `totaldamagedealttochampions`,`ps`.`magicdamagedealttochampions` AS `magicdamagedealttochampions`,`ps`.`physicaldamagedealttochampions` AS `physicaldamagedealttochampions`,`ps`.`truedamagedealttochampions` AS `truedamagedealttochampions`,`ps`.`totalheal` AS `totalheal`,`ps`.`toalunitshealed` AS `toalunitshealed`,`ps`.`damageselfmitigated` AS `damageselfmitigated`,`ps`.`damagedealttoobjectives` AS `damagedealttoobjectives`,`ps`.`damagedealttoturrets` AS `damagedealttoturrets`,`ps`.`visionscore` AS `visionscore`,`ps`.`timeccingothers` AS `timeccingothers`,`ps`.`totaldamagetaken` AS `totaldamagetaken`,`ps`.`magicaldamagetaken` AS `magicaldamagetaken`,`ps`.`physicaldamagetaken` AS `physicaldamagetaken`,`ps`.`truedamagetaken` AS `truedamagetaken`,`ps`.`goldearned` AS `goldearned`,`ps`.`goldspent` AS `goldspent`,`ps`.`turretkills` AS `turretkills`,`ps`.`inhibitorkills` AS `inhibitorkills`,`ps`.`totalminionskilled` AS `totalminionskilled`,`ps`.`neutralminionskilled` AS `neutralminionskilled`,`ps`.`neutralminionskilledteamjungle` AS `neutralminionskilledteamjungle`,`ps`.`neutralminionskilledenemyjungle` AS `neutralminionskilledenemyjungle`,`ps`.`totaltimecrowdcontrolldealt` AS `totaltimecrowdcontrolldealt`,`ps`.`champlevel` AS `champlevel`,`ps`.`visionwardsboughtingame` AS `visionwardsboughtingame`,`ps`.`sightwardsboughtingame` AS `sightwardsboughtingame`,`ps`.`wardsplaced` AS `wardsplaced`,`ps`.`wardskilled` AS `wardskilled`,`ps`.`firstbloodkill` AS `firstbloodkill`,`ps`.`firstbloodassist` AS `firstbloodassist` from ((((`leagueoflegends`.`participantstats` `ps` join `leagueoflegends`.`participantidentity` `pi` on((`ps`.`participant` = `pi`.`participant`))) join `leagueoflegends`.`summoners` `s` on((`pi`.`summoner` = `s`.`id`))) join `leagueoflegends`.`participants` `p` on((`ps`.`participant` = `p`.`id`))) join `leagueoflegends`.`matches` `m` on((`p`.`match` = `m`.`id`)));

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
