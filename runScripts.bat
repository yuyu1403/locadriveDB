@echo off
set /p password="Enter DB Password: "

echo Executing DB script...
mariadb -u root -p%password% < Database/Locadrive_Schema.sql
echo DB script OK !

echo Adding dummy data...
mariadb -u root -p%password% < Database/Locadrive_Schema_Dummy.sql
echo Dummy data added !

echo Executing vehicle procedures...
mariadb -u root -p%password% < Database/Procedures_Vehicle.sql
echo Vehicle procedures OK !

echo Executing utilisateur procedures...
mariadb -u root -p%password% < Database/Procedures_Utilisateur.sql
echo Utilisateur procedures OK !

echo Executing reservation procedures...
mariadb -u root -p%password% < Database/Procedures_Reservation.sql
echo User procedures OK !

pause
