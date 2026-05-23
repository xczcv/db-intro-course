-- Завдання:
--      Сформувати єдиний список активностей університету, що поєднує:
--          - записи студентів на курси
--          - призначення викладачів на курси
--      Очікувані колонки результату:
--          - повне ім'я (full_name)
--          - назва курсу (course_name)
--          - тип активності (activity_type) - 'запис на курс' або 'викладання курсу'
--      Включити тільки активні курси (статус 'активний')
--      Результат відсортувати за:
--          - назвою курсу, потім за типом активності, потім за іменем

-- Рішення:
SELECT p.first_name || ' ' || p.last_name AS full_name,
       c.name AS course_name,
       'викладання курсу' AS activity_type
FROM course AS c
JOIN course_teacher AS ct
  ON ct.course_id = c.course_id
JOIN professor AS pr
  ON pr.professor_id = ct.professor_id
JOIN person AS p
  ON p.person_id = pr.person_id
WHERE c.status = 'активний'

UNION ALL

SELECT p.first_name || ' ' || p.last_name AS full_name,
       c.name AS course_name,
       'запис на курс' AS activity_type
FROM course AS c
JOIN enrolment AS e
  ON e.course_id = c.course_id
JOIN student AS s
  ON s.student_id = e.student_id
JOIN person AS p
  ON p.person_id = s.person_id
WHERE c.status = 'активний'
ORDER BY course_name, activity_type, full_name;
