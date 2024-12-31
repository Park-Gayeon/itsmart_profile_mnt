-- 연결 문자셋 설정
SET NAMES utf8mb4;

-- db 생성
CREATE DATABASE IF NOT EXISTS demo_db;
USE demo_db;

-- user 생성
create user IF NOT EXISTS 'itsmart'@'%' IDENTIFIED WITH caching_sha2_password BY 'itsmart1!';

-- 권한 부여
GRANT ALL PRIVILEGES ON `demo_db`.* TO 'itsmart'@'%' with grant option;
flush privileges;

-- 테이블 생성
CREATE TABLE TB_USER_PROFILE_INFO
(
    user_id         VARCHAR(10)  NOT NULL COMMENT '직원 아이디',
    user_pw         VARCHAR(120) NOT NULL COMMENT '비밀번호',
    user_nm         VARCHAR(6)   NOT NULL COMMENT '직원명',
    user_position   VARCHAR(3)   NOT NULL COMMENT '직급/직위',
    user_birth      VARCHAR(8)   NOT NULL COMMENT '직원 생년월일',
    user_department VARCHAR(3)   NOT NULL COMMENT '소속',
    hire_date       VARCHAR(8)   NOT NULL COMMENT '입사일',
    user_phone      VARCHAR(11)  NOT NULL COMMENT '휴대전화',
    user_address    VARCHAR(50)  NOT NULL COMMENT '주소',
    user_role       CHAR(1)      NOT NULL DEFAULT '1' COMMENT '권한 (0: admin, 1: user)',
    use_yn          CHAR(1)      NOT NULL DEFAULT 'Y' COMMENT '사용 여부',
    file_seq        INT COMMENT '파일 순번',
    created_date    TIMESTAMP    NOT NULL COMMENT '생성일시',
    modified_date   TIMESTAMP    NOT NULL COMMENT '수정일시',
    creator         VARCHAR(10)  NOT NULL COMMENT '생성자',
    modifier        VARCHAR(10)  NOT NULL COMMENT '수정자',

    PRIMARY KEY (user_id)
) COMMENT ='직원 프로필 정보 테이블';

CREATE TABLE TB_USER_PROFILE_INFO_HIST
(
    user_id         VARCHAR(10) NOT NULL COMMENT '직원 아이디',
    hist_seq        INT         NOT NULL COMMENT '이력 순번',
    user_nm         VARCHAR(6) COMMENT '직원명',
    user_position   VARCHAR(3) COMMENT '직급/직위',
    user_birth      VARCHAR(8) COMMENT '직원 생년월일',
    user_department VARCHAR(3) COMMENT '소속',
    hire_date       VARCHAR(8) COMMENT '입사일',
    user_phone      VARCHAR(11) COMMENT '휴대전화',
    user_address    VARCHAR(50) COMMENT '주소',
    file_seq        INT COMMENT '파일 순번',
    created_date    TIMESTAMP   NOT NULL COMMENT '생성일시',
    creator         VARCHAR(10) NOT NULL COMMENT '생성자',

    PRIMARY KEY (user_id, hist_seq)
) COMMENT ='직원 프로필이력관리 테이블';

CREATE TABLE TB_USER_EDUCATION_INFO
(
    user_id           VARCHAR(10) NOT NULL COMMENT '직원 아이디',
    school_seq        INT         NOT NULL COMMENT '학교 순번',
    school_gubun      VARCHAR(3) COMMENT '학력 구분',
    school_nm         VARCHAR(20) COMMENT '학교명',
    school_start_date VARCHAR(8) COMMENT '입학일자',
    school_end_date   VARCHAR(8) COMMENT '졸업일자',
    major             VARCHAR(20) COMMENT '주전공',
    double_major      VARCHAR(20) COMMENT '복수전공',
    total_grade       DECIMAL(2, 1) COMMENT '졸업학점',
    standard_grade    DECIMAL(2, 1) COMMENT '기준학점',
    grad_status       VARCHAR(3) COMMENT '졸업상태',
    created_date      TIMESTAMP   NOT NULL COMMENT '생성일시',
    modified_date     TIMESTAMP   NOT NULL COMMENT '수정일시',
    creator           VARCHAR(10) NOT NULL COMMENT '생성자',
    modifier          VARCHAR(10) NOT NULL COMMENT '수정자',

    PRIMARY KEY (user_id, school_seq)
) COMMENT ='직원 학력 정보테이블';

CREATE TABLE TB_USER_EDUCATION_INFO_HIST
(
    user_id           VARCHAR(10) NOT NULL COMMENT '직원 아이디',
    school_seq        INT         NOT NULL COMMENT '학교 순번',
    hist_seq          INT         NOT NULL COMMENT '이력 순번',
    school_gubun      VARCHAR(3) COMMENT '학력 구분',
    school_nm         VARCHAR(20) COMMENT '학교명',
    school_start_date VARCHAR(8) COMMENT '입학일자',
    school_end_date   VARCHAR(8) COMMENT '졸업일자',
    major             VARCHAR(20) COMMENT '주전공',
    double_major      VARCHAR(20) COMMENT '복수전공',
    total_grade       DECIMAL(2, 1) COMMENT '졸업학점',
    standard_grade    DECIMAL(2, 1) COMMENT '기준학점',
    grad_status       VARCHAR(3) COMMENT '졸업상태',
    created_date      TIMESTAMP   NOT NULL COMMENT '생성일시',
    creator           VARCHAR(10) NOT NULL COMMENT '생성자',

    PRIMARY KEY (user_id, school_seq, hist_seq)
) COMMENT ='직원 학력 이력관리 테이블';

CREATE TABLE TB_PROJECT_INFO
(
    user_id            VARCHAR(10)  NOT NULL COMMENT '직원 아이디',
    project_seq        INT          NOT NULL COMMENT '사업 순번',
    project_nm         VARCHAR(100) NOT NULL COMMENT '사업명',
    project_start_date VARCHAR(8)   NOT NULL COMMENT '투입시작일',
    project_end_date   VARCHAR(8)   NOT NULL COMMENT '투입종료일',
    project_role       VARCHAR(3) COMMENT '역할',
    project_client     VARCHAR(20)  NOT NULL COMMENT '발주처',
    assigned_task_lar  VARCHAR(3)   NOT NULL COMMENT '담당업무(대분류)',
    assigned_task_mid  VARCHAR(3)   NOT NULL COMMENT '담당업무(소분류)',
    use_yn             CHAR(1)      NOT NULL DEFAULT 'Y' COMMENT '사용 여부',
    created_date       TIMESTAMP    NOT NULL COMMENT '생성일시',
    modified_date      TIMESTAMP    NOT NULL COMMENT '수정일시',
    creator            VARCHAR(10)  NOT NULL COMMENT '생성자',
    modifier           VARCHAR(10)  NOT NULL COMMENT '수정자',

    PRIMARY KEY (user_id, project_seq)
) COMMENT ='참여사업 정보테이블';

CREATE TABLE TB_PROJECT_INFO_HIST
(
    user_id            VARCHAR(10) NOT NULL COMMENT '직원 아이디',
    project_seq        INT         NOT NULL COMMENT '사업 순번',
    hist_seq           INT         NOT NULL COMMENT '이력 순번',
    project_nm         VARCHAR(100) COMMENT '사업명',
    project_start_date VARCHAR(8) COMMENT '투입시작일',
    project_end_date   VARCHAR(8) COMMENT '투입종료일',
    project_role       VARCHAR(3) COMMENT '역할',
    project_client     VARCHAR(20) COMMENT '발주처',
    assigned_task_lar  VARCHAR(3) COMMENT '담당업무(대분류)',
    assigned_task_mid  VARCHAR(3) COMMENT '담당업무(소분류)',
    created_date       TIMESTAMP   NOT NULL COMMENT '생성일시',
    creator            VARCHAR(10) NOT NULL COMMENT '생성자',

    PRIMARY KEY (user_id, project_seq, hist_seq)
) COMMENT ='참여사업 이력관리 테이블';

CREATE TABLE TB_USER_SKILL_INFO
(
    user_id       VARCHAR(10) NOT NULL COMMENT '직원 아이디',
    project_seq   INT         NOT NULL COMMENT '사업 순번',
    skill_id      INT         NOT NULL COMMENT '기술 아이디',
    skill_nm      VARCHAR(20) NOT NULL COMMENT '기술명',
    use_yn        CHAR(1)     NOT NULL DEFAULT 'Y' COMMENT '사용여부',
    created_date  TIMESTAMP   NOT NULL COMMENT '생성일시',
    modified_date TIMESTAMP   NOT NULL COMMENT '수정일시',
    creator       VARCHAR(10) NOT NULL COMMENT '생성자',
    modifier      VARCHAR(10) NOT NULL COMMENT '수정자',

    PRIMARY KEY (user_id, project_seq, skill_id)
) COMMENT ='직원 기술 정보테이블';

CREATE TABLE TB_USER_SKILL_INFO_HIST
(
    user_id      VARCHAR(10) NOT NULL COMMENT '직원 아이디',
    project_seq  INT         NOT NULL COMMENT '사업 순번',
    skill_id     INT         NOT NULL COMMENT '기술 아이디',
    hist_seq     INT         NOT NULL COMMENT '이력 순번',
    skill_nm     VARCHAR(20) COMMENT '기술명',
    created_date TIMESTAMP   NOT NULL COMMENT '생성일시',
    creator      VARCHAR(10) NOT NULL COMMENT '생성자',

    PRIMARY KEY (user_id, project_seq, skill_id, hist_seq)
) COMMENT ='직원 기술 이력관리 테이블';

CREATE TABLE TB_USER_QUALIFICATION_INFO
(
    user_id           VARCHAR(10) NOT NULL COMMENT '직원 아이디',
    qualification_seq INT         NOT NULL COMMENT '자격증 순번',
    qualification_nm  VARCHAR(20) NOT NULL COMMENT '자격증 명',
    issuer            VARCHAR(20) NOT NULL COMMENT '발행기관',
    acquisition_date  VARCHAR(8)  NOT NULL COMMENT '취득일자',
    expiry_date       VARCHAR(8) COMMENT '만기일자',
    is_expired        CHAR(1)              DEFAULT 'N' COMMENT '만기여부',
    use_yn            CHAR(1)     NOT NULL DEFAULT 'Y' COMMENT '사용여부',
    created_date      TIMESTAMP   NOT NULL COMMENT '생성일시',
    modified_date     TIMESTAMP   NOT NULL COMMENT '수정일시',
    creator           VARCHAR(10) NOT NULL COMMENT '생성자',
    modifier          VARCHAR(10) NOT NULL COMMENT '수정자',

    PRIMARY KEY (user_id, qualification_seq)
) COMMENT ='직원 자격증 정보테이블';

CREATE TABLE TB_USER_QUALIFICATION_INFO_HIST
(
    user_id           VARCHAR(10) NOT NULL COMMENT '직원 아이디',
    qualification_seq INT         NOT NULL COMMENT '자격증 순번',
    hist_seq          INT         NOT NULL COMMENT '이력 순번',
    qualification_nm  VARCHAR(20) COMMENT '자격증 명',
    issuer            VARCHAR(20) COMMENT '발행기관',
    acquisition_date  VARCHAR(8) COMMENT '취득일자',
    expiry_date       VARCHAR(8) COMMENT '만기일자',
    is_expired        CHAR(1) DEFAULT 'N' COMMENT '만기여부',
    created_date      TIMESTAMP   NOT NULL COMMENT '생성일시',
    creator           VARCHAR(10) NOT NULL COMMENT '생성자',

    PRIMARY KEY (user_id, qualification_seq, hist_seq)
) COMMENT ='직원 자격증 이력관리 테이블';

CREATE TABLE TB_WORK_EXPERIENCE_INFO
(
    user_id            VARCHAR(10) NOT NULL COMMENT '직원 아이디',
    work_seq           INT         NOT NULL COMMENT '근무지 순번',
    work_place         VARCHAR(20) NOT NULL COMMENT '근무지',
    work_assigned_task VARCHAR(20) NOT NULL COMMENT '담당업무',
    work_position      VARCHAR(10) NOT NULL COMMENT '직급',
    work_start_date    VARCHAR(8)  NOT NULL COMMENT '입사일자',
    work_end_date      VARCHAR(8)  NOT NULL COMMENT '퇴사일자',
    use_yn             CHAR(1)     NOT NULL DEFAULT 'Y' COMMENT '사용여부',
    created_date       TIMESTAMP   NOT NULL COMMENT '생성일시',
    modified_date      TIMESTAMP   NOT NULL COMMENT '수정일시',
    creator            VARCHAR(10) NOT NULL COMMENT '생성자',
    modifier           VARCHAR(10) NOT NULL COMMENT '수정자',

    PRIMARY KEY (user_id, work_seq)
) COMMENT ='직원 근무지 정보테이블';

CREATE TABLE TB_WORK_EXPERIENCE_INFO_HIST
(
    user_id            VARCHAR(10) NOT NULL COMMENT '직원 아이디',
    work_seq           INT         NOT NULL COMMENT '근무지 순번',
    hist_seq           INT         NOT NULL COMMENT '이력 순번',
    work_place         VARCHAR(20) COMMENT '근무지',
    work_assigned_task VARCHAR(20) COMMENT '담당업무',
    work_position      VARCHAR(10) COMMENT '직급',
    work_start_date    VARCHAR(8) COMMENT '입사일자',
    work_end_date      VARCHAR(8) COMMENT '퇴사일자',
    created_date       TIMESTAMP   NOT NULL COMMENT '생성일시',
    creator            VARCHAR(10) NOT NULL COMMENT '생성자',

    PRIMARY KEY (user_id, work_seq, hist_seq)
) COMMENT ='직원 근무지 이력관리 테이블';

CREATE TABLE TB_ATTACHMENT_INFO
(
    user_id        VARCHAR(10)  NOT NULL COMMENT '직원 아이디',
    file_seq       INT          NOT NULL COMMENT '파일 순번',
    file_se        VARCHAR(30)  NOT NULL COMMENT '파일 구분',
    file_ori_nm    VARCHAR(20)  NOT NULL COMMENT '로컬파일명',
    file_sver_nm   VARCHAR(50)  NOT NULL COMMENT '서버파일명',
    file_sver_path VARCHAR(100) NOT NULL COMMENT '파일 서버경로',
    file_extension VARCHAR(8)   NOT NULL COMMENT '파일확장자',
    use_yn         CHAR(1)      NOT NULL DEFAULT 'Y' COMMENT '사용여부',
    created_date   TIMESTAMP    NOT NULL COMMENT '생성일시',
    creator        VARCHAR(10)  NOT NULL COMMENT '생성자',

    PRIMARY KEY (file_seq, file_se, user_id)
) COMMENT ='첨부파일 정보테이블';

CREATE TABLE TB_COMMON_CODE
(
    code_group_id VARCHAR(5)  NOT NULL COMMENT '코드그룹 아이디',
    code_id       VARCHAR(3)  NOT NULL COMMENT '코드상세 아이디',
    code_group_nm VARCHAR(10) NOT NULL COMMENT '코드그룹 명',
    code_value    VARCHAR(50) NOT NULL COMMENT '코드 값',
    parent_id     VARCHAR(3) COMMENT '상위코드 아이디',
    level         INT         NOT NULL COMMENT '계층 레벨',
    use_yn        CHAR(1)     NOT NULL DEFAULT 'Y' COMMENT '사용여부',
    created_date  TIMESTAMP   NOT NULL COMMENT '생성일시',
    creator       VARCHAR(10) NOT NULL COMMENT '생성자',

    PRIMARY KEY (code_group_id, code_id)
) COMMENT ='공통코드 테이블';

CREATE TABLE TB_USER_REFRESH_TOKEN_INFO
(
    user_id      VARCHAR(10)  NOT NULL COMMENT '직원 아이디',
    token        VARCHAR(256) NOT NULL COMMENT 'REFRESH TOKEN',
    created_date TIMESTAMP    NOT NULL COMMENT '생성일시'
) COMMENT ='TOKEN 테이블';

-- parent_id 컬럼에 인덱스 추가
CREATE INDEX idx_tb_common_code_parent_id ON TB_COMMON_CODE (parent_id);
-- 수행경력 계산을 위한 인덱스 추가
CREATE INDEX idx_start_end ON TB_PROJECT_INFO (project_start_date, project_end_date);

-- 수행경력 계산 함수
DELIMITER $$

CREATE FUNCTION calculate_total_months_v2(input_user_id VARCHAR(8))
    RETURNS INT
    DETERMINISTIC
BEGIN
    DECLARE done INT DEFAULT 0; -- 반복 종료 플래그
    DECLARE start_date DATE;
    DECLARE end_date DATE;
    DECLARE total_months INT;

    -- 병합된 결과를 저장할 임시 테이블 생성
    CREATE TEMPORARY TABLE temp_merged_periods
    (
        project_start_date DATE,
        project_end_date   DATE
    );

    -- 처리할 데이터를 저장할 임시 테이블 생성
    CREATE TEMPORARY TABLE temp_unmerged_periods AS
    SELECT project_start_date, project_end_date
    FROM TB_PROJECT_INFO
    WHERE user_id = input_user_id
    ORDER BY project_start_date;

    -- 초기 시작일과 종료일 설정
    SET start_date = (SELECT project_start_date FROM temp_unmerged_periods ORDER BY project_start_date LIMIT 1);
    SET end_date = (SELECT project_end_date FROM temp_unmerged_periods ORDER BY project_start_date LIMIT 1);

    -- 병합 반복문
    REPEAT
        IF NOT done THEN
            -- 병합된 기간 삽입
            INSERT INTO temp_merged_periods
            SELECT project_start_date, project_end_date
            FROM (SELECT LEAST(start_date, t1.project_start_date) AS project_start_date,
                         GREATEST(end_date, t1.project_end_date)  AS project_end_date
                  FROM temp_unmerged_periods t1
                  WHERE end_date >= t1.project_start_date
                    AND start_date <= t1.project_end_date) a
            ORDER BY project_end_date DESC
            LIMIT 1;

            -- 병합된 데이터 삭제
            DELETE
            FROM temp_unmerged_periods
            WHERE end_date >= project_start_date
              AND start_date <= project_end_date;

            -- 다음 병합 대상 가져오기
            IF EXISTS (SELECT 1 FROM temp_unmerged_periods) THEN
                SELECT project_start_date, project_end_date
                INTO start_date, end_date
                FROM temp_unmerged_periods
                ORDER BY project_start_date
                LIMIT 1;
            ELSE
                SET done = 1;
            END IF;
        END IF;
    UNTIL done END REPEAT;

    -- 총 개월 수 계산
    SELECT FLOOR(SUM(DATEDIFF(project_end_date, project_start_date) + 1) / 30)
    INTO total_months
    FROM temp_merged_periods;

    -- 임시 테이블 삭제
    DROP TEMPORARY TABLE temp_merged_periods;
    DROP TEMPORARY TABLE temp_unmerged_periods;

    RETURN total_months;
END $$

DELIMITER ;

-- 최초 적재 데이터
-- 초기 데이터
-- TB_USER_PROFILE_INFO
insert into TB_USER_PROFILE_INFO ( user_id
                                 , user_pw
                                 , user_nm
                                 , user_position
                                 , user_birth
                                 , user_department
                                 , hire_date
                                 , user_phone
                                 , user_address
                                 , user_role
                                 , created_date
                                 , modified_date
                                 , creator
                                 , modifier)
VALUES ( 'admin'
       , '$2a$10$XMQKsECASRc6gBJbLEw3ZOnBWF92BJSNUMLNcBQdYtzD2Q9gLeq/C'
       , '관리자'
       , '004'
       , '20201212'
       , '012'
       , '20240401'
       , '01011111111'
       , '대구광역시 남구 우리집303호'
       , '0'
       , now()
       , now()
       , 'admin'
       , 'admin');


-- TB_USER_PROFILE_INFO_HIST
INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'admin';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('asjang', '$2a$10$iO2ChfGYlcQHzuIVFDyhBO9qFwLOcDUcwPWssp6709zigvX1.Psnq', '장안섭', '010', '20201212', '004',
        '20201212', '01090813438', '대구광역시', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'asjang';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('bgshin', '$2a$10$qglq4WoFsEzj5IOKdbeiZOKqtacbDt5clsSH5a2yO5F1qS08lRed6', '신봉규', '004', '20201010', '003',
        '20201010', '01048484848', '대구광역시', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'bgshin';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('bhyoon', '$2a$10$olSg5uMtBp3sLR/D2b7eIePgc5l2ZPRCerkDDqML1sIFOT4/Agy1i', '윤병환', '007', '20201212', '017',
        '20201212', '01038938383', '솔루션사업팀', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'bhyoon';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('bsmyeong', '$2a$10$vw3XpqbKZW13F57E1qoVhOsXEueFHoZtxmBbJzspnMhPKUuO6uohm', '명백송', '009', '20201211', '016',
        '20201211', '01047474747', '솔루션사업', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'bsmyeong';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('bwjung', '$2a$10$XPbQYkAb5egg7ax2IuPSzOwcEu8FSpurTwR1z1Xk3cIWhbrPfbnXu', '정병욱', '008', '20201010', '012',
        '20201212', '01031233999', '대구광역시', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'bwjung';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('chlee', '$2a$10$M8r/5gyp/C1xt/VkLvO.xeZYsxaXk47JomhvtNQR3xafD63rvMB0m', '이찬혁', '005', '19920418', '012',
        '19920418', '01020311053', 'ㅁㅁ', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'chlee';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('chock', '$2a$10$p1HfZsYnnDcfsrDEMb4bzOhZViFLpQ9CgAy65lOe2OCkmOUx3NMcm', '옥창훈', '007', '20201212', '006',
        '20201212', '0108387934', 'ITO사업2팀 ', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'chock';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('cskang', '$2a$10$GrgEMuLqa/.OYdIop8JLF.0XB7lUVxJp2W1dQT7O7n5/tLNg1D/fW', '강청순', '006', '20201212', '015',
        '20201212', '01033333333', '대구광역시', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'cskang';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('dhkim', '$2a$10$gtBPxsMQ04dEGlhp4lYLOu5pc7yulGoBGvNApc0t5DtiypA3JEdr2', '김대환', '010', '20201212', '006',
        '20201212', '01033651393', '서비스사업부가없다', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'dhkim';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('dhson', '$2a$10$RZR9hpmOk3ysqlbY4ZvxduBV7AcJud9rtYOXYSTV40kpWRG2WGyra', '손동현', '006', '20201212', '015',
        '20201212', '01089898989', '대구광역시', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'dhson';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('dilim', '$2a$10$L5b5Fs6P2QCqWOtYHHG2J.mx7vGvSZlKaq.gcatCx3TsB5OUNiJTm', '임대일', '011', '20201212', '009',
        '20201212', '01088787878', 'ㅁㄴㅇㄹ', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'dilim';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('donghyeo', '$2a$10$zK3r/OSy.ZYVVKy0U/HqUeiTNa50hOv.qln6efa7jNWFx39rWfbn.', '김동현', '003', '20201212', '014',
        '20201212', '01062303603', '대구광역시', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'donghyeo';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('dsjeong', '$2a$10$mHmPGoRHaGZrfmtUDM/G2ebYvFiCzsZZWJ4to80FmXSIqWprCJp4K', '정두식', '008', '20201010', '017',
        '20201010', '01038383838', 'DW사업팀 ', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'dsjeong';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('eslee', '$2a$10$/A./fQhvFcM6wpqZ8bNEd.gnYPZUq20m8UnkIZ2MLq3LW2xsutsX.', '이은석', '005', '20201212', '006',
        '20201212', '01038873948', 'ITO사업2팀 ', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'eslee';


INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('ghjung', '$2a$10$qVqFKmMB9J/KGNBlDvmVre/VuidyGws9S1zV59l3nH4kjNZJb6IO.', '정규현', '006', '20201010', '012',
        '20201010', '01038483838', ' 금융사업3팀 ', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'ghjung';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('gypark', '$2a$10$LjLkXF7YkRnT20pZ885x7OpZ9/VCqDuauwdYzCPpS9PYkgSd3XPqO', '박가연', '004', '19960904', '012',
        '20240401', '01063684863', '대구광역시 남구 대명동 1622', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'gypark';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('gyungsoo', '$2a$10$gKulzxruGllcCemxaAq1V.Ue/gY94zXUEMbWe3rC4i8l0Dhb37xG2', '이경술', '006', '20201212', '014',
        '20201212', '01023305946', '대구광역시', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'gyungsoo';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('happy', '$2a$10$mUIQV8nu4JWq3RBZUqeoquC9L5XuxqbZxQc9iuNs4Q5QmKwRoQfPG', '팽성훈', '010', '20201010', '016',
        '20201010', '01062557332', '미디어콘텐츠사업부', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'happy';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('hgkang', '$2a$10$hcl/fOAFRp1snV2Re01zleONZawoeWukq0GKjIuA8wWq5WrZ72dKq', '강홍구', '006', '20200303', '016',
        '20201212', '01072900121', '대구광역시', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'hgkang';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('hgshin', '$2a$10$dSr8ZGRIWwwrq583eWlB5uojbMW2zuQIOFyL8EtgxrhARGSIr3/We', '신현규', '009', '20201010', '012',
        '20201010', '0100348480', 'ㅁ', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'hgshin';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('hhan', '$2a$10$xLEq5uGHJWJ52hMTRYLRjePAEsGzCzbOYemG/48BhBGcw.Pppq9Pm', '한호', '003', '20201211', '017',
        '20201211', '01038383838', 'DW사업팀 ', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'hhan';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('hjshin', '$2a$10$/113JjBnDwEbVCak7C/kD.Pwh1h4jfuGhDIBpplfOlur8sU9EHnDC', '신희재', '005', '19850222', '010',
        '19850222', '01073033092', 'ㅁㅁ', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'hjshin';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('hmyoo', '$2a$10$PRnZK8xgrpK0v8Kl8Qx7p.YtfEw8xrvZJ.fgg6MGA8hrGQiqI26RK', '유현민', '005', '20200303', '014',
        '20200303', '01039838383', '대구광역시', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'hmyoo';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('honorone', '$2a$10$TmC5REANiYN2z3WQciCuU.hAfAyReCd/1QRTgvO241uqsRHwOfYBS', '정경일', '008', '20200404', '006',
        '20200404', '01038848383', 'ITO사업2팀 ', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'honorone';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('hopark', '$2a$10$ja0.UKkG2PH8mBeDg.U8yerY.SHLwKE3mz7n5LMgDBLpsIVH0mnv2', '박호종', '013', '20200101', '001',
        '20200101', '01099909090', '대구광역시', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'hopark';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('hskim', '$2a$10$cmaLNajxgO1CajcjDCoH..0cgUvKDCPt.x/3DvM6KQ3jT.2YuVe2G', '김한수', '004', '20201010', '010',
        '20201010', '01035831078', 'ㅁㅁ', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'hskim';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('hypark', '$2a$10$jwupHZu1y5xeO.Yj1.GL1uGThcmoLq.UjD4Q9vJNt0w/UG/0XIhTq', '박호영', '006', '19850222', '010',
        '19850222', '01073033092', '대구광역시', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'hypark';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('icshin', '$2a$10$ApALcIUw4qBVkn5QB.A2nuyX0QR47tkGjJqsBAKfmP1.FsdpVPC4G', '신인철', '010', '20200202', '014',
        '20200202', '01038383838', '대구광역시', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'icshin';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('ikshin', '$2a$10$Wo63s6ryqN655d31Vta4DuhVL7JkxIapr1w7LUqm662zjpte5IoGO', '신인근', '010', '20201212', '006',
        '20201212', '0108589898', '금융사업본부', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'ikshin';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('isjung', '$2a$10$4n.flSjtS9h7qHLvVbaFoOvFLurgVAqxHqUv5mAdP2/BKMi6NrKT.', '정인선', '005', '20201212', '002',
        '20201212', '0102222222', '대구광역시', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'isjung';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('jkkim', '$2a$10$EfRrVDbGrZJj5FqE6pNYk.AhLmXomJB/HOufwYGqWRl4.XJVZYZ16', '김종경', '008', '20201212', '014',
        '20201212', '01044434343', '대구광역시', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'jkkim';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('jklee', '$2a$10$ayW1Dz7EXATe5oCf.EbxHuF3UqeF3wZ5HHO5OqxAbbinkMf6hoW7G', '이중기', '009', '19690511', '003',
        '20201010', '01089828016', 'a', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'jklee';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('jpyu', '$2a$10$9sFSHxkWixgPwUhoqaskAetrJZE93r5a8tTZ7r88cnZmp0MWqPvVK', '유재필', '007', '20200404', '011',
        '20200404', '01043341979', '영업팀', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'jpyu';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('jsnam', '$2a$10$3ArN9s7W/cDYqWvZtef.fO.hPLq5BEISib.r64Ak73DLDIBMWs8z6', '남정석', '007', '20201212', '017',
        '20201212', '01038483897', 'DW사업팀 ', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'jsnam';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('jssong', '$2a$10$ZtTHvq1c7CCExQZYKwS7S.pFEeipALfb.JguitJ2.M0lzzeFReU0y', '송종수', '006', '20200101', '006',
        '20200101', '01084787878', 'Freelancer', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'jssong';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('junheo', '$2a$10$0Gv3qa8.Gm9eoxv30F1Kpu2tXQHzYJx593SCiIRDW5UYgW5co1PYO', '허준', '004', '19960525', '010',
        '19960525', '01053115782', '기술지원팀', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'junheo';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('jwkim', '$2a$10$bOGSDYJLuEY9sS3cKP1/YeFudtoC7r9l61FQQqoScChMUjJ/wMdFO', '김지우', '003', '20201212', '014',
        '20201212', '01048484848', '금융사업2팀', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'jwkim';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('jwseo', '$2a$10$mYZHcs.pfrP975iWVJ468ePQ5SQgLZ/3uUuKLIZFplYjNM/ICeqpa', '서진우', '005', '20201212', '015',
        '20201212', '01022222222', '대구광역시', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'jwseo';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('jypark', '$2a$10$c6DbsMDQJNGA08HgohHd9On2Wvl99JfuRLXuf41zTqRNWC5lPnQBS', '박준영', '003', '20201010', '015',
        '20201010', '01038443140', '대구광역시', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'jypark';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('kanoh', '$2a$10$GSutPg4P473PKthq0d6w..N7MzxQDIdPjRfxw2PoefHNvrB6GXN5y', '노경아', '005', '20201212', '002',
        '20201212', '01099939393', '대구광역시', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'kanoh';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('khpark', '$2a$10$PU9HuK/4xDeDCEMmGZ0Pj.Hst4q9N1o2KojAw3laMB8U.lGYc7VUK', '박기훈', '006', '20201212', '014',
        '20201212', '01046577147', '대구광역시', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'khpark';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('kjkim', '$2a$10$C99cGUqEzJnicl3Qy58EseUX2VoyLS/z1n8ppKKZrUooZgDAGQ3Za', '김경진', '003', '20200303', '014',
        '20200303', '01038373878', 'Freelancer', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'kjkim';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('minjikim', '$2a$10$gAWO0dopAeF4git7UoDkE.ZOJWZA9m1aPsVxuGNxDRuK1oc1rK.fi', '김민지', '007', '20201212', '017',
        '20201212', '01030303030', 'DW사업팀 ', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'minjikim';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('mjkim', '$2a$10$0GIIxTVizxA5rFd03xfM6uWnGkDWeqLbI.NPFvNvS0PkMR3Gxqtwi', '김민재', '005', '20201212', '006',
        '20201212', '01044444444', '대구광역시', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'mjkim';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('moonsu', '$2a$10$wp4z/w/2WCcWZgXGjbcqpej9nmd3acapB5Ehs0eD0Gm6tRX3yt8WG', '채문석', '009', '20201010', '009',
        '20201010', '01054764291', 'ㅁㅇㄹ', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'moonsu';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('mspark', '$2a$10$4AGINaKKevvJ9zrCMfHPCuN7KqYDruJ7XLJkzIEFfNN.8/K/BcvXy', '박명수', '005', '20201010', '010',
        '20201010', '01067005225', 'ㅁㅁ', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'mspark';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('powerkoo', '$2a$10$Zt0Xuv/a8kR6hFbSHu3VvOFAJ9ypJJZDmU8YYVfmiet5ko9kCN98e', '구자형', '009', '20201212', '016',
        '20201212', '01048484848', '솔루션사업팀', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'powerkoo';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('shinhyeo', '$2a$10$bqdsBwbYaFxB7gCzAiFKYuQ71mgmlfT0FQfaVqXxrBjRYZINlYRMC', '신현지', '004', '20201212', '015',
        '20201212', '01085601510', '대구광역시', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'shinhyeo';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('shkim', '$2a$10$hUCop8daQwu7KQFeSfihI.HiPOQA/2tttSKccLigtzKP1HDVLy/q6', '김승현', '007', '20201212', '017',
        '20201212', '01074738383', 'DW사업팀 ', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'shkim';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('shkoo', '$2a$10$PQAa.bFYxEqr02YQXJd.WezF22zfxXSjEYh7c6Wl4p6.whQ3sGEba', '구순회', '009', '20201010', '012',
        '20201010', '01078379482', '금융사업3팀', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'shkoo';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('shlee', '$2a$10$qV0yn0wp0wybSwL4/QrZju6hnVlFIu9Vp.pufUvjw37EFevBcDcVW', '이상훈', '009', '20201212', '016',
        '20201212', '01047747474', '솔루션사업2팀', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'shlee';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('shlim', '$2a$10$Cm4sgH770OWFoYRrjLXaguGIfgeHMgnNr9G.dUuBX3D9GGuF0O7Ea', '임성현', '004', '20201212', '006',
        '20201212', '01049385945', '대구광역시', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'shlim';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('shpark', '$2a$10$ofgEEGnodTOgPhE5BFV7POTWes3Byyq9V3Iu1j53A.mhamgPrGlw6', '박상호', '008', '20201212', '015',
        '20201212', '01085691737', '대구광역시', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'shpark';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('smjeong', '$2a$10$SCIUId4oTlwGzbkjacIx0OmBImH.1mAOOphA1.taoza4BgGHWys9W', '정상명', '010', '20200303', '016',
        '20200303', '0108585858', '솔루션사업팀', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'smjeong';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('smkim', '$2a$10$.xHhaBanpHEL4dr6OrWgO.q161o.ggVIIYv5c/kslFEYwcn3afhIu', '김시명', '010', '20201212', '017',
        '20201212', '01033454593', 'DW사업팀 ', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'smkim';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('sskim', '$2a$10$B2kBXgSaomeplAJjWvQZXON4RGXqpoQA2yRE5ld3sm20Bi/7K7UP.', '김승수', '006', '20201010', '014',
        '20201010', '01048484848', '대구광역시', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'sskim';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('ssongj', '$2a$10$hwZgBwWKbHEkysBcINSFWeJQiR.5XmdKh95iIH6cMDOvJKC29lR8q', '송주훈', '006', '20201221', '009',
        '20201221', '01038383784', 'ㅇ', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'ssongj';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('tyyoo', '$2a$10$cE87KGuNCHVJsiy5gHaA6.tYH3ksOu4Nq4ZYeOQoN9HI.gcUISVcS', '유태영', '009', '20201010', '003',
        '20201010', '01094421693', 'a', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'tyyoo';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('whjung', '$2a$10$8HPb1VAO.ILPLSYXOZa6yOCIx/tg2sAjr.r3IQiIyNtHTJN.HZMTm', '정우형', '004', '19810325', '010',
        '19810325', '01046593379', 'TS인프라', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'whjung';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('xeroma', '$2a$10$w8L499YvSRAUxnCpWuRNner9lTswSxHFTVQuGRs8OpMr5/Sruw/.O', '김영남', '007', '20200404', '016',
        '20200404', '01088787878', 'ㅇㅇ', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'xeroma';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('ycjoo', '$2a$10$z5VjEMxwxLxYQosVAgqqaOFWs9mHfqi9VOb02f12ePEX9lYRyMtp6', '주영철', '008', '20201212', '016',
        '20201212', '0102939393', '솔루션사업팀', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'ycjoo';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('ydkim', '$2a$10$ZFQ1G4sJfka.ySwovs2QV.pT.ZxhLWo75XmaLPW264DMg1oCSceAi', '김영대', '009', '20201010', '010',
        '20201010', '01031016569', 'ㄴ', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'ydkim';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('yjchoi', '$2a$10$HlnXpQSEAiGJyp63VZSfpeTJsKxiclm2kxpzTNj7dqTYYBFYdkN5.', '최영주', '006', '20201211', '015',
        '20201211', '01085650263', '대구광역시', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'yjchoi';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('yjkim', '$2a$10$6LzImNm6KI.DKLPlf4Lc.uUyPiUrawL.D89Mc7N1R3D3Pr9SvF.mK', '김영진', '007', '20200404', '016',
        '20200404', '01050505050', 'Freelancer', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'yjkim';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('yjpark', '$2a$10$Icqra2z5BXVrbvKToV/IwOedZzorpszru88nSn1jZm8ccjsI0R9jK', '박용진', '009', '20201010', '018',
        '20201010', '01056848890', '컨설팅사업', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'yjpark';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('yjwon', '$2a$10$uC5ti1/B1R24TKgQEcKPfOmJlZvdrhD4eb/VooIUrQv7nF2ZlC8zq', '원유준', '009', '19790820', '009',
        '20201212', '01027090960', 'ㅇㅇㅇㅇ', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'yjwon';

INSERT INTO TB_USER_PROFILE_INFO

(user_id, user_pw, user_nm, user_position, user_birth, user_department, hire_date, user_phone, user_address, user_role,
 use_yn, file_seq, created_date, modified_date, creator, modifier)

VALUES ('ywkang', '$2a$10$9kyB4lWZ1W85v9Q353axN.LgHVgVR3GMunaWkKIXyuxM99KwFA9dq', '강연웅', '007', '19810811', '009',
        '20200303', '01046282712', 'ㅁㄴㄹ', '1', 'Y', 0, now(), now(), 'admin', 'admin');

INSERT INTO TB_USER_PROFILE_INFO_HIST(USER_ID, hist_seq, USER_NM, USER_POSITION, USER_BIRTH, user_department, hire_date,
                                      user_phone, user_address, created_date, creator)
SELECT USER_ID,
       0 AS HIST_SEQ,
       user_nm,
       user_position,
       user_birth,
       user_department,
       hire_date,
       user_phone,
       user_address,
       created_date,
       creator
FROM TB_USER_PROFILE_INFO
WHERE USER_ID = 'ywkang';

-- TB_COMMON_CODE
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('PSIT', '001', '직위/직급', '수습', NULL, 0, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('PSIT', '002', '직위/직급', '인턴', NULL, 0, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('PSIT', '003', '직위/직급', '사원', NULL, 0, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('PSIT', '004', '직위/직급', '주임', NULL, 0, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('PSIT', '005', '직위/직급', '대리', NULL, 0, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('PSIT', '006', '직위/직급', '과장', NULL, 0, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('PSIT', '007', '직위/직급', '차장', NULL, 0, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('PSIT', '008', '직위/직급', '부장', NULL, 0, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('PSIT', '009', '직위/직급', '이사', NULL, 0, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('PSIT', '010', '직위/직급', '상무이사', NULL, 0, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('PSIT', '011', '직위/직급', '전무이사', NULL, 0, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('PSIT', '012', '직위/직급', '부사장', NULL, 0, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('PSIT', '013', '직위/직급', '대표이사', NULL, 0, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '001', '담당업무', 'IT컨설팅', NULL, 1, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '002', '담당업무', 'IT프로젝트관리', NULL, 1, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '003', '담당업무', 'IT아키텍처', NULL, 1, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '004', '담당업무', 'SW개발', NULL, 1, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '005', '담당업무', '시스템 구축 및 운영', NULL, 1, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '006', '담당업무', 'IT마케팅', NULL, 1, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '007', '담당업무', 'IT품질관리', NULL, 1, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '008', '담당업무', '정보보호', NULL, 1, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '009', '담당업무', 'IT기술교육', NULL, 1, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '010', '담당업무', '정보기술기획', '001', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '011', '담당업무', '정보기술컨설팅', '001', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '012', '담당업무', '정보보호컨설팅', '001', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '013', '담당업무', '데이터분석', '001', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '014', '담당업무', '업무분석', '001', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '015', '담당업무', '빅데이터기획', '001', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '016', '담당업무', 'UI/UX기획', '001', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '017', '담당업무', '인공지능서비스기획', '001', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '018', '담당업무', 'IT프로젝트관리', '002', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '019', '담당업무', 'IT프로젝트사업관리', '002', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '020', '담당업무', 'SW아키텍처', '003', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '021', '담당업무', 'infrastructure아키텍처', '003', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '022', '담당업무', '데이터아키텍처', '003', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '023', '담당업무', '빅데이터아키텍처', '003', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '024', '담당업무', '인공지능아키텍처', '003', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '025', '담당업무', 'UI/UX개발', '004', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '026', '담당업무', 'UI/UX디자인', '004', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '027', '담당업무', '응용SW개발', '004', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '028', '담당업무', '빅데이터개발', '004', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '029', '담당업무', '시스템SW개발', '004', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '030', '담당업무', '임베디드SW개발', '004', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '031', '담당업무', '인공지능SW개발', '004', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '032', '담당업무', '데이터베이스관리', '005', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '033', '담당업무', 'NW엔지니어링', '005', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '034', '담당업무', 'IT시스템관리', '005', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '035', '담당업무', 'IT시스템기술지원', '005', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '036', '담당업무', '빅데이터엔지니어링', '005', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '037', '담당업무', '인공지능서비스관리', '005', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '038', '담당업무', 'SW제품기획', '006', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '039', '담당업무', 'IT기술영업', '006', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '040', '담당업무', 'IT서비스기획', '006', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '041', '담당업무', 'IT품질관리', '007', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '042', '담당업무', 'IT테스트', '007', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '043', '담당업무', 'IT감리', '007', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '044', '담당업무', 'IT감사', '007', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '045', '담당업무', '정보보호관리', '008', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '046', '담당업무', '보안사고대응', '008', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('TASK', '047', '담당업무', 'IT기술교육', '009', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('ORG', '001', '소속', 'CEO', NULL, 1, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('ORG', '002', '소속', '경영지원팀', '001', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('ORG', '003', '소속', '기업부설연구소', '001', 2, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('ORG', '004', '소속', 'SI사업본부', '003', 3, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('ORG', '005', '소속', 'TS사업본부', '003', 3, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('ORG', '006', '소속', 'ITO사업부', '004', 4, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('ORG', '007', '소속', 'ITS사업부', '004', 4, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('ORG', '008', '소속', '영업2팀', '003', 3, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('ORG', '009', '소속', '클라우드사업', '005', 4, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('ORG', '010', '소속', 'TS사업', '005', 4, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('ORG', '011', '소속', '영업1팀', '006', 5, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('ORG', '012', '소속', '금융사업3팀', '006', 5, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('ORG', '013', '소속', '영남지사', '006', 5, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('ORG', '014', '소속', '금융사업2팀', '007', 5, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('ORG', '015', '소속', '금융사업1팀', '007', 5, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('ORG', '016', '소속', '솔루션사업', '007', 5, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('ORG', '017', '소속', 'DW사업', '007', 5, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('ORG', '018', '소속', '컨설팅사업', '007', 5, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('STUT', '001', '구분', '졸업', NULL, 0, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('STUT', '002', '구분', '졸업예정', NULL, 0, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('STUT', '003', '구분', '재학중', NULL, 0, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('STUT', '010', '구분', '고등학교', NULL, 0, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('STUT', '011', '구분', '대학교(2,3년)', NULL, 0, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('STUT', '012', '구분', '대학교(4년)', NULL, 0, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('STUT', '013', '구분', '대학원', NULL, 0, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('ROLE', '001', '사업역할', 'PM', NULL, 0, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('ROLE', '002', '사업역할', 'PMO', NULL, 0, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('ROLE', '003', '사업역할', 'PL', NULL, 0, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('ROLE', '004', '사업역할', 'PE', NULL, 0, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('ROLE', '005', '사업역할', 'PA', NULL, 0, SYSDATE(), 'admin');
INSERT INTO TB_COMMON_CODE (code_group_id, code_id, code_group_nm, code_value, parent_id, level, created_date, creator)
VALUES ('ROLE', '006', '사업역할', 'QA', NULL, 0, SYSDATE(), 'admin');

