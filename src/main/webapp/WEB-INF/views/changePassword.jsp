<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width" , initial-scale="1">
    <link rel="stylesheet" href="/css/bootstrap.css">
    <link rel="stylesheet" href="/css/basic.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <title>비밀번호 변경</title>
</head>
<body>
<div class="content" tabindex="-1">
    <div class="container pb-0">
        <div class="container-info row-box row mb-0 g-0">
            <h2 class="header">비밀번호 변경
                <div class="description">
                    <button type="button" class="btn btn-success" onclick="save()">SAVE</button>
                </div>
            </h2>

            <div class="modal-body py-3">
                <div class="container text-center">
                    <form id="frm">
                        <!-- 개인정보 -->
                        <div class="col-md-auto g-0">
                            <div class="row mb-2 g-0">
                                <div class="col-sm common-box common-box input-box pt-4">
                                    <span>NEW PASSWORD</span>
                                    <input type="hidden" name="user_id" value="${user_id}"/>
                                    <input type="password" name="user_pw" maxlength="20"/>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script src="//code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/js/common.js"></script>
<script type="text/javascript">

    function save() {
        const newPw = $("input[name=user_pw]").val();
        if (newPw == '') {
            alert("신규 비밀번호를 작성해주세요");
        }

        if (!chkPassword(newPw)) {
            alert("비밀번호는 8~20자 이내로,\n문자+숫자+특수문자 조합으로 작성해주세요");
            $("input[name=user_pw]").val("");
            return;
        }

        if (confirm("저장하시겠습니까?")) {

            $.ajax({
                url: "/auth/save/password",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify({
                    user_id: $("input[name=user_id]").val(),
                    user_pw: newPw
                }),
                success: function () {
                    alert("저장되었습니다. 로그인 페이지로 이동합니다.");
                    if (window.opener && !window.opener.closed) {
                        window.opener.location.href = "/auth/login/main";
                    }
                    window.close();
                },
                error: function () {
                    alert("서버 오류가 발생했습니다. 다시 시도해 주세요");
                }
            });
        }
    }

</script>
</html>
