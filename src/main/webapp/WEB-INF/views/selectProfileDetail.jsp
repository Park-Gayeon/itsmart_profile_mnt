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
                    <div class="description" style="position: relative; top: 0px">
                        <input type="button" class="btn btn-warning" onclick="excel()" value="EXCEL"/>
                        <input type="button" class="btn btn-warning" onclick="goModify()" value="EDT"/>
                    </div>
                </h2>
                <div class="common-box row-box row mb-5 g-0">
                    <!-- 인적사항 -->
                    <div class="row-box row mb-5 g-0">
                        <header class="header">인적사항</header>
                        <!-- 사진 -->
                        <div class="col-md text-center mb-3">
                            <c:choose>
                                <c:when test="${profile.fileInfo.file_sver_nm eq null || profile.fileInfo.file_sver_nm eq ''}">
                                    <img class="img-profile detail" src="/image/image.png"/>
                                </c:when>
                                <c:otherwise>
                                    <img class="img-profile detail" src="/${profile.fileInfo.file_sver_nm}"/>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <!-- 사진 끝 -->
                        <!-- 개인정보 -->
                        <div class="col-md-auto g-0">
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
                    <div>
                        <header class="header">학력</header>
                            <div class="col-md g-0">
                                <c:forEach var="i" begin="1" end="3">
                                    <c:set var="eduKey" value="edu${i}_school_name"/>
                                    <c:if test="${profile[eduKey] ne ''}">
                                        <!-- 첫번째 row -->
                                        <div class="row mb-2 g-0">
                                            <div class="col-sm-1 common-box input-box pt-4">
                                                <c:set var="gubunKey" value="edu${i}_gubun"/>
                                                <span>학교구분</span>
                                                <c:choose>
                                                    <c:when test="${profile[gubunKey]  == '010'}">
                                                        <input type="text" value="고등학교" readonly/>
                                                    </c:when>
                                                    <c:when test="${profile[gubunKey]  == '011'}">
                                                        <input type="text" value="대학교(2,3년)" readonly/>
                                                    </c:when>
                                                    <c:when test="${profile[gubunKey]  == '012'}">
                                                        <input type="text" value="대학교(4년)" readonly/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <input type="text" value="대학원" readonly/>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="col-sm-3 common-box input-box pt-4 me-2">
                                                <span>학교명</span>
                                                <input type="text" value="${profile[eduKey]}" readonly/>
                                            </div>
                                            <div class="col-sm-2 common-box input-box pt-4">
                                                <c:set var="startDateKey" value="edu${i}_start_date"/>
                                                <span>입학년월</span>
                                                <input type="text" class="dateFmt" value="${profile[startDateKey]}" readonly/>
                                            </div>
                                            <div class="col-sm-2 common-box input-box pt-4 me-2">
                                                <c:set var="endDateKey" value="edu${i}_end_date"/>
                                                <span>졸업년월</span>
                                                <input type="text" class="dateFmt" value="${profile[endDateKey]}" readonly/>
                                            </div>
                                            <div class="col-sm-1 common-box input-box pt-4 me-2">
                                                <c:set var="statusKey" value="edu${i}_grad_status"/>
                                                <span>졸업상태</span>
                                                <c:choose>
                                                    <c:when test="${profile[statusKey] == '001'}">
                                                        <input type="text" value="졸업" readonly/>
                                                    </c:when>
                                                    <c:when test="${profile[statusKey] == '002'}">
                                                        <input type="text" value="졸업예정" readonly/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <input type="text" value="재학중" readonly/>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                                <c:if test="${profile.edu1_school_name eq ''}">
                                    <div style="text-align: center;">
                                        <p>작성된 내용이 없습니다</p>
                                    </div>
                                </c:if>
                                <!-- 두번째 row -->
                                <div class="row mb-2 g-0"
                                     style="<c:if test="${profile.major eq '' || profile.major eq null}">display: none;</c:if>">
                                    <div class="col-sm-2 common-box input-box pt-4 me-2">
                                        <span>전공명</span>
                                        <input type="text" value="${profile.major}" readonly/>
                                    </div>
                                    <div class="col-sm-2 common-box input-box pt-4 me-2">
                                        <span>복수전공명</span>
                                        <input type="text" value="${profile.double_major}" readonly/>
                                    </div>
                                    <div class="col-sm-1 common-box input-box pt-4">
                                        <span>학점</span>
                                        <input type="text" value="${profile.total_grade}" readonly/>
                                    </div>
                                    <div class="col-sm-1 common-box input-box pt-4">
                                        <span>총점</span>
                                        <input type="text" value="${profile.standard_grade}" readonly/>
                                    </div>
                                </div>
                            </div>
                    </div>
                    <!-- 학력 끝 -->
                </div>
            </div>
            <!-- 프로필 끝 -->
            <!-- 자격증 -->
            <div class="form-floating">
                <h2 class="header">자격증</h2>
                <div class="common-box row-box row mb-5 g-0">
                    <div class="col-md g-0">
                        <c:choose>
                            <c:when test="${not empty profile.qualificationList}">
                                <c:forEach var="qualification" items="${profile.qualificationList}">
                                    <div class="row mb-2 g-0">
                                        <div class="col-sm-2 common-box input-box pt-4 me-2">
                                            <span>자격증명</span>
                                            <input type="text" value="${qualification.qualification_nm}" readonly>
                                        </div>
                                        <div class="col-sm-2 common-box input-box pt-4 me-2">
                                            <span>발행기관</span>
                                            <input type="text" value="${qualification.issuer}" readonly/>
                                        </div>
                                        <div class="col-sm-2 common-box input-box pt-4">
                                            <span>취득일자</span>
                                            <input type="text" class="dateFmt" value="${qualification.acquisition_date}"
                                                   readonly/>
                                        </div>
                                        <div class="col-sm-2 common-box input-box pt-4">
                                            <span for="expiry_date">만기일자</span>
                                            <input type="text" class="dateFmt" value="${qualification.expiry_date}"
                                                   readonly/>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div style="text-align: center;">
                                    <p>작성된 내용이 없습니다</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
            <!-- 자격증 끝 -->
            <!-- 경력 -->
            <div class="form-floating">
                <h2 class="header">경력</h2>
                <div class="common-box row-box row mb-5 g-0">
                    <!-- 근무경력 -->
                    <div class="pb-3">
                        <header class="header">근무경력
                            <span name="wk_career" class="fw-bolder" style="font-size: 12px;"></span>
                        </header>
                        <div class="col-md g-0">
                            <c:choose>
                                <c:when test="${not empty profile.workExperienceList}">
                                    <c:forEach var="work" items="${profile.workExperienceList}">
                                        <div class="row mb-2 g-0">
                                            <div class="col-sm-3 common-box input-box pt-4 me-2">
                                                <span>회사명</span>
                                                <input type="text" value="${work.work_place}" readonly/>
                                            </div>
                                            <div class="col-sm-2 common-box input-box pt-4">
                                                <span>입사일자</span>
                                                <input type="text" class="dateFmt" value="${work.work_start_date}"
                                                       readonly/>
                                            </div>
                                            <div class="col-sm-2 common-box input-box pt-4">
                                                <span>퇴사일자</span>
                                                <input type="text" class="dateFmt" value="${work.work_end_date}"
                                                       readonly/>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div style="text-align: center;">
                                        <p>작성된 내용이 없습니다</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <!-- 근무경력 끝-->
                    <hr>
                    <!-- 수행경력 -->
                    <div>
                        <header class="header">수행경력
                            <span name="pj_career" class="fw-bolder" style="font-size: 12px;"></span>
                        </header>
                        <div class="table-responsive common-box p-3">
                            <header>진행사항</header>
                            <table class="table table-hover mb-5">
                                <colgroup>
                                    <col style="width: 5%;">
                                    <col style="width: 15%;">
                                    <col style="width: 30%;">
                                    <col style="width: 20%;">
                                    <col style="width: 15%;">
                                    <col style="width: 5%;">
                                    <col style="width: 5%;">
                                    <col style="width: 5%;">
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
                                        <tbody>
                                        <tr>
                                            <td colspan="8" style="text-align: center;">진행중인 사업이 없습니다</td>
                                        </tr>
                                        </tbody>
                                    </c:when>
                                    <c:otherwise>
                                        <tbody class="table-group-divider">
                                        <c:set var="count_ing" value="1"/>
                                        <c:forEach var="project_ing" items="${profile.projectList}"
                                                   varStatus="pjStatus">
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
                                                    <td>${project_ing.project_start_date}
                                                        ~ ${project_ing.project_end_date}</td>
                                                    <td>${project_ing.assigned_task_lar_nm}
                                                        > ${project_ing.assigned_task_mid_nm}</td>
                                                    <td>${project_ing.project_role_nm}</td>
                                                    <td>
                                                        <input type="button" class="btn btn-warning"
                                                               onclick="viewSkill(${project_ing.project_seq}, '0')"
                                                               value="확인"/>
                                                    </td>
                                                </tr>
                                                <c:set var="count_ing" value="${count_ing+1}"/>
                                            </c:if>
                                        </c:forEach>
                                        </tbody>
                                    </c:otherwise>
                                </c:choose>
                            </table>
                            <header>이력사항</header>
                            <table class="table table-hover">
                                <colgroup>
                                    <col style="width: 5%;">
                                    <col style="width: 15%;">
                                    <col style="width: 30%;">
                                    <col style="width: 20%;">
                                    <col style="width: 15%;">
                                    <col style="width: 5%;">
                                    <col style="width: 5%;">
                                    <col style="width: 5%;">
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
                                        <tbody>
                                        <tr>
                                            <td colspan="8" style="text-align: center;">참여했던 사업이 없습니다</td>
                                        </tr>
                                        </tbody>
                                    </c:when>
                                    <c:otherwise>
                                        <tbody class="table-group-divider">
                                        <c:set var="count_hist" value="1"/>
                                        <c:forEach var="project_hist" items="${profile.projectList}" varStatus="pjStatus">
                                            <fmt:parseDate var="project_end_date" value="${project_hist.project_end_date}"
                                                           pattern="yyyyMMdd"/>
                                            <fmt:formatDate value="${project_end_date}" pattern="yyyy-MM-dd"
                                                            var="project_end_date"/>
                                            <c:if test="${today > project_end_date}">
                                                <tr>
                                                    <td>${count_hist}</td>
                                                    <td>${project_hist.project_client}</td>
                                                    <td>${project_hist.project_nm}</td>
                                                    <td>${project_hist.project_start_date}
                                                        ~ ${project_hist.project_end_date}</td>
                                                    <td>${project_hist.assigned_task_lar_nm}
                                                        > ${project_hist.assigned_task_mid_nm}</td>
                                                    <td>${project_hist.project_role_nm}</td>
                                                    <td>
                                                        <input type="button" class="btn btn-warning"
                                                               onclick="viewSkill(${project_hist.project_seq}, '0')" value="확인"/>
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
                        <div class="description" style="position: relative; top: 0px">
                            <spqn><span class="star">*</span> 필수 입력 정보입니다.</spqn>
                            <input type="button" class="btn btn-warning" data-name="profile" onclick="goSave(this)" value="SAVE"/>
                        </div>
                    </h2>
                    <div class="common-box row-box row mb-5 g-0">
                        <!-- 인적사항 -->
                        <div class="row-box row mb-5 g-0">
                            <header class="header">인적사항</header>
                            <!-- 사진 -->
                            <div class="col-md text-center mb-3">
                                <c:choose>
                                    <c:when test="${profile.fileInfo.file_sver_nm eq null || profile.fileInfo.file_sver_nm eq ''}">
                                        <img class="img-profile edit" src="/image/image.png"/>
                                    </c:when>
                                    <c:otherwise>
                                        <img class="img-profile edit" src="/${profile.fileInfo.file_sver_nm}"/>
                                    </c:otherwise>
                                </c:choose>
                                <input type="file" id="imgFile" name="imgFile" class="form-control form-control-sm" accept=".jpg, .png, .jpeg"/>
                            </div>
                            <!-- 사진 끝 -->
                            <!-- 개인정보 -->
                            <div class="col-md-auto g-0">
                                <!-- 첫번째 row -->
                                <div class="row mb-2 g-0">
                                    <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                        <span>이름</span>
                                        <input type="text" name="user_nm" value="${profile.user_nm}" readonly/>
                                    </div>
                                    <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                        <span>생년월일 <span class="star">*</span></span>
                                        <input type="text" name="user_birth" class="dateFmt" maxlength="10" value="${profile.user_birth}"/>
                                    </div>
                                    <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                        <span>휴대전화 <span class="star">*</span></span>
                                        <input type="text" name="user_phone" class="telFmt" maxlength="13" value="${profile.user_phone}"/>
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
                                        <select name="user_department" class="form-select">
                                            <c:forEach var="orgList" items="${orgList}">
                                                <option value="${orgList.code_id}"
                                                        <c:if test="${orgList.code_id eq profile.user_department}">selected</c:if>>${orgList.code_value}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                        <span>직위/직급 <span class="star">*</span></span>
                                        <select class="form-select" name="user_position">
                                            <c:forEach var="psitList" items="${psitList}">
                                                <option value="${psitList.code_id}"
                                                        <c:if test="${psitList.code_id eq profile.user_position}">selected</c:if>>${psitList.code_value}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                        <span>입사일자</span>
                                        <input type="text" name="hire_date" class="dateFmt" maxlength="10" value="${profile.hire_date}" readonly/>
                                    </div>
                                    <div class="col-sm common-box common-box input-box pt-4 me-2">
                                        <span>주소 <span class="star">*</span></span>
                                        <input type="text" name="user_address" maxlength="40" value="${profile.user_address}"/>
                                    </div>
                                </div>
                            </div>
                            <!-- 개인정보 끝 -->
                        </div>
                        <!-- 인적사항 끝 -->
                        <hr>
                        <!-- 학력 -->
                        <div id="schFrm">
                            <header class="header">학력
                                <span>
                                <button type="button" class="btn btn-primary add_field"
                                        data-target="schFrm">ADD</button>
                            </span>
                            </header>
                            <div class="col-md g-0 add-main">
                                <c:forEach var="i" begin="1" end="3">
                                    <c:set var="eduKey" value="edu${i}_school_name"/>
                                    <c:if test="${profile[eduKey] ne ''}">
                                        <!-- 첫번째 row -->
                                        <div class="row mb-2 g-0 add">
                                            <div class="col-sm-1 common-box input-box pt-4">
                                                <c:set var="gubunKey" value="edu${i}_gubun"/>
                                                <span>학교구분</span>
                                                <select name="edu${i}_gubun" class="form-select schGb"
                                                        style="width: 100px; font-size: 12px;">
                                                    <option value="">선택해주세요</option>
                                                    <option value="010" ${profile[gubunKey] == '010' ? 'selected' : ''}>
                                                        고등학교
                                                    </option>
                                                    <option value="011" ${profile[gubunKey] == '011' ? 'selected' : ''}>
                                                        대학교(2,3년)
                                                    </option>
                                                    <option value="012" ${profile[gubunKey] == '012' ? 'selected' : ''}>
                                                        대학교(4년)
                                                    </option>
                                                    <option value="013" ${profile[gubunKey] == '013' ? 'selected' : ''}>
                                                        대학원
                                                    </option>
                                                </select>
                                            </div>
                                            <div class="col-sm-3 common-box input-box pt-4 me-2">
                                                <span>학교명</span>
                                                <input type="text" name="edu${i}_school_name" maxlength="15"
                                                       value="${profile[eduKey]}"/>
                                            </div>
                                            <div class="col-sm-2 common-box input-box pt-4">
                                                <c:set var="startDateKey" value="edu${i}_start_date"/>
                                                <span>입학년월</span>
                                                <input type="text" name="edu${i}_start_date" class="dateFmt" maxlength="10"
                                                       value="${profile[startDateKey]}"/>
                                            </div>
                                            <div class="col-sm-2 common-box input-box pt-4 me-2">
                                                <c:set var="endDateKey" value="edu${i}_end_date"/>
                                                <span>졸업년월</span>
                                                <input type="text" name="edu${i}_end_date" class="dateFmt" maxlength="10"
                                                       value="${profile[endDateKey]}"/>
                                            </div>
                                            <div class="col-sm-1 common-box input-box pt-4 me-2">
                                                <c:set var="statusKey" value="edu${i}_grad_status"/>
                                                <span>졸업상태</span>
                                                <select name="edu${i}_grad_status" class="form-select"
                                                        style="width: 100px; font-size: 12px">
                                                    <option value="">선택해주세요</option>
                                                    <option value="001" ${profile[statusKey] == '001' ? 'selected' : ''}>
                                                        졸업
                                                    </option>
                                                    <option value="002" ${profile[statusKey] == '002' ? 'selected' : ''}>
                                                        졸업예정
                                                    </option>
                                                    <option value="003" ${profile[statusKey] == '003' ? 'selected' : ''}>
                                                        재학중
                                                    </option>
                                                </select>
                                            </div>
                                            <c:if test="${i eq 1}">
                                                <div class="col-sm-1" style="text-align: center; padding-top: 15px;">
                                                    <button type="button" class="btn btn-danger clear_field"
                                                            onclick="clearField()">CLEAR
                                                    </button>
                                                </div>
                                            </c:if>
                                            <c:if test="${i ne 1}">
                                                <div class="col-sm-1" style="text-align: center; padding-top: 15px;">
                                                    <button type="button" class="btn btn-danger remove-field"
                                                            data-target="schFrm">REMOVE
                                                    </button>
                                                </div>
                                            </c:if>
                                        </div>
                                    </c:if>
                                </c:forEach>
                                <c:if test="${profile.edu1_school_name eq ''}">
                                    <!-- 첫번째 row -->
                                    <div class="row mb-2 g-0 add">
                                        <div class="col-sm-1 common-box input-box pt-4">
                                            <span>학교구분</span>
                                            <select name="edu1_gubun" class="form-select schGb"
                                                    style="width: 100px; font-size: 12px">
                                                <option value="">선택해주세요</option>
                                                <option value="010">고등학교</option>
                                                <option value="011">대학교(2,3년)</option>
                                                <option value="012">대학교(4년)</option>
                                                <option value="013">대학원</option>
                                            </select>
                                        </div>
                                        <div class="col-sm-3 common-box input-box pt-4 me-2">
                                            <span>학교명</span>
                                            <input type="text" name="edu1_school_name" maxlength="15"/>
                                        </div>
                                        <div class="col-sm-2 common-box input-box pt-4">
                                            <span>입학년월</span>
                                            <input type="text" name="edu1_start_date" class="dateFmt"/>
                                        </div>
                                        <div class="col-sm-2 common-box input-box pt-4 me-2">
                                            <span>졸업년월</span>
                                            <input type="text" name="edu1_end_date" class="dateFmt"/>
                                        </div>
                                        <div class="col-sm-1 common-box input-box pt-4 me-2">
                                            <span>졸업상태</span>
                                            <select name="edu1_grad_status" class="form-select"
                                                    style="width: 100px; font-size: 12px">
                                                <option value="">선택해주세요</option>
                                                <option value="001">졸업</option>
                                                <option value="002">졸업예정</option>
                                                <option value="003">재학중</option>
                                            </select>
                                        </div>
                                        <div class="col-sm-1" style="text-align: center; padding-top: 15px;">
                                            <button type="button" class="btn btn-danger clear_field" onclick="clearField()">
                                                CLEAR
                                            </button>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                            <!-- 두번째 row -->
                            <div id="schSub" class="row mb-2 g-0"
                                 style="<c:if test="${profile.major eq '' || profile.major eq null}">display: none;</c:if>">
                                <div class="col-sm-3 common-box input-box pt-4 me-2">
                                    <span>전공명</span>
                                    <input type="text" name="major" maxlength="18" value="${profile.major}"/>
                                </div>
                                <div class="col-sm-3 common-box input-box pt-4 me-2">
                                    <span>복수전공명</span>
                                    <input type="text" name="double_major" maxlength="18" value="${profile.double_major}"/>
                                </div>
                                <div class="col-sm-1 common-box input-box pt-4">
                                    <span>학점</span>
                                    <input type="text" name="total_grade" class="grade" maxlength="3"
                                           onkeyup="onlyDot(this)" value="${profile.total_grade}"/>
                                </div>
                                <div class="col-sm-1 common-box input-box pt-4">
                                    <span>총점</span>
                                    <input type="text" name="standard_grade" class="grade" maxlength="3"
                                           onkeyup="onlyDot(this)" value="${profile.standard_grade}"/>
                                </div>
                            </div>
                        </div>
                        <!-- 학력 끝 -->
                    </div>
                </div>
            </form>
            <!-- 프로필 끝-->
            <!-- 자격증 -->
            <form id="qualification">
                <div class="form-floating" id="qlFrm">
                    <h2 class="header">자격증
                        <span>
                        <button type="button" class="btn btn-primary add_field" data-target="qlFrm">ADD</button>
                        <button type="button" class="btn btn-outline-success" data-name="qualification"
                                onclick="goSave(this)">SAVE</button>
                    </span>
                    </h2>
                    <div class="common-box row-box row mb-5 g-0">
                        <div class="col-md g-0 add-main">
                            <c:choose>
                                <c:when test="${not empty profile.qualificationList}">
                                    <c:forEach var="qualification" items="${profile.qualificationList}"
                                               varStatus="qlStatus">
                                        <div class="row mb-2 g-0 add" id="qualificationList_${qlStatus.index}">
                                            <input type="hidden" name="qualificationList[${qlStatus.index}].qualification_seq"
                                                   class="seq" value="${qualification.qualification_seq}">
                                            <div class="col-sm-2 common-box input-box pt-4 me-2">
                                                <span>자격증명</span>
                                                <input type="text" name="qualificationList[${qlStatus.index}].qualification_nm"
                                                       maxlength="18" value="${qualification.qualification_nm}">
                                            </div>
                                            <div class="col-sm-2 common-box input-box pt-4 me-2">
                                                <span>발행기관</span>
                                                <input type="text" name="qualificationList[${qlStatus.index}].issuer"
                                                       maxlength="18" value="${qualification.issuer}"/>
                                            </div>
                                            <div class="col-sm-2 common-box input-box pt-4">
                                                <span>취득일자</span>
                                                <input type="text" name="qualificationList[${qlStatus.index}].acquisition_date"
                                                       class="dateFmt" maxlength="10" value="${qualification.acquisition_date}"/>
                                            </div>
                                            <div class="col-sm-2 common-box input-box pt-4">
                                                <span>만기일자</span>
                                                <input type="text" name="qualificationList[${qlStatus.index}].expiry_date"
                                                       class="dateFmt" maxlength="10" value="${qualification.expiry_date}"/>
                                            </div>
                                            <div class="col-sm-1" style="text-align: center; padding-top: 15px;">
                                                <c:choose>
                                                    <c:when test="${qlStatus.index == 0}">
                                                        <button type="button" class="btn btn-danger clear_field"
                                                                onclick="clearField()">CLEAR
                                                        </button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button type="button" class="btn btn-danger remove-field"
                                                                data-target="qlFrm">REMOVE
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="row mb-2 g-0 add" id="qualificationList_0">
                                        <input type="hidden" name="qualificationList[0].qualification_seq"
                                               class="seq" value="1">
                                        <div class="col-sm-2 common-box input-box pt-4 me-2">
                                            <span>자격증명</span>
                                            <input type="text" name="qualificationList[0].qualification_nm" maxlength="18"/>
                                        </div>
                                        <div class="col-sm-2 common-box input-box pt-4 me-2">
                                            <span>발행기관</span>
                                            <input type="text" name="qualificationList[0].issuer" maxlength="18"/>
                                        </div>
                                        <div class="col-sm-2 common-box input-box pt-4">
                                            <span>취득일자</span>
                                            <input type="text" name="qualificationList[0].acquisition_date"
                                                   class="dateFmt" maxlength="10"/>
                                        </div>
                                        <div class="col-sm-2 common-box input-box pt-4">
                                            <span>만기일자</span>
                                            <input type="text" name="qualificationList[0].expiry_date"
                                                   class="dateFmt" maxlength="10"/>
                                        </div>
                                        <div class="col-sm-1" style="text-align: center; padding-top: 15px;">
                                            <button type="button" class="btn btn-danger clear_field"
                                                    onclick="clearField()">CLEAR
                                            </button>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </form>
            <!-- 자격증 끝 -->
            <!-- 경력 -->
            <div class="form-floating">
                <h2 class="header">경력</h2>
                <div class="common-box row-box row mb-5 g-0">
                    <!-- 근무경력 -->
                    <form id="workExperience">
                        <div class="pb-3" id="workFrm">
                            <header class="header">근무경력
                                <span name="wk_career" class="fw-bolder" style="font-size: 12px;"></span>
                                <span>
                                <button type="button" class="btn btn-primary add_field"
                                        data-target="workFrm">ADD
                                </button>
                                <button type="button" class="btn btn-outline-success"
                                        data-name="workExperience" onclick="goSave(this)">SAVE
                                </button>
                            </span>
                            </header>
                            <div class="col-md g-0 add-main">
                                <c:choose>
                                    <c:when test="${not empty profile.workExperienceList}">
                                        <c:forEach var="work" items="${profile.workExperienceList}" varStatus="wkStatus">
                                            <div id="workExperienceList_${wkStatus.index}" class="row mb-2 g-0 add">
                                                <input type="hidden" name="workExperienceList[${wkStatus.index}].work_seq"
                                                       class="seq" value="${work.work_seq}"/>
                                                <div class="col-sm-3 common-box input-box pt-4 me-2">
                                                    <span>회사명</span>
                                                    <input type="text" name="workExperienceList[${wkStatus.index}].work_place"
                                                           maxlength="18" value="${work.work_place}"/>
                                                </div>
                                                <div class="col-sm-2 common-box input-box pt-4">
                                                    <span>입사일자</span>
                                                    <input type="text" name="workExperienceList[${wkStatus.index}].work_start_date"
                                                           class="dateFmt" maxlength="10" value="${work.work_start_date}"/>
                                                </div>
                                                <div class="col-sm-2 common-box input-box pt-4">
                                                    <span>퇴사일자</span>
                                                    <input type="text" name="workExperienceList[${wkStatus.index}].work_end_date"
                                                           class="dateFmt" maxlength="10" value="${work.work_end_date}"/>
                                                </div>
                                                <div class="col-sm-1" style="text-align: center; padding-top: 15px;">
                                                    <c:choose>
                                                        <c:when test="${wkStatus.index == 0}">
                                                            <button type="button" class="btn btn-danger clear_field"
                                                                    onclick="clearField()">CLEAR
                                                            </button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button type="button" class="btn btn-danger remove-field"
                                                                    data-target="workFrm">REMOVE
                                                            </button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="row mb-2 g-0 add" id="workExperienceList_0">
                                            <input type="hidden" name="workExperienceList[0].work_seq" class="seq"/>
                                            <div class="col-sm-3 common-box input-box pt-4 me-2">
                                                <span>회사명</span>
                                                <input type="text" name="workExperienceList[0].work_place" maxlength="18"/>
                                            </div>
                                            <div class="col-sm-2 common-box input-box pt-4">
                                                <span>입사일자</span>
                                                <input type="text" name="workExperienceList[0].work_start_date"
                                                       class="dateFmt" maxlength="10"/>
                                            </div>
                                            <div class="col-sm-2 common-box input-box pt-4">
                                                <span>퇴사일자</span>
                                                <input type="text" name="workExperienceList[0].work_end_date"
                                                       class="dateFmt" maxlength="10"/>
                                            </div>
                                            <div class="col-sm-1" style="text-align: center; padding-top: 15px;">
                                                <button type="button" class="btn btn-danger clear_field"
                                                        onclick="clearField()">CLEAR
                                                </button>
                                            </div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </form>
                    <!-- 근무경력 끝-->
                    <hr>
                    <!-- 수행경력 -->
                    <form id="project">
                        <div id="pjFrm">
                            <header class="header">수행경력
                                <span name="pj_career" class="fw-bolder" style="font-size: 12px;"></span>
                                <span>
                                <button type="button" class="btn btn-primary" data-target="pjFrm"
                                        onclick="addProject()">ADD
                                </button>
                                <button type="button" class="btn btn-outline-success"
                                        data-name="project" onclick="goSave(this)">SAVE
                                </button>
                            </span>
                            </header>
                            <div class="table-responsive common-box p-3">
                                <header>진행사항</header>
                                <table class="table table-hover mb-5">
                                    <colgroup>
                                        <col style="width: 5%;">
                                        <col style="width: 15%;">
                                        <col style="width: 30%;">
                                        <col style="width: 20%;">
                                        <col style="width: 15%;">
                                        <col style="width: 5%;">
                                        <col style="width: 5%;">
                                        <col style="width: 5%;">
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
                                                <td colspan="8" style="text-align: center;">진행중인 사업이 없습니다</td>
                                            </tr>
                                            </tbody>
                                        </c:when>
                                        <c:otherwise>
                                            <tbody id="project_ing" class="table-group-divider">
                                            <c:set var="count_ing" value="1"/>
                                            <c:forEach var="project_ing" items="${profile.projectList}" varStatus="pjStatus">
                                                <fmt:parseDate var="project_end_date" value="${project_ing.project_end_date}"
                                                               pattern="yyyyMMdd"/>
                                                <fmt:formatDate value="${project_end_date}" pattern="yyyy-MM-dd"
                                                                var="project_end_date"/>
                                                <c:if test="${today <= project_end_date}">
                                                    <tr id="projectList_${pjStatus.index}" class="add">
                                                        <td>${count_ing}</td>
                                                        <input type="hidden" name="projectList[${pjStatus.index}].project_seq"
                                                               value="${project_ing.project_seq}"/>
                                                        <input type="hidden" name="projectList[${pjStatus.index}].use_yn"
                                                               class="useYn" value="${project_ing.use_yn}"/>
                                                        <td><input type="text" name="projectList[${pjStatus.index}].project_client"
                                                                   maxlength="18" value="${project_ing.project_client}"/></td>
                                                        <td><input type="text" name="projectList[${pjStatus.index}].project_nm"
                                                                   maxlength="18" value="${project_ing.project_nm}"/></td>
                                                        <td><input type="text"
                                                                   name="projectList[${pjStatus.index}].project_start_date"
                                                                   class="dateFmt" maxlength="10"
                                                                   value="${project_ing.project_start_date}"/>
                                                            ~ <input type="text"
                                                                     name="projectList[${pjStatus.index}].project_end_date"
                                                                     class="dateFmt" maxlength="10"
                                                                     value="${project_ing.project_end_date}"/></td>
                                                        <td>
                                                            <select name="projectList[${pjStatus.index}].assigned_task_lar"
                                                                    class="form-select" style="width: auto"
                                                                    onchange="selectTaskLar(this)">
                                                                <c:forEach var="taskLarList" items="${taskLarList}">
                                                                    <option value="${taskLarList.code_id}"
                                                                            <c:if test="${taskLarList.code_id eq project_ing.assigned_task_lar}">selected</c:if>>${taskLarList.code_value}</option>
                                                                </c:forEach>
                                                            </select>
                                                            <select name="projectList[${pjStatus.index}].assigned_task_mid"
                                                                    class="form-select" style="width: auto">
                                                                <c:forEach var="taskMidList" items="${taskMidList}">
                                                                    <option value="${taskMidList.code_id}"
                                                                            <c:if test="${taskMidList.code_id eq project_ing.assigned_task_mid}">selected</c:if>>${taskMidList.code_value}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </td>
                                                        <td>
                                                            <select name="projectList[${pjStatus.index}].project_role"
                                                                    class="form-select" style="width: auto">
                                                                <c:forEach var="roleList" items="${roleList}">
                                                                    <option value="${roleList.code_id}"
                                                                            <c:if test="${roleList.code_id eq project_ing.project_role}">selected</c:if>>${roleList.code_value}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </td>
                                                        <td>
                                                            <input type="button" class="btn btn-warning"
                                                                   onclick="viewSkill(${project_ing.project_seq}, '1')" value="수정"/>
                                                        </td>
                                                        <td>
                                                            <input type="button" class="btn btn-danger"
                                                                   onclick="remove(this, 'old')" value="REMOVE"/>
                                                        </td>
                                                    </tr>
                                                    <c:set var="count_ing" value="${count_ing+1}"/>
                                                </c:if>
                                            </c:forEach>
                                            </tbody>
                                        </c:otherwise>
                                    </c:choose>
                                </table>
                                <header>이력사항</header>
                                <table class="table table-hover">
                                    <colgroup>
                                        <col style="width: 5%;">
                                        <col style="width: 15%;">
                                        <col style="width: 30%;">
                                        <col style="width: 20%;">
                                        <col style="width: 15%;">
                                        <col style="width: 5%;">
                                        <col style="width: 5%;">
                                        <col style="width: 5%;">
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
                                                <td colspan="8" style="text-align: center;">참여했던 사업이 없습니다</td>
                                            </tr>
                                            </tbody>
                                        </c:when>
                                        <c:otherwise>
                                            <tbody id="project_hist" class="table-group-divider">
                                            <c:set var="count_hist" value="1"/>
                                            <c:forEach var="project_hist" items="${profile.projectList}" varStatus="pjStatus">
                                                <fmt:parseDate var="project_end_date" value="${project_hist.project_end_date}"
                                                               pattern="yyyyMMdd"/>
                                                <fmt:formatDate value="${project_end_date}" pattern="yyyy-MM-dd"
                                                                var="project_end_date"/>
                                                <c:if test="${today > project_end_date}">
                                                    <tr id="projectList_${pjStatus.index}" class="add">
                                                        <td>${count_hist}</td>
                                                        <input type="hidden" name="projectList[${pjStatus.index}].project_seq"
                                                               value="${project_hist.project_seq}"/>
                                                        <input type="hidden" name="projectList[${pjStatus.index}].use_yn"
                                                               class="useYn" value="${project_hist.use_yn}"/>
                                                        <td><input type="text" name="projectList[${pjStatus.index}].project_client"
                                                                   maxlength="18" value="${project_hist.project_client}"/></td>
                                                        <td><input type="text" name="projectList[${pjStatus.index}].project_nm"
                                                                   maxlength="18" value="${project_hist.project_nm}"/></td>
                                                        <td><input type="text"
                                                                   name="projectList[${pjStatus.index}].project_start_date"
                                                                   class="dateFmt" maxlength="10"
                                                                   value="${project_hist.project_start_date}"/>
                                                            ~ <input type="text"
                                                                     name="projectList[${pjStatus.index}].project_end_date"
                                                                     class="dateFmt" maxlength="10"
                                                                     value="${project_hist.project_end_date}"/>
                                                        </td>
                                                        <td>
                                                            <select name="projectList[${pjStatus.index}].assigned_task_lar"
                                                                    class="form-select" style="width: auto">
                                                                <c:forEach var="taskLarList" items="${taskLarList}">
                                                                    <option value="${taskLarList.code_id}"
                                                                            <c:if test="${taskLarList.code_id eq project_hist.assigned_task_lar}">selected</c:if>>${taskLarList.code_value}</option>
                                                                </c:forEach>
                                                            </select>
                                                            <select name="projectList[${pjStatus.index}].assigned_task_mid"
                                                                    class="form-select" style="width: auto">
                                                                <c:forEach var="taskMidList" items="${taskMidList}">
                                                                    <option value="${taskMidList.code_id}"
                                                                            <c:if test="${taskMidList.code_id eq project_hist.assigned_task_mid}">selected</c:if>>${taskMidList.code_value}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </td>
                                                        <td>
                                                            <select name="projectList[${pjStatus.index}].project_role"
                                                                    class="form-select" style="width: auto">
                                                                <c:forEach var="roleList" items="${roleList}">
                                                                    <option value="${roleList.code_id}"
                                                                            <c:if test="${roleList.code_id eq project_hist.project_role}">selected</c:if>>${roleList.code_value}</option>
                                                                </c:forEach>
                                                            </select>
                                                        <td>
                                                            <input type="button" class="btn btn-warning"
                                                                   onclick="viewSkill(${project_hist.project_seq}, '1')" value="수정"/>
                                                        </td>
                                                        <td>
                                                            <input type="button" class="btn btn-danger"
                                                                   onclick="remove(this, 'old')" value="REMOVE"/>
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
                listNm = "edu";
            }
            $(this).closest(".add").remove();
            updateRowIndex(frmId, listNm);

            if (frmId === 'schFrm') {
                $(".schGb").trigger("change");
            }
        });

        // 학교 구분 제어
        $(document).on("change", ".schGb", function () {
            const chkArr = ["011", "012", "013"];
            let show = false;
            $(".schGb").each(function () {
                if (chkArr.includes($(this).val())) {
                    show = true;
                    return;
                }
            });
            if (show) {
                $("#schSub").show();
            } else {
                $("#schSub").hide();
            }
        });

        // 날짜 및 휴대전화 실시간 포맷
        $(".container").on("keyup", ".dateFmt, .telFmt", function () {
            formatInput($(this));
        });

        // 프로필이미지 등록
        $("#imgFile").on("change", function(e){
            /*최대 파일크기 2MB(2097152) */
            const fileInfo = e.target.files[0];
            const maxSize = 1024*1024*2; // 최대 크기 2MB
            const basicImg = "/image/image.png"; // 기본 이미지 경로
            chgImg = true;

            // 파일 선택 취소
            if(!fileInfo){
                $(".edit").attr("src", basicImg);
                chgImg = false;
                return;
            }
            // 파일 크기 검증
            if(fileInfo.size > maxSize){
                alert("이미지 사진의 용량이 2MB를 초과합니다.");
                return;
            }
            // 파일 형식 검증
            const allowedExtensions = ['image/jpeg', 'image/png', 'image/jpg'];
            if(!allowedExtensions.includes(fileInfo.type)){
                alert("이미지 파일만 업로드 가능합니다.");
                return;
            }
            // 파일 미리보기
            const reader = new FileReader();
            reader.onload = function(e){
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
            let schCnt = $("#schFrm .add-main")[0].childElementCount;

            if (frmId == 'qlFrm') {
                listNm = 'qualificationList';
                newRow =
                    `<div class="row mb-2 g-0 add" id="qualificationList_">
                            <input type="hidden" class="seq" name="qualificationList[].qualification_seq" value=""/>
                            <div class="col-sm-2 common-box input-box pt-4 me-2">
                                <span>자격증명</span>
                                <input type="text" name="qualificationList[].qualification_nm" maxlength="18"/>
                            </div>
                            <div class="col-sm-2 common-box input-box pt-4 me-2">
                                <span>발행기관</span>
                                <input type="text" name="qualificationList[].issuer" maxlength="18"/>
                            </div>
                            <div class="col-sm-2 common-box input-box pt-4">
                                <span>취득일자</span>
                                <input type="text" class="dateFmt" maxlength="10" name="qualificationList[].acquisition_date"/>
                            </div>
                            <div class="col-sm-2 common-box input-box pt-4">
                                <span>만기일자</span>
                                <input type="text" class="dateFmt" maxlength="10" name="qualificationList[].expiry_date"/>
                            </div>
                            <div class="col-sm-1" style="text-align: center; padding-top: 15px;"><button type="button" class="btn btn-danger remove-field" data-target="qlFrm">REMOVE</button></div>
                        </div>`;
            } else if (frmId == 'workFrm') {
                listNm = 'workExperienceList';
                newRow =
                    `<div class="row mb-2 g-0 add" id="workExperienceList_">
                                        <input type="hidden" class="seq" name="workExperienceList[].work_seq" value=""/>
                                        <div class="col-sm-3 common-box input-box pt-4 me-2">
                                            <span>회사명</span>
                                            <input type="text" name="workExperienceList[].work_place" maxlength="18"/>
                                        </div>
                                        <div class="col-sm-2 common-box input-box pt-4">
                                            <span>입사일자</span>
                                            <input type="text" class="dateFmt" maxlength="10" name="workExperienceList[].work_start_date"/>
                                        </div>
                                        <div class="col-sm-2 common-box input-box pt-4">
                                            <span>퇴사일자</span>
                                            <input type="text" class="dateFmt" maxlength="10" name="workExperienceList[].work_end_date"/>
                                        </div>
                                        <div class="col-sm-1" style="text-align: center; padding-top: 15px;">
                                            <button type="button" class="btn btn-danger remove-field" data-target="workFrm">REMOVE</button>
                                        </div>
                                    </div>`;
            } else if (frmId == 'schFrm') {
                listNm = 'edu';
                newRow = `<div class="row mb-2 g-0 add">
                            <div class="col-sm-1 common-box input-box pt-4">
                                <span>학교구분</span>
                                <select class="form-select schGb" style="width: 100px; font-size: 12px"
                                        name="edu1_gubun">
                                    <option value="">선택해주세요</option>
                                    <option value="010">고등학교</option>
                                    <option value="011">대학교(2,3년)</option>
                                    <option value="012">대학교(4년)</option>
                                    <option value="013">대학원</option>
                                </select>
                            </div>
                            <div class="col-sm-3 common-box input-box pt-4 me-2">
                                <span>학교명</span>
                                <input type="text" name="edu1_school_name" maxlength="15"/>
                            </div>
                            <div class="col-sm-2 common-box input-box pt-4">
                                <span>입학년월</span>
                                <input type="text" class="dateFmt" maxlength="10" name="edu1_start_date"/>
                            </div>
                            <div class="col-sm-2 common-box input-box pt-4 me-2">
                                <span>졸업년월</span>
                                <input type="text" class="dateFmt" maxlength="10" name="edu1_end_date"/>
                            </div>
                            <div class="col-sm-1 common-box input-box pt-4 me-2">
                                <span>졸업상태</span>
                                <select class="form-select" style="width: 100px; font-size: 12px"
                                        name="edu1_grad_status">
                                    <option value="">선택해주세요</option>
                                    <option value="001">졸업</option>
                                    <option value="002">졸업예정</option>
                                    <option value="003">재학중</option>
                                </select>
                            </div>
                            <div class="col-sm-1" style="text-align: center; padding-top: 15px;">
                                <button type="button" class="btn btn-danger remove-field" data-target="schFrm">REMOVE</button>
                                </button>
                            </div>
                        </div>
                    `;
                if (schCnt == 3) {
                    alert("학력은 3개 이상 작성 할 수 없습니다");
                    return;
                }
            }
            $("#" + frmId + " .add-main").append(newRow);
            updateRowIndex(frmId, listNm);
        });

    });

    // 항목 추가/제거 시 index 정렬
    function updateRowIndex(frmId, listNm) {
        $("#" + frmId + " .add").each(function (i) {
            if (frmId == 'schFrm') {
                i += 1;
                $(this).find("input, select").each(function () {
                    let name = $(this).attr("name");
                    if (name && name.startsWith(listNm)) {
                        let newName = name.replace(/edu\d+_/, 'edu' + i + '_');
                        $(this).attr("name", newName);
                    }
                });
            } else {
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
            }
        });
    }

    // input 초기화
    function clearField() {
        alert("아직 구현중");
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
                    <td><input type="text" name="projectList[].project_client" maxlength="18"
                               value="` + data.project_client + `" readonly/></td>
                    <td><input type="text" name="projectList[].project_nm" maxlength="18"
                               value="` + data.project_nm + `" readonly/></td>
                    <td><input type="text" class="dateFmt" maxlength="10"
                               name="projectList[].project_start_date"
                               value="` + data.project_start_date + `" readonly/>
                        ~ <input type="text" class="dateFmt" maxlength="10"
                                 name="projectList[].project_end_date"
                                 value="` + data.project_end_date + `" readonly/></td>
                    <td>
                        <input type="hidden" name="projectList[].assigned_task_lar" value="` + data.assigned_task_lar + `"/>
                        <select class="form-select" style="width: auto" disabled>
                                <option>` + data.assigned_task_lar_nm + `</option>
                        </select>
                        <input type="hidden" name="projectList[].assigned_task_mid" value="` + data.assigned_task_mid + `"/>
                        <select class="form-select" style="width: auto" disabled>
                                <option>` + data.assigned_task_mid_nm + `</option>
                        </select>
                    </td>
                    <td>
                        <input type="hidden" name="projectList[].project_role" value="` + data.project_role + `"/>
                        <select class="form-select" style="width: auto" disabled>
                                <option>` + data.project_role_nm + `</option>
                        </select>
                    <td>

                    </td>
                    <td>
                        <input type="button" class="btn btn-danger"
                               onclick="remove(this, 'new')" value="REMOVE"/>
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
        let properties = "width=600, height=400";
        window.open(url, "viewSkill", properties)
    }

    function excel() {
        alert("엑셀다운기능 준비중");
    }

    function goModify() {
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
        const chkArr = ["011", "012", "013"];
        let isValid = true;
        let cnt = 0;

        $(".schGb").each(function () {
            const schGbValue = $(this).val();
            if (chkArr.includes(schGbValue)) {
                cnt++;
            }
        });
        if (cnt > 0) {
            $(".grade").each(function () {
                const grade = $(this).val();
                if (!chkGrade(grade)) {
                    alert("학점, 혹은 총점 입력값이 올바르지 않습니다");
                    $(this).focus();
                    isValid = false;
                    return false;
                }
            });
        } else {
            $(".grade").val('');
            $("input[name=major]").val('');
            $("input[name=double_major]").val('');
        }

        return isValid;
    }

    // 날짜 검증
    function validateDates(frmId) {
        let isValidDates = true;
        $("#" + frmId).find(".dateFmt").each(function () {
            const date = $(this).val();
            if (!chkDate(date)) {
                alert("입력일자를 확인해주세요");
                $(this).focus();
                isValidDates = false;
                return false;
            }
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
                console.log(name + " - " + input);
                const nullable = ['major', 'double_major', 'total_grade', 'standard_grade', 'imgFile'];
                if (!nullable.includes(name) && input === '') {
                    alert("항목을 입력하세요");
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
                    if (!endVal) {
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
            frm = {frmNm: "schFrm", startDt: "start_date", endDt: "end_date"}
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


</script>

</body>
</html>
