--16. tblAddressBook. 남자 평균 나이보다 나이가 많은 서울 태생 + 직업을 가지고 있는 사람들을 가져오시오.
SELECT
	*
FROM tbladdressbook
	WHERE age > (SELECT avg(age) FROM tbladdressbook WHERE gender = 'm')
		AND hometown IN ('서울') AND job NOT IN ('백수', '취업준비생');
	
-- employees. 'Munich' 도시에 위치한 부서에 소속된 직원들 명단?



-- tblMen. tblWoman. 서로 짝이 있는 사람 중 남자와 여자의 정보를 모두 가져오시오.
--    [남자]        [남자키]   [남자몸무게]     [여자]    [여자키]   [여자몸무게]
--    홍길동         180       70              장도연     177        65
--    아무개         175       null            이세영     163        null
--    ..
SELECT
	*
FROM tblmen m
	INNER JOIN tblwomen w
		ON m.name = w.couple;

    

-- tblAddressBook. 가장 많은 사람들이 가지고 있는 직업은 주로 어느 지역 태생(hometown)인가?
SELECT
	DISTINCT hometown
FROM tbladdressbook
	WHERE job = (SELECT job FROM tbladdressbook GROUP BY job HAVING count(*) = (SELECT max(count(*)) FROM tbladdressbook GROUP BY job))
		ORDER BY hometown ASC;
	
-- tblAddressBook. 이메일 도메인들 중 평균 아이디 길이가 가장 긴 이메일 사이트의 도메인은 무엇인가?
SELECT
	substr(email, instr(email,'@')+1),
	avg(LENGTH(substr(email, 1, instr(email,'@')-1)))
FROM tbladdressbook
	GROUP BY substr(email, instr(email,'@')+1)
		HAVING avg(LENGTH(substr(email, 1, instr(email,'@')-1))) =
			(SELECT max(avg(LENGTH(substr(email, 1, instr(email,'@')-1)))) 
				FROM tbladdressbook
					GROUP BY substr(email, instr(email,'@')+1));
            

-- tblAddressBook. 평균 나이가 가장 많은 출신(hometown)들이 가지고 있는 직업 중 가장 많은 직업은?
SELECT
	job
FROM tbladdressbook
WHERE hometown = (
		SELECT hometown 
		FROM tbladdressbook 
		GROUP BY hometown 
		HAVING avg(age) = (
			SELECT max(avg(age)) 
			FROM tbladdressbook 
			GROUP BY hometown))
GROUP BY job 
having count(*) = (
		select max(count(*)) 
		from tblAddressBook
		where hometown
			= (
				select hometown 
				from tblAddressBook 
				group by hometown 
				having avg(age) = (
					select max(avg(age)) 
					from tblAddressBook 
					group by hometown)) 
		group by job); 





-- tblAddressBook. 남자 평균 나이보다 나이가 많은 서울 태생 + 직업을 가지고 있는 사람들을 가져오시오.
SELECT 
	*
FROM tbladdressbook
	WHERE age > (SELECT avg(age) FROM tbladdressbook)
	and gender = 'm' AND hometown IN ('서울') AND job NOT IN ('백수', '취업준비생')




-- tblAddressBook. 가장 나이가 많으면서 가장 몸무게가 많이 나가는 사람과 같은 직업을 가지는 사람들을 가져오시오.
SELECT
	*
FROM tbladdressbook
	WHERE job = (
		SELECT job 
		FROM tbladdressbook 
		WHERE weight = (
			SELECT max(weight) 
			FROM tbladdressbook 
			) 
		and age = (SELECT max(age) FROM tbladdressbook));


-- tblAddressBook.  동명이인이 여러명 있습니다. 이 중 가장 인원수가 많은 동명이인(모든 이도윤)의 명단을 가져오시오.
SELECT
	*
FROM tbladdressbook
	WHERE name = (
		SELECT name
		FROM tbladdressbook
			GROUP BY name
			having count(*) = (
				SELECT max(count(*))
				FROM tbladdressbook
					GROUP BY name));
	


			
-- tblAddressBook. 가장 사람이 많은 직업의(332명) 세대별 비율을 구하시오.
--    [10대]       [20대]       [30대]       [40대]
--    8.7%        30.7%        28.3%        32.2%

SELECT
	job,
	round(count(CASE
		WHEN age BETWEEN 10 AND 19 THEN 1
	END) / count(*)*100,2) || '%' AS "[10대]",
	round(count(CASE
		WHEN age BETWEEN 20 AND 29 THEN 1
	END) / count(*)*100,2) || '%' AS "[20대]",
	round(count(CASE
		WHEN age BETWEEN 30 AND 39 THEN 1
	END) / count(*)*100,2) || '%' AS "[30대]",
	round(count(CASE
		WHEN age BETWEEN 40 AND 49 THEN 1
	END) / count(*)*100,2) || '%' AS "[40대]"
FROM tbladdressbook
	GROUP BY job	
	HAVING count(*) = (
		SELECT max(count(job))
		FROM tbladdressbook
			GROUP by job);
		
	


















