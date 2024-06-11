-- LIMIT
-- SELECT문의 결과 집합에서 반환할 행의 수를 제한할 때 사용된다.
/*
 LIMIT 사용법
 SELECT [columnName]
 FROM [tableName]
 LIMIT [offSet], [rowCount]

 offset : 시작할 행의 번호 (인덱스 체계)
 row count : 이후 행부터 반환 받을 행의 갯수
 */

-- tbl_menu 테이블의 menu_code, menu_name, menu_price 조회
-- menu_code 기준 내림차순 정렬
select menu_code,
       menu_name,
       menu_price
from tbl_menu
order by menu_code desc
-- 2행부터 5행까지 조회
limit 1, 4;

-- tbl_menu에서 가장 저렴한 메뉴 3가지의 menu_name과 menu_price 조회하기
select menu_name,
       menu_price
from tbl_menu
order by menu_price
limit 3; -- 시작할 행 입력하지 않으면 자동으로 0번 인덱스부터 시작