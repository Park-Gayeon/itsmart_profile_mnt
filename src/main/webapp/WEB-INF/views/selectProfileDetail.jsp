<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <%-- 웹 앱 반응형 --%>
    <meta name="viewport" content="width=device-width" , initial-scale="1">
    <link rel="stylesheet" href="/css/bootstrap.css">
    <link rel="stylesheet" href="/css/basic.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <title>직원 프로필관리 시스템</title>
</head>
<style>
    tr td:first-child input{
        text-align: center;
    }
</style>
<body>
<!-- header.jsp -->
<%@ include file="layout/header.jsp" %>
<!-- header.jsp -->

<jsp:useBean id="now" class="java.util.Date"/>
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today"/>

<!-- main-content -->
<div class="content">
    <div class="container">
        <!-- 상세화면 -->
        <div id="viewMode" style="display: block">
            <!-- 프로필 -->
            <div class="form-floating">
                <h2 class="header">프로필
                    <div class="description">
                        <c:if test="${userRole[0] eq 'ROLE_ADMIN'}">
                        <button type="button" class="btn btn-success" onclick=location.href="/profile/info/list">
                            <span>목록가기</span>
                        </button>
                        </c:if>
                        
                        <c:if test="${profile.user_id != loginUser && userRole[0] eq 'ROLE_ADMIN'}">
                            <button type="button" class="btn btn-danger" onclick="usrDelete()">
                                <span>삭제</span>
                            </button>
                        </c:if>
                        <c:if test="${profile.user_id == loginUser}">
                            <button type="button" class="btn btn-warning" onclick="goModify()">
                                <span>수정</span>
                            </button>
                        </c:if>
                    </div>
                </h2>
                <div style="float: right; display: block; width: 344px; text-align: right; margin-bottom: 10px;">
                	<select class="form-select" aria-label="Default select example" id="excelTempate" style="width: 150px; float: left;">
         	  			<option value="0" selected>template.xlsx</option>
			  			<c:forEach var="attachFileList" items="${attachFileList}">
                     		<option value="${attachFileList.file_seq}">${attachFileList.file_ori_nm}</option>
                 		</c:forEach>
					</select>
			
                    <button type="button" class="btn btn-secondary" onclick="excel()" style="float: left; margin-left: 10px;">
                    	<span>엑셀</span>
                   	</button>
                   	
                   	<button type="button" class="btn btn-dark" onclick="openExcelTemplatePop()" style="float: right;">
                    	<span>엑셀템플릿업로드</span>
                   	</button>
                </div>
                <div class="container-info row-box row mb-5 g-0" style="clear: both;">
                    <!-- 인적사항 -->
                    <header class="description mb-sm-3">인적사항
                        <c:if test="${userRole[0] eq 'ROLE_ADMIN'}">
                            <div class="right-group">
                                <a class="nav-link" style="font-size: 12px; color: var(--bs-danger);" href="#" onclick="initPw()">비밀번호초기화</a>
                            </div>
                        </c:if>
                    </header>
                    <div class="row-box px-5 row mb-5 g-0">
                        <!-- 사진 -->
                        <div class="col-sm text-center">
                            <c:choose>
                                <c:when test="${profile.fileInfo.file_sver_nm eq null || profile.fileInfo.file_sver_nm eq ''}">
                                    <img class="img-profile detail" src="/images/image.png"/>
                                </c:when>
                                <c:otherwise>
                                    <img class="img-profile detail" src="/${profile.fileInfo.file_sver_nm}"/>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <!-- 사진 끝 -->
                        <!-- 개인정보 -->
                        <div class="col-sm-10 g-0">
                            <!-- 첫번째 row -->
                            <div class="row mb-2 g-0">
                                <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                    <span>이름</span>
                                    <input type="text" value="${profile.user_nm}" readonly/>
                                </div>
                                <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                    <span>생년월일</span>
                                    <input type="text" class="dateFmt" value="${profile.user_birth}" readonly/>
                                </div>
                                <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                    <span>휴대전화</span>
                                    <input type="text" class="telFmt" value="${profile.user_phone}" readonly/>
                                </div>
                                <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                    <span>직원ID</span>
                                    <input type="text" value="${profile.user_id}" readonly/>
                                </div>
                                <div class="col-sm common-box common-box input-box pt-4 me-2">
                                    <span>이메일</span>
                                    <input type="text" value="${profile.user_id}@itsmart.co.kr" readonly/>
                                </div>
                            </div>
                            <!-- 두번째 row -->
                            <div class="row mb-2 g-0">
                                <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                    <span>소속</span>
                                    <input type="text" value="${profile.user_department_nm}" readonly/>
                                </div>
                                <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                    <span>직위/직급</span>
                                    <input type="text" value="${profile.user_position_nm}" readonly/>
                                </div>
                                <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                    <span>입사일자</span>
                                    <input type="text" class="dateFmt" value="${profile.hire_date}" readonly/>
                                </div>
                                <div class="col-sm common-box common-box input-box pt-4 me-2">
                                    <span>주소</span>
                                    <input type="text" value="${profile.user_address}" readonly/>
                                </div>
                            </div>
                        </div>
                        <!-- 개인정보 끝 -->
                    </div>
                    <!-- 인적사항 끝 -->
                    <hr>
                    <!-- 학력 -->
                    <div class="mb-5 g-0">
                        <header class="description mb-sm-3">학력</header>
                        <div class="col-sm px-5 g-0">
                            <c:choose>
                                <c:when test="${not empty profile.educationList}">
                                    <c:forEach var="education" items="${profile.educationList}">
                                        <div class="row mb-2 g-0">
                                            <div class="col-sm-auto common-box input-box pt-4 me-1">
                                                <span>학교구분</span>
                                                <select class="form-select noneBorder"
                                                        style="background-color: transparent" disabled>
                                                    <option value="010" ${education.school_gubun == '010' ? 'selected' : ''}>
                                                        고등학교
                                                    </option>
                                                    <option value="011" ${education.school_gubun == '011' ? 'selected' : ''}>
                                                        대학교(2,3년)
                                                    </option>
                                                    <option value="012" ${education.school_gubun == '012' ? 'selected' : ''}>
                                                        대학교(4년)
                                                    </option>
                                                    <option value="013" ${education.school_gubun == '013' ? 'selected' : ''}>
                                                        대학원
                                                    </option>
                                                </select>
                                            </div>
                                            <div class="col-sm common-box input-box pt-4">
                                                <span>학교명</span>
                                                <input type="text" value="${education.school_nm}" readonly/>
                                            </div>
                                            <div class="col-sm-2 common-box input-box pt-4 me-1"
                                                 style="margin-left: -1px;">
                                                <span>전공명</span>
                                                <input type="text" value="${education.major}" readonly/>
                                            </div>
                                            <div class="col-sm-2 common-box input-box pt-4">
                                                <span>입학일자</span>
                                                <input type="text" class="dateFmt"
                                                       value="${education.school_start_date}"
                                                       readonly/>
                                            </div>
                                            <div class="col-sm-2 common-box input-box pt-4 me-1"
                                                 style="margin-left:-1px;">
                                                <span>졸업일자</span>
                                                <input type="text" class="dateFmt" value="${education.school_end_date}"
                                                       readonly/>
                                            </div>
                                            <div class="col-sm-1 common-box input-box pt-4 me-1">
                                                <span>학점</span>
                                                <input type="text" value="${education.total_grade}" readonly/>
                                            </div>
                                            <div class="col-sm-auto common-box input-box pt-4 me-2">
                                                <span>졸업상태</span>
                                                <select class="form-select noneBorder"
                                                        style="background-color: transparent" disabled>
                                                    <option value="001" ${education.grad_status == '001' ? 'selected' : ''}>
                                                        졸업
                                                    </option>
                                                    <option value="002" ${education.grad_status == '002' ? 'selected' : ''}>
                                                        졸업예정
                                                    </option>
                                                    <option value="003" ${education.grad_status == '003' ? 'selected' : ''}>
                                                        재학중
                                                    </option>
                                                </select>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-center">
                                        <p>작성된 내용이 없습니다</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <!-- 학력 끝 -->
                </div>
            </div>
            <!-- 프로필 끝 -->
            <!-- 자격증 -->
            <div class="form-floating">
                <h2 class="header">자격증</h2>
                <div class="container-info row-box row mb-5 g-0">
                    <div class="table-responsive px-5">
                        <table class="table table-hover mb-5">
                            <colgroup>
                                <col style="width: 10%;">
                                <col style="width: auto;">
                                <col style="width: 25%;">
                                <col style="width: 15%;">
                                <col style="width: 15%;">
                            </colgroup>
                            <thead>
                            <tr>
                                <th scope="col">NO</th>
                                <th scope="col">자격증명</th>
                                <th scope="col">발행기관</th>
                                <th scope="col">취득일자</th>
                                <th scope="col">만기일자</th>
                            </tr>
                            </thead>
                            <c:choose>
                                <c:when test="${empty profile.qualificationList}">
                                    <tbody>
                                    <tr>
                                        <td colspan="5" class="figure-caption">작성된 내용이 없습니다</td>
                                    </tr>
                                    </tbody>
                                </c:when>
                                <c:otherwise>
                                    <tbody class="table-group-divider">
                                    <c:forEach var="qualification" items="${profile.qualificationList}"
                                               varStatus="qlStatus">
                                        <fmt:parseDate var="acquisition_date" value="${qualification.acquisition_date}"
                                                       pattern="yyyyMMdd"/>
                                        <fmt:parseDate var="expiry_date" value="${qualification.expiry_date}"
                                                       pattern="yyyyMMdd"/>
                                        <fmt:formatDate var="acquisition_date" value="${acquisition_date}"
                                                        pattern="yyyy-MM-dd"/>
                                        <fmt:formatDate var="expiry_date" value="${expiry_date}" pattern="yyyy-MM-dd"/>
                                        <tr>
                                            <td>${qlStatus.count}</td>
                                            <td>${qualification.qualification_nm}</td>
                                            <td>${qualification.issuer}</td>
                                            <td>${acquisition_date}</td>
                                            <td>${expiry_date}</td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </c:otherwise>
                            </c:choose>
                        </table>
                    </div>
                </div>
            </div>
            <!-- 자격증 끝 -->
            <!-- 경력 -->
            <div class="form-floating">
                <h2 class="header">경력</h2>
                <div class="container-info row-box row mb-5 g-0">
                    <!-- 근무경력 -->
                    <div class="row mb-5 g-0">
                        <header class="description mb-sm-3">
                            <div class="left-group">
                                근무경력
                                <span name="wk_career"></span>
                            </div>
                        </header>
                        <div class="table-responsive px-5">
                            <table class="table table-hover mb-5">
                                <colgroup>
                                    <col style="width: 10%;">
                                    <col style="width: auto;">
                                    <col style="width: 10%;">
                                    <col style="width: 15%;">
                                    <col style="width: 15%;">
                                    <col style="width: 15%;">
                                </colgroup>
                                <thead>
                                <tr>
                                    <th scope="col">NO</th>
                                    <th scope="col">회사명</th>
                                    <th scope="col">직급</th>
                                    <th scope="col">담당업무</th>
                                    <th scope="col">입사일자</th>
                                    <th scope="col">퇴사일자</th>
                                </tr>
                                </thead>
                                <c:choose>
                                    <c:when test="${empty profile.workExperienceList}">
                                        <tbody>
                                        <tr>
                                            <td colspan="6" class="figure-caption">작성된 내용이 없습니다</td>
                                        </tr>
                                        </tbody>
                                    </c:when>
                                    <c:otherwise>
                                        <tbody class="table-group-divider">
                                        <c:forEach var="work" items="${profile.workExperienceList}"
                                                   varStatus="wkStatus">
                                            <fmt:parseDate var="work_start_date" value="${work.work_start_date}"
                                                           pattern="yyyyMMdd"/>
                                            <fmt:parseDate var="work_end_date" value="${work.work_end_date}"
                                                           pattern="yyyyMMdd"/>
                                            <fmt:formatDate var="work_start_date" value="${work_start_date}"
                                                            pattern="yyyy-MM-dd"/>
                                            <fmt:formatDate var="work_end_date" value="${work_end_date}"
                                                            pattern="yyyy-MM-dd"/>
                                            <tr>
                                                <td>${wkStatus.count}</td>
                                                <td>${work.work_place}</td>
                                                <td>${work.work_position}</td>
                                                <td>${work.work_assigned_task}</td>
                                                <td>${work_start_date}</td>
                                                <td>${work_end_date}</td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </c:otherwise>
                                </c:choose>
                            </table>
                        </div>
                    </div>
                    <!-- 근무경력 끝 -->
                    <hr>
                    <!-- 수행경력 -->
                    <div class="mb-5 g-0">
                        <header class="description mb-sm-3">
                            <div class="left-group">
                                수행경력
                                <span name="pj_career"></span>
                            </div>
                        </header>
                        <div class="table-responsive px-5">
                            <header class="basic-medium"><span class="star">*</span>현재 진행중인 사업 내역</header>
                            <table class="table table-hover mb-5">
                                <colgroup>
                                    <col style="width: 5%;">
                                    <col style="width: 20%;">
                                    <col style="width: auto;">
                                    <col style="width: 10%;">
                                    <col style="width: 25%;">
                                    <col style="width: 10%;">
                                    <col style="width: 6%;">
                                <colgroup>
                                <thead>
                                <tr>
                                    <th scope="col">NO</th>
                                    <th scope="col">발주처</th>
                                    <th scope="col">사업명</th>
                                    <th scope="col">참여기간</th>
                                    <th scope="col">담당업무</th>
                                    <th scope="col">역할</th>
                                    <th scope="col">기술</th>
                                </tr>
                                </thead>
                                <c:choose>
                                    <c:when test="${empty profile.projectList}">
                                        <tbody>
                                        <tr>
                                            <td colspan="8" class="figure-caption">진행중인 사업이 없습니다</td>
                                        </tr>
                                        </tbody>
                                    </c:when>
                                    <c:otherwise>
                                        <tbody class="table-group-divider">
                                        <c:set var="count_ing" value="1"/>
                                        <c:forEach var="project_ing" items="${profile.projectList}"
                                                   varStatus="pjStatus">
                                            <fmt:parseDate var="project_start_date"
                                                           value="${project_ing.project_start_date}"
                                                           pattern="yyyyMMdd"/>
                                            <fmt:formatDate value="${project_start_date}" pattern="yyyy-MM-dd"
                                                            var="project_start_date"/>
                                            <fmt:parseDate var="project_end_date"
                                                           value="${project_ing.project_end_date}"
                                                           pattern="yyyyMMdd"/>
                                            <fmt:formatDate value="${project_end_date}" pattern="yyyy-MM-dd"
                                                            var="project_end_date"/>
                                            <c:if test="${today <= project_end_date}">
                                                <tr>
                                                    <td>${count_ing}</td>
                                                    <td>${project_ing.project_client}</td>
                                                    <td>${project_ing.project_nm}</td>
                                                    <td>${project_start_date}
                                                        ~ ${project_end_date}</td>
                                                    <td>${project_ing.assigned_task_lar_nm}
                                                        > ${project_ing.assigned_task_mid_nm}</td>
                                                    <td>${project_ing.project_role_nm}</td>
                                                    <td>
                                                        <button type="button" class="btn btn-warning"
                                                                onclick="viewSkill(${project_ing.project_seq}, '0')">
                                                            <span>보기</span>
                                                        </button>
                                                    </td>
                                                </tr>
                                                <c:set var="count_ing" value="${count_ing+1}"/>
                                            </c:if>
                                        </c:forEach>
                                        </tbody>
                                    </c:otherwise>
                                </c:choose>
                            </table>
                            <header class="basic-medium"><span class="star">*</span>과거 사업 내역</header>
                            <table class="table table-hover">
                                <colgroup>
                                    <col style="width: 5%;">
                                    <col style="width: 20%;">
                                    <col style="width: auto;">
                                    <col style="width: 10%;">
                                    <col style="width: 25%;">
                                    <col style="width: 10%;">
                                    <col style="width: 6%;">
                                <colgroup>
                                <thead>
                                <tr>
                                    <th scope="col">NO</th>
                                    <th scope="col">발주처</th>
                                    <th scope="col">사업명</th>
                                    <th scope="col">참여기간</th>
                                    <th scope="col">담당업무</th>
                                    <th scope="col">역할</th>
                                    <th scope="col">기술</th>
                                </tr>
                                </thead>
                                <c:choose>
                                    <c:when test="${empty profile.projectList}">
                                        <tbody>
                                        <tr>
                                            <td colspan="8" class="figure-caption">참여했던 사업이 없습니다</td>
                                        </tr>
                                        </tbody>
                                    </c:when>
                                    <c:otherwise>
                                        <tbody class="table-group-divider">
                                        <c:set var="count_hist" value="1"/>
                                        <c:forEach var="project_hist" items="${profile.projectList}"
                                                   varStatus="pjStatus">
                                            <fmt:parseDate var="project_start_date"
                                                           value="${project_hist.project_start_date}"
                                                           pattern="yyyyMMdd"/>
                                            <fmt:formatDate value="${project_start_date}" pattern="yyyy-MM-dd"
                                                            var="project_start_date"/>
                                            <fmt:parseDate var="project_end_date"
                                                           value="${project_hist.project_end_date}"
                                                           pattern="yyyyMMdd"/>
                                            <fmt:formatDate value="${project_end_date}" pattern="yyyy-MM-dd"
                                                            var="project_end_date"/>
                                            <c:if test="${today > project_end_date}">
                                                <tr>
                                                    <td>${count_hist}</td>
                                                    <td>${project_hist.project_client}</td>
                                                    <td>${project_hist.project_nm}</td>
                                                    <td>${project_start_date}
                                                        ~ ${project_end_date}</td>
                                                    <td>${project_hist.assigned_task_lar_nm}
                                                        > ${project_hist.assigned_task_mid_nm}</td>
                                                    <td>${project_hist.project_role_nm}</td>
                                                    <td>
                                                        <button type="button" class="btn btn-warning"
                                                                onclick="viewSkill(${project_hist.project_seq}, '0')">
                                                            <span>보기</span>
                                                        </button>
                                                    </td>
                                                </tr>
                                                <c:set var="count_hist" value="${count_hist+1}"/>
                                            </c:if>
                                        </c:forEach>
                                        </tbody>
                                    </c:otherwise>
                                </c:choose>
                            </table>
                        </div>
                    </div>
                    <!-- 수행경력 끝-->
                </div>
            </div>
            <!-- 경력 끝 -->
        </div>
        <!-- 상세화면 끝 -->
        <!-- 수정화면 -->
        <div id="editMode" style="display: none">
            <!-- 프로필 -->
            <form id="profile">
                <div class="form-floating">
                    <h2 class="header">프로필
                        <div class="description">
                            <span class="basic-medium"><span class="star">*</span> 필수 입력 정보입니다.</span>
                            <button type="button" class="btn btn-secondary" onclick="back();">
                                <span>뒤로가기</span>
                            </button>
                            <button type="button" class="btn btn-dark" onclick="excelUpload();">
                                <span>일괄업로드</span>
                            </button>
                            <button type="button" class="btn btn-success" data-name="profile" onclick="goSave(this);">
                                <span>저장</span>
                            </button>
                        </div>
                    </h2>
                    <div class="container-info row-box row mb-5 g-0">
                        <!-- 인적사항 -->
                        <header class="description mb-sm-3">인적사항</header>
                        <div class="row-box px-5 row mb-5 g-0">
                            <!-- 사진 -->
                            <div class="col-sm d-sm-flex justify-content-sm-center">
                                <c:choose>
                                    <c:when test="${profile.fileInfo.file_sver_nm eq null || profile.fileInfo.file_sver_nm eq ''}">
                                        <img class="img-profile edit" src="/images/image.png"/>
                                    </c:when>
                                    <c:otherwise>
                                        <img class="img-profile edit" src="/${profile.fileInfo.file_sver_nm}"/>
                                    </c:otherwise>
                                </c:choose>
                                <label for="imgFile" class="align-self-end">
                                    <div class="img-profile-btn do-hyeon-regular">+</div>
                                </label>
                                <input type="file" id="imgFile" name="imgFile" class="d-none"
                                       accept=".jpg, .png, .jpeg"/>
                            </div>
                            <!-- 사진 끝 -->
                            <!-- 개인정보 -->
                            <div class="col-10 g-0">
                                <!-- 첫번째 row -->
                                <div class="row mb-2 g-0">
                                    <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                        <span>이름</span>
                                        <input type="text" name="user_nm" value="${profile.user_nm}" readonly/>
                                    </div>
                                    <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                        <span>생년월일 <span class="star">*</span></span>
                                        <input type="text" name="user_birth" class="dateFmt" maxlength="10"
                                               value="${profile.user_birth}"/>
                                    </div>
                                    <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                        <span>휴대전화 <span class="star">*</span></span>
                                        <input type="text" name="user_phone" class="telFmt" maxlength="13"
                                               value="${profile.user_phone}"/>
                                    </div>
                                    <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                        <span>직원ID</span>
                                        <input type="text" name="user_id" value="${profile.user_id}" readonly/>
                                    </div>
                                    <div class="col-sm common-box common-box input-box pt-4 me-2">
                                        <span>이메일</span>
                                        <input type="text" value="${profile.user_id}@itsmart.co.kr" readonly/>
                                    </div>
                                </div>
                                <!-- 두번째 row -->
                                <div class="row mb-2 g-0">
                                    <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                        <span>소속 <span class="star">*</span></span>
                                        <select name="user_department" class="form-select noneBorder">
                                            <c:forEach var="orgList" items="${orgList}">
                                                <option value="${orgList.code_id}"
                                                        <c:if test="${orgList.code_id eq profile.user_department}">selected</c:if>>${orgList.code_value}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                        <span>직위/직급 <span class="star">*</span></span>
                                        <select class="form-select noneBorder" name="user_position">
                                            <c:forEach var="psitList" items="${psitList}">
                                                <option value="${psitList.code_id}"
                                                        <c:if test="${psitList.code_id eq profile.user_position}">selected</c:if>>${psitList.code_value}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                        <span>입사일자</span>
                                        <input type="text" name="hire_date" class="dateFmt" maxlength="10"
                                               value="${profile.hire_date}" readonly/>
                                    </div>
                                    <div class="col-sm common-box common-box input-box pt-4 me-2">
                                        <span>주소 <span class="star">*</span></span>
                                        <input type="text" name="user_address" maxlength="40"
                                               value="${profile.user_address}"/>
                                    </div>
                                </div>
                            </div>
                            <!-- 개인정보 끝 -->
                        </div>
                        <!-- 인적사항 끝 -->
                        <hr>
                        <!-- 학력 -->
                        <div id="schFrm" class="mb-5 g-0">
                            <header class="description mb-sm-3">학력
                                <div class="primary-btn">
                                    <button type="button" class="btn btn-outline-primary add_field"
                                            data-target="schFrm">
                                        <span>+</span>
                                    </button>
                                </div>
                            </header>
                            <div class="col-sm ps-5 g-0 add-main">
                                <c:choose>
                                    <c:when test="${not empty profile.educationList}">
                                        <c:forEach var="education" items="${profile.educationList}" varStatus="status">
                                            <div class="row mb-2 g-0 add" id="educationList_${status.index}">
                                                <input type="hidden"
                                                       name="educationList[${status.index}].school_seq"
                                                       class="seq" value="${education.school_seq}"/>
                                                <div class="col-sm-auto common-box input-box pt-4 me-1">
                                                    <span>학교구분</span>
                                                    <select name="educationList[${status.index}].school_gubun"
                                                            class="form-select noneBorder schGb">
                                                        <option value="">-</option>
                                                        <option value="010" ${education.school_gubun == '010' ? 'selected' : ''}>
                                                            고등학교
                                                        </option>
                                                        <option value="011" ${education.school_gubun == '011' ? 'selected' : ''}>
                                                            대학교(2,3년)
                                                        </option>
                                                        <option value="012" ${education.school_gubun == '012' ? 'selected' : ''}>
                                                            대학교(4년)
                                                        </option>
                                                        <option value="013" ${education.school_gubun == '013' ? 'selected' : ''}>
                                                            대학원
                                                        </option>
                                                    </select>
                                                </div>
                                                <div class="col-sm common-box input-box pt-4">
                                                    <span>학교명</span>
                                                    <input type="text" name="educationList[${status.index}].school_nm"
                                                           maxlength="15"
                                                           value="${education.school_nm}"/>
                                                </div>
                                                <div class="col-sm-2 common-box input-box pt-4 me-1"
                                                     style="margin-left: -1px;">
                                                    <span>전공명</span>
                                                    <input type="text" name="educationList[${status.index}].major"
                                                           maxlength="18" value="${education.major}"/>
                                                </div>
                                                <div class="col-sm-2 common-box input-box pt-4">
                                                    <span>입학일자</span>
                                                    <input type="text"
                                                           name="educationList[${status.index}].school_start_date"
                                                           class="dateFmt"
                                                           maxlength="10"
                                                           value="${education.school_start_date}"/>
                                                </div>
                                                <div class="col-sm-2 common-box input-box pt-4 me-1"
                                                     style="margin-left:-1px;">
                                                    <span>졸업일자</span>
                                                    <input type="text"
                                                           name="educationList[${status.index}].school_end_date"
                                                           class="dateFmt"
                                                           maxlength="10"
                                                           value="${education.school_end_date}"/>
                                                </div>
                                                <div class="col-sm-1 common-box input-box pt-4 me-1">
                                                    <span>학점</span>
                                                    <input type="text"
                                                           name="educationList[${status.index}].total_grade"
                                                           class="grade" maxlength="3"
                                                           onkeyup="onlyDot(this)" value="${education.total_grade}"/>
                                                </div>
                                                <div class="col-sm-auto common-box input-box pt-4 me-2">
                                                    <span>졸업상태</span>
                                                    <select name="educationList[${status.index}].grad_status"
                                                            class="form-select noneBorder">
                                                        <option value="">-</option>
                                                        <option value="001" ${education.grad_status == '001' ? 'selected' : ''}>
                                                            졸업
                                                        </option>
                                                        <option value="002" ${education.grad_status == '002' ? 'selected' : ''}>
                                                            졸업예정
                                                        </option>
                                                        <option value="003" ${education.grad_status == '003' ? 'selected' : ''}>
                                                            재학중
                                                        </option>
                                                    </select>
                                                </div>
                                                <c:if test="${status.count eq 1}">
                                                    <div class="col-sm-auto align-content-center ps-3">
                                                        <button type="button" class="btn btn-danger clear_field"
                                                                onclick="clearField(this)"><span>-</span>
                                                        </button>
                                                    </div>
                                                </c:if>
                                                <c:if test="${status.count ne 1}">
                                                    <div class="col-sm-auto align-content-center ps-3">
                                                        <button type="button"
                                                                class="btn btn-outline-danger remove-field"
                                                                data-target="schFrm"><span>-</span>
                                                        </button>
                                                    </div>
                                                </c:if>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="row mb-2 g-0 add" id="educationList_0">
                                            <input type="hidden" name="educationList[0].school_seq"
                                                   class="seq" value="1">
                                            <div class="col-sm-auto common-box input-box pt-4 me-1">
                                                <span>학교구분</span>
                                                <select name="educationList[0].school_gubun"
                                                        class="form-select noneBorder schGb">
                                                    <option value="">-</option>
                                                    <option value="010">고등학교</option>
                                                    <option value="011">대학교(2,3년)</option>
                                                    <option value="012">대학교(4년)</option>
                                                    <option value="013">대학원</option>
                                                </select>
                                            </div>
                                            <div class="col-sm common-box input-box pt-4">
                                                <span>학교명</span>
                                                <input type="text" name="educationList[0].school_nm" maxlength="15"/>
                                            </div>
                                            <div class="col-sm-2 common-box input-box pt-4 me-1"
                                                 style="margin-left: -1px;">
                                                <span>전공명</span>
                                                <input type="text" name="educationList[0].major" maxlength="18"/>
                                            </div>
                                            <div class="col-sm-2 common-box input-box pt-4">
                                                <span>입학일자</span>
                                                <input type="text" name="educationList[0].school_start_date"
                                                       class="dateFmt"/>
                                            </div>
                                            <div class="col-sm-2 common-box input-box pt-4 me-1"
                                                 style="margin-left: -1px;">
                                                <span>졸업일자</span>
                                                <input type="text" name="educationList[0].school_end_date"
                                                       class="dateFmt"/>
                                            </div>
                                            <div class="col-sm-1 common-box input-box pt-4 me-1">
                                                <span>학점</span>
                                                <input type="text" name="educationList[0].total_grade" class="grade"
                                                       maxlength="3"
                                                       onkeyup="onlyDot(this)"/>
                                            </div>
                                            <div class="col-sm-auto common-box input-box pt-4 me-2">
                                                <span>졸업상태</span>
                                                <select name="educationList[0].grad_status"
                                                        class="form-select noneBorder">
                                                    <option value="">-</option>
                                                    <option value="001">졸업</option>
                                                    <option value="002">졸업예정</option>
                                                    <option value="003">재학중</option>
                                                </select>
                                            </div>
                                            <div class="col-sm-auto align-content-center ps-3">
                                                <button type="button" class="btn btn-danger clear_field"
                                                        onclick="clearField(this)">
                                                    <span>-</span>
                                                </button>
                                            </div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <!-- 학력 끝 -->
                    </div>
                </div>
            </form>
            <!-- 프로필 끝-->
            <!-- 자격증 -->
            <form id="qualification">
                <div id="qlFrm">
                    <h2 class="header">자격증
                        <span>
                            <button type="button" class="btn btn-outline-primary add_field"
                                    data-target="qlFrm"><span>+</span></button>
                        <button type="button" class="btn btn-success" data-name="qualification"
                                onclick="goSave(this)"><span>저장</span></button>
                    </span>
                    </h2>
                    <div class="container-info row-box row mb-5 g-0">
                        <div class="table-responsive px-5">
                            <table class="table table-hover mb-5">
                                <colgroup>
                                    <col style="width: 10%;">
                                    <col style="width: auto;">
                                    <col style="width: 25%;">
                                    <col style="width: 15%;">
                                    <col style="width: 15%;">
                                    <col style="width: 10%;">
                                </colgroup>
                                <thead>
                                <tr>
                                    <th scope="col">NO</th>
                                    <th scope="col">자격증명</th>
                                    <th scope="col">발행기관</th>
                                    <th scope="col">취득일자</th>
                                    <th scope="col">만기일자</th>
                                    <th scope="col"></th>
                                </tr>
                                </thead>
                                <c:choose>
                                    <c:when test="${empty profile.qualificationList}">
                                        <tbody class="table-group-divider add-main">
                                        <tr class="add" id="qualificationList_0">
                                            <td>1</td>
                                            <input type="hidden" class="seq"
                                                   name="qualificationList[0].qualification_seq"
                                                   value="1"/>
                                            <td><input type="text"
                                                       name="qualificationList[0].qualification_nm"
                                                       maxlength="18"/></td>
                                            <td><input type="text"
                                                       name="qualificationList[0].issuer"
                                                       maxlength="18"/></td>
                                            <td><input type="text" class="dateFmt"
                                                       name="qualificationList[0].acquisition_date"
                                                       maxlength="10"/></td>
                                            <td><input type="text" class="dateFmt"
                                                       name="qualificationList[0].expiry_date"
                                                       maxlength="10"/></td>
                                            <td class="text-center">
                                                <button type="button" class="btn btn-danger clear_field"
                                                        onclick="clearField(this)"><span>-</span>
                                                </button>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </c:when>
                                    <c:otherwise>
                                        <tbody class="table-group-divider add-main">
                                        <c:forEach var="qualification" items="${profile.qualificationList}"
                                                   varStatus="qlStatus">
                                            <tr class="add" id="qualificationList_${qlStatus.index}">
                                                <td>${qlStatus.count}</td>
                                                <input type="hidden" class="seq"
                                                       name="qualificationList[${qlStatus.index}].qualification_seq"
                                                       value="${qualification.qualification_seq}"/>
                                                <td><input type="text"
                                                           name="qualificationList[${qlStatus.index}].qualification_nm"
                                                           maxlength="18"
                                                           value="${qualification.qualification_nm}"/></td>
                                                <td><input type="text"
                                                           name="qualificationList[${qlStatus.index}].issuer"
                                                           maxlength="18" value="${qualification.issuer}"/></td>
                                                <td><input type="text" class="dateFmt"
                                                           name="qualificationList[${qlStatus.index}].acquisition_date"
                                                           maxlength="10"
                                                           value="${qualification.acquisition_date}"/></td>
                                                <td><input type="text" class="dateFmt"
                                                           name="qualificationList[${qlStatus.index}].expiry_date"
                                                           maxlength="10"
                                                           value="${qualification.expiry_date}"/></td>
                                                <td class="text-center">
                                                    <c:choose>
                                                        <c:when test="${qlStatus.index == 0}">
                                                            <button type="button" class="btn btn-danger clear_field"
                                                                    onclick="clearField(this)"><span>-</span>
                                                            </button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button type="button"
                                                                    class="btn btn-outline-danger remove-field"
                                                                    data-target="qlFrm"><span>-</span>
                                                            </button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </c:otherwise>
                                </c:choose>
                            </table>
                        </div>
                    </div>
                </div>
            </form>
            <!-- 자격증 끝 -->
            <!-- 경력 -->
            <div class="form-floating">
                <h2 class="header">경력</h2>
                <div class="container-info row-box row mb-5 g-0">
                    <!-- 근무경력 -->
                    <form id="workExperience">
                        <div id="workFrm" class="mb-5 px-sm-0 g-0">
                            <header class="description mb-sm-3">
                                <div class="left-group">
                                    근무경력
                                    <span name="wk_career"></span>
                                </div>
                                <div class="right-group">
                                    <span>
                                        <button type="button" class="btn btn-outline-primary add_field"
                                                data-target="workFrm"><span>+</span>
                                        </button>
                                        <button type="button" class="btn btn-success"
                                                data-name="workExperience" onclick="goSave(this)"><span>저장</span>
                                        </button>
                                    </span>
                                </div>
                            </header>
                            <div class="table-responsive px-5">
                                <table class="table table-hover mb-5">
                                    <colgroup>
                                        <col style="width: 10%;">
                                        <col style="width: auto;">
                                        <col style="width: 10%;">
                                        <col style="width: 15%;">
                                        <col style="width: 15%;">
                                        <col style="width: 15%;">
                                        <col style="width: 10%;">
                                    </colgroup>
                                    <thead>
                                    <tr>
                                        <th scope="col">NO</th>
                                        <th scope="col">회사명</th>
                                        <th scope="col">직급</th>
                                        <th scope="col">담당업무</th>
                                        <th scope="col">입사일자</th>
                                        <th scope="col">퇴사일자</th>
                                        <th scope="col"></th>
                                    </tr>
                                    </thead>
                                    <c:choose>
                                        <c:when test="${empty profile.workExperienceList}">
                                            <tbody class="table-group-divider add-main">
                                            <tr class="add" id="workExperienceList_0">
                                                <td>1</td>
                                                <input type="hidden" class="seq"
                                                       name="workExperienceList[0].work_seq"
                                                       value="1"/>
                                                <td><input type="text"
                                                           name="workExperienceList[0].work_place"
                                                           maxlength="18"/>
                                                </td>
                                                <td><input type="text"
                                                           name="workExperienceList[0].work_position"
                                                           maxlength="8"/>
                                                </td>
                                                <td><input type="text"
                                                           name="workExperienceList[0].work_assigned_task"
                                                           maxlength="18"/>
                                                </td>
                                                <td><input type="text" class="dateFmt"
                                                           name="workExperienceList[0].work_start_date"
                                                           maxlength="10"/>
                                                </td>
                                                <td><input type="text" class="dateFmt"
                                                           name="workExperienceList[0].work_end_date"
                                                           maxlength="10"/>
                                                </td>
                                                <td class="text-center">
                                                    <button type="button" class="btn btn-danger clear_field"
                                                            onclick="clearField(this)"><span>-</span>
                                                    </button>
                                                </td>
                                            </tr>
                                            </tbody>
                                        </c:when>
                                        <c:otherwise>
                                            <tbody class="table-group-divider add-main">
                                            <c:forEach var="work" items="${profile.workExperienceList}"
                                                       varStatus="wkStatus">
                                                <tr class="add" id="workExperienceList_${wkStatus.index}">
                                                    <td>${wkStatus.count}</td>
                                                    <input type="hidden" class="seq"
                                                           name="workExperienceList[${wkStatus.index}].work_seq"
                                                           value="${work.work_seq}"/>
                                                    <td><input type="text"
                                                               name="workExperienceList[${wkStatus.index}].work_place"
                                                               maxlength="18"
                                                               value="${work.work_place}"/></td>
                                                    <td><input type="text"
                                                               name="workExperienceList[${wkStatus.index}].work_position"
                                                               maxlength="8"
                                                               value="${work.work_position}"/>
                                                    </td>
                                                    <td><input type="text"
                                                               name="workExperienceList[${wkStatus.index}].work_assigned_task"
                                                               maxlength="18"
                                                               value="${work.work_assigned_task}"/>
                                                    </td>
                                                    <td><input type="text" class="dateFmt"
                                                               name="workExperienceList[${wkStatus.index}].work_start_date"
                                                               maxlength="10"
                                                               value="${work.work_start_date}"/></td>
                                                    <td><input type="text" class="dateFmt"
                                                               name="workExperienceList[${wkStatus.index}].work_end_date"
                                                               maxlength="10"
                                                               value="${work.work_end_date}"/></td>
                                                    <td class="text-center">
                                                        <c:choose>
                                                            <c:when test="${wkStatus.index == 0}">
                                                                <button type="button" class="btn btn-danger clear_field"
                                                                        onclick="clearField(this)"><span>-</span>
                                                                </button>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <button type="button"
                                                                        class="btn btn-outline-danger remove-field"
                                                                        data-target="workFrm"><span>-</span>
                                                                </button>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </c:otherwise>
                                    </c:choose>
                                </table>
                            </div>
                        </div>
                    </form>
                    <!-- 근무경력 끝-->
                    <hr>
                    <!-- 수행경력 -->
                    <form id="project">
                        <div id="pjFrm" class="mb-5 px-sm-0 g-0">
                            <header class="description mb-sm-3">
                                <div class="left-group">
                                    수행경력
                                    <span name="pj_career"></span>
                                </div>
                                <div class="right-group">
                                    <span>
                                        <button type="button" class="btn btn-outline-primary" data-target="pjFrm"
                                                onclick="addProject()"><span>+</span>
                                        </button>
                                        <button type="button" class="btn btn-success"
                                                data-name="project" onclick="goSave(this)"><span>저장</span>
                                        </button>
                                    </span>
                                </div>
                            </header>
                            <div class="table-responsive px-5">
                                <header class="basic-medium"><span class="star">*</span>현재 진행중인 사업 내역</header>
                                <table class="table table-hover mb-5">
                                    <colgroup>
                                        <col style="width: 5%;">
                                        <col style="width: 20%;">
                                        <col style="width: auto;">
                                        <col style="width: 10%;">
                                        <col style="width: 20%;">
                                        <col style="width: 10%;">
                                        <col style="width: 6%;">
                                        <col style="width: 2%;">
                                    <colgroup>
                                    <thead>
                                    <tr>
                                        <th scope="col">NO</th>
                                        <th scope="col">발주처</th>
                                        <th scope="col">사업명</th>
                                        <th scope="col">참여기간</th>
                                        <th scope="col">담당업무</th>
                                        <th scope="col">역할</th>
                                        <th scope="col">기술</th>
                                        <th scope="col"></th>
                                    </tr>
                                    </thead>
                                    <c:choose>
                                        <c:when test="${empty profile.projectList}">
                                            <tbody class="table-group-divider" id="project_ing">
                                            <tr>
                                                <td colspan="8" class="figure-caption">진행중인 사업이 없습니다</td>
                                            </tr>
                                            </tbody>
                                        </c:when>
                                        <c:otherwise>
                                            <tbody id="project_ing" class="table-group-divider">
                                            <c:set var="count_ing" value="1"/>
                                            <c:forEach var="project_ing" items="${profile.projectList}"
                                                       varStatus="pjStatus">
                                                <fmt:parseDate var="project_end_date"
                                                               value="${project_ing.project_end_date}"
                                                               pattern="yyyyMMdd"/>
                                                <fmt:formatDate value="${project_end_date}" pattern="yyyy-MM-dd"
                                                                var="project_end_date"/>
                                                <c:if test="${today <= project_end_date}">
                                                    <tr id="projectList_${pjStatus.index}" class="add">
                                                        <td>${count_ing}</td>
                                                        <input type="hidden"
                                                               name="projectList[${pjStatus.index}].project_seq"
                                                               value="${project_ing.project_seq}"/>
                                                        <input type="hidden"
                                                               name="projectList[${pjStatus.index}].use_yn"
                                                               class="useYn" value="${project_ing.use_yn}"/>
                                                        <td><input type="text"
                                                                   name="projectList[${pjStatus.index}].project_client"
                                                                   maxlength="18"
                                                                   value="${project_ing.project_client}"/></td>
                                                        <td><input type="text"
                                                                   name="projectList[${pjStatus.index}].project_nm"
                                                                   maxlength="18" value="${project_ing.project_nm}"/>
                                                        </td>
                                                        <td><input type="text"
                                                                   name="projectList[${pjStatus.index}].project_start_date"
                                                                   class="dateFmt" maxlength="10" style="width: 80px;"
                                                                   value="${project_ing.project_start_date}"/>
                                                            ~ <input type="text"
                                                                     name="projectList[${pjStatus.index}].project_end_date"
                                                                     class="dateFmt" maxlength="10" style="width: 80px;"
                                                                     value="${project_ing.project_end_date}"/></td>
                                                        <td>
                                                            <select name="projectList[${pjStatus.index}].assigned_task_lar"
                                                                    class="form-select noneBorder"
                                                                    onchange="selectTaskLar(this)">
                                                                <c:forEach var="taskLarList" items="${taskLarList}">
                                                                    <option value="${taskLarList.code_id}"
                                                                            <c:if test="${taskLarList.code_id eq project_ing.assigned_task_lar}">selected</c:if>>${taskLarList.code_value}</option>
                                                                </c:forEach>
                                                            </select>
                                                            <select name="projectList[${pjStatus.index}].assigned_task_mid"
                                                                    class="form-select noneBorder">
                                                                <c:forEach var="taskMidList" items="${taskMidList}">
                                                                    <option value="${taskMidList.code_id}"
                                                                            <c:if test="${taskMidList.code_id eq project_ing.assigned_task_mid}">selected</c:if>>${taskMidList.code_value}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </td>
                                                        <td>
                                                            <select name="projectList[${pjStatus.index}].project_role"
                                                                    class="form-select noneBorder">
                                                                <option>--</option>
                                                                <c:forEach var="roleList" items="${roleList}">
                                                                    <option value="${roleList.code_id}"
                                                                            <c:if test="${roleList.code_id eq project_ing.project_role}">selected</c:if>>${roleList.code_value}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </td>
                                                        <td>
                                                            <button type="button" class="btn btn-warning"
                                                                    onclick="viewSkill(${project_ing.project_seq}, '1')">
                                                                <span>수정</span>
                                                            </button>
                                                        </td>
                                                        <td>
                                                            <button type="button" class="btn btn-outline-danger"
                                                                    onclick="remove(this, 'old')">
                                                                <span>-</span>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                    <c:set var="count_ing" value="${count_ing+1}"/>
                                                </c:if>
                                            </c:forEach>
                                            </tbody>
                                        </c:otherwise>
                                    </c:choose>
                                </table>
                                <header class="basic-medium"><span class="star">*</span>과거 사업 내역</header>
                                <table class="table table-hover">
                                    <colgroup>
                                        <col style="width: 5%;">
                                        <col style="width: 20%;">
                                        <col style="width: auto;">
                                        <col style="width: 10%;">
                                        <col style="width: 20%;">
                                        <col style="width: 10%;">
                                        <col style="width: 6%;">
                                        <col style="width: 2%;">
                                    <colgroup>
                                    <thead>
                                    <tr>
                                        <th scope="col">NO</th>
                                        <th scope="col">발주처</th>
                                        <th scope="col">사업명</th>
                                        <th scope="col">참여기간</th>
                                        <th scope="col">담당업무</th>
                                        <th scope="col">역할</th>
                                        <th scope="col">기술</th>
                                        <th scope="col"></th>
                                    </tr>
                                    </thead>
                                    <c:choose>
                                        <c:when test="${empty profile.projectList}">
                                            <tbody id="project_hist" class="table-group-divider">
                                            <tr>
                                                <td colspan="8" class="figure-caption">참여했던 사업이 없습니다</td>
                                            </tr>
                                            </tbody>
                                        </c:when>
                                        <c:otherwise>
                                            <tbody id="project_hist" class="table-group-divider">
                                            <c:set var="count_hist" value="1"/>
                                            <c:forEach var="project_hist" items="${profile.projectList}"
                                                       varStatus="pjStatus">
                                                <fmt:parseDate var="project_end_date"
                                                               value="${project_hist.project_end_date}"
                                                               pattern="yyyyMMdd"/>
                                                <fmt:formatDate value="${project_end_date}" pattern="yyyy-MM-dd"
                                                                var="project_end_date"/>
                                                <c:if test="${today > project_end_date}">
                                                    <tr id="projectList_${pjStatus.index}" class="add">
                                                        <td>${count_hist}</td>
                                                        <input type="hidden"
                                                               name="projectList[${pjStatus.index}].project_seq"
                                                               value="${project_hist.project_seq}"/>
                                                        <input type="hidden"
                                                               name="projectList[${pjStatus.index}].use_yn"
                                                               class="useYn" value="${project_hist.use_yn}"/>
                                                        <td><input type="text"
                                                                   name="projectList[${pjStatus.index}].project_client"
                                                                   maxlength="18"
                                                                   value="${project_hist.project_client}"/></td>
                                                        <td><input type="text"
                                                                   name="projectList[${pjStatus.index}].project_nm"
                                                                   maxlength="18" value="${project_hist.project_nm}"/>
                                                        </td>
                                                        <td><input type="text"
                                                                   name="projectList[${pjStatus.index}].project_start_date"
                                                                   class="dateFmt" maxlength="10" style="width: 80px;"
                                                                   value="${project_hist.project_start_date}"/>
                                                            ~ <input type="text"
                                                                     name="projectList[${pjStatus.index}].project_end_date"
                                                                     class="dateFmt" maxlength="10" style="width: 80px;"
                                                                     value="${project_hist.project_end_date}"/>
                                                        </td>
                                                        <td>
                                                            <select name="projectList[${pjStatus.index}].assigned_task_lar"
                                                                    class="form-select noneBorder"
                                                                    onchange="selectTaskLar(this)">
                                                                <c:forEach var="taskLarList" items="${taskLarList}">
                                                                    <option value="${taskLarList.code_id}"
                                                                            <c:if test="${taskLarList.code_id eq project_hist.assigned_task_lar}">selected</c:if>>${taskLarList.code_value}</option>
                                                                </c:forEach>
                                                            </select>
                                                            <select name="projectList[${pjStatus.index}].assigned_task_mid"
                                                                    class="form-select noneBorder">
                                                                <c:forEach var="taskMidList" items="${taskMidList}">
                                                                    <option value="${taskMidList.code_id}"
                                                                            <c:if test="${taskMidList.code_id eq project_hist.assigned_task_mid}">selected</c:if>>${taskMidList.code_value}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </td>
                                                        <td>
                                                            <select name="projectList[${pjStatus.index}].project_role"
                                                                    class="form-select noneBorder">
                                                                <option>--</option>
                                                                <c:forEach var="roleList" items="${roleList}">
                                                                    <option value="${roleList.code_id}"
                                                                            <c:if test="${roleList.code_id eq project_hist.project_role}">selected</c:if>>${roleList.code_value}</option>
                                                                </c:forEach>
                                                            </select>
                                                        <td>
                                                            <button type="button" class="btn btn-warning"
                                                                    onclick="viewSkill(${project_hist.project_seq}, '1')">
                                                                <span>수정</span>
                                                            </button>
                                                        </td>
                                                        <td>
                                                            <button type="button" class="btn btn-outline-danger"
                                                                    onclick="remove(this, 'old')">
                                                                <span>-</span>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                    <c:set var="count_hist" value="${count_hist+1}"/>
                                                </c:if>
                                            </c:forEach>
                                            </tbody>
                                        </c:otherwise>
                                    </c:choose>
                                </table>
                            </div>
                        </div>
                    </form>
                    <!-- 수행경력 끝-->
                </div>
            </div>
            <!-- 경력 끝-->
        </div>
        <!-- 수정화면 끝-->
    </div>


</div>
<!-- main-content -->

<!-- footer.jsp -->
<%@ include file="layout/footer.jsp" %>
<!-- footer.jsp -->
<script src="//code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/js/bootstrap.bundle.js"></script>
<script src="/js/common.js"></script>
<script type="text/javascript">
    // 전역변수로 선언
    let addCnt = 0;
    let chgImg = false;

    $(document).ready(function () {

        const wk_totalMonth = [[${wk_totalMonth}]];
        const pj_totalMonth = [[${pj_totalMonth}]];

        let calc_wk_totalMonth = convertToString(wk_totalMonth);
        let calc_pj_totalMonth = convertToString(pj_totalMonth);

        $("span[name=wk_career]").text(calc_wk_totalMonth);
        $("span[name=pj_career]").text(calc_pj_totalMonth);

        const urlParams = new URLSearchParams(window.location.search);
        const mode = urlParams.get("mode");

        if (mode === "edit") {
            $("#viewMode").css("display", "none");
            $("#editMode").css("display", "");
        } else {
            $("#viewMode").css("display", "");
            $("#editMode").css("display", "none");
        }

        // 최초 DOM 읽을 때 dateFmt, telFmt 포맷팅하여 표기
        $(".container").find(".dateFmt, .telFmt").each(function () {
            formatInput($(this));
        });

        // 항목 제거
        $(document).on("click", ".remove-field", function () {
            let frmId = $(this).data("target");
            let listNm;
            if (frmId === "qlFrm") {
                listNm = "qualificationList";
            } else if (frmId === "workFrm") {
                listNm = "workExperienceList";
            } else if (frmId === 'schFrm') {
                listNm = "educationList";
            }
            $(this).closest(".add").remove();
            updateRowIndex(frmId, listNm);
        });

        // 날짜 및 휴대전화 실시간 포맷
        $(".container").on("keyup", ".dateFmt, .telFmt", function () {
            formatInput($(this));
        });

        // 프로필이미지 등록
        $("#imgFile").on("change", function (e) {
            /*최대 파일크기 2MB(2097152) */
            const fileInfo = e.target.files[0];
            const maxSize = 1024 * 1024 * 2; // 최대 크기 2MB
            const basicImg = "/images/image.png"; // 기본 이미지 경로
            chgImg = true;

            // 파일 선택 취소
            if (!fileInfo) {
                $(".edit").attr("src", basicImg);
                chgImg = false;
                return;
            }
            // 파일 이름 검증(20자)
            const oriFileNm = fileInfo.name;
            if (oriFileNm.length > 20 || oriFileNm.includes(" ")) {
                alert("파일명은 공백을 제외한 20자 이내로 작성해주세요");
                return;
            }
            // 파일 크기 검증
            if (fileInfo.size > maxSize) {
                alert("이미지 사진의 용량이 2MB를 초과합니다.");
                return;
            }
            // 파일 형식 검증
            const allowedExtensions = ['image/jpeg', 'image/png', 'image/jpg'];
            if (!allowedExtensions.includes(fileInfo.type)) {
                alert("이미지 파일만 업로드 가능합니다.");
                return;
            }
            // 파일 미리보기
            const reader = new FileReader();
            reader.onload = function (e) {
                const url = e.target.result;
                $(".edit").attr("src", url);
            };
            reader.readAsDataURL(fileInfo);
        });

        // 항목 추가
        $(".add_field").click(function () {
            let frmId = $(this).data("target");
            let newRow;
            let listNm;

            if (frmId == 'qlFrm') {
                listNm = 'qualificationList';
                newRow =
                    `<tr class="add" id="qualificationList_">
                         <td>+</td>
                         <input type="hidden" class="seq"
                                name="qualificationList[].qualification_seq"/>
                         <td><input type="text"
                                    name="qualificationList[].qualification_nm" maxlength="18"/>
                         </td>
                         <td><input type="text"
                                    name="qualificationList[].issuer" maxlength="18"/>
                         </td>
                         <td><input type="text" class="dateFmt"
                                    name="qualificationList[].acquisition_date" maxlength="10"/>
                         </td>
                         <td><input type="text" class="dateFmt"
                                    name="qualificationList[].expiry_date" maxlength="10"/>
                         </td>
                         <td class="text-center"><button type="button" class="btn btn-outline-danger remove-field"
                                      data-target="qlFrm"><span>-</span></button>
                         </td>
                     </tr>`;
            } else if (frmId == 'workFrm') {
                listNm = 'workExperienceList';
                newRow =
                    `<tr class="add" id="workExperienceList_">
                        <td>+</td>
                        <input type="hidden" class="seq"
                               name="workExperienceList[].work_seq"/>
                        <td><input type="text"
                                   name="workExperienceList[].work_place" maxlength="18"/>
                        </td>
                        <td><input type="text"
                                   name="workExperienceList[].work_position"
                                   maxlength="8"/>
                        </td>
                        <td><input type="text"
                                   name="workExperienceList[].work_assigned_task"
                                   maxlength="18"/>
                        </td>
                        <td><input type="text" class="dateFmt"
                                   name="workExperienceList[].work_start_date" maxlength="10"/>
                        </td>
                        <td><input type="text" class="dateFmt"
                                   name="workExperienceList[].work_end_date" maxlength="10"/>
                        </td>
                        <td class="text-center">
                            <button type="button" class="btn btn-outline-danger remove-field"
                                    data-target="workFrm"><span>-</span></button>
                        </td>
                    </tr>`;
            } else if (frmId == 'schFrm') {
                listNm = 'educationList';
                newRow =
                    `<div class="row mb-2 g-0 add" id="educationList_">
                            <input type="hidden" class="seq" name="educationList[].school_seq" value=""/>
                            <div class="col-sm-auto common-box input-box pt-4 me-1">
                                <span>학교구분</span>
                                <select class="form-select noneBorder schGb"
                                        name="educationList[].school_gubun">
                                    <option value="">-</option>
                                    <option value="010">고등학교</option>
                                    <option value="011">대학교(2,3년)</option>
                                    <option value="012">대학교(4년)</option>
                                    <option value="013">대학원</option>
                                </select>
                            </div>
                            <div class="col-sm common-box input-box pt-4">
                                <span>학교명</span>
                                <input type="text" name="educationList[].school_nm" maxlength="15"  />
                            </div>
                            <div class="col-sm-2 common-box input-box pt-4 me-1" style="margin-left: -1px;">
                                <span>전공명</span>
                                <input type="text" name="educationList[].major" maxlength="18"/>
                            </div>
                            <div class="col-sm-2 common-box input-box pt-4">
                                <span>입학일자</span>
                                <input type="text" class="dateFmt" maxlength="10" name="educationList[].school_start_date"  />
                            </div>
                            <div class="col-sm-2 common-box input-box pt-4 me-1" style="margin-left: -1px;">
                                <span>졸업일자</span>
                                <input type="text" class="dateFmt" maxlength="10" name="educationList[].school_end_date"  />
                            </div>
                            <div class="col-sm-1 common-box input-box pt-4 me-1">
                                <span>학점</span>
                                <input type="text" class="grade" maxlength="3" name="educationList[].total_grade" onkeyup="onlyDot(this)" />
                            </div>
                            <div class="col-sm-auto common-box input-box pt-4 me-4">
                                <span>졸업상태</span>
                                <select class="form-select noneBorder"
                                        name="educationList[].grad_status">
                                    <option value="">-</option>
                                    <option value="001">졸업</option>
                                    <option value="002">졸업예정</option>
                                    <option value="003">재학중</option>
                                </select>
                            </div>
                            <div class="col-sm-auto align-content-center">
                                <button type="button" class="btn btn-outline-danger remove-field" data-target="schFrm"><span>-</span></button>
                                </button>
                            </div>
                        </div>`;
            }
            $("#" + frmId + " .add-main").append(newRow);
            updateRowIndex(frmId, listNm);
        });

    });

    // 항목 추가/제거 시 index 정렬
    function updateRowIndex(frmId, listNm) {
        $("#" + frmId + " .add").each(function (i) {
            $(this).attr("id", listNm + "_" + i);
            // 모든 input 및 select 태그에서 name 속성 업데이트(인덱스 정렬)
            $(this).find("input, select").each(function () {
                let name = $(this).attr("name");
                if (name && name.startsWith(listNm)) {
                    let newName = name.replace(/\[\d*\]/, '[' + i + ']');
                    $(this).attr("name", newName);
                }
            });
            $(this).find(".seq").attr("value", i + 1); // seq 새로 부여
        });
    }

    // input 초기화
    function clearField(ob) {
        const clearOb = $(ob).closest(".add");
        clearOb.find("input, select").each(function(){
            const name = $(this).attr("name");
            if(!name.includes("seq")){
                $(this).val('');
            }
        });
    }

    // 사업 추가 팝업 호출
    function addProject() {
        let user_id = $('input[name=user_id]').val();
        let url = "/profile/project/add?user_id=" + user_id;
        let properties = "width=800,height=300"
        window.open(url, "addNewProject", properties);
    }

    // 팝업창에서 데이터 받아오기
    function addProjectRow(data) {
        const PjEndDate = new Date(data.project_end_date);
        const todayDate = new Date();

        // 이걸로 추가가 된 횟수를 센다.
        addCnt += data.addCnt;

        // 진행/이력 구분
        const target = PjEndDate >= todayDate ? document.getElementById("project_ing") : document.getElementById("project_hist");
        let newRow;
        let project_seq = Number(data.project_seq) + addCnt; // TB_PROJECT 에서 MAX(SEQ)를 조회한 값에 addCnt를 더해줌으로써 seq 를 새롭게 생성
        let frmId = 'pjFrm';
        let listNm = 'projectList';
        newRow = `<tr class="add">
                    <td>+</td>
                    <input type="hidden" name="projectList[].project_seq" value="` + project_seq + `"/>
                    <td><input type="text" class="noneBorder align-content-center" name="projectList[].project_client" style="background: transparent;" maxlength="18"
                               value="` + data.project_client + `" readonly/></td>
                    <td><input type="text" class="noneBorder align-content-center" name="projectList[].project_nm" style="background: transparent;" maxlength="18"
                               value="` + data.project_nm + `" readonly/></td>
                    <td><input type="text" class="dateFmt noneBorder align-content-center" maxlength="10"
                               name="projectList[].project_start_date" style="width: 80px; background: transparent;"
                               value="` + data.project_start_date + `" readonly/>
                        ~ <input type="text" class="dateFmt noneBorder align-content-center" maxlength="10"
                                 name="projectList[].project_end_date" style="width: 80px; background: transparent;"
                                 value="` + data.project_end_date + `" readonly/></td>
                    <td>
                        <input type="hidden" name="projectList[].assigned_task_lar" value="` + data.assigned_task_lar + `"/>
                        <input type="hidden" name="projectList[].assigned_task_mid" value="` + data.assigned_task_mid + `"/>
                        <input type="text" value="` + data.assigned_task_lar_nm + ` > ` + data.assigned_task_mid_nm + `" style="width: 100%; background: transparent;" readonly/>
                    </td>
                    <td>
                        <input type="hidden" name="projectList[].project_role" value="` + data.project_role + `"/>
                        <input type="text" value="` + data.project_role_nm + `" style="width: 100%; background: transparent;" readonly/>
                    <td>

                    </td>
                    <td>
                        <button type="button" class="btn btn-outline-danger" onclick="remove(this, 'new')">
                            <span>-</span>
                    </td>
                </tr>
        `;

        target.insertAdjacentHTML('beforeend', newRow);
        updateRowIndex(frmId, listNm);

    }

    // 기술 확인(flag=0)/수정(flag=1)
    function viewSkill(project_seq, flag) {
        let user_id = $('input[name=user_id]').val();
        let url = "/profile/project/select/skill?user_id=" + user_id + "&project_seq=" + project_seq + "&flag=" + flag;
        let properties = "width=600, height=420";
        window.open(url, "viewSkill", properties)
    }

    function excel() {
        const userId = $('input[name=user_id]').val();
        const userNm = $('input[name=user_nm]').val();
        const fileSeq = $("#excelTempate").val();

        fetch("/excel/" + userId + "/downloadTemplate/" + fileSeq, {
            method: 'POST'
        }).then(response => {
            if (!response.ok) { // HTTP 상태 코드가 200-299 범위에 없을 경우
                return response.text().then(errorMessage => {
                    throw new Error(errorMessage); // 서버에서 반환한 에러 메세지
                })
            }
            return response.blob(); // Blob 데이터 반환
        }).then(blob => {
            // Blob 데이터를 URL 객체로 변환
            const url = window.URL.createObjectURL(blob);
            // 다운로드 링크 생성 및 클릭 이벤트 실행
            const a = document.createElement('a');
            a.style.display = 'none';
            a.href = url;
            a.download = "profile_" + userId + ".xlsx"; // 다운로드할 파일 이름 설정
            document.body.appendChild(a);
            a.click();
            window.URL.revokeObjectURL(url);// URL 객체 해제
        }).catch(error => {
            // 오류 발생
            alert(error);
        })
    }

    function goModify() {
        const url = new URL(window.location.href);
        url.searchParams.set("mode", "edit");

        // 새로고침 하지 않고 url 변경
        window.history.pushState({}, '', url.toString());

        $("#viewMode").css("display", "none");
        $("#editMode").css("display", "");
    }

    function validateForm(frmId) {
        if (frmId === "profile") {
            // 휴대폰번호 검증
            const phoneNum = $("input[name=user_phone]").val();

            if (!chkTel(phoneNum)) {
                alert("휴대폰번호를 확인해주세요.");
                $("input[name=user_phone]").focus();
                return false;
            }
            // 학점 검증
            if (!validateGrades()) return false;
        }

        // 날짜 검증
        if (!validateDates(frmId)) return false;

        // 데이터 빈 값 검증
        if (!chkInputs(frmId)) return false;

        return true;
    }

    // 학점 검증
    function validateGrades() {
        let isValid = true;

        $(".grade").each(function () {
            const grade = $(this).val();
            // 고등학교는 검증제외
            let gubun = $(this).closest(".add").find(".schGb").val();
            if(gubun == '010'){
                return;
            }
            if (!chkGrade(grade)) {
                alert("학점 입력값이 올바르지 않습니다");
                $(this).focus();
                isValid = false;
                return false;
            }
        });
        return isValid;
    }


    // 날짜 검증
    function validateDates(frmId) {
        let isValidDates = true;
        $("#" + frmId).find(".dateFmt").each(function () {
            const date = $(this).val();

            let name = $(this).attr("name");
            if(name.endsWith("expiry_date") && date === ""){
                return;
            } else {
                if (!chkDate(date)) {
                    alert("입력일자를 확인해주세요");
                    $(this).focus();
                    isValidDates = false;
                    return false;
                }
            };
        });

        if (!isValidDates) return false;

        // 날짜 start_date < end_date && 날짜 빈값 검증
        if (!chkDateForm(frmId)) return false;

        return true;
    }

    // 빈 값에 대한 유효성 검사
    function chkInputs(frmId) {
        let isValid = true;

        $("#" + frmId).find("input, select").each(function () {
            if (!isValid) return false;
            const name = $(this).attr("name");
            if (name) {
                let input = $(this).val();
                const nullable = ['major', 'total_grade', 'imgFile', 'expiry_date'];
                let isNullable = false;

                for (const nullableItem of nullable) {
                    if (name.endsWith(nullableItem)) {
                        isNullable = true;
                        break;
                    }
                }

                if (!isNullable && input === '') {
                    alert("항목을 입력하세요.");
                    $(this).focus();
                    isValid = false;
                    return false;
                }
            }
        });
        return isValid;
    }

    // 날짜 replace
    function formatDates(frmId) {
        // 날짜 포맷
        $("#" + frmId).find(".dateFmt").each(function () {
            const date = $(this).val().replaceAll('-', '');
            $(this).val(date);
        });
    }

    // 휴대전화 replace
    function formatPhone() {
        const phone = $("input[name=user_phone]").val().replaceAll('-', '');
        $("input[name=user_phone]").val(phone);
    }

    // url 생성
    function buildUrl(frmId, userId) {
        if (frmId == 'profile') {
            return "/profile/save/" + userId;
        } else {
            return "/profile/" + frmId + "/save/" + userId;
        }
    }

    // ajax
    function sendAjaxRequest(url, data, flag) {
        $.ajax({
            url: url,
            type: "POST",
            data: data,
            processData: flag, // 파일 처리 : false
            contentType: flag ? "application/x-www-form-urlencoded; charset=UTF-8" : false,
            success: function (response) {
                if (response === "SUCCESS") {
                    alert("저장되었습니다.");
                    const url = new URL(window.location.href);
                    url.searchParams.set("mode", "edit");
                    window.history.pushState({}, '', url.toString());

                    location.reload();
                } else {
                    alert(response);
                }
            },
            error: function () {
                alert("서버 오류가 발생했습니다. 다시 시도해 주세요.")
            }
        });
    }

    // 저장
    function goSave(frm) {
        let frmId = $(frm).data("name");
        // 파일 전송을 위한 flag 설정
        let flag = true;
        let data;

        // 검증 실패시 종료
        if (!validateForm(frmId)) return;

        // 날짜 포맷 변경
        formatDates(frmId);

        // 휴대폰 포맷 변경
        formatPhone();

        if (frmId === 'profile') {
            if (chgImg) {
                // 프로필 사진이 변경된 경우
                flag = false; // FormData 사용
                data = new FormData($("#" + frmId)[0]);
            } else {
                // 사진이 변경되지 않은 경우
                $("#imgFile").attr("disabled", true);
                data = $("#" + frmId).serialize();
            }
        } else {
            data = $("#" + frmId).serialize();
        }

        if (confirm("저장하시겠습니까?")) {
            const userId = $('input[name=user_id]').val();
            const url = buildUrl(frmId, userId);

            sendAjaxRequest(url, data, flag);
        }
    }

    // 수행경력 remove
    function remove(ob, str) {
        let frmId = 'pjFrm';
        let listNm = 'projectList';
        if (str == 'new') {
            $(ob).closest(".add").remove();
            addCnt--;
            updateRowIndex(frmId, listNm);
        } else {
            $(ob).closest(".add").hide();
            let updateEl = $(ob).closest(".add").find(".useYn");
            updateEl.val('N');
        }
    }

    // 업무분류 BOX 서버 데이터 조회
    function selectTaskLar(ob) {
        const parentId = $(ob).val();
        const url = "/profile/project/select/task";
        const $subCategory = $(ob).next();

        // 중분류를 초기화 한다.
        $subCategory.empty().append('<option value="">-- 중분류 선택 --</option>');

        $.ajax({
            url: url,
            type: "GET",
            data: {code_id: parentId},
            dataType: 'json',
            success: function (response) {
                response.forEach(data => {
                    $subCategory.append('<option value="' + data.code_id + '">' + data.code_value + '</option>');
                });
            },
            error: function () {
                alert("서버 오류가 발생했습니다. 다시 시도해 주세요.")
            }
        });
    }

    // start_date, end_date 에 대한 유효성 검사
    function compareDate(frm, startDt, endDt) {
        let isValid = true;

        $("#" + frm).find(".add").each(function (i) {
            if (!isValid) return false; // 이전 반복에서 실패하면 즉시 중단
            let startVal = null;
            let endVal = null;

            // 현재 항목의 input 요소 순회
            $(this).find("input").each(function () {
                const name = $(this).attr("name");

                if (name && name.endsWith(startDt)) {
                    startVal = $(this).val();
                    if (!startVal) {
                        alert("입력값을 확인해주세요");
                        $(this).focus();
                        isValid = false;
                        return false; // 반복중단
                    }
                }
                if (name && name.endsWith(endDt)) {
                    endVal = $(this).val();
                    if (!endVal && endDt != "expiry_date") {
                        alert("입력값을 확인해주세요");
                        $(this).focus();
                        isValid = false;
                        return false; // 반복중단
                    }
                }
            });
            // 시작일과 종료일 비교
            if (startVal && endVal) {
                const fmtStartDt = new Date(startVal);
                const fmtEndDt = new Date(endVal);
                if (fmtStartDt > fmtEndDt) {
                    alert("입력날짜가 적합하지 않습니다.");
                    isValid = false;
                    return false; // 반복중단
                }
            }
        });
        return isValid;
    }

    function chkDateForm(frmId) {
        let frm = null;
        if (frmId == "profile") {
            frm = {frmNm: "schFrm", startDt: "school_start_date", endDt: "school_end_date"}
        } else if (frmId == "qualification") {
            frm = {frmNm: "qlFrm", startDt: "acquisition_date", endDt: "expiry_date"}
        } else if (frmId == "workExperience") {
            frm = {frmNm: "workFrm", startDt: "work_start_date", endDt: "work_end_date"}
        } else { // project
            frm = {frmNm: "pjFrm", startDt: "project_start_date", endDt: "project_end_date"}
        }
        const isVaild = compareDate(frm.frmNm, frm.startDt, frm.endDt);
        if (!isVaild) {
            return false;
        }
        return true;
    }

    function back() {
        const url = new URL(window.location.href);
        url.searchParams.delete("mode");
        window.history.pushState({}, '', url.toString());

        $("#viewMode").css("display", "");
        $("#editMode").css("display", "none");
    }

    function initPw() {
        if (confirm("초기화 하시겠습니까?")) {
            $.ajax({
                url: "/auth/save/password?flag=1",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify({
                    user_id: $("input[name=user_id]").val()
                }),
                success: function () {
                    alert("초기화되었습니다.");
                },
                error: function () {
                    alert("서버 오류가 발생했습니다. 다시 시도해 주세요");
                }
            });
        }
    }

    function usrDelete(){
        let user_id = $("input[name=user_id]").val();
        if(confirm("직원 삭제 하시겠습니까?")){
            $.ajax({
                url: "/auth/delete/"+user_id,
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify({
                    user_id: $("input[name=user_id]").val()
                }),
                success: function () {
                    alert("삭제되었습니다");
                    window.location.href = "/profile/info/list";
                },
                error: function () {
                    alert("서버 오류가 발생했습니다. 다시 시도해 주세요");
                }
            });
        }
    }

    function excelUpload(){
        let user_id = $("input[name=user_id]").val();

        let url = "/excel/" + user_id + "/upload";
        let properties = "width=600, height=200";
        window.open(url, "excelUpload", properties)
    }
    
    function openExcelTemplatePop(){
    	let url = "/excel/excelTemplateUpload";
        let properties = "width=900, height=600";
        window.open(url, "excelUpload", properties)
    }

</script>

</body>
</html>
