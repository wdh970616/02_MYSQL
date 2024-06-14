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
where year(adddate(date(substring(STUDENT_SSN, 1, 6)), interval 19 year)) < year(date(ENTRANCE_DATE));

#6
select concat('2020년 크리스마스는 ', substring('일월화수목금토', dayofweek('2020-12-25'), 1), '요일이다.') as '2020년도 크리스마스의 요일';

#7
select str_to_date('99/10/11', '%y/%m/%d'),
       str_to_date('49/10/11', '%y/%m/%d'),
       str_to_date('70/10/11', '%y/%m/%d'),
       str_to_date('69/10/11', '%y/%m/%d');

#8
select format(avg(POINT), 1) 평점
from tb_grade
where STUDENT_NO = 'A517178'
group by STUDENT_NO;

#9
select DEPARTMENT_NO 학과번호,
       count(*) as '학생수(명)'
from tb_student
group by DEPARTMENT_NO;

#10
select count(*)
from tb_student
group by COACH_PROFESSOR_NO
having COACH_PROFESSOR_NO is null;

#11
select substring(term_no, 1, 4) 년도,
       format(avg(POINT), 1) '년도별 평점'
from tb_grade
where STUDENT_NO = 'A112113'
group by substring(TERM_NO, 1, 4);

#12
select department_no 학과코드명,
       count(*) '휴학생 수'
from tb_student
where ABSENCE_YN = 'Y'
group by DEPARTMENT_NO;

#13
select STUDENT_NAME 동일이름,
       count(*) '동명인 수'
from tb_student
group by STUDENT_NAME
having count(*) > 1
order by STUDENT_NAME;

#14
select substring(TERM_NO, 1, 4) 년도,
       substring(TERM_NO, 5, 2) 학기,
       format(sum(POINT), 1)
from tb_grade
where STUDENT_NO = 'A112113'
group by 년도, 학기;