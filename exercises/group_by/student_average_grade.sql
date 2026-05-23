-- Завдання:
--      Для кожного студента знайти його середній бал у порівнянні з середнім балом по групі
--      Очікувані колонки результату:
--          - ідентифікатор студента (student_id)
--          - повне ім'я студента (full_name)
--          - середній бал студента (avg_student_grade) - округлити результат до 2 знаків після коми
--          - назва групи (group_name)
--          - середній бал по групі (avg_group_grade) - округлити результат до 2 знаків після коми
--      Результат відсортувати за:
--          - за назвою групи, потім за іменем студента

-- Рішення:
WITH student_grades AS (
    SELECT s.student_id,
           p.first_name || ' ' || p.last_name AS full_name,
           g.name AS group_name,
           s.group_id,
           AVG(e.grade) AS avg_student_grade_raw
    FROM student AS s
    JOIN person AS p
      ON p.person_id = s.person_id
    JOIN student_group AS g
      ON g.group_id = s.group_id
    LEFT JOIN enrolment AS e
      ON e.student_id = s.student_id
    GROUP BY s.student_id, p.first_name, p.last_name, g.name, s.group_id
),
group_grades AS (
    SELECT sg.group_id,
           ROUND(AVG(sg.avg_student_grade_raw), 2) AS avg_group_grade
    FROM student_grades AS sg
    GROUP BY sg.group_id
)
SELECT sg.student_id,
       sg.full_name,
       ROUND(sg.avg_student_grade_raw, 2) AS avg_student_grade,
       sg.group_name,
       gg.avg_group_grade
FROM student_grades AS sg
JOIN group_grades AS gg
  ON gg.group_id = sg.group_id
ORDER BY sg.group_name, sg.full_name, avg_student_grade DESC, sg.student_id;
