-- Завдання:
--      Знайти всіх студентів, які записані на більше курсів ніж в середньому
--      Очікувані колонки результату:
--          - ідентифікатор студента (student_id)
--          - повне ім'я студента (full_name)
--          - кількість курсів студента (course_number)
--          - середня кількість курсів серед усіх студентів (avg_number) - округлити результат до 2 знаків після коми
--      Результат відсортувати за:
--          - кількістю курсів студента (спадання), потім за іменем студента, потім за ідентифікатор студента

-- Рішення:
WITH student_course_counts AS (
    SELECT e.student_id,
           COUNT(*) AS course_number
    FROM enrolment AS e
    GROUP BY e.student_id
),
average_course_count AS (
    SELECT ROUND(AVG(course_number), 2) AS avg_number
    FROM student_course_counts
)
SELECT scc.student_id,
       p.first_name || ' ' || p.last_name AS full_name,
       scc.course_number,
       acc.avg_number
FROM student_course_counts AS scc
JOIN student AS s
  ON s.student_id = scc.student_id
JOIN person AS p
  ON p.person_id = s.person_id
CROSS JOIN average_course_count AS acc
WHERE scc.course_number > acc.avg_number
ORDER BY scc.course_number DESC, full_name;
