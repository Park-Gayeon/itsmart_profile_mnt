<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <%-- 웹 앱 반응형 --%>
    <meta name="viewport" content="width=device-width" , initial-scale="1">
    <link rel="stylesheet" href="/css/login.css">
    <link rel="stylesheet" href="/css/basic.css">
    <link rel="stylesheet" href="/css/bootstrap.css">
    <title>직원 프로필관리 시스템</title>
</head>
<body>
<!-- header.jsp -->
<%@ include file="layout/header.jsp" %>
<!-- header.jsp -->

<!-- main-content -->
<main class="content">
    <div class="form-signin w-100 m-auto">
        <div class="logo pb-3">
            <div class="logo-image">
                <img src="/images/person-circle.svg" alt="logo" class="bi pe-none me-2">
            </div>
            <p>반갑습니다 :-)</p>
        </div>
        <form id="frm">
            <div class="form-floating">
                <input type="text" class="form-control" id="floatingInput" name="user_id" placeholder="ID">
                <label for="floatingInput">ID</label>
            </div>
            <div class="form-floating">
                <input type="password" class="form-control" id="floatingPassword" name="user_pw" placeholder="PW" autoComplete="off">
                <label for="floatingPassword">PW</label>
            </div>
        </form>
        <button id="login" class="btn btn-dark w-100 py-2"><span class="basic-medium">로그인</span></button>
    </div>
</main>
<!-- main-content -->

<!-- footer.jsp -->
<%@ include file="layout/footer.jsp" %>
<!-- footer.jsp -->

</body>
<script src="//code.jquery.com/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
       $(document).on("keydown", function (e){
           if(e.which === 13){
               e.preventDefault();
               $("#login").click();
           }
       });
       $("#login").on("click", function(){
           goLogin();
       });
    });
    function goLogin() {
        const user_id = $("input[name=user_id]").val();
        const user_pw = $("input[name=user_pw]").val();
        if (user_id == "" || user_pw == "") {
            alert("ID와 PW를 확인하세요");
            return false;
        }

        $.ajax({
            url: "/auth/login",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({
                user_id: user_id,
                user_pw: user_pw
            }),
            success: function () {
                window.location.href = "/home";
            },
            error: function (response) {
                alert(response.responseText);
                $("input[name=user_id]").val('');
                $("input[name=user_pw]").val('');
                return;
            }
        });
    }
</script>
</html>
