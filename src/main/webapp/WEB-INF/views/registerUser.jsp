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
    <title>신규직원 등록</title>
</head>
<body>
<div class="content" tabindex="-1">
    <div class="container pb-0">
        <div class="common-box row-box row mb-0 g-0">
            <div class="modal-header">
                <h5 class="modal-title">정보 입력</h5>
            </div>
            <div class="modal-body py-3">
                <div class="container text-center">
                    <form id="frm">
                        <!-- 사진 -->
                        <div class="col-md text-center">
                            <img src="/image/image.png" class="img-profile" alt="Profile Picture">
                        </div>
                        <!-- 개인정보 -->
                        <div class="col-md-auto g-0">
                            <!-- 첫번째 row -->
                            <div class="row mb-2 g-0">
                                <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                    <label for="user_nm">이름</label>
                                    <input type="text" name="user_nm" id="user_nm" maxlength="5"/>
                                </div>
                                <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                    <label for="user_birth">생년월일</label>
                                    <input type="text" class="dateFmt" name="user_birth" id="user_birth" maxlength="10"/>
                                </div>
                                <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                    <label for="user_phone">휴대전화</label>
                                    <input type="text" class ="telFmt" name="user_phone" id="user_phone" maxlength="13"/>
                                </div>
                                <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                    <label for="user_id">직원ID</label>
                                    <input type="text" name="user_id" id="user_id" maxlength="8"/>
                                </div>
                                <div class="col-sm common-box common-box input-box pt-4 me-2">
                                    <label for="user_email">이메일</label>
                                    <input type="email" id="user_email"/>
                                </div>
                            </div>
                            <!-- 두번째 row -->
                            <div class="row mb-2 g-0">
                                <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                    <label for="user_department">소속</label>
                                    <select class="form-select" name="user_department" id="user_department"
                                            style="font-size: xx-small;">
                                        <option value="">-- 선택해주세요 --</option>
                                        <c:forEach var="orgList" items="${orgList}">
                                            <option value="${orgList.code_id}">${orgList.code_value}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                    <label for="user_position">직위/직급</label>
                                    <select class="form-select" name="user_position" id="user_position"
                                            style="font-size: xx-small;">
                                        <option value="">-- 선택해주세요 --</option>
                                        <c:forEach var="psitList" items="${psitList}">
                                            <option value="${psitList.code_id}">${psitList.code_value}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                    <label for="hire_date">입사일자</label>
                                    <input type="text" class="dateFmt" name="hire_date" id="hire_date" maxlength="10"/>
                                </div>
                                <div class="col-sm common-box common-box input-box pt-4 me-2">
                                    <label for="user_address">주소</label>
                                    <input type="text" name="user_address" id="user_address" maxlength="40"/>
                                </div>
                            </div>
                        </div>
                    </form>
                    <input type="button" class="btn btn-warning" onclick="save()" value="SAVE"/>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script src="//code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/js/common.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        $(".container").on("keyup", ".dateFmt, .telFmt", function(){
            formatInput($(this));
        });

        $("#user_nm").on("keyup", function(){
            const name = onlyCharKo($(this).val());
            $(this).val(name);
        });

        $("#user_id").on("keyup", function(){
            const user_id = onlyCharEn($(this).val());
            $(this).val(user_id);
            const domain = "itsmart.co.kr";

            if(user_id.trim() === ""){
                $("#user_email").val("");
            } else {
                let email = user_id + "@" + domain;
                $("#user_email").val(email);
            }
        });
    });

    function save(){
        // 빈값 검증
        if(!chkEmptyData()) return false;

        // 휴대전화 정규식
        if(!validatePhone()) return false;

        // 날짜 정규식
        if(!validateDates()) return false;

        // 문자열 치환
        $("#frm").find(".dateFmt, .telFmt").each(function (){
            const replStr = $(this).val().replaceAll("-", "");
            $(this).val(replStr);
        })

        if(confirm("저장하시겠습니까?")){
            const frm = $("#frm").serialize();
            const url = "/profile/info/register";

            $.ajax({
                url: url,
                type: "POST",
                data: frm,
                success: function(response){
                    if(response === "SUCCESS"){
                        alert("저장되었습니다.");
                        window.close();
                    } else {
                        alert(response);
                    }
                },
                error: function (){
                    alert("서버 오류가 발생했습니다. 다시 시도해 주세요");
                }
            });
        }
    }

    function validatePhone(){
        // 휴대폰번호 검증(정규식 체크)
        if(!chkTel($(".telFmt").val())){
            alert("휴대폰번호를 확인해주세요");
            $(".telFmt").focus();
            return false;
        }
        return true;
    }

    function validateDates() {
        let isValidDates = true;
        $(".dateFmt").each(function () {
            if (!isValidDates) return false;

            const date = $(this).val();
            if (!chkDate(date)) {
                alert("입력일자를 확인해주세요.");
                $(this).focus();
                isValidDates = false;
                return false;
            }
        });
        return isValidDates;
    }

</script>
</html>
