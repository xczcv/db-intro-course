-- Завдання:
--      Для кожного курсу знайти мінімальний семестр, в якому він може читатись
--      Очікувані колонки результату:
--          - ідентифікатор курсу (course_id)
--          - назва курсу (name)
--          - мінімальний рік (min_year)
--      Результат відсортувати за:
--          - мінімальним роком (зростання), потім за назвою курсу

-- Рішення:
WITH RECURSIVE prerequisite_chain AS (
    SELECT cp.course_id,
           cp.prerequisite_course_id,
           1 AS depth
    FROM course_prerequisite AS cp

    UNION ALL

    SELECT pc.course_id,
           cp.prerequisite_course_id,
           pc.depth + 1 AS depth
    FROM prerequisite_chain AS pc
    JOIN course_prerequisite AS cp
      ON cp.course_id = pc.prerequisite_course_id
)
SELECT c.course_id,
       c.name,
       COALESCE(MAX(pc.depth), 0) + 1 AS min_year
FROM course AS c
LEFT JOIN prerequisite_chain AS pc
  ON pc.course_id = c.course_id
GROUP BY c.course_id, c.name
ORDER BY min_year, name;
