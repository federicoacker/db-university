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

/*
7. Da quanti dipartimenti è composta l'università? (12)
*/

SELECT COUNT(`d`.`id`)
FROM `departments` `d`;

/*
8. Quanti sono gli insegnanti che non hanno un numero di telefono? (50)
*/

SELECT COUNT(`t`.`id`)
FROM `teachers` `t`
WHERE `t`.`phone` IS NULL;

/*
QUERY CON GROUP BY
*/

/*
1. Contare quanti iscritti ci sono stati ogni anno
*/

SELECT COUNT(`s`.`id`) as `enrolled_students_count`, YEAR(`s`.`enrolment_date`) as `enrolment_year`
FROM `students` `s`
GROUP BY `enrolment_year`;

/*
2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio
*/

SELECT COUNT(`t`.`id`) as `teachers_count`, `t`.`office_address` as `address`
FROM `teachers` `t`
GROUP BY `address`
HAVING `teachers_count` > 1;

/*
Essendo che la traccia era di "contare gli insegnatni che hanno l'ufficio nello stesso edificio", 
ho escluso gli edifici che hanno come count 1. Perché in quegli edifici non ci sono "insegnanti nello stesso edificio".
*/