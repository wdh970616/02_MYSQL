-- ORDER BY
-- select문과 함께 사용하며 결과 집합을 특정 열이나 값에 따라 정렬하는데 사용된다.

select menu_code,
       menu_name,
       menu_price
from tbl_menu
-- order by menu_price asc;    -- 오름차순 정렬
-- order by menu_price desc;    -- 내림차순 정렬
order by menu_price;
-- default값은 오름차순

-- 컬럼에 따라 여러번 정렬할 수 있다.
-- 메뉴 price를 기준으로 내림차순 정렬을 하고,
-- 같은 가격이 있다면 menu_name에 따라 오름차순 정렬
select menu_code,
       menu_name,
       menu_price
from tbl_menu
order by menu_price desc,
         menu_name;

-- 컬럼을 연산해서 연산결과와 함께 정렬을 할 수 있다.
-- order by 절을 이용해서 연산결과롸 함께 정렬
select menu_code,
       menu_price,
       menu_code * menu_price as multiple
from tbl_menu
order by multiple desc;

/*
 FIELD('비교할값', '비교대상', '비교대상', ...)
 - 첫번째 인자가 두번째 인자 이후의 값들과 비교해서 일치하면 해당 위치의 값을 보여준다.
 */
select field('A', 'B', 'C', 'A');
select field('B', 'A', 'B', 'C');

-- 데이터베이스에 들어있는 데이터를 비교할 수 있다.
select field(orderable_status, 'N', 'Y')
from tbl_menu;

-- order bym field를 같이써서 사용하기
select menu_name,
       orderable_status
from tbl_menu
order by field(orderable_status, 'N', 'Y');

-- null 값이 있는 컬럼에 대한 정렬
select category_code,
       category_name,
       ref_category_code
from tbl_category
order by ref_category_code;
-- 오름차순 했을때 null이 상단으로 온다.

-- null값 위치에 따라 정렬할 때 (is null)
-- asc : 오름차순 정렬시 null이 마지막으로 위치된다. (default)
-- desc : 내림차순 정렬시 null이 처음으로 위치된다.
select category_code,
       category_name,
       ref_category_code
from tbl_category
order by ref_category_code is null asc;

-- 한개를 조회해서 두번 정렬 할때
select
    category_code,
    category_name,
    ref_category_code
from tbl_category
order by ref_category_code is null desc,    -- null값의 위치를 정하고
         ref_category_code desc;    -- ref_category_code를 오름차순으로 정렬
