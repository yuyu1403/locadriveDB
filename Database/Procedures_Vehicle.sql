USE LOCADRIVE;

-- GESTION DES véhiculeS --

-------------------------------------- Ajouter un véhicule ----------------------------------------------------------
DELIMITER //
CREATE PROCEDURE AddVehicle(
    IN p_veh_num VARCHAR(9),
    IN p_veh_brand VARCHAR(20),
    IN p_veh_model VARCHAR(50),
    IN p_veh_cat ENUM('ECO', 'FAMILY', 'PRESTIGE'),
    IN p_veh_daily_price DECIMAL(6,2),
    IN p_veh_fuel ENUM('ES','EV','GO', 'HY'),
    IN p_veh_mileage INT,
    IN p_veh_transmission ENUM('A', 'M'),
    IN p_veh_conform TINYINT(1),
    IN p_veh_tank_ok TINYINT(1),
    IN p_veh_service DATE
)
BEGIN
    INSERT INTO VEHICLE (veh_num, veh_brand, veh_model, veh_cat, veh_daily_price, veh_fuel, veh_mileage, veh_transmission, veh_conform, veh_tank_ok, veh_service)
    VALUES (p_veh_num, p_veh_brand, p_veh_model, p_veh_cat, p_veh_daily_price, p_veh_fuel, p_veh_mileage, p_veh_transmission, p_veh_conform, p_veh_tank_ok, p_veh_service);
END //
DELIMITER ;

---------------------------------------------- MaJ un véhicule ------------------------------------------------------
DELIMITER //
CREATE PROCEDURE UpdateVehicle(
    IN p_veh_id INT,
    IN p_veh_num VARCHAR(9),
    IN p_veh_brand VARCHAR(20),
    IN p_veh_model VARCHAR(50),
    IN p_veh_cat ENUM('ECO', 'FAMILY', 'PRESTIGE'),
    IN p_veh_daily_price DECIMAL(6,2),
    IN p_veh_fuel ENUM('ES','EV','GO', 'HY'),
    IN p_veh_mileage INT,
    IN p_veh_transmission ENUM('A', 'M'),
    IN p_veh_conform TINYINT(1),
    IN p_veh_tank_ok TINYINT(1),
    IN p_veh_service DATE
)
BEGIN
    UPDATE VEHICLE
    SET 
        veh_num = p_veh_num,
        veh_brand = p_veh_brand,
        veh_model = p_veh_model,
        veh_cat = p_veh_cat,
        veh_daily_price = p_veh_daily_price,
        veh_fuel = p_veh_fuel,
        veh_mileage = p_veh_mileage,
        veh_transmission = p_veh_transmission,
        veh_conform = p_veh_conform,
        veh_tank_ok = p_veh_tank_ok,
        veh_service = p_veh_service
    WHERE veh_id = p_veh_id;
END //
DELIMITER ;

------------------------------------------------- Effacer un véhicule -----------------------------------------------
DELIMITER //
CREATE PROCEDURE DeleteVehicle(IN p_veh_id INT)
BEGIN
    DELETE FROM VEHICLE WHERE veh_id = p_veh_id;
END //
DELIMITER ;

-------------------------------------- Obtenir la liste des véhicules en stock --------------------------------------
DELIMITER //
CREATE PROCEDURE VehiclesStock()
BEGIN
    SELECT * FROM VEHICLE;
END //
DELIMITER ;

--------------------------------------- Obtenir la liste des véhicules disponibles ----------------------------------

DELIMITER //
CREATE PROCEDURE ListAvailableVehicles(IN p_date DATE)
BEGIN
    SELECT * FROM VEHICLE v
    WHERE NOT EXISTS (
        SELECT 1 FROM RESERVATION r
        WHERE r.veh_id = v.veh_id 
        AND p_date BETWEEN r.res_start_date AND r.res_end_date
    )
    AND v.veh_conform = 1
    AND v.veh_tank_ok = 1; -- Ajout de la condition du plein de carburant
END //
DELIMITER ;

--------------------------------------- MaJ de la date d'entretien d'un véhicule ------------------------------------
DELIMITER //
CREATE PROCEDURE VehicleServiceUpdate(
    IN p_veh_id INT,
    IN p_veh_service DATE
)
BEGIN
    UPDATE VEHICLE SET veh_service = p_veh_service WHERE veh_id = p_veh_id;
END //
DELIMITER ;

------------------------------------ MaJ du statut d'un véhicule lors du retour de location -------------------------
DELIMITER //
CREATE PROCEDURE UpdateVehicleReturnStatus(
    IN p_veh_id INT,
    IN p_veh_conform TINYINT(1),
    IN p_veh_tank_ok TINYINT(1)
)
BEGIN
    UPDATE VEHICLE 
    SET 
        veh_conform = p_veh_conform,
        veh_tank_ok = p_veh_tank_ok
    WHERE veh_id = p_veh_id;
END //
DELIMITER ;

