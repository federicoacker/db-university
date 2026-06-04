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