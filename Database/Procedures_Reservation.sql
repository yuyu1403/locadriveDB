USE LOCADRIVE;

-- GESTION DES RESERVATIONS --

----------------------------------- Création d'une réservation ----------------------------------------------------------
DELIMITER //
CREATE PROCEDURE AddReservation(
    p_res_start DATE,
    p_res_end DATE,
    p_veh_id INT,
    p_user_id INT
)
BEGIN
    DECLARE p_res_total DECIMAL(6,2);
    
    -- Calcul du coût total: nombre de jours * tarif journalier du véhicule
    SELECT veh_daily_price * DATEDIFF(p_res_end, p_res_start) INTO p_res_total
    FROM VEHICLE WHERE veh_id = p_veh_id;
    
    INSERT INTO RESERVATION(res_start, res_end, res_total, veh_id, user_id)
    VALUES (p_res_start, p_res_end, p_res_total, p_veh_id, p_user_id);
END //
DELIMITER ;

------------------------------- Affichage des réservations pour un utilisateur --------------------------------------
DELIMITER //
CREATE PROCEDURE GetReservationsForUser(p_user_id INT)
BEGIN
    SELECT * FROM RESERVATION WHERE user_id = p_user_id;
END //
DELIMITER ;

----------------------------- Affichage des réservations pour un véhicule --------------------------------------------
DELIMITER //
CREATE PROCEDURE GetReservationsForVehicle(p_veh_id INT)
BEGIN
    SELECT * FROM RESERVATION WHERE veh_id = p_veh_id;
END //
DELIMITER ;

---------------------------- Annulation d'annulation d'une réservation -----------------------------------------------
DELIMITER //
CREATE PROCEDURE CancelReservation(p_res_id INT)
BEGIN
    DELETE FROM RESERVATION WHERE res_id = p_res_id;
END //
DELIMITER ;

-- Commentaire:
---- Concernant la modification d'une réservation, j'ai opté pour une approche annulation => nouvelle réservation
---- pour plus de simplicité.