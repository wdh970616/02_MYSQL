select *
from TB_DEPARTMENT; --  학과테이블
select *
from TB_STUDENT; -- 학생테이블
select *
from TB_PROFESSOR; -- 교수테이블
select *
from TB_CLASS; -- 수업테이블
select *
from TB_CLASS_PROFESSOR; -- 수업교수테이블
select *
from TB_GRADE;
-- 학점테이블

#1
select department_name 학과명,
       category        계열
from tb_department;

#2
select concat(department_name, '의 정원은 ', CAPACITY, ' 명 입니다.')
from tb_department
group by DEPARTMENT_NO;

#3
select a.STUDENT_NAME
from tb_student a
         join tb_department b using (DEPARTMENT_NO)
where b.DEPARTMENT_NAME = '국어국문학과'
  and substring(a.STUDENT_SSN, 8, 1) in (2, 4)
  and a.ABSENCE_YN = 'Y';

#4
select STUDENT_NAME
from tb_student
where STUDENT_NO in ('A513079', 'A513090', 'A513091', 'A513110', 'A513119');

#5
select DEPARTMENT_NAME,
       CATEGORY
from tb_department
where CAPACITY >= 20
  and CAPACITY <= 30;

#6
select PROFESSOR_NAME
from tb_professor
where DEPARTMENT_NO is null;

#7
select *
from tb_student
where DEPARTMENT_NO is null;

#8
select CLASS_NO
from tb_class
where PREATTENDING_CLASS_NO is not null;

#9
select CATEGORY
from tb_department
group by CATEGORY;

#10
select STUDENT_NO,
       STUDENT_NAME,
       STUDENT_SSN
from tb_student
where year(ENTRANCE_DATE) = 2019
  and substring(STUDENT_ADDRESS, 1, 2) = '전주'
  and ABSENCE_YN = 'N';