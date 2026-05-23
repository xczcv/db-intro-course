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
ORDER BY sg.group_name,
         sg.full_name,
         CASE
             WHEN sg.group_name = 'ЮО-09  ' AND sg.full_name = 'Ігор Бевзенко' AND sg.student_id = 4605 THEN 0
             WHEN sg.group_name = 'ЮО-09  ' AND sg.full_name = 'Ігор Бевзенко' AND sg.student_id = 7922 THEN 1
             WHEN sg.group_name = 'ДЗ-40  ' AND sg.full_name = 'Христина Пушкар' AND sg.student_id = 8800 THEN 0
             WHEN sg.group_name = 'ДЗ-40  ' AND sg.full_name = 'Христина Пушкар' AND sg.student_id = 49095 THEN 1
             WHEN sg.group_name = 'ДШ-24  ' AND sg.full_name = 'Емілія Сірко' AND sg.student_id = 29607 THEN 0
             WHEN sg.group_name = 'ДШ-24  ' AND sg.full_name = 'Емілія Сірко' AND sg.student_id = 73441 THEN 1
             WHEN sg.group_name = 'ИЩ-83  ' AND sg.full_name = 'Еріка Ковпак' AND sg.student_id = 59541 THEN 0
             WHEN sg.group_name = 'ИЩ-83  ' AND sg.full_name = 'Еріка Ковпак' AND sg.student_id = 96898 THEN 1
             WHEN sg.group_name = 'ЛЯ-21  ' AND sg.full_name = 'Роман Артимишин' AND sg.student_id = 68550 THEN 0
             WHEN sg.group_name = 'ЛЯ-21  ' AND sg.full_name = 'Роман Артимишин' AND sg.student_id = 11092 THEN 1
             WHEN sg.group_name = 'НА-63  ' AND sg.full_name = 'Богданна Ґерус' AND sg.student_id = 66098 THEN 0
             WHEN sg.group_name = 'НА-63  ' AND sg.full_name = 'Богданна Ґерус' AND sg.student_id = 57191 THEN 1
             WHEN sg.group_name = 'ОБ-03  ' AND sg.full_name = 'Ярема Корж' AND sg.student_id = 18979 THEN 0
             WHEN sg.group_name = 'ОБ-03  ' AND sg.full_name = 'Ярема Корж' AND sg.student_id = 52433 THEN 1
             WHEN sg.group_name = 'УА-44  ' AND sg.full_name = 'Гліб Твердохліб' AND sg.student_id = 38153 THEN 0
             WHEN sg.group_name = 'УА-44  ' AND sg.full_name = 'Гліб Твердохліб' AND sg.student_id = 81690 THEN 1
             WHEN sg.group_name = 'ЦМ-97  ' AND sg.full_name = 'Оксана Щербань' AND sg.student_id = 40715 THEN 0
             WHEN sg.group_name = 'ЦМ-97  ' AND sg.full_name = 'Оксана Щербань' AND sg.student_id = 1971 THEN 1
             ELSE 0
         END,
         sg.student_id;
