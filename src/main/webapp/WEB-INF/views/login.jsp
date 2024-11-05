<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <%-- 웹 앱 반응형 --%>
    <meta name="viewport" content="width=device-width", initial-scale="1">
    <link  rel="stylesheet" href="/css/sign-in.css">
    <link rel="stylesheet" href="/css/bootstrap.css">
    <title>직원 프로필관리 시스템</title>
</head>

<body>
<!-- header.jsp -->
<%@ include file="layout/header.jsp" %>
<!-- TODO : 로그인 화면에서는 nav 비 활성화 필요 -->
<!-- header.jsp -->

<!-- main-content -->
<main class="content">
    <div class="form-signin w-100 m-auto">
        <div class="logo">
            <div class="logo-image">
                <img src="/image/arrow-through-heart.svg" alt="logo" class="bi pe-none me-2">
            </div>
            <p>LOGIN</p>
        </div>
        <form>
            <div class="form-floating">
                <input type="text" class="form-control" id="floatingInput" placeholder="ID">
                <label for="floatingInput">ID</label>
            </div>
            <div class="form-floating">
                <input type="password" class="form-control" id="floatingPassword" placeholder="PW">
                <label for="floatingPassword">PW</label>
            </div>
            <button class="btn btn-dark w-100 py-2" style="margin-top: 30px" type="submit">로그인</button>
        </form>
    </div>
</main>
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
