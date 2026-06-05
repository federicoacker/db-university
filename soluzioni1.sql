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

/*
3. Calcolare la media dei voti di ogni appello d'esame
*/
SELECT AVG(`es`.`vote`) as `vote_average`, `es`.`exam_id` as `exam_id`
FROM `exam_student` `es`
GROUP BY `exam_id`;

SELECT COUNT(`es`.`student_id`), `es`.`exam_id`
FROM `exam_student` `es`
GROUP BY `es`.`exam_id`;

SELECT SUM(`es`.`vote`), `es`.`exam_id`
FROM `exam_student` `es`
GROUP BY `es`.`exam_id`;

/*
Solo la prima query fa quello richiesto dall'esercizio, le altre due query 
sotto sono quelle che ho creato per controllare che non ci fossero errori nei risultati
*/

/*
4. Contare quanti corsi di laurea ci sono per ogni dipartimento
*/
SELECT COUNT(`de`.`id`) as `degrees_count`, `de`.`department_id` as `department_id`
FROM `degrees` `de`
GROUP BY `department_id`;

/*
QUERY CON JOIN
*/

/*
1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
*/

SELECT 
	CONCAT(`s`.`name`, " ", `s`.`surname`) as `student_full_name`,
	`s`.`registration_number`, 
	`s`.`id` as `student_id`, 
	`d`.`name` as `degree_name`,
	`d`.`id`
FROM `students` `s`
JOIN `degrees` `d`
ON `s`.`degree_id` = `d`.`id`
WHERE `d`.`name` = "Corso di Laurea in Economia";

/*
2. Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di
Neuroscienze
*/

SELECT `d`.*
FROM `degrees` `d`
JOIN `departments` `de`
ON `d`.`department_id` = `de`.`id`
WHERE `de`.`name` = "Dipartimento di Neuroscienze" AND `d`.`level` = "Magistrale";

/*
3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
*/
SELECT 
	`c`.`name` as `course_name`,
    `c`.`description` as `course_description`,
    `c`.`period` as `course_period`,
    `c`.`year` as `course_year`,
    `c`.`cfu` as `course_cfu`,
    `c`.`website` as `course_website`,
	CONCAT(`t`.`name`, " ", `t`.`surname`) as `teacher_full_name`
FROM `courses` `c`
JOIN `course_teacher` `ct`
ON `c`.`id` = `ct`.`course_id`
JOIN `teachers` `t`
ON `t`.`id` = `ct`.`teacher_id`
WHERE `t`.`id` = 44
ORDER BY `course_year`, `course_cfu`;

/*
4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui
sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e
nome
*/

SELECT 
	CONCAT(`s`.`name`, " ", `s`.`surname`) as `student_full_name`,
    `s`.`registration_number` as `student_registration_numer`,
    `d`.`name` as `degree_name`,
    `d`.`id` as `degree_id`,
    `de`.`name` as `department_name`
FROM `students` `s`
JOIN `degrees` `d`
ON `d`.`id` = `s`.`degree_id`
JOIN `departments` `de`
ON `de`.`id` = `d`.`department_id`
ORDER BY `s`.`surname`, `s`.`name`;

/*
5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
*/

SELECT 
	`d`.`name` as `degree_name`, 
    `c`.`name` as `course_name`, 
    CONCAT(`t`.`name`, " ", `t`.`surname`) as `teacher_name`
FROM `degrees` `d`
JOIN `courses` `c`
ON `c`.`degree_id` = `d`.`id`
JOIN `course_teacher` `ct`
ON `ct`.`course_id` = `c`.`id`
JOIN `teachers` `t`
ON `t`.`id` = `ct`.`teacher_id`
ORDER BY `d`.`id`, `c`.`id`, `t`.`id`;

/*
6. Selezionare tutti i docenti che insegnano nel Dipartimento di
Matematica (54)
*/
SELECT 
	`t`.`id` as `teacher_id`,
	CONCAT(`t`.`name`, " ", `t`.`surname`) as `teacher_full_name`,
    `de`.`name` as `department_name`,
    `d`.`name` as `degree_name`
FROM `teachers` `t`
JOIN `course_teacher` `ct`
ON `ct`.`teacher_id` = `t`.`id`
JOIN `courses` `c`
ON `c`.`id` = `ct`.`course_id`
JOIN `degrees` `d`
ON `c`.`degree_id` = `d`.`id`
JOIN `departments` `de`
ON `de`.`id` = `d`.`department_id`
WHERE `de`.`name` = "Dipartimento di Matematica"
ORDER BY `t`.`id`;

/*
7. BONUS: Selezionare per ogni studente il numero di tentativi sostenuti
per ogni esame, stampando anche il voto massimo. Successivamente,
filtrare i tentativi con voto minimo 18
*/

SELECT 
CONCAT(`s`.`name`, " ", `s`.`surname`) as `student_full_name`,
COUNT(`es`.`student_id`) as `exam_count`,
MAX(`es`.`vote`) as `max_vote`
FROM `exam_student` `es`
JOIN `students` `s`
ON `es`.`student_id` = `s`.`id`
GROUP BY `student_full_name`;

SELECT 
CONCAT(`s`.`name`, " ", `s`.`surname`) as `student_full_name`,
COUNT(`es`.`student_id`) as `exam_count`,
MIN(`es`.`vote`) as `min_vote`,
MAX(`es`.`vote`) as `max_vote`
FROM `students` `s`
JOIN `exam_student` `es`
ON `es`.`student_id` = `s`.`id`
GROUP BY `student_full_name`
HAVING `min_vote` >= 18;

