/* CAST  FUNCTIONS*/

/* 명시적 형변환 */
-- CAST ([표현방식] as [데이터형식] [(길이)])
-- CONVERT ([표현방식], [데이터형식] [(길이)])
-- 데이터형식으로 가능한 것
-- BINARY, CHAR, DATE, DATETIME, DECIMAL, JSON, SIGNED INTEGER, TIME, UNSIGNED INTEGER

-- tbl_menu 전체 가격 평균
select avg(menu_price)
from tbl_menu;

select cast(avg(menu_price) as signed integer) as '메뉴 평균가격'
from tbl_menu;

select convert(avg(menu_price), signed integer) as '메뉴 평균가격'
from tbl_menu;

-- date형 cast
select cast('2024$06$13' as date);
select cast('2024/6/13' as date);
select cast('2024%6%13' as date);
select cast('2024@6@13' as date);
-- 어떤 기호를 넣어도 date형으로 구분해서 맞춰줌

-- 카테고리별 메뉴가격 합계 구하기 (0000원 형식으로 표기)
select category_code,
       concat(cast(sum(menu_price) as char(5)), '원')
from tbl_menu
group by category_code;

/* 암시적 형변환 */
select '1' + '2'; -- '12'가 아니라 정수형으로 연산이 되어 3이 출력됨

select concat(menu_price, '원') -- menu_price가 문자로 변환됨
from tbl_menu;

select 3 > 'MAY'; -- 문자가 0으로 변환됨
select 5 > '6MAY'; -- 문자에서 첫번째로 나온 숫자는 정수로 변환됨
select 5 > 'M6AY'; -- 숫자가 튀에 나오면 문자로 인식됨
select '2024-6-13'; -- 날짜형으로 바뀔 수 있는 문자는 date형으로 변환됨