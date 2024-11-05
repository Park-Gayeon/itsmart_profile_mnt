<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <%-- 웹 앱 반응형 --%>
    <meta name="viewport" content="width=device-width", initial-scale="1">
    <link rel="stylesheet" href="/css/bootstrap.css">
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
            <div class="row-box row">
                <!-- 사진 -->
                <div class="col-md-2">
                    <img src="/image/image.png" class="img-profile" style="height: 150px" alt="Profile Picture">
                </div>
                <!-- 개인정보 -->
                <div class="col-md-10">
                    <div class="row mb-2">
                        <div class="col-sm-3">이름</div>
                        <div class="col-sm-9">${profile.user_nm}</div>
                    </div>
                    <div class="row mb-2">
                        <div class="col-sm-3">생년월일</div>
                        <div class="col-sm-9">${profile.user_birth}</div>
                    </div>
                    <div class="row mb-2">
                        <div class="col-sm-3">입사일자</div>
                        <div class="col-sm-9">${profile.hire_date}</div>
                    </div>
                    <!-- 추가 정보 -->
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
