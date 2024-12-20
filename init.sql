-- 연결 문자셋 설정
SET NAMES utf8mb4;

-- db 생성
CREATE DATABASE IF NOT EXISTS demo_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
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
) COMMENT ='직원 프로필 정보 테이블' CHARACTER SET utf8mb4
                           COLLATE utf8mb4_unicode_ci;

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
) COMMENT ='직원 프로필이력관리 테이블' CHARACTER SET utf8mb4
                            COLLATE utf8mb4_unicode_ci;

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
) COMMENT ='직원 학력 정보테이블' CHARACTER SET utf8mb4
                         COLLATE utf8mb4_unicode_ci;

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
) COMMENT ='직원 학력 이력관리 테이블' CHARACTER SET utf8mb4
                            COLLATE utf8mb4_unicode_ci;

CREATE TABLE TB_PROJECT_INFO
(
    user_id            VARCHAR(10) NOT NULL COMMENT '직원 아이디',
    project_seq        INT         NOT NULL COMMENT '사업 순번',
    project_nm         VARCHAR(20) NOT NULL COMMENT '사업명',
    project_start_date VARCHAR(8)  NOT NULL COMMENT '투입시작일',
    project_end_date   VARCHAR(8)  NOT NULL COMMENT '투입종료일',
    project_role       VARCHAR(3)  NOT NULL COMMENT '역할',
    project_client     VARCHAR(20) NOT NULL COMMENT '발주처',
    assigned_task_lar  VARCHAR(3)  NOT NULL COMMENT '담당업무(대분류)',
    assigned_task_mid  VARCHAR(3)  NOT NULL COMMENT '담당업무(소분류)',
    use_yn             CHAR(1)     NOT NULL DEFAULT 'Y' COMMENT '사용 여부',
    created_date       TIMESTAMP   NOT NULL COMMENT '생성일시',
    modified_date      TIMESTAMP   NOT NULL COMMENT '수정일시',
    creator            VARCHAR(10) NOT NULL COMMENT '생성자',
    modifier           VARCHAR(10) NOT NULL COMMENT '수정자',

    PRIMARY KEY (user_id, project_seq)
) COMMENT ='참여사업 정보테이블' CHARACTER SET utf8mb4
                        COLLATE utf8mb4_unicode_ci;

CREATE TABLE TB_PROJECT_INFO_HIST
(
    user_id            VARCHAR(10) NOT NULL COMMENT '직원 아이디',
    project_seq        INT         NOT NULL COMMENT '사업 순번',
    hist_seq           INT         NOT NULL COMMENT '이력 순번',
    project_nm         VARCHAR(20) COMMENT '사업명',
    project_start_date VARCHAR(8) COMMENT '투입시작일',
    project_end_date   VARCHAR(8) COMMENT '투입종료일',
    project_role       VARCHAR(3) COMMENT '역할',
    project_client     VARCHAR(20) COMMENT '발주처',
    assigned_task_lar  VARCHAR(3) COMMENT '담당업무(대분류)',
    assigned_task_mid  VARCHAR(3) COMMENT '담당업무(소분류)',
    created_date       TIMESTAMP   NOT NULL COMMENT '생성일시',
    creator            VARCHAR(10) NOT NULL COMMENT '생성자',

    PRIMARY KEY (user_id, project_seq, hist_seq)
) COMMENT ='참여사업 이력관리 테이블' CHARACTER SET utf8mb4
                           COLLATE utf8mb4_unicode_ci;

CREATE TABLE TB_USER_SKILL_INFO
(
    user_id       VARCHAR(10) NOT NULL COMMENT '직원 아이디',
    project_seq   INT         NOT NULL COMMENT '사업 순번',
    skill_id      INT         NOT NULL COMMENT '기술 아이디',
    skill_nm      VARCHAR(10) NOT NULL COMMENT '기술명',
    use_yn        CHAR(1)     NOT NULL DEFAULT 'Y' COMMENT '사용여부',
    created_date  TIMESTAMP   NOT NULL COMMENT '생성일시',
    modified_date TIMESTAMP   NOT NULL COMMENT '수정일시',
    creator       VARCHAR(10) NOT NULL COMMENT '생성자',
    modifier      VARCHAR(10) NOT NULL COMMENT '수정자',

    PRIMARY KEY (user_id, project_seq, skill_id)
) COMMENT ='직원 기술 정보테이블' CHARACTER SET utf8mb4
                         COLLATE utf8mb4_unicode_ci;

CREATE TABLE TB_USER_SKILL_INFO_HIST
(
    user_id      VARCHAR(10) NOT NULL COMMENT '직원 아이디',
    project_seq  INT         NOT NULL COMMENT '사업 순번',
    skill_id     INT         NOT NULL COMMENT '기술 아이디',
    hist_seq     INT         NOT NULL COMMENT '이력 순번',
    skill_nm     VARCHAR(10) COMMENT '기술명',
    created_date TIMESTAMP   NOT NULL COMMENT '생성일시',
    creator      VARCHAR(10) NOT NULL COMMENT '생성자',

    PRIMARY KEY (user_id, project_seq, skill_id, hist_seq)
) COMMENT ='직원 기술 이력관리 테이블' CHARACTER SET utf8mb4
                            COLLATE utf8mb4_unicode_ci;

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
) COMMENT ='직원 자격증 정보테이블' CHARACTER SET utf8mb4
                          COLLATE utf8mb4_unicode_ci;

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
) COMMENT ='직원 자격증 이력관리 테이블' CHARACTER SET utf8mb4
                             COLLATE utf8mb4_unicode_ci;

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
) COMMENT ='직원 근무지 정보테이블' CHARACTER SET utf8mb4
                          COLLATE utf8mb4_unicode_ci;

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
) COMMENT ='직원 근무지 이력관리 테이블' CHARACTER SET utf8mb4
                             COLLATE utf8mb4_unicode_ci;

CREATE TABLE TB_ATTACHMENT_INFO
(
    user_id        VARCHAR(10)  NOT NULL COMMENT '직원 아이디',
    file_seq       INT          NOT NULL COMMENT '파일 순번',
    file_ori_nm    VARCHAR(20)  NOT NULL COMMENT '로컬파일명',
    file_sver_nm   VARCHAR(50)  NOT NULL COMMENT '서버파일명',
    file_sver_path VARCHAR(100) NOT NULL COMMENT '파일 서버경로',
    file_extension VARCHAR(8)   NOT NULL COMMENT '파일확장자',
    use_yn         CHAR(1)      NOT NULL DEFAULT 'Y' COMMENT '사용여부',
    created_date   TIMESTAMP    NOT NULL COMMENT '생성일시',
    creator        VARCHAR(10)  NOT NULL COMMENT '생성자',

    PRIMARY KEY (user_id, file_seq)
) COMMENT ='첨부파일 정보테이블' CHARACTER SET utf8mb4
                        COLLATE utf8mb4_unicode_ci;

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
) COMMENT ='공통코드 테이블' CHARACTER SET utf8mb4
                      COLLATE utf8mb4_unicode_ci;

CREATE TABLE TB_USER_REFRESH_TOKEN_INFO
(
    user_id      VARCHAR(10)  NOT NULL COMMENT '직원 아이디',
    token        VARCHAR(256) NOT NULL COMMENT 'REFRESH TOKEN',
    created_date TIMESTAMP    NOT NULL COMMENT '생성일시'
) COMMENT ='TOKEN 테이블' CHARACTER SET utf8mb4
                       COLLATE utf8mb4_unicode_ci;

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
    CREATE TEMPORARY TABLE temp_merged_periods (
                                                   project_start_date DATE,
                                                   project_end_date DATE
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
            FROM (
                     SELECT
                         LEAST(start_date, t1.project_start_date) AS project_start_date,
                         GREATEST(end_date, t1.project_end_date) AS project_end_date
                     FROM temp_unmerged_periods t1
                     WHERE end_date >= t1.project_start_date
                       AND start_date <= t1.project_end_date
                 ) a
            ORDER BY project_end_date DESC
            LIMIT 1;

            -- 병합된 데이터 삭제
            DELETE FROM temp_unmerged_periods
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

