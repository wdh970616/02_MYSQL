/* GROUPING */
-- 'GROUP BY'절을 이용해서 결과집합을 특정열의 값에 따라 그룹화 하는데에 사용한다.
-- 'HAVING'은 'GROUP BY'절과 함께 사용해야 하며 그룹에 대한 조건을 적용하는데에 사용된다.

-- tbl_menu에서 카테고리 그룹 조회
select category_code
from tbl_menu
group by category_code;

/* COUNT */
-- 카테고리별 갯수 조회하기
select category_code,
       count(*) -- 매개변수와 위치에 따라 여러 사용방법이 있음 / 여기선 전체 행 중 일치하는 행이 몇개인지 갯수를 반환하는 역할
from tbl_menu
group by category_code;

/* SUM */
-- sum으로 그룹화된 값의 총합을 구할 수 있다.
-- 카테고리별 가격 총합 계산하기
select category_code,
       sum(menu_price)
from tbl_menu
group by category_code;

/* AVG */
-- avg로 그룹화된 값의 평균을 구할 수 있다.
-- 카테고리별 평균 계산하기
select category_code,
       avg(menu_price)
from tbl_menu
group by category_code;

select category_code,
       count(*)        총갯수,
       sum(menu_price) 총합,
       avg(menu_price) 평균
from tbl_menu
group by category_code;

-- 2개 이상의 조건으로 그룹을 생성
-- menu_price, category_code
select menu_price,
       category_code,
       count(*)
from tbl_menu
group by menu_price,
         category_code;

-- category_code, orderable_status -> 그룹
-- 갯수, 평균, 총합 -> 별칭도 적용하기
select category_code,
       orderable_status,
       count(*)        총갯수,
       sum(menu_price) 총합,
       avg(menu_price) 평균
from tbl_menu
group by category_code,
         orderable_status
order by orderable_status;

/* HAVING */
-- GROUP BY와 함께 사용되며, 그룹화된 결과에 조건을 적용할 때 사용된다.
-- WHERE는 개별 행에 조건을 적용하는 것과 달리 HAVING절은 그룹화된 데이터에 조건을 적용한다.

-- menu_price, category_code로 그루핑딘 데이터에서
-- category_code가 5이상, 8이하만 조회
select menu_price,
       category_code
from tbl_menu
group by menu_price,
         category_code
having category_code >= 5
   and category_code <= 8
order by menu_price;

-- where절로도 할 수 있다.
select menu_price,
       category_code
from tbl_menu
where category_code >= 5
  and category_code <= 8
group by menu_price,
         category_code
order by menu_price;

-- 그룹화 전에 필터링을 할 수 없는 경우에는 having절로만 가능하다.
-- 그룹화된 카테고리별 평균을 구하고, 평균이 8000 이상인 경우만 조회
-- 그룹화 이후에 평균이 구해지기 때문에 where절 사용 불가능
select category_code,
       avg(menu_price)
from tbl_menu
group by category_code
having avg(menu_price) >= 8000;

/* WITH ROLLUP */
-- GROUP BY에서 사용되는 확장기능으로 다양한 수준의 집계 데이터를 생성할 수 있다.

-- 총합을 구할때
select category_code,
       sum(menu_price)
from tbl_menu
group by category_code
with rollup;

/* 컬럼 두개를 활용한 WITH ROLLUP */
-- 메뉴 가격별 총합 및 해당 메뉴 가격별 같은 카테고리의 총합
select menu_price,
       category_code,
       count(*),
       sum(menu_price)
from tbl_menu
group by menu_price,
         category_code
with rollup;

-- 1. 특정 카테고리 총 메뉴 가격이 20000원 이상인 경우
select category_code,
       sum(menu_price)
from tbl_menu
group by category_code
having sum(menu_price) >= 20000;

-- 2. 특정 카테고리 메뉴수가 3개 이상인 경우
select category_code,
       count(*)
from tbl_menu
group by category_code
having count(*) >= 3;

-- 3. 특정 카테고리에서 주문 가능한 메뉴의 평균 가격이 10000원 이상인 경우
select category_code,
       avg(menu_price)
from tbl_menu
where orderable_status = 'Y'
group by category_code
having avg(menu_price) >= 10000;