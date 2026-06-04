/*
1. Selezionare tutti gli studenti nati nel 1990
*/
SELECT `s`.* 
FROM `students` `s`
WHERE YEAR(`s`.`date_of_birth`) = 1990;

/*
2. Selezionare tutti i corsi he valgono più di 10 crediti
*/
SELECT `c`.`name`, `c`.`cfu`,`c`.`year`
FROM `courses` `c`
WHERE `c`.`cfu` > 10
ORDER BY `c`.`cfu`, `c`.`year`;