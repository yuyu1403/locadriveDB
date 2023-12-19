DROP DATABASE IF EXISTS LOCADRIVE;

CREATE DATABASE LOCADRIVE;

USE LOCADRIVE;

CREATE TABLE VEHICLE(
   veh_id INT AUTO_INCREMENT PRIMARY KEY,
   veh_num VARCHAR(9) NOT NULL UNIQUE,
   veh_brand VARCHAR(20) NOT NULL,
   veh_model VARCHAR(50) NOT NULL,
   veh_cat ENUM('ECO', 'FAMILY', 'PRESTIGE') NOT NULL,
   veh_daily_price DECIMAL(6,2) NOT NULL,
   veh_fuel ENUM('ES','EV','GO', 'HY') NOT NULL,
   veh_mileage INT,
   veh_transmission ENUM('A', 'M') NOT NULL,
   veh_conform TINYINT(1) NOT NULL,  -- in MariaDB LOGICAL is replaced by TINYINT
   veh_tank_ok TINYINT(1) NOT NULL,
   veh_service DATE NOT NULL
) ENGINE=INNODB;

CREATE TABLE UTILISATEUR(
   user_id INT AUTO_INCREMENT PRIMARY KEY,
   user_surname VARCHAR(50) NOT NULL,
   user_name VARCHAR(50) NOT NULL,
   user_email VARCHAR(100) NOT NULL UNIQUE,
   user_adress VARCHAR(250) NOT NULL,
   user_phone VARCHAR(20) NOT NULL UNIQUE,
   user_pwd VARCHAR(255) NOT NULL,
   user_role ENUM('CLIENT', 'STAFF') NOT NULL
) ENGINE=INNODB;

CREATE TABLE STAFF(
   staff_id INT PRIMARY KEY,  -- == user_id
   staff_entry_date DATE NOT NULL,
   staff_contract ENUM ('CDI', 'CDD', 'APPRENTI') NOT NULL,
   staff_RQTH TINYINT(1),
   FOREIGN KEY(staff_id) REFERENCES UTILISATEUR(user_id)
) ENGINE=INNODB;

CREATE TABLE CLIENT(
   cli_id INT PRIMARY KEY,  -- == user_id
   cli_licence VARCHAR(50) NOT NULL UNIQUE,
   FOREIGN KEY(cli_id) REFERENCES UTILISATEUR(user_id)
) ENGINE=INNODB;

CREATE TABLE RESERVATION(
   res_id INT AUTO_INCREMENT PRIMARY KEY,
   res_end DATE NOT NULL,
   res_total DECIMAL(6,2) NOT NULL,
   res_start DATE NOT NULL,
   veh_id INT NOT NULL,
   user_id INT NOT NULL,
   FOREIGN KEY(veh_id) REFERENCES VEHICLE(veh_id),
   FOREIGN KEY(user_id) REFERENCES UTILISATEUR(user_id)
) ENGINE=INNODB;
