USE LOCADRIVE;

-- GESTION DES UTILISATEURS --

-------------------------------------------- Ajouter un client ------------------------------------------------------
DELIMITER //
CREATE PROCEDURE InsertNewClient(
    p_user_surname VARCHAR(50),
    p_user_name VARCHAR(50),
    p_user_email VARCHAR(100),
    p_user_adress VARCHAR(250),
    p_user_phone VARCHAR(20),
    p_user_pwd VARCHAR(255), 
    p_cli_licence VARCHAR(50)
)
BEGIN
    -- Insertion dans la table UTILISATEUR
    INSERT INTO UTILISATEUR(user_surname, user_name, user_email, user_adress, user_phone, user_pwd, user_role) 
    VALUES (p_user_surname, p_user_name, p_user_email, p_user_adress, p_user_phone, p_user_pwd, 'CLIENT');

    -- Récupération du dernier ID inséré dans la table UTILISATEUR
    SET @last_user_id = LAST_INSERT_ID();

    -- Insertion dans la table CLIENT
    INSERT INTO CLIENT(cli_id, cli_licence) VALUES (@last_user_id, p_cli_licence);
END //
DELIMITER ;

---------------------------------------------- Ajouter un employé ---------------------------------------------------
DELIMITER //
CREATE PROCEDURE InsertNewStaff(
    p_user_surname VARCHAR(50),
    p_user_name VARCHAR(50),
    p_user_email VARCHAR(100),
    p_user_adress VARCHAR(250),
    p_user_phone VARCHAR(20),
    p_user_pwd VARCHAR(255),
    p_staff_entry_date DATE,
    p_staff_contract ENUM('CDI', 'CDD', 'APPRENTI'),
    p_staff_RQTH TINYINT(1)
)
BEGIN
    -- Insertion dans la table UTILISATEUR
    INSERT INTO UTILISATEUR(user_surname, user_name, user_email, user_adress, user_phone, user_pwd, user_role) 
    VALUES (p_user_surname, p_user_name, p_user_email, p_user_adress, p_user_phone, p_user_pwd, 'STAFF');

    -- Récupération du dernier ID inséré dans la table UTILISATEUR
    SET @last_user_id = LAST_INSERT_ID();

    -- Insertion dans la table STAFF
    INSERT INTO STAFF(staff_id, staff_entry_date, staff_contract, staff_RQTH) 
    VALUES (@last_user_id, p_staff_entry_date, p_staff_contract, p_staff_RQTH);
END //
DELIMITER ;

--------------------------------------- Récupérer les infos d'un utilisateur --------------------------------
DELIMITER //
CREATE PROCEDURE GetUser(p_user_id INT)
BEGIN
    SELECT * FROM UTILISATEUR WHERE user_id = p_user_id;
END //
DELIMITER ;

-------------------------------------- Récupérer la liste des utilisateurs -------------------------------------
DELIMITER //
CREATE PROCEDURE GetAllUsers()
BEGIN
    SELECT * FROM UTILISATEUR;
END //
DELIMITER ;

------------------------------------------- Updater un utilisateur ------------------------------------------------
DELIMITER //
CREATE PROCEDURE UpdateUser(
    p_user_id INT,
    p_user_surname VARCHAR(50),
    p_user_name VARCHAR(50),
    p_user_email VARCHAR(100),
    p_user_adress VARCHAR(250),
    p_user_phone VARCHAR(20),
    p_user_pwd VARCHAR(255)
)
BEGIN
    UPDATE UTILISATEUR
    SET user_surname = COALESCE(p_user_surname, user_surname),
        user_name = COALESCE(p_user_name, user_name),
        user_email = COALESCE(p_user_email, user_email),
        user_adress = COALESCE(p_user_adress, user_adress),
        user_phone = COALESCE(p_user_phone, user_phone),
        user_pwd = COALESCE(p_user_pwd, user_pwd)
    WHERE user_id = p_user_id;
END //
DELIMITER ;

----------------------------------------------- Supprimer un client -------------------------------------------------
DELIMITER //
CREATE PROCEDURE DeleteClient(p_user_id INT)
BEGIN
    DELETE FROM CLIENT WHERE cli_id = p_user_id;
    DELETE FROM UTILISATEUR WHERE user_id = p_user_id;
END //
DELIMITER ;

---------------------------------------------- Supprimer un employé ------------------------------------------------
DELIMITER //
CREATE PROCEDURE DeleteStaff(p_user_id INT)
BEGIN
    DELETE FROM STAFF WHERE staff_id = p_user_id;
    DELETE FROM UTILISATEUR WHERE user_id = p_user_id;
END //
DELIMITER ;


