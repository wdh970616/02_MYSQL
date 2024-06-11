/* SUBQUERY */
-- 서브쿼리는 다른 쿼리에서 실행되는 쿼리이다.
-- 존재하지 않는 조건에 근거한 값들을 검색하고자 할 때 사용한다.
-- 메인쿼리가 서브쿼리를 포함하는 종속적인 관계이다.

/* 서브쿼리의 유형 */
-- 1. 일반 서브쿼리
#     1-a. 단일행 일반 서브쿼리
#     1-b. 다중행 일반 서브쿼리
-- 2. 상관 서브쿼리
#     2-a. 스칼라 서브쿼리

/* 서브쿼리의 규칙 */
-- 서브쿼리는 반드시 소괄호()로 묶어야한다. (SELECT ...) 형태
-- 서브쿼리는 연산자의 오른쪽에 위치 해야한다.
-- 서브쿼리 내에서 ORDER BY 문법은 지원되지 않는다.

/* 단일 행 서브쿼리 */
-- 민트미역국이랑 같은 카테고리의 메뉴를 조회(메뉴코드, 메뉴명, 가격, 주문가능여부)

-- 2개의 쿼리문을 사용해서 구하기
select category_code
from tbl_menu
where menu_name = '민트미역국'; -- 4(서브쿼리의 결과가 하나여야 단일행 서브쿼리로 사용가능)

select menu_code        메뉴코드,
       menu_name        메뉴명,
       menu_price       메뉴가격,
       orderable_status 주문가능여부
from tbl_menu
where category_code = 4;

-- 단일행 서브쿼리를 사용해서 하나의 쿼리문으로 구하기
select menu_code        메뉴코드,
       menu_name        메뉴명,
       menu_price       메뉴가격,
       orderable_status 주문가능여부
from tbl_menu
where category_code = (select category_code
                       from tbl_menu
                       where menu_name = '민트미역국');

/* 다중행 서브쿼리 */
-- 카테고리 코드가 식사인 모든 category_code를 조회
select category_code
from tbl_category
where ref_category_code = 1; -- 결과가 4, 5, 6, 7로 여러개이므로 다중행 서브쿼리

select *
from tbl_menu
where category_code in (select category_code
                        from tbl_category
                        where ref_category_code = 1);

/* ALL 연산자 */
-- 서브쿼리의 결과 모두에 대해 연산결과가 참이면 참을 반환한다.
-- x > ALL(...) : 모든 값보다 크면 참 (최대값보다도 크면 참)
-- x >= ALL(...) : 모든 값보다 크거나 같으면 참 (최대값보다도 크거나 같으면 참)
-- x < ALL(...) : 모든 값보다 작으면 참 (최소값보다도 작으면 참)
-- x <= ALL(...) : 모든 값보다 작거나 같으면 참 (최소값보다도 작거나 같으면 참)
-- x = ALL(...) : 모든 값과 같으면 참
-- x != ALL(...) : 모든 값과 다르면 참 (NOT IN과 동일)

-- 가장 비싼 메뉴를 조회
# select max(menu_price)
# from tbl_menu;

select *
from tbl_menu
where menu_price >= all (select menu_price
                         from tbl_menu);

-- 한식보다 비싼 일식 or 중식을 조회하라.
select *
from tbl_menu
where category_code in (5, 6)
  and menu_price > all (select menu_price
                        from tbl_menu
                        where category_code = 4);

/* 상관 서브쿼리 */
-- 메인쿼리가 서브쿼리의 결과에 영향을 주는 경우를 의미한다.
-- 메인쿼리의 값을 서브쿼리에게 주고 서브쿼리를 수행한 다음 그 결과를 다시 메인쿼리로 반환하는 형식으로 수행되는 서브쿼리.
-- 서브쿼리의 where절 수행을 위해, 메인쿼리가 먼저 수행되는 구조.
-- 메인쿼리 테이블의 행에 따라 서브쿼리의 결과값도 바뀐다.

-- 카테고리별 평균 가격이 가장 비싼 메뉴 조회
select category_code,
       max(menu_price)
from tbl_menu
group by category_code;

select *
from tbl_menu a
where menu_price = (select max(menu_price)
                    from tbl_menu
                    where category_code = a.category_code);
-- 메인쿼리의 테이블을 서브쿼리에서 사용한다.

/* EXISTS */
-- 서브쿼리 결과집합에 행이 존재하면 참, 행이 존재하지 않으면 거짓을 반환한다.
-- NOT EXISTS : 서브쿼리 결과집합에 행이 존재하지 않으면 참, 존재하면 거짓을 반환한다.

-- tbl_menu에서 사용되는 카테고리만 조회
select a.category_code,
       a.category_name
from tbl_category a
where exists(select category_code
             from tbl_menu b
             where b.category_code = a.category_code);

/* 스칼라 서브쿼리 */
-- 결과값이 1개인 서브쿼리, 주로 SELECT문에서 사용된다.
-- 스칼라 = 단일값

-- 메뉴명, 카테고리명 조회
select a.menu_name,
       b.category_name
from tbl_menu a
         join tbl_category b
              on a.category_code = b.category_code;

-- 스칼라 서브쿼리
select a.menu_name,
       (select category_name
        from tbl_category b
        where a.category_code = b.category_code) category_name
from tbl_menu a;

-- 스칼라 서브쿼리의 반환 행수가 1행보다 많을수는 없다.
# select menu_name,
#        (select category_name
#         from tbl_category) category_name
# from tbl_menu;

/* CTE(Common Table Expressions) */
-- 서브쿼리와 비슷한 개념
-- 코드의 가독성과 재사용성을 위해 사용한다.
-- FROM절에서만 사용된다. (JOIN 일시 JOIN구문에서도 사용가능)

-- 메뉴명과 카페고리명을 함께 출력
with menucate as (select menu_name,
                         category_name
                  from tbl_menu a
                           join tbl_category b on a.category_code = b.category_code)
select *
from menucate
order by menu_name;