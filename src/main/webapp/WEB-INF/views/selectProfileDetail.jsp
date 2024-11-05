<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <%-- 웹 앱 반응형 --%>
    <meta name="viewport" content="width=device-width", initial-scale="1">
    <link rel="stylesheet" href="/css/bootstrap.css">
    <link rel="stylesheet" href="/css/basic.css">
    <link  rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <title>직원 프로필관리 시스템</title>
</head>

<body>
<!-- header.jsp -->
<%@ include file="layout/header.jsp" %>
<!-- header.jsp -->

<!-- main-content -->
<div class="content">
    <div class="container">
        <!-- 첫번째  row > 프로필 사진이랑 기본 인적사항 -->
        <div class="form-floating">
            <h2 class="header">인적사항
                <div class="description"><span class="star">*</span> 필수 입력 정보입니다.</div>
            </h2>
            <div class="row-box row g-0">
                <!-- 사진 -->
                <div class="col-md-2 text-center">
                    <img src="/image/image.png" class="img-profile" style="height: 150px" alt="Profile Picture">
                </div>
                <!-- 개인정보 -->
                <div class="col-md-10 g-0">
                <!-- 첫번째 row -->
                    <div class="row mb-2 g-0">
                        <div class="col-sm-2 input-box-1">
                            <label for="user_nm">이름 <span class="star">*</span></label>
                            <input type="text" name="user_nm" id="user_nm" value="${profile.user_nm}"/>
                        </div>
                        <div class="col-sm-2 input-box-1">
                            <label for="user_birth">생년월일 <span class="star">*</span></label>
                            <input type="text" name="user_birth" id="user_birth" value="${profile.user_birth}"/>
                        </div>
                        <div class="col-sm-2 input-box-1">
                            <label for="user_phone">휴대전화 <span class="star">*</span></label>
                            <input type="text" name="user_phone" id="user_phone" value="${profile.user_phone}"/>
                        </div>
                        <div class="col-sm-2 input-box-1">
                            <label for="user_id">직원ID <span class="star">*</span></label>
                            <input type="email" name="user_id" id="user_id" value="${profile.user_id}"/>
                        </div>
                        <div class="col-sm input-box-1">
                            <label for="user_email">이메일 <span class="star">*</span></label>
                            <input type="email" id="user_email" value="${profile.user_id}@itsmart.co.kr" readonly/>
                        </div>
                    </div>
                <!-- 두번째 row -->
                    <div class="row mb-2 g-0">
                        <div class="col-sm-2 input-box-1">
                            <label for="user_department">소속 <span class="star">*</span></label>
                            <input type="text" name="user_department" id="user_department" value="${profile.user_department}"/>
                        </div>
                        <div class="col-sm-2 input-box-1">
                            <label for="user_position">직위/직급 <span class="star">*</span></label>
                            <input type="text" name="user_position" id="user_position" value="${profile.user_position}"/>
                        </div>
                        <div class="col-sm-2 input-box-1">
                            <label for="hire_date">입사일자 <span class="star">*</span></label>
                            <input type="email" name="hire_date" id="hire_date" value="${profile.hire_date}"/>
                        </div>
                        <div class="col-sm input-box-1">
                            <label for="user_address">주소 <span class="star">*</span></label>
                            <input type="text" name="user_address" id="user_address" value="${profile.user_address}"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- main-content -->

<!-- footer.jsp -->
<%@ include file="layout/footer.jsp" %>
<!-- footer.jsp -->

</body>
<%-- jquery cdn--%>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<%-- js cdn--%>
<script src="js/bootstrap.js"></script>
<script src="js/bootstrap.bundle.js"></script>
</html>
