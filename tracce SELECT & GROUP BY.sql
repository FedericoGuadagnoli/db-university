-- ---------------------------------------  QUERY CON SELECT

-- 1. Selezionare tutti gli studenti nati nel 1990 (160)
SELECT `name`, `surname`, `date_of_birth`
FROM `students`
WHERE YEAR(`date_of_birth`) = 1990;

-- 2. Selezionare tutti i corsi che valgono più di 10 crediti (479)
SELECT `name`, `cfu`
FROM `courses`
WHERE `cfu` > 10;

-- 3. Selezionare tutti gli studenti che hanno più di 30 anni
SELECT `name`, `surname`, `date_of_birth` 
FROM students
WHERE `date_of_birth` < DATE_SUB(CURDATE(), INTERVAL 30 YEAR);

-- 4. Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di laurea (286)
SELECT *
FROM `courses`
WHERE `period` LIKE 'I semestre%' 
AND `year` LIKE '1';

-- 5. Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del 20/06/2020 (21)
SELECT * 
FROM `exams`
WHERE date = '2020/06/20'
AND `hour` > '14:00:00';

-- 6. Selezionare tutti i corsi di laurea magistrale (38)
SELECT *
FROM `degrees`
WHERE `level` LIKE 'magistrale';

-- 7. Da quanti dipartimenti è composta l'università? (12)
SELECT COUNT(name) AS 'Numero totale di dipartimenti'
FROM `departments`;

-- 8. Quanti sono gli insegnanti che non hanno un numero di telefono? (50)
SELECT COUNT(*) AS 'Totale insegnanti senza numero di telefono' 
FROM `teachers`
WHERE `phone` IS NULL;


-- ------------------------------------------ QUERY CON GROUP BY


-- 1. Contare quanti iscritti ci sono stati ogni anno
SELECT COUNT(*) AS 'Studenti iscritti,', YEAR(`enrolment_date`) AS 'Anno'
FROM `students`
GROUP BY `Anno`;

-- 2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio
SELECT COUNT(*) AS 'Numero insegnanti,', `office_address` AS 'Edificio'
FROM `teachers`
GROUP BY `Edificio`;

-- 3. Calcolare la media dei voti di ogni appello d'esame
SELECT `exam_id` AS ' Appello', AVG(`vote`) as 'Media voti'
FROM `exam_student`
GROUP BY (`Appello`);

-- 4. Contare quanti corsi di laurea ci sono per ogni dipartimento
SELECT `department_id` AS 'Dipartimenti', COUNT(`name`) AS 'Numero corsi di laurea'
FROM `degrees`
GROUP BY `Dipartimenti`;


-- ------------------------------------------ QUERY CON JOIN
-- 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
SELECT `students`.`name` AS 'Nome', `students`.`surname` AS 'Cognome', `degrees`.`name` AS 'Corso'
FROM `students`
JOIN `degrees`
ON `degrees`.`id` = `students`.`degree_id`
WHERE `degrees`.`name` = 'Corso di Laurea in Economia';

-- 2. Selezionare tutti i Corsi di Laurea del Dipartimento di Neuroscienze
SELECT `degrees`.`name` AS 'Corso di Laurea' , `departments`.`name` AS 'Dipartimento'
FROM `degrees`
JOIN `departments`
ON `departments`.`id` = `degrees`. `department_id`
WHERE `departments`.`name` = 'Dipartimento di Neuroscienze';

-- 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
SELECT `teachers`.`name` AS 'Nome', `teachers`.`surname` AS 'Cognome', `courses`.`name` AS 'Corso'
FROM `teachers`
JOIN `course_teacher`
ON `teachers`.`id` = `course_teacher`.`teacher_id`
JOIN `courses`
ON `courses`.`id`= `course_teacher`.`course_id`
WHERE `teachers`.`id` = 44;

-- 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome
SELECT `students`.`surname` AS 'Cognome Studente', `students`.`name` AS 'Nome studente',  `degrees`.`*`, `departments`.`name` AS 'Dipartimento'
FROM `students`
JOIN `degrees`
ON `degrees`.`id` = `students`.`degree_id`
JOIN `departments`
ON `departments`.`id` = `degrees`.`department_id`
ORDER BY `Cognome Studente` ASC;

-- 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti


-- 6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)


-- 7. BONUS: Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per superare ciascuno dei suoi esami