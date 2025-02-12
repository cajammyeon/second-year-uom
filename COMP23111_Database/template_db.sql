-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 22, 2024 at 01:09 PM
-- Server version: 8.0.36
-- PHP Version: 8.2.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Database: `s61110ab`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`s61110ab`@`localhost` PROCEDURE `AverageRaceTimeFromRaceID` (IN `race_id_id_id` INT)   BEGIN
	SELECT AVG(time) AS AverageRaceTime
    FROM results
    WHERE race_id = race_id_id_id;
END$$

CREATE DEFINER=`s61110ab`@`localhost` PROCEDURE `AverageScore` ()   BEGIN
	SELECT AVG(score) AS average_score FROM players;
END$$

CREATE DEFINER=`s61110ab`@`localhost` PROCEDURE `birthday` ()   BEGIN
	SELECT * FROM employee
    WHERE MONTH(dob) = MONTH(CURRENT_DATE);
END$$

CREATE DEFINER=`s61110ab`@`localhost` PROCEDURE `GetGreaterThan` (IN `required_score` INT)   BEGIN
	SELECT * FROM players WHERE score > required_score ORDER BY score ASC;
END$$

CREATE DEFINER=`s61110ab`@`localhost` PROCEDURE `GetScore` ()   BEGIN
	SELECT * FROM players WHERE score >1200 
    ORDER BY score ASC;
END$$

CREATE DEFINER=`s61110ab`@`localhost` PROCEDURE `GetTrackScore` (IN `races_id` INT)   BEGIN 
	SELECT races.track_name, players.username, results.position, results.time
    FROM results
    JOIN races ON results.race_id = races.id
    JOIN players ON results.player_id = players.id
    WHERE races.id = races_id
    ORDER BY results.position;
END$$

CREATE DEFINER=`s61110ab`@`localhost` PROCEDURE `SelectAverageAndNumber` (IN `race_id_id` INT)   BEGIN
	SELECT AVG(time) FROM results WHERE race_id = race_id_id;
    SELECT COUNT(player_id) FROM results WHERE race_id = race_id_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `number_of_order` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customer_order`
--

CREATE TABLE `customer_order` (
  `order_ID` int NOT NULL,
  `customer_name` varchar(255) NOT NULL,
  `delivery_vehicle_ID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `unique_ID` int NOT NULL,
  `employee_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `position` varchar(255) NOT NULL,
  `salary` int NOT NULL,
  `email` varchar(255) NOT NULL,
  `dob` date NOT NULL,
  `profile_picture` varchar(255) NOT NULL DEFAULT 'profile_icon.jpg',
  `office_location` varchar(255) NOT NULL,
  `home_address` varchar(255) NOT NULL,
  `hired_date` date NOT NULL,
  `amount_of_leave` int NOT NULL,
  `contract` varchar(30) NOT NULL,
  `nin` varchar(9) NOT NULL,
  `emergency_name` varchar(255) NOT NULL,
  `emergency_relationship` varchar(255) NOT NULL,
  `emergency_phone` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`unique_ID`, `employee_name`, `position`, `salary`, `email`, `dob`, `profile_picture`, `office_location`, `home_address`, `hired_date`, `amount_of_leave`, `contract`, `nin`, `emergency_name`, `emergency_relationship`, `emergency_phone`) VALUES
(1221265, 'Russ Cutchie', 'Factory Worker', 25416, 'Russ.Cutchie@kilburnazon.com', '1985-09-08', 'profile_icon.jpg', 'Northern Ireland Distribution Centre', '661 Gale Road', '2015-02-15', 30, 'Part-Time', 'BZ630455D', '', '', '07070 997812'),
(1221452, 'Harriott Pinn', 'Factory Worker', 29230, 'Harriott.Pinn@kilburnazon.com', '2009-05-28', 'profile_icon.jpg', 'Northern Ireland Distribution Centre', '94695 Oak Valley Drive', '2015-05-04', 30, 'Full-Time', 'SB900295A', 'Ella Huygen', '', '07527 612710'),
(1221709, 'Emmey Hirtz', 'Factory Worker', 27263, 'Emmey.Hirtz@kilburnazon.com', '2005-11-30', 'profile_icon.jpg', 'England South Distribution Centre', '2 Sunfield Parkway', '2020-07-31', 30, 'Full-Time', 'GV786046B', 'Aigneis Mollatt', 'Husband', '07136 161512'),
(1221792, 'Gregg Schiell', 'Factory Worker', 25773, 'Gregg.Schiell@kilburnazon.com', '1978-10-02', 'profile_icon.jpg', 'Northern Ireland Distribution Centre', '4 Bay Street', '2023-10-10', 30, 'Full-time', 'FD270800C', 'Jerri Allan', 'Husband', ''),
(1221832, 'Cristin Loudian', 'Factory Worker', 29058, 'Cristin.Loudian@kilburnazon.com', '1989-06-18', 'profile_icon.jpg', 'England Central Distribution Centre', '86 Fairview Drive', '2016-04-27', 30, 'Full-Time', 'OM263026A', 'Brantley Zanetti', '', '07889 556088'),
(1221908, 'Lock McCurrie', 'Factory Worker', 26375, 'Lock.McCurrie@kilburnazon.com', '2004-07-21', 'profile_icon.jpg', 'England South Distribution Centre', '25218 Eastlawn Terrace', '2022-07-19', 30, 'Full-Time', 'PU212720A', 'Adoree Tomkies', 'Boyfriend', '07083 955300'),
(12110062, 'Sheela Plews', 'Health & Safety Officer', 28546, 'Sheela.Plews@kilburnazon.com', '2004-12-04', 'profile_icon.jpg', 'England South Distribution Centre', '424 Nancy Terrace', '2017-08-16', 30, 'Part-Time', 'SE804347A', 'Briant Tall', 'Girlfriend', ''),
(12111088, 'Tierney Saura', 'Health & Safety Officer', 33774, 'Tierney.Saura@kilburnazon.com', '2003-08-20', 'profile_icon.jpg', 'Wales Distribution Centre', '36 Fordem Way', '2023-02-16', 30, 'Full-Time', 'IB336855D', '', '', '07776 617476'),
(12111522, 'Marten Eskrick', 'Health & Safety Officer', 29570, 'Marten.Eskrick@kilburnazon.com', '1988-02-11', 'profile_icon.jpg', 'Wales Distribution Centre', '0488 Michigan Avenue', '2021-12-23', 30, 'Part-Time', 'HO238829D', 'Isador Struttman', 'Girlfriend', '07228 700712'),
(12112639, 'Aurilia Dove', 'Health & Safety Officer', 23283, 'Aurilia.Dove@kilburnazon.com', '1998-09-27', 'profile_icon.jpg', 'Scotland Distribution Centre', '1 Corry Court', '2023-03-05', 30, 'Full-Time', 'MZ652678D', 'Stanly Grindell', 'Wife', '07325 756690'),
(12112712, 'Jenda Cohrs', 'Health & Safety Officer', 32861, 'Jenda.Cohrs@kilburnazon.com', '2000-12-25', 'profile_icon.jpg', 'England North Distribution Centre', '85093 Stuart Point', '2023-11-23', 30, 'Part-Time', 'IE617692A', 'Elsworth Roskruge', 'Wife', '07301 166168'),
(12112750, 'Carol Paolozzi', 'Health & Safety Officer', 25195, 'Carol.Paolozzi@kilburnazon.com', '1983-07-26', 'profile_icon.jpg', 'England South Distribution Centre', '56 John Wall Point', '2016-09-25', 30, 'Part-Time', 'ME002330D', 'Jone Phelp', 'Wife', '07727 912036'),
(12113642, 'Scarface Gavaran', 'Health & Safety Officer', 29686, 'Scarface.Gavaran@kilburnazon.com', '1996-09-23', 'profile_icon.jpg', 'England Central Distribution Centre', '51060 Anderson Drive', '2023-08-30', 30, 'Full-Time', 'WF788117C', 'Jaynell Sprey', 'Girlfriend', '07997 333416'),
(12113666, 'Edythe Colisbe', 'Health & Safety Officer', 27512, 'Edythe.Colisbe@kilburnazon.com', '2008-07-04', 'profile_icon.jpg', 'England North Distribution Centre', '7244 Northland Alley', '2019-07-04', 30, 'Full-Time', 'MO232288B', '', 'Civil Partner', '07749 087584'),
(12114168, 'Cymbre Braiden', 'Health & Safety Officer', 22947, 'Cymbre.Braiden@kilburnazon.com', '1984-03-09', 'profile_icon.jpg', 'Northern Ireland Distribution Centre', '0 Artisan Road', '2022-04-23', 30, 'Full-Time', 'LD278104D', 'Danette Dines', '', '07777 784214'),
(12116288, 'Deeanne Westoll', 'Health & Safety Officer', 34693, 'Deeanne.Westoll@kilburnazon.com', '1977-12-06', 'profile_icon.jpg', 'England Central Distribution Centre', '412 North Street', '2016-09-21', 30, 'Full-Time', 'XR656206B', 'Zeke Vennings', 'Wife', '07647 152752'),
(12116601, 'Christie Pischoff', 'Health & Safety Officer', 23242, 'Christie.Pischoff@kilburnazon.com', '1981-10-15', 'profile_icon.jpg', 'Scotland Distribution Centre', '39695 Sunbrook Plaza', '2017-01-05', 30, 'Full-Time', 'YN332435C', "Illa O'Hanley", 'Husband', '07632 770322'),
(12118412, 'Bordy Langhorne', 'Health & Safety Officer', 33345, 'Bordy.Langhorne@kilburnazon.com', '1993-05-06', 'profile_icon.jpg', 'Northern Ireland Distribution Centre', '2 North Way', '2016-03-02', 30, 'Full-Time', 'QS763259D', 'Chrysa Stodd', 'Husband', '07196 158363'),
(12211065, 'Francis Horsted', 'Factory Worker', 23375, 'Francis.Horsted@kilburnazon.com', '1988-07-25', 'profile_icon.jpg', 'Northern Ireland Distribution Centre', '7 Crownhardt Plaza', '2023-07-29', 30, 'Full-Time', 'GP190594B', 'Vittorio Deacock', 'Father', '07635 422929'),
(12211197, 'Salmon Petegre', 'Factory Worker', 22669, 'Salmon.Petegre@kilburnazon.com', '1978-11-11', 'profile_icon.jpg', 'Wales Distribution Centre', '65790 Buell Plaza', '2023-03-31', 30, 'Full-Time', 'VH028029C', 'Mitchell Slessar', 'Wife', '07217 353647'),
(12211317, 'Park Smallridge', 'Factory Worker', 29224, 'Park.Smallridge@kilburnazon.com', '2008-12-28', 'profile_icon.jpg', 'England North Distribution Centre', '18 Hauk Place', '2017-10-26', 30, 'Full-Time', 'XJ058657D', '', 'Wife', '07764 434396'),
(12211356, 'Brook Ewington', 'Factory Worker', 24899, 'Brook.Ewington@kilburnazon.com', '1995-08-24', 'profile_icon.jpg', 'England Central Distribution Centre', '2337 Schurz Park', '2018-12-31', 30, 'Part-Time', 'PJ845064C', 'Elmer Viccars', '', '07734 615318'),
(12211384, 'Colman Quinion', 'Factory Worker', 26857, 'Colman.Quinion@kilburnazon.com', '1995-06-23', 'profile_icon.jpg', 'Scotland Distribution Centre', '906 Menomonie Circle', '2019-03-29', 30, 'Part-Time', 'AG066537A', '', 'Mother', '07831 106222'),
(12211435, 'Tommie Roxbrough', 'Factory Worker', 26893, 'Tommie.Roxbrough@kilburnazon.com', '2007-09-13', 'profile_icon.jpg', 'England North Distribution Centre', '81047 Summerview Trail', '2021-08-24', 30, 'Full-Time', 'MC945932A', 'Hobey Couchman', '', '07765 987470'),
(12211587, 'Andres De Marchi', 'Factory Worker', 23519, 'Andres.De Marchi@kilburnazon.com', '1984-06-14', 'profile_icon.jpg', 'England South Distribution Centre', '895 David Alley', '2021-12-13', 30, 'Full-Time', 'OJ510253B', 'Saudra Cuthbertson', '', '07280 447664'),
(12211691, 'Rikki Pauer', 'Factory Worker', 22074, 'Rikki.Pauer@kilburnazon.com', '1981-12-27', 'profile_icon.jpg', 'Scotland Distribution Centre', '82787 Rowland Junction', '2020-12-12', 30, 'Part-Time', 'FA890103C', '', 'Civil Partner', '07586 267442'),
(12211861, 'Dud Laible', 'Factory Worker', 24642, 'Dud.Laible@kilburnazon.com', '1985-08-26', 'profile_icon.jpg', 'England South Distribution Centre', '7747 Butternut Crossing', '2021-08-25', 30, 'Full-Time', 'YH533098A', 'Vernice Perrycost', 'Mother', '07705 656653'),
(12212092, 'Arleyne Cherm', 'Factory Worker', 24478, 'Arleyne.Cherm@kilburnazon.com', '1993-04-07', 'profile_icon.jpg', 'Scotland Distribution Centre', '48 Buhler Hill', '2018-10-10', 30, 'Full-Time', 'ZD863526A', '', '', ''),
(12212102, 'Kittie McLaverty', 'Factory Worker', 26100, 'Kittie.McLaverty@kilburnazon.com', '2008-07-16', 'profile_icon.jpg', 'Scotland Distribution Centre', '49691 Forest Place', '2016-11-17', 30, 'Part-Time', 'WC624356A', 'Cory Ioselevich', 'Civil Partner', ''),
(12212104, 'Gael Poulston', 'Factory Worker', 29807, 'Gael.Poulston@kilburnazon.com', '2010-01-26', 'profile_icon.jpg', 'England North Distribution Centre', '484 Scoville Avenue', '2017-11-20', 30, 'Part-Time', 'EF123771D', '', '', '07521 164356'),
(12212133, 'Hymie Stratford', 'Factory Worker', 24560, 'Hymie.Stratford@kilburnazon.com', '1983-07-25', 'profile_icon.jpg', 'England Central Distribution Centre', '4 Armistice Place', '2017-12-08', 30, 'Full-Time', 'QJ749434A', 'Annmaria McMorran', 'Father', '07995 987135'),
(12212155, 'Arie Papworth', 'Factory Worker', 23437, 'Arie.Papworth@kilburnazon.com', '1994-07-22', 'profile_icon.jpg', 'England South Distribution Centre', '4 Bartillon Circle', '2016-04-27', 30, 'Full-Time', 'NS449797D', '', 'Husband', ''),
(12212183, 'Elton Brailey', 'Factory Worker', 25216, 'Elton.Brailey@kilburnazon.com', '1983-08-29', 'profile_icon.jpg', 'England North Distribution Centre', '1846 Eagan Center', '2021-11-23', 30, 'Full-Time', 'NY623452C', '', 'Husband', '07792 581415'),
(12212299, 'Hamel Hurtic', 'Factory Worker', 26292, 'Hamel.Hurtic@kilburnazon.com', '2008-01-09', 'profile_icon.jpg', 'England North Distribution Centre', '0 West Crossing', '2019-02-10', 30, 'Full-Time', 'IU169701B', 'Wells Zemler', '', '07851 839533'),
(12212488, 'Susette Hammer', 'Factory Worker', 29674, 'Susette.Hammer@kilburnazon.com', '1978-12-26', 'profile_icon.jpg', 'Wales Distribution Centre', '25117 Waubesa Park', '2022-11-23', 30, 'Full-Time', 'IW817361B', 'Gardner Brastead', 'Husband', '07256 179974'),
(12212691, 'Maris Bossom', 'Factory Worker', 24961, 'Maris.Bossom@kilburnazon.com', '1992-06-29', 'profile_icon.jpg', 'England Central Distribution Centre', '55 Spaight Circle', '2022-05-15', 30, 'Part-Time', 'RG359319A', 'Cullan Mollitt', '', '07691 319082'),
(12212751, 'Ira Wasiela', 'Factory Worker', 27487, 'Ira.Wasiela@kilburnazon.com', '1997-12-13', 'profile_icon.jpg', 'Wales Distribution Centre', '855 Corben Plaza', '2024-04-21', 30, 'Full-Time', 'UR499786B', 'Rosalynd Robet', 'Civil Partner', '07295 498242'),
(12212803, 'Nicki Soall', 'Factory Worker', 28490, 'Nicki.Soall@kilburnazon.com', '1986-02-23', 'profile_icon.jpg', 'Wales Distribution Centre', '8991 Gerald Crossing', '2018-03-15', 30, 'Full-Time', 'KQ705677B', 'Nataniel Denman', 'Boyfriend', '07551 879062'),
(12212831, 'Cobb Ricart', 'Factory Worker', 26642, 'Cobb.Ricart@kilburnazon.com', '1987-01-22', 'profile_icon.jpg', 'Scotland Distribution Centre', '04195 Gale Plaza', '2020-05-10', 30, 'Full-Time', 'JV246199D', 'Alica Smewings', 'Mother', ''),
(12212901, 'Nyssa Gerhold', 'Factory Worker', 28395, 'Nyssa.Gerhold@kilburnazon.com', '1977-11-26', 'profile_icon.jpg', 'England South Distribution Centre', '79171 Luster Drive', '2020-07-11', 30, 'Full-Time', 'QX909374C', 'Veda Mapson', 'Wife', ''),
(12212982, 'Archer Blakely', 'Factory Worker', 24840, 'Archer.Blakely@kilburnazon.com', '2004-05-18', 'profile_icon.jpg', 'Northern Ireland Distribution Centre', '3 Forest Dale Drive', '2016-04-20', 30, 'Full-Time', 'TT192832C', 'Patricio Speechly', 'Civil Partner', '07817 587038'),
(12212991, 'Kerrie Weedon', 'Factory Worker', 27826, 'Kerrie.Weedon@kilburnazon.com', '1994-11-24', 'profile_icon.jpg', 'England South Distribution Centre', '13 Ridgeview Street', '2018-03-22', 30, 'Full-Time', 'DD817948C', 'Bob Polin', 'Boyfriend', '07684 634429'),
(12213124, 'Gideon Pridham', 'Factory Worker', 25612, 'Gideon.Pridham@kilburnazon.com', '1981-01-26', 'profile_icon.jpg', 'England North Distribution Centre', '7640 Hauk Trail', '2015-02-22', 30, 'Full-Time', 'LY731522C', 'Mellisa Warriner', '', '07624 054614'),
(12213338, 'Myrna Kilfedder', 'Factory Worker', 27977, 'Myrna.Kilfedder@kilburnazon.com', '1994-09-22', 'profile_icon.jpg', 'England Central Distribution Centre', '746 Carey Hill', '2016-09-13', 30, 'Part-Time', 'ZN341846D', 'Erasmus Franchyonok', '', '07046 104357'),
(12213491, 'Bernadene Christall', 'Factory Worker', 24461, 'Bernadene.Christall@kilburnazon.com', '1994-04-28', 'profile_icon.jpg', 'Scotland Distribution Centre', '4172 Melvin Street', '2015-03-15', 30, 'Full-Time', 'IZ802514D', 'Arlene de Castelain', 'Mother', '07369 082498'),
(12213598, 'Wendye Lightbown', 'Factory Worker', 29448, 'Wendye.Lightbown@kilburnazon.com', '1984-09-11', 'profile_icon.jpg', 'Northern Ireland Distribution Centre', '23476 Fair Oaks Crossing', '2019-07-25', 30, 'Full-Time', 'YD516559D', 'Marjy Widdison', '', ''),
(12213724, 'Craggie McKernan', 'Factory Worker', 26303, 'Craggie.McKernan@kilburnazon.com', '1979-01-26', 'profile_icon.jpg', 'Wales Distribution Centre', '6 Toban Court', '2016-03-31', 30, 'Part-Time', 'IW726530A', 'Kimbra Forman', 'Wife', ''),
(12213809, 'Tate Cowton', 'Factory Worker', 26798, 'Tate.Cowton@kilburnazon.com', '1996-07-02', 'profile_icon.jpg', 'England Central Distribution Centre', '1 Kensington Pass', '2019-11-07', 30, 'Full-Time', 'MP800168B', 'Cody Trymme', 'Girlfriend', '07148 668953'),
(12213841, 'Gustavus Hinrich', 'Factory Worker', 27880, 'Gustavus.Hinrich@kilburnazon.com', '2010-01-25', 'profile_icon.jpg', 'Wales Distribution Centre', '11 Rockefeller Drive', '2017-04-10', 30, 'Full-Time', 'JE689255B', 'Dory Skynner', 'Boyfriend', '07641 909987'),
(12213973, 'Andee Pulley', 'Factory Worker', 29053, 'Andee.Pulley@kilburnazon.com', '2006-10-28', 'profile_icon.jpg', 'Scotland Distribution Centre', '212 Mccormick Way', '2021-03-21', 30, 'Full-Time', 'ZR122877D', 'Esteban McDill', 'Civil Partner', '07812 005920'),
(12213974, 'Sigismondo Shorland', 'Factory Worker', 26620, 'Sigismondo.Shorland@kilburnazon.com', '1995-01-16', 'profile_icon.jpg', 'Scotland Distribution Centre', '6 Quincy Street', '2017-01-03', 30, 'Full-Time', 'BV974391A', 'Nikolai Agiolfinger', 'Girlfriend', '07169 431350'),
(12213983, 'Norene Caurah', 'Factory Worker', 25026, 'Norene.Caurah@kilburnazon.com', '2007-07-23', 'profile_icon.jpg', 'England South Distribution Centre', '29 Novick Plaza', '2017-10-07', 30, 'Full-Time', 'VA851027A', 'Reamonn Daleman', '', '07866 713818'),
(12214007, 'Estrella de Tocqueville', 'Factory Worker', 29193, 'Estrella.de Tocqueville@kilburnazon.com', '1985-05-09', 'profile_icon.jpg', 'Scotland Distribution Centre', '6 Bunker Hill Plaza', '2021-01-28', 30, 'Full-Time', 'RZ897581B', 'Michel Archanbault', '', ''),
(12214028, 'Shae Piotrowski', 'Factory Worker', 22078, 'Shae.Piotrowski@kilburnazon.com', '1984-11-06', 'profile_icon.jpg', 'England South Distribution Centre', '469 Clyde Gallagher Way', '2022-09-05', 30, 'Full-Time', 'ZG697320A', 'Malory Garrals', 'Father', '07383 324090'),
(12214048, 'Cece Corneck', 'Factory Worker', 24867, 'Cece.Corneck@kilburnazon.com', '1977-06-17', 'profile_icon.jpg', 'Scotland Distribution Centre', '5941 Everett Road', '2020-02-08', 30, 'Full-Time', 'UE573499B', 'Bryanty Janjusevic', 'Boyfriend', '07167 846379'),
(12214105, 'Brandi Charrier', 'Factory Worker', 28395, 'Brandi.Charrier@kilburnazon.com', '1982-03-08', 'profile_icon.jpg', 'Wales Distribution Centre', '85503 Dahle Circle', '2019-05-04', 30, 'Full-Time', 'IW006546D', 'Amii De Simone', 'Boyfriend', '07735 915033'),
(12214121, 'Gerek Piccop', 'Factory Worker', 27388, 'Gerek.Piccop@kilburnazon.com', '1984-10-26', 'profile_icon.jpg', 'Wales Distribution Centre', '52 Donald Terrace', '2021-10-10', 30, 'Full-Time', 'TX132819D', 'Gaylor McMurray', 'Boyfriend', '07092 071016'),
(12214152, 'Edmon Hunnable', 'Factory Worker', 29285, 'Edmon.Hunnable@kilburnazon.com', '2003-01-28', 'profile_icon.jpg', 'England Central Distribution Centre', '640 Fieldstone Crossing', '2021-04-20', 30, 'Full-Time', 'WU139834B', 'Marcus Demkowicz', 'Father', ''),
(12214303, 'Romeo Mc Combe', 'Factory Worker', 28963, 'Romeo.Mc Combe@kilburnazon.com', '2001-08-27', 'profile_icon.jpg', 'England Central Distribution Centre', '29334 Veith Alley', '2021-11-15', 30, 'Full-Time', 'NT727673A', '', 'Wife', '07951 197373'),
(12214418, 'Hamil Sonner', 'Factory Worker', 27243, 'Hamil.Sonner@kilburnazon.com', '1991-05-19', 'profile_icon.jpg', 'Wales Distribution Centre', '06243 Trailsway Hill', '2016-07-29', 30, 'Full-Time', 'ZH643753A', '', 'Civil Partner', '07040 348788'),
(12214573, 'Silvie Kensy', 'Factory Worker', 23750, 'Silvie.Kensy@kilburnazon.com', '2007-02-17', 'profile_icon.jpg', 'Wales Distribution Centre', '9 Forest Run Trail', '2018-02-14', 30, 'Full-Time', 'KQ688135B', 'Liliane Spirit', 'Girlfriend', '07180 069610'),
(12214750, 'Zorina Rumgay', 'Factory Worker', 26338, 'Zorina.Rumgay@kilburnazon.com', '2007-07-12', 'profile_icon.jpg', 'England North Distribution Centre', '75495 Mendota Drive', '2024-02-28', 30, 'Full-Time', 'BE368387B', 'Bonnee Parade', 'Boyfriend', '07150 674848'),
(12214822, 'Silvie Pitone', 'Factory Worker', 29524, 'Silvie.Pitone@kilburnazon.com', '1985-11-06', 'profile_icon.jpg', 'England North Distribution Centre', '19 Utah Junction', '2022-04-10', 30, 'Full-Time', 'EC081603D', 'Orran Dummigan', 'Father', '07769 506815'),
(12215160, 'Roma Raynham', 'Factory Worker', 25429, 'Roma.Raynham@kilburnazon.com', '2002-04-12', 'profile_icon.jpg', 'Wales Distribution Centre', '83055 5th Junction', '2017-07-03', 30, 'Full-Time', 'WL256374C', '', 'Father', ''),
(12215254, 'Bev Duddin', 'Factory Worker', 27170, 'Bev.Duddin@kilburnazon.com', '1979-01-11', 'profile_icon.jpg', 'Northern Ireland Distribution Centre', '13 Miller Plaza', '2019-10-18', 30, 'Full-Time', 'RI956084A', 'Hussein Gurg', 'Husband', '07657 688119'),
(12215263, 'Morganica Cornell', 'Factory Worker', 22185, 'Morganica.Cornell@kilburnazon.com', '1976-01-24', 'profile_icon.jpg', 'England Central Distribution Centre', '555 Chinook Circle', '2023-03-03', 30, 'Full-Time', 'PX205687D', '', 'Boyfriend', '07528 372445'),
(12215349, 'Murdock Couves', 'Factory Worker', 27174, 'Murdock.Couves@kilburnazon.com', '2006-10-02', 'profile_icon.jpg', 'England South Distribution Centre', '2825 Merry Parkway', '2017-10-25', 30, 'Part-Time', 'KJ917140A', 'Bendicty Jenney', '', '07335 479379'),
(12215479, 'Raeann McGann', 'Factory Worker', 24709, 'Raeann.McGann@kilburnazon.com', '1976-07-25', 'profile_icon.jpg', 'Wales Distribution Centre', '880 Ridgeview Circle', '2017-01-11', 30, 'Full-Time', 'LH242707D', '', 'Wife', '07866 056882'),
(12215484, 'Elena Pirdue', 'Factory Worker', 22682, 'Elena.Pirdue@kilburnazon.com', '1977-11-06', 'profile_icon.jpg', 'Wales Distribution Centre', '506 Arkansas Trail', '2017-06-20', 30, 'Full-Time', 'VA222115A', 'Aurel Byles', 'Mother', '07371 440337'),
(12215504, 'Glori Childes', 'Factory Worker', 28468, 'Glori.Childes@kilburnazon.com', '1990-04-03', 'profile_icon.jpg', 'Wales Distribution Centre', '83346 Montana Crossing', '2022-11-30', 30, 'Full-Time', 'BS841445B', 'Powell Haszard', 'Wife', '07843 627553'),
(12215537, 'Georgeta Wimsett', 'Factory Worker', 29149, 'Georgeta.Wimsett@kilburnazon.com', '2000-03-03', 'profile_icon.jpg', 'Scotland Distribution Centre', '9 Northland Avenue', '2023-09-29', 30, 'Full-Time', 'SI936435A', '', 'Girlfriend', '07925 226446'),
(12215562, 'Silvan Murrum', 'Factory Worker', 27210, 'Silvan.Murrum@kilburnazon.com', '1988-11-19', 'profile_icon.jpg', 'England North Distribution Centre', '3485 Farwell Avenue', '2016-02-05', 30, 'Full-Time', 'QR276424B', 'Riannon Hedgeley', 'Girlfriend', '07416 475697'),
(12215594, 'Nan Branchett', 'Factory Worker', 27496, 'Nan.Branchett@kilburnazon.com', '2004-07-22', 'profile_icon.jpg', 'England South Distribution Centre', '8470 Dorton Pass', '2023-08-18', 30, 'Full-Time', 'VM862134C', '', 'Boyfriend', '07140 397605'),
(12215734, 'Reinold Batcheldor', 'Factory Worker', 23196, 'Reinold.Batcheldor@kilburnazon.com', '1998-01-23', 'profile_icon.jpg', 'Northern Ireland Distribution Centre', '54841 Eastlawn Alley', '2020-09-26', 30, 'Full-Time', 'HP910350D', 'Quillan Cotelard', '', '07402 789089'),
(12215785, 'Russ Thick', 'Factory Worker', 26277, 'Russ.Thick@kilburnazon.com', '2002-11-08', 'profile_icon.jpg', 'Wales Distribution Centre', '10 North Way', '2018-02-12', 30, 'Full-Time', 'FF334132C', 'Brose Bewsey', 'Civil Partner', '07551 210971'),
(12215805, 'Hallsy Hitzke', 'Factory Worker', 22579, 'Hallsy.Hitzke@kilburnazon.com', '2002-01-09', 'profile_icon.jpg', 'England North Distribution Centre', '1543 4th Trail', '2023-05-31', 30, 'Full-Time', 'PI475660C', '', 'Boyfriend', ''),
(12215877, 'Grantham Croose', 'Factory Worker', 28331, 'Grantham.Croose@kilburnazon.com', '1986-05-24', 'profile_icon.jpg', 'Scotland Distribution Centre', '5 Jay Street', '2017-11-20', 30, 'Full-Time', 'PA064813C', 'Beltran Blunkett', '', '07615 215737'),
(12215968, 'Thadeus Frances', 'Factory Worker', 22214, 'Thadeus.Frances@kilburnazon.com', '2004-10-21', 'profile_icon.jpg', 'Wales Distribution Centre', '3489 Sunbrook Avenue', '2018-01-07', 30, 'Full-Time', 'MP338297A', 'Selena Gilliat', 'Girlfriend', '07459 397115'),
(12216093, 'Gaultiero Folini', 'Factory Worker', 25094, 'Gaultiero.Folini@kilburnazon.com', '2003-05-16', 'profile_icon.jpg', 'England North Distribution Centre', '4885 Southridge Street', '2023-08-08', 30, 'Full-Time', 'BS704468C', 'Donalt Volcker', '', '07558 160444'),
(12216138, 'Reta Lympany', 'Factory Worker', 23051, 'Reta.Lympany@kilburnazon.com', '1995-01-21', 'profile_icon.jpg', 'England North Distribution Centre', '408 Meadow Valley Street', '2017-09-14', 30, 'Full-Time', 'KT258389D', 'Hilliary Cullingford', '', '07663 787888'),
(12216285, 'Tammara Cristoforo', 'Factory Worker', 22899, 'Tammara.Cristoforo@kilburnazon.com', '1981-05-07', 'profile_icon.jpg', 'Scotland Distribution Centre', '9 Golf Drive', '2022-10-14', 30, 'Full-Time', 'IM822270A', 'Worth Dearn', 'Husband', '07104 872801'),
(12216342, 'Alvina Le Grys', 'Factory Worker', 22389, 'Alvina.Le Grys@kilburnazon.com', '1980-04-15', 'profile_icon.jpg', 'Scotland Distribution Centre', '7118 Del Mar Terrace', '2015-02-07', 30, 'Full-Time', 'AN547962C', '', 'Mother', '07038 288225'),
(12217046, 'Dehlia Jackes', 'Factory Worker', 28581, 'Dehlia.Jackes@kilburnazon.com', '1984-08-13', 'profile_icon.jpg', 'Scotland Distribution Centre', '193 Village Green Hill', '2022-12-08', 30, 'Full-Time', 'RV614094A', 'Marrilee Gainsford', 'Father', '07838 245506'),
(12217234, 'Jozef Stinton', 'Factory Worker', 23923, 'Jozef.Stinton@kilburnazon.com', '1991-05-19', 'profile_icon.jpg', 'England Central Distribution Centre', '2191 Eagle Crest Road', '2015-06-19', 30, 'Part-Time', 'CK472140C', 'Judi Scanlon', 'Civil Partner', '07764 252550'),
(12217291, 'Melantha Merricks', 'Factory Worker', 28884, 'Melantha.Merricks@kilburnazon.com', '1976-03-23', 'profile_icon.jpg', 'Wales Distribution Centre', '03738 Prairie Rose Road', '2019-09-26', 30, 'Part-Time', 'MI009758A', 'Hebert Learmond', 'Husband', '07730 757373'),
(12217385, 'Shannah Langelaan', 'Factory Worker', 25837, 'Shannah.Langelaan@kilburnazon.com', '1982-04-23', 'profile_icon.jpg', 'Northern Ireland Distribution Centre', '89 Vermont Parkway', '2015-06-17', 30, 'Full-Time', 'YK800571D', 'Roma Getcliff', 'Husband', '07770 964810'),
(12217466, 'Joelynn Dorgan', 'Factory Worker', 22660, 'Joelynn.Dorgan@kilburnazon.com', '1989-08-08', 'profile_icon.jpg', 'England Central Distribution Centre', '556 Merchant Drive', '2016-01-02', 30, 'Full-Time', 'QQ562762D', 'Rog Redman', 'Wife', '07596 559644'),
(12217623, 'Ebba MacLeese', 'Factory Worker', 25826, 'Ebba.MacLeese@kilburnazon.com', '1989-05-23', 'profile_icon.jpg', 'England North Distribution Centre', '6 Ridgeway Place', '2015-11-29', 30, 'Full-Time', 'DV715327B', 'Cal Maybey', 'Civil Partner', '07126 482408'),
(12217795, 'Monty Ambrozik', 'Factory Worker', 25346, 'Monty.Ambrozik@kilburnazon.com', '1979-10-17', 'profile_icon.jpg', 'England Central Distribution Centre', '1538 Linden Way', '2024-01-24', 30, 'Full-Time', 'XL643171C', 'Angy Recke', 'Mother', '07027 376702'),
(12217867, 'Austin Lambertini', 'Factory Worker', 23623, 'Austin.Lambertini@kilburnazon.com', '1983-02-10', 'profile_icon.jpg', 'Scotland Distribution Centre', '0365 Ludington Terrace', '2021-12-03', 30, 'Full-Time', 'DB481685B', 'Dorise Rait', 'Father', '07004 169110'),
(12217876, 'Matias Tuttle', 'Factory Worker', 25796, 'Matias.Tuttle@kilburnazon.com', '1977-01-02', 'profile_icon.jpg', 'Northern Ireland Distribution Centre', '12 Holmberg Alley', '2017-01-21', 30, 'Full-Time', 'CM486322A', 'Ole Habard', 'Father', '07385 115626'),
(12218012, 'Linoel Leyfield', 'Factory Worker', 28948, 'Linoel.Leyfield@kilburnazon.com', '1997-01-29', 'profile_icon.jpg', 'Wales Distribution Centre', '7183 Huxley Street', '2016-02-13', 30, 'Full-Time', 'MD948062C', '', '', '07571 099273'),
(12218053, 'Judith Ingry', 'Factory Worker', 23852, 'Judith.Ingry@kilburnazon.com', '1985-11-20', 'profile_icon.jpg', 'Scotland Distribution Centre', '1378 Caliangt Way', '2022-05-03', 30, 'Full-Time', 'NN501872D', 'Pierrette Renvoise', 'Wife', ''),
(12218242, 'Bliss Scarlon', 'Factory Worker', 29838, 'Bliss.Scarlon@kilburnazon.com', '1995-08-15', 'profile_icon.jpg', 'Scotland Distribution Centre', '98 Acker Road', '2021-06-08', 30, 'Full-Time', 'FX964363B', 'Frazier Lob', 'Boyfriend', '07803 263257'),
(12218688, 'Randee Hedgeman', 'Factory Worker', 24395, 'Randee.Hedgeman@kilburnazon.com', '2003-11-22', 'profile_icon.jpg', 'England South Distribution Centre', '68 Mcbride Road', '2019-08-21', 30, 'Full-Time', 'UN052491C', 'Katie Pryor', '', '07663 548014'),
(12218788, 'Philis Dosdale', 'Factory Worker', 29490, 'Philis.Dosdale@kilburnazon.com', '1980-10-24', 'profile_icon.jpg', 'England South Distribution Centre', '70 Delaware Street', '2021-07-13', 30, 'Full-Time', 'NV495682B', 'Elonore Hair', 'Father', '07428 928875'),
(12218834, 'Lyndel Ivankov', 'Factory Worker', 27114, 'Lyndel.Ivankov@kilburnazon.com', '1980-10-08', 'profile_icon.jpg', 'Wales Distribution Centre', '3017 Arapahoe Center', '2019-04-19', 30, 'Full-Time', 'UC182199C', 'Humfrey Easbie', 'Father', ''),
(12218854, 'Janie Gavaran', 'Factory Worker', 29163, 'Janie.Gavaran@kilburnazon.com', '2008-07-10', 'profile_icon.jpg', 'Northern Ireland Distribution Centre', '21 Monterey Drive', '2022-10-19', 30, 'Part-Time', 'JB759596D', 'Susan Steeples', 'Girlfriend', '07134 753781'),
(12218878, 'Lari Lesaunier', 'Factory Worker', 26072, 'Lari.Lesaunier@kilburnazon.com', '1997-02-16', 'profile_icon.jpg', 'Wales Distribution Centre', '44 Dakota Avenue', '2022-08-16', 30, 'Full-Time', 'EY051190D', 'Melissa Lerer', 'Boyfriend', ''),
(12218960, 'Rockwell Bradshaw', 'Factory Worker', 23982, 'Rockwell.Bradshaw@kilburnazon.com', '1994-02-11', 'profile_icon.jpg', 'Scotland Distribution Centre', '232 Colorado Trail', '2016-05-26', 30, 'Full-Time', 'AE765414B', 'Carmine Stickel', 'Boyfriend', ''),
(12219024, 'Myrtia Querree', 'Factory Worker', 25277, 'Myrtia.Querree@kilburnazon.com', '1985-07-17', 'profile_icon.jpg', 'Wales Distribution Centre', '9 Claremont Plaza', '2017-12-11', 30, 'Full-Time', 'EO523284A', 'Kelley Porrett', 'Husband', '07333 032436'),
(12219175, 'Suzanne Spillane', 'Factory Worker', 23367, 'Suzanne.Spillane@kilburnazon.com', '1987-10-30', 'profile_icon.jpg', 'Wales Distribution Centre', '6945 Logan Street', '2019-08-26', 30, 'Full-Time', 'VC486847C', 'Andrej Ratke', '', '07715 401737'),
(12219204, 'Lovell Pullan', 'Factory Worker', 27984, 'Lovell.Pullan@kilburnazon.com', '1987-07-19', 'profile_icon.jpg', 'England South Distribution Centre', '1586 Gina Avenue', '2015-12-08', 30, 'Full-Time', 'GU758119B', 'Tisha Wycliff', 'Civil Partner', ''),
(12219325, 'Atlanta Wimmer', 'Factory Worker', 26637, 'Atlanta.Wimmer@kilburnazon.com', '1996-11-17', 'profile_icon.jpg', 'England North Distribution Centre', '6286 Burrows Plaza', '2022-06-17', 30, 'Full-Time', 'VH221989D', '', '', ''),
(12219474, 'Carmelina Draxford', 'Factory Worker', 23557, 'Carmelina.Draxford@kilburnazon.com', '1983-06-23', 'profile_icon.jpg', 'England North Distribution Centre', '22104 Sundown Hill', '2018-06-20', 30, 'Full-Time', 'SF517589B', '', 'Civil Partner', '07773 365110'),
(12219510, 'Alice Dunklee', 'Factory Worker', 28410, 'Alice.Dunklee@kilburnazon.com', '2003-05-28', 'profile_icon.jpg', 'England South Distribution Centre', '615 Anhalt Circle', '2020-07-26', 30, 'Full-Time', 'AF026052C', 'Francine Marzello', 'Father', '07244 052918'),
(12219550, 'Duky Belfit', 'Factory Worker', 27710, 'Duky.Belfit@kilburnazon.com', '1977-02-27', 'profile_icon.jpg', 'England South Distribution Centre', '66619 Ruskin Avenue', '2023-01-07', 30, 'Full-Time', 'ME613124D', 'Arvy Covely', 'Girlfriend', '07146 735902'),
(12219584, 'Fernandina Pietrzyk', 'Factory Worker', 27538, 'Fernandina.Pietrzyk@kilburnazon.com', '1991-09-03', 'profile_icon.jpg', 'Northern Ireland Distribution Centre', '797 Reinke Park', '2015-12-01', 30, 'Full-Time', 'OD878006D', 'Melesa Raoult', 'Father', '07920 910745'),
(12219595, 'Octavius Campkin', 'Factory Worker', 27289, 'Octavius.Campkin@kilburnazon.com', '1999-01-15', 'profile_icon.jpg', 'Wales Distribution Centre', '15 Meadow Vale Drive', '2022-11-03', 30, 'Full-Time', 'TT300300B', 'Claus Starking', '', '07947 350202'),
(12219646, 'Nolie Maiklem', 'Factory Worker', 28901, 'Nolie.Maiklem@kilburnazon.com', '1997-07-02', 'profile_icon.jpg', 'Scotland Distribution Centre', '32022 Haas Pass', '2018-08-19', 30, 'Full-Time', 'YY366239A', 'Louie Dommett', '', ''),
(12219701, 'Graham Pannett', 'Factory Worker', 23595, 'Graham.Pannett@kilburnazon.com', '1994-12-16', 'profile_icon.jpg', 'Northern Ireland Distribution Centre', '64489 Luster Circle', '2021-02-03', 30, 'Full-Time', 'JT025781C', 'Jordanna Buxsey', 'Mother', '07756 130401'),
(12219779, 'Muffin Herion', 'Factory Worker', 24658, 'Muffin.Herion@kilburnazon.com', '1986-10-13', 'profile_icon.jpg', 'England South Distribution Centre', '2523 Mcbride Avenue', '2021-07-15', 30, 'Full-Time', 'RF555700B', 'Gloriana Huckell', '', '07502 956122'),
(12311037, 'Bettina Karby', 'Delivery Driver', 29913, 'Bettina.Karby@kilburnazon.com', '2004-02-11', 'profile_icon.jpg', 'England Central Distribution Centre', '42818 Farragut Park', '2016-08-29', 30, 'Full-Time', 'DC674435A', 'Leora Brownstein', 'Girlfriend', '07681 639640'),
(12311055, 'Elora Lundbech', 'Delivery Driver', 31513, 'Elora.Lundbech@kilburnazon.com', '1983-01-31', 'profile_icon.jpg', 'England South Distribution Centre', '2597 Hintze Court', '2020-03-31', 30, 'Full-Time', 'TP864527A', 'Raymond Palatini', 'Husband', ''),
(12311153, 'Prissie Berthome', 'Delivery Driver', 25745, 'Prissie.Berthome@kilburnazon.com', '1990-09-22', 'profile_icon.jpg', 'England North Distribution Centre', '27 Sunnyside Parkway', '2017-02-21', 30, 'Full-Time', 'ER911659C', 'Quintus Battelle', 'Husband', '07478 793423'),
(12311581, 'Hesther Mallows', 'Delivery Driver', 27848, 'Hesther.Mallows@kilburnazon.com', '2000-12-26', 'profile_icon.jpg', 'England North Distribution Centre', '51052 Hazelcrest Pass', '2024-02-28', 30, 'Full-Time', 'XH223005D', '', 'Husband', ''),
(12311667, 'Ursuline Boltwood', 'Delivery Driver', 30717, 'Ursuline.Boltwood@kilburnazon.com', '1996-11-23', 'profile_icon.jpg', 'England South Distribution Centre', '00426 Erie Place', '2024-01-03', 30, 'Full-Time', 'XT806503B', '', 'Mother', ''),
(12311703, 'Elsworth Vannuccini', 'Delivery Driver', 26213, 'Elsworth.Vannuccini@kilburnazon.com', '2004-10-15', 'profile_icon.jpg', 'England South Distribution Centre', '1 Killdeer Parkway', '2023-10-18', 30, 'Full-Time', 'LL003960D', 'Sansone Majury', 'Wife', '07750 314774'),
(12312622, 'Tish Armsden', 'Delivery Driver', 31890, 'Tish.Armsden@kilburnazon.com', '2007-10-08', 'profile_icon.jpg', 'Wales Distribution Centre', '1 Holy Cross Alley', '2021-01-31', 30, 'Full-Time', 'MA003782C', 'Tedd Elcott', 'Husband', '07929 076995'),
(12312658, 'Kailey Gilfoy', 'Delivery Driver', 25278, 'Kailey.Gilfoy@kilburnazon.com', '1992-03-22', 'profile_icon.jpg', 'Scotland Distribution Centre', '6 Cardinal Pass', '2018-12-26', 30, 'Full-Time', 'XX406929D', 'Orsola Philip', '', '07476 651024'),
(12312661, 'Yance Colenutt', 'Delivery Driver', 34275, 'Yance.Colenutt@kilburnazon.com', '1977-04-08', 'profile_icon.jpg', 'England North Distribution Centre', '3 Dwight Hill', '2018-01-11', 30, 'Freelance', 'EX860931B', 'Barclay Whitehall', 'Girlfriend', '07935 195747'),
(12312718, 'Jessee Gilliatt', 'Delivery Driver', 33264, 'Jessee.Gilliatt@kilburnazon.com', '1986-05-19', 'profile_icon.jpg', 'Wales Distribution Centre', '1 Ridgeview Court', '2016-02-03', 30, 'Full-Time', 'GP806436B', 'Adiana Calveley', '', '07013 385409'),
(12313264, 'Leyla Boraston', 'Delivery Driver', 26346, 'Leyla.Boraston@kilburnazon.com', '1976-07-26', 'profile_icon.jpg', 'Wales Distribution Centre', '494 Grim Alley', '2020-06-28', 30, 'Full-Time', 'WB171749D', '', '', '07518 048416'),
(12313366, 'Nelson Gabala', 'Delivery Driver', 28300, 'Nelson.Gabala@kilburnazon.com', '1975-10-14', 'profile_icon.jpg', 'England Central Distribution Centre', '60618 Fremont Crossing', '2016-11-17', 30, 'Part-Time', 'BK288308D', '', 'Boyfriend', ''),
(12313725, 'Tedda Howle', 'Delivery Driver', 32593, 'Tedda.Howle@kilburnazon.com', '1997-03-15', 'profile_icon.jpg', 'England South Distribution Centre', '581 Pepper Wood Lane', '2017-08-15', 30, 'Full-Time', 'WU418446C', 'Gilbertina Glaisner', 'Girlfriend', '07482 265277'),
(12313980, 'Natalie Riggert', 'Delivery Driver', 31733, 'Natalie.Riggert@kilburnazon.com', '1984-06-30', 'profile_icon.jpg', 'Northern Ireland Distribution Centre', '0 Melvin Plaza', '2016-07-29', 30, 'Full-Time', 'DZ022802D', 'Cale Aspital', '', '07150 096722'),
(12314042, 'Courtnay Glowach', 'Delivery Driver', 29544, 'Courtnay.Glowach@kilburnazon.com', '1999-05-14', 'profile_icon.jpg', 'England North Distribution Centre', '6 Red Cloud Plaza', '2015-05-12', 30, 'Part-Time', 'MY766732B', '', 'Mother', ''),
(12314327, 'Lucien Pfeiffer', 'Delivery Driver', 28500, 'Lucien.Pfeiffer@kilburnazon.com', '1981-06-12', 'profile_icon.jpg', 'Northern Ireland Distribution Centre', '56692 Esker Plaza', '2018-11-01', 30, 'Freelance', 'AA005657A', 'Rice Skentelbury', 'Father', '07208 447376'),
(12314528, 'Kingsley Santoro', 'Delivery Driver', 33011, 'Kingsley.Santoro@kilburnazon.com', '2005-05-31', 'profile_icon.jpg', 'Scotland Distribution Centre', '5 Anderson Center', '2017-07-28', 30, 'Part-Time', 'JS005009C', '', 'Wife', '07870 741081'),
(12314667, 'Sileas Brooksbank', 'Delivery Driver', 25331, 'Sileas.Brooksbank@kilburnazon.com', '1993-05-27', 'profile_icon.jpg', 'Scotland Distribution Centre', '1364 Hermina Alley', '2019-10-06', 30, 'Freelance', 'JF077926D', '', '', ''),
(12315187, 'Cayla Manginot', 'Delivery Driver', 30474, 'Cayla.Manginot@kilburnazon.com', '2005-08-03', 'profile_icon.jpg', 'Scotland Distribution Centre', '446 Springs Pass', '2021-12-20', 30, 'Full-Time', 'PW746511A', 'Keane Ales0', 'Civil Partner', '07707 013055'),
(12315752, 'Evvie Chesters', 'Delivery Driver', 26877, 'Evvie.Chesters@kilburnazon.com', '1997-09-04', 'profile_icon.jpg', 'Northern Ireland Distribution Centre', '84068 Sycamore Trail', '2015-07-14', 30, 'Freelance', 'AN202720C', 'Natasha Santoro', '', '07084 119115'),
(12315825, 'Dorita Ilyunin', 'Delivery Driver', 25521, 'Dorita.Ilyunin@kilburnazon.com', '2002-07-09', 'profile_icon.jpg', 'Wales Distribution Centre', '6902 La Follette Pass', '2018-03-13', 30, 'Full-Time', 'OU700204C', 'Geordie Lyall', 'Girlfriend', '07306 693225'),
(12315928, 'Rubetta Dienes', 'Delivery Driver', 30488, 'Rubetta.Dienes@kilburnazon.com', '2009-04-22', 'profile_icon.jpg', 'England Central Distribution Centre', '43037 Little Fleur Road', '2018-02-12', 30, 'Full-Time', 'TP293641C', 'Derrek Gladdin', 'Civil Partner', '07860 628735'),
(12316053, 'Donn Muscat', 'Delivery Driver', 27092, 'Donn.Muscat@kilburnazon.com', '1999-05-26', 'profile_icon.jpg', 'Wales Distribution Centre', '2269 Marquette Terrace', '2022-11-06', 30, 'Full-Time', 'MM977993D', '', 'Mother', '07794 304300'),
(12316237, 'Bald Spindler', 'Delivery Driver', 28972, 'Bald.Spindler@kilburnazon.com', '1977-11-12', 'profile_icon.jpg', 'Northern Ireland Distribution Centre', '894 Stoughton Way', '2018-08-29', 30, 'Full-Time', 'KY965343C', 'Isidor Hillan', '', '07722 676666'),
(12316925, 'Jacklyn Schuricke', 'Delivery Driver', 28147, 'Jacklyn.Schuricke@kilburnazon.com', '1999-11-21', 'profile_icon.jpg', 'England Central Distribution Centre', '13653 Granby Pass', '2016-08-17', 30, 'Full-Time', 'TW771202A', 'Cyrill Ismirnioglou', 'Husband', '07841 597997'),
(12317808, 'Philippine Hinchcliffe', 'Delivery Driver', 32534, 'Philippine.Hinchcliffe@kilburnazon.com', '2003-04-24', 'profile_icon.jpg', 'Scotland Distribution Centre', '29800 Main Alley', '2015-08-13', 30, 'Freelance', 'FZ330174A', 'Abbe Needs', 'Wife', ''),
(12317934, 'Phylis Shemwell', 'Delivery Driver', 26136, 'Phylis.Shemwell@kilburnazon.com', '1987-11-05', 'profile_icon.jpg', 'Northern Ireland Distribution Centre', '5604 Chinook Hill', '2016-04-08', 30, 'Full-Time', 'LT510431B', 'Gloria Highwood', 'Boyfriend', '07196 818911'),
(12318662, 'Viki Maddinon', 'Delivery Driver', 31908, 'Viki.Maddinon@kilburnazon.com', '1990-03-09', 'profile_icon.jpg', 'England North Distribution Centre', '42 Thierer Center', '2020-03-15', 30, 'Freelance', 'TI165499C', 'Afton Walden', '', '07039 917113'),
(12319513, 'Hillie Hele', 'Delivery Driver', 33855, 'Hillie.Hele@kilburnazon.com', '1999-02-04', 'profile_icon.jpg', 'England Central Distribution Centre', '820 Graceland Place', '2021-07-25', 30, 'Full-Time', 'ZO227530D', 'Bettina Evanson', 'Girlfriend', '07334 622208'),
(12319914, 'Saidee Favela', 'Delivery Driver', 31935, 'Saidee.Favela@kilburnazon.com', '1999-04-16', 'profile_icon.jpg', 'England South Distribution Centre', '94 Ruskin Street', '2016-11-10', 30, 'Full-Time', 'ZV971333B', 'Shaine Olsson', '', '07512 967997'),
(13110482, 'Jayme Greiswood', 'Accountant', 33681, 'Jayme.Greiswood@kilburnazon.com', '1991-11-11', 'profile_icon.jpg', 'Kilburn Building', '70 Farragut Lane', '2018-08-16', 30, 'Full-Time', 'PH455369B', 'Hayward Norley', 'Mother', '07832 036596'),
(13111738, 'Mirabella Gullane', 'Accountant', 38988, 'Mirabella.Gullane@kilburnazon.com', '1996-05-20', 'profile_icon.jpg', 'Lewis Building', '3 Beilfuss Trail', '2020-12-28', 30, 'Part-Time', 'KF883937B', '', 'Boyfriend', '07862 622159'),
(13117262, 'Samara Le febre', 'Accountant', 44372, 'Samara.Le febre@kilburnazon.com', '1990-05-16', 'profile_icon.jpg', 'Lewis Building', '200 Delladonna Terrace', '2021-12-14', 30, 'Full-Time', 'XA964107B', 'Marylynne Jonsson', 'Mother', '07437 831717'),
(13211973, 'Elden Toy', 'Financial Analyst', 39153, 'Elden.Toy@kilburnazon.com', '2004-06-04', 'profile_icon.jpg', 'Lewis Building', '2816 Florence Crossing', '2023-01-02', 30, 'Full-Time', 'NL822476D', 'Kienan Killeley', 'Father', ''),
(13212738, 'Paolo Lewin', 'Financial Analyst', 32254, 'Paolo.Lewin@kilburnazon.com', '1995-07-27', 'profile_icon.jpg', 'Kilburn Building', '84332 Oak Plaza', '2020-08-13', 30, 'Full-Time', 'RI019366A', 'Jenica McGrudder', 'Girlfriend', '07963 860510'),
(14111094, 'Gerek Davenell', 'Brand Developer', 28285, 'Gerek.Davenell@kilburnazon.com', '1993-07-28', 'profile_icon.jpg', 'Lewis Building', '057 Dixon Park', '2020-09-20', 30, 'Freelance', 'ZX739819A', '', 'Husband', '07183 143586'),
(14113626, 'Eberhard Pepi', 'Brand Developer', 23218, 'Eberhard.Pepi@kilburnazon.com', '1978-09-03', 'profile_icon.jpg', 'Kilburn Building', '4323 Vernon Lane', '2020-08-11', 30, 'Full-Time', 'BY151362A', 'Tabbie Gilphillan', '', '07678 551130'),
(14118236, 'Emogene Burchard', 'Brand Developer', 25249, 'Emogene.Burchard@kilburnazon.com', '1988-07-19', 'profile_icon.jpg', 'Broadgate Tower', '25 Arkansas Trail', '2022-09-29', 30, 'Part-Time', 'UZ112160A', '', 'Boyfriend', ''),
(14119372, 'Peirce Stoyell', 'Brand Developer', 22515, 'Peirce.Stoyell@kilburnazon.com', '1982-10-03', 'profile_icon.jpg', 'Lewis Building', '903 Claremont Street', '2020-10-13', 30, 'Freelance', 'VQ308399D', 'Doria Johanchon', 'Civil Partner', '07036 960338'),
(14212158, 'Zacharias Tomlett', 'Industry Researcher', 28703, 'Zacharias.Tomlett@kilburnazon.com', '1986-08-20', 'profile_icon.jpg', 'Lewis Building', '679 Brown Hill', '2018-05-01', 30, 'Full-Time', 'TK940382B', 'Minda Ferrillo', 'Mother', '07056 710360'),
(14213503, 'Merle Lehrahan', 'Industry Researcher', 29514, 'Merle.Lehrahan@kilburnazon.com', '1990-12-16', 'profile_icon.jpg', 'Lewis Building', '22 Aberg Trail', '2024-03-03', 30, 'Full-Time', 'CP398627A', 'Aluin Humbell', 'Mother', ''),
(14216011, 'Berny Mountstephen', 'Industry Researcher', 24129, 'Berny.Mountstephen@kilburnazon.com', '1986-12-16', 'profile_icon.jpg', 'Lewis Building', '5347 Vermont Parkway', '2020-11-07', 30, 'Full-Time', 'CM316192A', '', 'Mother', '07532 858225'),
(14216103, 'Doretta Lavrick', 'Industry Researcher', 25206, 'Doretta.Lavrick@kilburnazon.com', '2002-03-02', 'profile_icon.jpg', 'Lewis Building', '72342 Swallow Drive', '2019-10-11', 30, 'Full-Time', 'IN506488A', 'Dacey Chasmoor', 'Mother', '07780 371203'),
(14218309, 'Colette McChruiter', 'Industry Researcher', 28946, 'Colette.McChruiter@kilburnazon.com', '1996-09-27', 'profile_icon.jpg', 'Broadgate Tower', '227 Green Ridge Junction', '2023-05-01', 30, 'Freelance', 'YK615192A', 'Brianna Harlock', 'Husband', '07181 235352'),
(14219116, 'Cosmo Challicombe', 'Industry Researcher', 27254, 'Cosmo.Challicombe@kilburnazon.com', '1997-02-13', 'profile_icon.jpg', 'Kilburn Building', '87 Comanche Trail', '2019-11-29', 30, 'Full-Time', 'IB014432A', '', 'Girlfriend', '07527 844139'),
(14311409, 'Karlotte Jeffry', 'Product Designer', 23759, 'Karlotte.Jeffry@kilburnazon.com', '1991-07-20', 'profile_icon.jpg', 'Kilburn Building', '964 Fordem Drive', '2023-11-13', 30, 'Full-Time', 'VP996371C', 'Viola Ferrario', 'Girlfriend', '07717 776894'),
(14311984, 'Annis Cranna', 'Product Designer', 24243, 'Annis.Cranna@kilburnazon.com', '1987-08-17', 'profile_icon.jpg', 'Broadgate Tower', '26 Bay Court', '2021-05-18', 30, 'Full-Time', 'RJ336182A', 'Dmitri Cranna', 'Husband', ''),
(14312012, 'Ondrea Brewitt', 'Product Designer', 22872, 'Ondrea.Brewitt@kilburnazon.com', '1979-12-18', 'profile_icon.jpg', 'Kilburn Building', '47 Welch Way', '2016-06-02', 30, 'Full-Time', 'WQ882395C', 'Elita Pohls', 'Civil Partner', ''),
(14312778, "Andris O'Coskerry", 'Product Designer', 23747, "Andris.O'Coskerry@kilburnazon.com", '1988-04-08', 'profile_icon.jpg', 'Broadgate Tower', '70267 Hallows Plaza', '2017-04-05', 30, 'Full-Time', 'DE252849D', 'Fernande Struthers', 'Father', '07699 818669'),
(14315369, 'Uta Ashbee', 'Product Designer', 23762, 'Uta.Ashbee@kilburnazon.com', '1989-10-09', 'profile_icon.jpg', 'Lewis Building', '73746 Commercial Pass', '2015-12-30', 30, 'Full-Time', 'RY032334C', 'Danette Costi', '', '07997 748914'),
(14316158, 'Janessa Hilldrup', 'Product Designer', 24021, 'Janessa.Hilldrup@kilburnazon.com', '2008-07-12', 'profile_icon.jpg', 'Lewis Building', '7 Dorton Way', '2016-08-21', 30, 'Full-Time', 'JO147528A', 'Denny Nicolson', 'Wife', '07123 801554'),
(14316558, 'Portie Shera', 'Product Designer', 25682, 'Portie.Shera@kilburnazon.com', '1989-12-28', 'profile_icon.jpg', 'Kilburn Building', '263 Old Gate Road', '2016-02-04', 30, 'Full-Time', 'AU408831D', 'Daria Menichillo', '', '07373 825339'),
(14319195, 'Loutitia Marsay', 'Product Designer', 29351, 'Loutitia.Marsay@kilburnazon.com', '1999-05-15', 'profile_icon.jpg', 'Kilburn Building', '19713 Jenna Trail', '2020-10-30', 30, 'Full-Time', 'KF921497D', 'Natalina Ollis', '', ''),
(14319749, 'Brendon Pinck', 'Product Designer', 25881, 'Brendon.Pinck@kilburnazon.com', '1983-03-15', 'profile_icon.jpg', 'Kilburn Building', '1 Aberg Road', '2021-09-10', 30, 'Full-Time', 'QT527452D', '', 'Mother', ''),
(14319953, 'Cornelle Plowright', 'Product Designer', 28686, 'Cornelle.Plowright@kilburnazon.com', '1993-03-15', 'profile_icon.jpg', 'Kilburn Building', '8902 Eastlawn Court', '2015-03-22', 30, 'Full-Time', 'UG075011C', 'Calypso Mapston', '', '07608 461696'),
(15111844, 'Tiphany Ricci', 'Front End Developer', 38197, 'Tiphany.Ricci@kilburnazon.com', '1987-12-19', 'profile_icon.jpg', 'Lewis Building', '71746 Division Court', '2018-11-21', 30, 'Freelance', 'OJ317301B', 'Artemus Gile', 'Wife', '07077 101937'),
(15112846, 'Quintina Stannard', 'Front End Developer', 48586, 'Quintina.Stannard@kilburnazon.com', '2002-10-24', 'profile_icon.jpg', 'Lewis Building', '695 Mariners Cove Court', '2018-04-30', 30, 'Part-Time', 'OS711286D', 'Livvy Shingles', 'Wife', ''),
(15113827, 'Codie Beards', 'Front End Developer', 38820, 'Codie.Beards@kilburnazon.com', '2004-11-17', 'profile_icon.jpg', 'Kilburn Building', '7 Corben Road', '2024-03-12', 30, 'Freelance', 'QS611097B', 'Kassi Flay', 'Father', '07204 608582'),
(15114920, 'Archie Mongeot', 'Front End Developer', 46420, 'Archie.Mongeot@kilburnazon.com', '1986-06-05', 'profile_icon.jpg', 'Kilburn Building', '210 Lake View Pass', '2023-04-05', 30, 'Freelance', 'DS458797C', '', '', ''),
(15118902, 'Torrey Lidgertwood', 'Front End Developer', 37008, 'Torrey.Lidgertwood@kilburnazon.com', '2006-02-12', 'profile_icon.jpg', 'Lewis Building', '366 Eagle Crest Park', '2023-05-07', 30, 'Full-Time', 'MB541802C', 'Tull North', '', '07082 174879'),
(15119246, 'Felisha Folke', 'Front End Developer', 38958, 'Felisha.Folke@kilburnazon.com', '1982-07-29', 'profile_icon.jpg', 'Broadgate Tower', '0773 Del Mar Place', '2018-08-14', 30, 'Part-Time', 'DY315283B', 'Brigitta Greep', '', '07079 952137'),
(15119273, 'Jolene Leeuwerink', 'Front End Developer', 43182, 'Jolene.Leeuwerink@kilburnazon.com', '1989-03-28', 'profile_icon.jpg', 'Broadgate Tower', '7 Comanche Hill', '2018-01-24', 30, 'Part-Time', 'FL470973C', 'Ronda Mabley', 'Wife', '07342 424970'),
(15210019, 'Philipa Secret', 'Back End Developer', 39583, 'Philipa.Secret@kilburnazon.com', '1995-12-15', 'profile_icon.jpg', 'Broadgate Tower', '02657 Summit Place', '2020-02-05', 30, 'Part-Time', 'BU955906D', 'Jeramey Czadla', 'Girlfriend', '07360 969163'),
(15210392, 'Gert Romagnosi', 'Back End Developer', 37617, 'Gert.Romagnosi@kilburnazon.com', '1995-04-29', 'profile_icon.jpg', 'Kilburn Building', '81 Mallard Alley', '2016-08-21', 30, 'Full-Time', 'TG492624A', 'Jilly Fullbrook', 'Girlfriend', '07405 079997'),
(15211173, 'Colas Rignoldes', 'Back End Developer', 35925, 'Colas.Rignoldes@kilburnazon.com', '1982-09-21', 'profile_icon.jpg', 'Kilburn Building', '1448 Springview Point', '2022-04-09', 30, 'Full-Time', 'TM708308D', '', 'Father', ''),
(15212726, 'Ad Gitthouse', 'Back End Developer', 38896, 'Ad.Gitthouse@kilburnazon.com', '2008-05-06', 'profile_icon.jpg', 'Lewis Building', '85018 Bluejay Way', '2018-08-21', 30, 'Full-Time', 'YF342757B', '', 'Girlfriend', '07933 924971'),
(15214928, 'Eb Scotter', 'Back End Developer', 35585, 'Eb.Scotter@kilburnazon.com', '2001-09-25', 'profile_icon.jpg', 'Kilburn Building', '8295 Milwaukee Junction', '2021-11-14', 30, 'Freelance', 'UQ114832D', 'Rosabel Rosell', 'Girlfriend', '07949 698940'),
(15218274, 'Brooke Bevir', 'Back End Developer', 41271, 'Brooke.Bevir@kilburnazon.com', '1992-12-08', 'profile_icon.jpg', 'Broadgate Tower', '9456 Charing Cross Parkway', '2020-04-15', 30, 'Full-Time', 'SJ671620A', 'Tremayne Mumford', 'Girlfriend', '07070 829323'),
(15310538, 'Barnie Howsden', 'Full Stack Developer', 78124, 'Barnie.Howsden@kilburnazon.com', '2004-05-28', 'profile_icon.jpg', 'Lewis Building', '940 Green Ridge Crossing', '2017-04-26', 30, 'Part-Time', 'QW437381C', '', 'Mother', '07654 711451'),
(15311928, 'Hobard McQuillen', 'Full Stack Developer', 68912, 'Hobard.McQuillen@kilburnazon.com', '1981-12-30', 'profile_icon.jpg', 'Lewis Building', '147 Clarendon Lane', '2023-11-24', 30, 'Part-Time', 'VN239373D', '', 'Husband', ''),
(15311947, 'Tamqrah Havill', 'Full Stack Developer', 89016, 'Tamqrah.Havill@kilburnazon.com', '1974-11-30', 'profile_icon.jpg', 'Kilburn Building', '03 Monument Trail', '2019-11-23', 30, 'Part-Time', 'ZU142453A', 'Burnard Yosifov', 'Girlfriend', '07231 488090'),
(15314926, 'Brunhilde Doring', 'Full Stack Developer', 82064, 'Brunhilde.Doring@kilburnazon.com', '1989-03-04', 'profile_icon.jpg', 'Lewis Building', '8 Canary Terrace', '2023-06-05', 30, 'Full-Time', 'DY737542D', 'Marlin Knight', 'Civil Partner', '07326 647976'),
(15413482, 'Brande Setch', 'Junior Developer', 53173, 'Brande.Setch@kilburnazon.com', '2000-06-01', 'profile_icon.jpg', 'Kilburn Building', '2 Columbus Terrace', '2020-09-11', 30, 'Full-Time', 'CM199844A', 'Nerissa Maisey', 'Wife', '07740 330980'),
(15413871, 'Tobit Blacker', 'Junior Developer', 22000, 'Tobit.Blacker@kilburnazon.com', '2005-09-26', 'profile_icon.jpg', 'Broadgate Tower', '77241 Arapahoe Court', '2023-01-21', 30, 'Internship', 'PX409930A', 'Letitia Normabell', 'Mother', '07295 892245'),
(15419183, 'Bevvy Counihan', 'Junior Developer', 95590, 'Bevvy.Counihan@kilburnazon.com', '1992-04-05', 'profile_icon.jpg', 'Broadgate Tower', '20943 Everett Park', '2023-07-04', 30, 'Part-Time', 'CU409429A', 'Fayth Bazylets', 'Girlfriend', ''),
(15419236, 'Raynard Scriviner', 'Junior Developer', 68175, 'Raynard.Scriviner@kilburnazon.com', '2008-03-27', 'profile_icon.jpg', 'Kilburn Building', '531 Hoard Place', '2023-03-26', 30, 'Part-Time', 'ST135719D', 'Emiline McEnhill', '', '07952 777488'),
(15419427, 'Fergus Blacker', 'Junior Developer', 22000, 'Fergus.Blacker@kilburnazon.com', '2005-09-26', 'profile_icon.jpg', 'Broadgate Tower', '77241 Arapahoe Court', '2023-01-21', 30, 'Internship', 'AJ281735A', 'Letitia Normabell', 'Mother', '07295 892245'),
(15512916, 'Sherye Larrat', 'Cyber Security', 63743, 'Sherye.Larrat@kilburnazon.com', '1993-12-23', 'profile_icon.jpg', 'Kilburn Building', '700 Harper Alley', '2018-03-08', 30, 'Part-Time', 'ZK749313A', 'Isidora Hanster', '', '07736 429556'),
(15518273, 'Julissa Pedrocchi', 'Cyber Security', 62946, 'Julissa.Pedrocchi@kilburnazon.com', '1989-02-28', 'profile_icon.jpg', 'Lewis Building', '23483 Clove Circle', '2022-02-21', 30, 'Part-Time', 'XA340620B', '', 'Wife', '07043 095609');

--
-- Triggers `employee`
--
DELIMITER $$
CREATE TRIGGER `log_update` AFTER UPDATE ON `employee` FOR EACH ROW BEGIN
IF OLD.employee_name <> NEW.employee_name THEN
INSERT INTO employee_update (employee_ID, changed_column, new_value, old_value, time_change)
VALUES (OLD.unique_ID, 'employee_name', NEW.employee_name, OLD.employee_name, NOW());
END IF;

IF OLD.email <> NEW.email THEN
INSERT INTO employee_update (employee_ID, changed_column, new_value, old_value, time_change)
VALUES (OLD.unique_ID, 'email', NEW.email, OLD.email, NOW());
END IF;
     
IF OLD.position <> NEW.position THEN
INSERT INTO employee_update (employee_ID, changed_column, new_value, old_value, time_change)
VALUES (OLD.unique_ID, 'position', NEW.position, OLD.position, NOW());
END IF;
     
IF OLD.salary <> NEW.salary THEN
INSERT INTO employee_update (employee_ID, changed_column, new_value, old_value, time_change)
VALUES (OLD.unique_ID, 'salary', NEW.salary, OLD.salary, NOW());
END IF;
     
IF OLD.dob <> NEW.dob THEN
INSERT INTO employee_update (employee_ID, changed_column, new_value, old_value, time_change)
VALUES (OLD.unique_ID, 'dob', NEW.dob, OLD.dob, NOW());
END IF;
     
IF OLD.office_location <> NEW.office_location THEN
INSERT INTO employee_update (employee_ID, changed_column, new_value, old_value, time_change)
VALUES (OLD.unique_ID, 'office_location', NEW.office_location, OLD.office_location, NOW());
END IF;
     
IF OLD.home_address <> NEW.home_address THEN
INSERT INTO employee_update (employee_ID, changed_column, new_value, old_value, time_change)
VALUES (OLD.unique_ID, 'home_address', NEW.home_address, OLD.home_address, NOW());
END IF;
     
     IF OLD.hired_date <> NEW.hired_date THEN
     	INSERT INTO employee_update (employee_ID, changed_column, new_value, old_value, time_change)
        VALUES (OLD.unique_ID, 'hired_date', NEW.hired_date, OLD.hired_date, NOW());
     END IF;
     
     IF OLD.amount_of_leave <> NEW.amount_of_leave THEN
     	INSERT INTO employee_update (employee_ID, changed_column, new_value, old_value, time_change)
        VALUES (OLD.unique_ID, 'amount_of_leave', NEW.amount_of_leave, OLD.amount_of_leave, NOW());
     END IF;
     
     IF OLD.contract <> NEW.contract THEN
     	INSERT INTO employee_update (employee_ID, changed_column, new_value, old_value, time_change)
        VALUES (OLD.unique_ID, 'contract', NEW.contract, OLD.contract, NOW());
     END IF;
     
     IF OLD.nin <> NEW.nin THEN
     	INSERT INTO employee_update (employee_ID, changed_column, new_value, old_value, time_change)
        VALUES (OLD.unique_ID, 'nin', NEW.nin, OLD.nin, NOW());
     END IF;
     
     IF OLD.emergency_name <> NEW.emergency_name THEN
     	INSERT INTO employee_update (employee_ID, changed_column, new_value, old_value, time_change)
        VALUES (OLD.unique_ID, 'emergency_name', NEW.emergency_name, OLD.emergency_name, NOW());
     END IF;
     
     IF OLD.emergency_relationship <> NEW.emergency_relationship THEN
     	INSERT INTO employee_update (employee_ID, changed_column, new_value, old_value, time_change)
        VALUES (OLD.unique_ID, 'emergency_relationship', NEW.emergency_relationship, OLD.emergency_relationship, NOW());
     END IF;
     
     IF OLD.emergency_phone <> NEW.emergency_phone THEN
     	INSERT INTO employee_update (employee_ID, changed_column, new_value, old_value, time_change)
        VALUES (OLD.unique_ID, 'emergency_phone', NEW.emergency_phone, OLD.emergency_phone, NOW());
     END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `termination` AFTER DELETE ON `employee` FOR EACH ROW BEGIN
	INSERT INTO employee_termination (unique_ID, employee_name, position, salary, email, dob, office_location, home_address, hired_date, contract, nin, log_date, log_time)
    VALUES (OLD.unique_ID, OLD.employee_name, OLD.position, OLD.salary, OLD.email, OLD.dob, OLD.office_location, OLD.home_address, OLD.hired_date, OLD.contract, OLD.nin, CURRENT_DATE(), CURRENT_TIME());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `employee_termination`
--

CREATE TABLE `employee_termination` (
  `unique_ID` int NOT NULL,
  `employee_name` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `position` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `salary` int NOT NULL,
  `email` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `dob` date NOT NULL,
  `office_location` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `home_address` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `hired_date` date NOT NULL,
  `contract` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `nin` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `log_date` time NOT NULL,
  `log_time` time NOT NULL,
  `logger_ID` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_update`
--

CREATE TABLE `employee_update` (
  `employee_ID` int NOT NULL,
  `changed_column` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `new_value` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `old_value` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `time_change` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `email` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `course_id` varchar(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  `feedback` text COLLATE utf8mb3_unicode_ci NOT NULL,
  `year` varchar(4) COLLATE utf8mb3_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `leave_management`
--

CREATE TABLE `leave_management` (
  `leave_key` int NOT NULL,
  `employee_ID` int NOT NULL,
  `date_start` date NOT NULL,
  `date_end` date NOT NULL,
  `status` varchar(20) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'Requested',
  `reasons` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `comment` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT 'No comment',
  `total` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

CREATE TABLE `location` (
  `address` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `location`
--

INSERT INTO `location` (`address`, `type`) VALUES
('Birmingham Office', 'Office'),
('Broadgate Tower', 'Office'),
('England Central Distribution Centre', 'Distribution Centre'),
('England North Distribution Centre', 'Distribution Centre'),
('England South Distribution Centre', 'Distribution Centre'),
('Kilburn Building', 'Head Office'),
('Lewis Building', 'Office'),
('London Office', 'Office'),
('Northern Ireland Distribution Centre', 'Distribution Centre'),
('Scotland Distribution Centre', 'Distribution Centre'),
('Wales Distribution Centre', 'Distribution Centre');

-- --------------------------------------------------------

--
-- Table structure for table `orderedproducts`
--

CREATE TABLE `orderedproducts` (
  `order_ID` int NOT NULL,
  `product_ID` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `position`
--

CREATE TABLE `position` (
  `position` varchar(255) NOT NULL,
  `person_in_charge` varchar(255) NOT NULL,
  `department` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `position`
--

INSERT INTO `position` (`position`, `person_in_charge`, `department`) VALUES
('Accountant', 'Jeff Lovelace', 'Finance'),
('Back End Developer', 'Sarah Turing', 'Technology'),
('Brand Developer\r\n', 'Steve Hopper', 'Marketing'),
('Cyber Security', 'Sarah Turing', 'Technology'),
('Delivery Driver', 'Tracey Gates', 'Operations'),
('Factory Worker', 'Tracey Gates', 'Operations'),
('Financial Analyst', 'Jeff Lovelace', 'Finance'),
('Front End Developer', 'Sarah Turing', 'Technology'),
('Full Stack Developer', 'Sarah Turing', 'Technology'),
('Health & Safety Officer', 'Tracey Gates', 'Operations'),
('Industry Researcher', 'Steve Hopper', 'Marketing'),
('Junior Developer', 'Sarah Turing', 'Technology'),
('Product Designer', 'Steve Hopper', 'Marketing');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `unique_ID` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `manufacturer` varchar(255) NOT NULL,
  `price` float NOT NULL,
  `number_in_stock` int NOT NULL,
  `number_of_reviews` int NOT NULL,
  `number_answerd` int NOT NULL,
  `average_rating` int NOT NULL,
  `category` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `productlocatiom`
--

CREATE TABLE `productlocatiom` (
  `product_ID` varchar(255) NOT NULL,
  `location_address` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

CREATE TABLE `review` (
  `product_ID` varchar(255) NOT NULL,
  `rating` int NOT NULL,
  `review` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vehicle`
--

CREATE TABLE `vehicle` (
  `vehicle_ID` int NOT NULL,
  `vehicle_registration` varchar(20) NOT NULL,
  `vehicle_model` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `customer_order`
--
ALTER TABLE `customer_order`
  ADD PRIMARY KEY (`order_ID`),
  ADD KEY `customer_name` (`customer_name`),
  ADD KEY `delivery_vehicle_ID` (`delivery_vehicle_ID`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`unique_ID`),
  ADD KEY `position` (`position`),
  ADD KEY `office_location` (`office_location`);

--
-- Indexes for table `employee_termination`
--
ALTER TABLE `employee_termination`
  ADD PRIMARY KEY (`unique_ID`);

--
-- Indexes for table `employee_update`
--
ALTER TABLE `employee_update`
  ADD KEY `employee_ID` (`employee_ID`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`email`,`course_id`,`year`);

--
-- Indexes for table `leave_management`
--
ALTER TABLE `leave_management`
  ADD PRIMARY KEY (`leave_key`),
  ADD KEY `leave_management_ibfk_1` (`employee_ID`);

--
-- Indexes for table `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`address`);

--
-- Indexes for table `orderedproducts`
--
ALTER TABLE `orderedproducts`
  ADD KEY `order_ID` (`order_ID`),
  ADD KEY `product_ID` (`product_ID`);

--
-- Indexes for table `position`
--
ALTER TABLE `position`
  ADD PRIMARY KEY (`position`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`unique_ID`);

--
-- Indexes for table `productlocatiom`
--
ALTER TABLE `productlocatiom`
  ADD KEY `location_address` (`location_address`),
  ADD KEY `product_ID` (`product_ID`);

--
-- Indexes for table `review`
--
ALTER TABLE `review`
  ADD KEY `product_ID` (`product_ID`);

--
-- Indexes for table `vehicle`
--
ALTER TABLE `vehicle`
  ADD PRIMARY KEY (`vehicle_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customer_order`
--
ALTER TABLE `customer_order`
  MODIFY `order_ID` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `leave_management`
--
ALTER TABLE `leave_management`
  MODIFY `leave_key` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vehicle`
--
ALTER TABLE `vehicle`
  MODIFY `vehicle_ID` int NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `customer_order`
--
ALTER TABLE `customer_order`
  ADD CONSTRAINT `customer_order_ibfk_1` FOREIGN KEY (`customer_name`) REFERENCES `customer` (`name`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `customer_order_ibfk_2` FOREIGN KEY (`delivery_vehicle_ID`) REFERENCES `vehicle` (`vehicle_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`position`) REFERENCES `position` (`position`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `employee_ibfk_2` FOREIGN KEY (`office_location`) REFERENCES `location` (`address`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `employee_update`
--
ALTER TABLE `employee_update`
  ADD CONSTRAINT `employee_update_ibfk_1` FOREIGN KEY (`employee_ID`) REFERENCES `employee` (`unique_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `leave_management`
--
ALTER TABLE `leave_management`
  ADD CONSTRAINT `leave_management_ibfk_1` FOREIGN KEY (`employee_ID`) REFERENCES `employee` (`unique_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `orderedproducts`
--
ALTER TABLE `orderedproducts`
  ADD CONSTRAINT `orderedproducts_ibfk_1` FOREIGN KEY (`order_ID`) REFERENCES `customer_order` (`order_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `orderedproducts_ibfk_2` FOREIGN KEY (`product_ID`) REFERENCES `product` (`unique_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `productlocatiom`
--
ALTER TABLE `productlocatiom`
  ADD CONSTRAINT `productlocatiom_ibfk_1` FOREIGN KEY (`location_address`) REFERENCES `location` (`address`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `productlocatiom_ibfk_2` FOREIGN KEY (`product_ID`) REFERENCES `product` (`unique_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `review`
--
ALTER TABLE `review`
  ADD CONSTRAINT `review_ibfk_1` FOREIGN KEY (`product_ID`) REFERENCES `product` (`unique_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`s61110ab`@`localhost` EVENT `auto_delete` ON SCHEDULE EVERY 1 DAY STARTS '2024-11-22 13:09:39' ON COMPLETION NOT PRESERVE ENABLE DO DELETE FROM employee_termination
WHERE LOG_DATE < NOW() - INTERVAL 3 YEAR$$

DELIMITER ;
COMMIT;
