#1
select tb_student.STUDENT_NO,
       tb_student.STUDENT_NAME,
       tb_student.ENTRANCE_DATE
from tb_student
where DEPARTMENT_NO = 002
order by ENTRANCE_DATE;

#2
select tb_professor.PROFESSOR_NAME,
       tb_professor.PROFESSOR_SSN
from tb_professor
where char_length(PROFESSOR_NAME) <> 3;

#3
select PROFESSOR_NAME                                                               교수이름,
       substring(curdate() - date(19000000 + substring(PROFESSOR_SSN, 1, 6)), 1, 2) 나이
from tb_professor
where substring(PROFESSOR_SSN, 8, 1) in (1, 3)
order by 나이;

#4
select substring(PROFESSOR_NAME, 2) 이름
from tb_professor;

#5
select STUDENT_NO,
       STUDENT_NAME,
       date(substring(STUDENT_SSN, 1, 6)),
       year(adddate(date(substring(STUDENT_SSN, 1, 6)), interval 19 year)) 만19세되는해,
       year(date(ENTRANCE_DATE)) 입학한해
from tb_student
where year(adddate(date(substring(STUDENT_SSN, 1, 6)), interval 19 year)) >= year(date(ENTRANCE_DATE));