/*
1. Selezionare tutti gli studenti nati nel 1990
*/
SELECT `s`.* 
FROM `students` `s`
WHERE YEAR(`s`.`date_of_birth`) = 1990;

