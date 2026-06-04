/*
1. Selezionare tutti gli studenti nati nel 1990
*/
SELECT `s`.* 
FROM `students` `s`
WHERE 
	YEAR(`s`.`date_of_birth`) = 1990
ORDER BY 
	`s`.`surname`, 
    `s`.`name`;

/*
2. Selezionare tutti i corsi he valgono più di 10 crediti
*/
SELECT `c`.`name`, `c`.`cfu`,`c`.`year`
FROM `courses` `c`
WHERE 
	`c`.`cfu` > 10
ORDER BY 
	`c`.`cfu`, 
    `c`.`year`;

/*
3. Selezionare tutti gli studenti che hanno più di 30 anni
*/
SELECT `s`.* 
FROM `students` `s`
WHERE 
	DATEDIFF(CURDATE(), `s`.`date_of_birth`)/365.2422 > 30
ORDER BY 
	`s`.`date_of_birth`, 
    `s`.`surname`,`s`.`name`;

/*
4. Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di
laurea (286)
*/

SELECT `c`.*
FROM `courses` `c`
WHERE 
	`c`.`period` = "I semestre" AND 
	`c`.`year` = 1
ORDER BY
	`c`.`degree_id`,
    `c`.`name`;

/*
5. Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del
20/06/2020 (21)
*/

SELECT `e`.*
FROM `exams` `e`
WHERE 
	`e`.`date` = "2020-06-20" AND 
    HOUR(`e`.`hour`) >= 14
ORDER BY 
	`e`.`hour`, 
	`e`.`location`;

/*
6. Selezionare tutti i corsi di laurea magistrale (38)
*/

SELECT `d`.*
FROM `degrees` `d`
WHERE
	`d`.`level` = "magistrale"
ORDER BY
	`d`.`name`;