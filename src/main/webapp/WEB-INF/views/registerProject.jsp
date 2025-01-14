<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width" , initial-scale="1">
    <link rel="stylesheet" href="/css/bootstrap.css">
    <link rel="stylesheet" href="/css/basic.css">
    <link rel="stylesheet" href="/css/pop.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <title>프로젝트 등록</title>
</head>
<body>
<div class="content" tabindex="-1">
    <div class="container-md py-sm-2">
        <div class="container-info row-box row mb-0 g-0">
            <h2 class="header">프로젝트 등록
                <div class="description">
                    <button class="btn btn-success" onclick="save()"><span>저장</span></button>
                </div>
            </h2>
            <div class="py-3">
                <form id="frm">
                    <div class="col-sm-auto g-0">
                        <div class="row mb-2 g-0">
                            <div class="col-sm-4 common-box input-box pt-4 me-2">
                                <span>사업명</span>
                                <input type="text" id="project_nm" name="project_nm" maxlength="18">
                            </div>
                            <div class="col-sm-3 common-box input-box pt-4 me-2">
                                <span>발주처</span>
                                <input type="text" id="project_client" name="project_client" maxlength="18">
                            </div>
                            <div class="col-sm-2 common-box input-box pt-4 me-2">
                                <span>사업시작일</span>
                                <input type="text" class="dateFmt" id="project_start_date" name="project_start_date"
                                       maxlength="10">
                            </div>
                            <div class="col-sm-2 common-box input-box pt-4">
                                <span>사업종료일</span>
                                <input type="text" class="dateFmt" id="project_end_date" name="project_end_date"
                                       maxlength="10">
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
<script src="//code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/js/common.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $(".container-md").on("keyup", ".dateFmt", function () {
            formatInput($(this));
        });
    })

    function save(){
        // 저장 로직
        if(!chkData()) return false;
        if(!validateDates()) return false;

        // 날짜 치환
        $(document).find(".dateFmt").each(function(){
            let fmtDate = $(this).val().replaceAll("-", "");
            $(this).val(fmtDate);
        })

        if(confirm("저장하시겠습니까?")){
            const url = "/project/common/register";

            $.ajax({
                url : url,
                type : "POST",
                data : $("#frm").serialize(),
                success : function(){
                    alert("저장되었습니다.");
                    if(window.opener && !window.opener.closed){
                        window.opener.location.reload(); // 부모 창 리로드
                    }
                    window.close(); // 자식 창 닫기
                },
                error : function (response) {
                    alert(response.responseText);
                    return;
                }
            });
        }
    }

    function chkData() {
        let inputEls = Array.from(document.getElementsByTagName("input"));
        let chk = true;
        for (let i = 0; i < inputEls.length; i++) {
            let elVal = inputEls[i].value;
            let elNm = inputEls[i].previousElementSibling.innerText;
            if (elVal == '') {
                chk = false;
                alert(elNm + " 확인해주세요");
                break;
            }
        }
        return chk;
    }

    function validateDates() {
        let isValidDates = true;
        $("#frm").find(".dateFmt").each(function () {
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
        const fmtStartDt = new Date($("#project_start_date").val());
        const fmtEndDt = new Date($("#project_end_date").val());
        if (fmtStartDt > fmtEndDt) {
            alert("종료일자가 시작일자보다 빠릅니다.");
            isValidDates = false;
        }
        return isValidDates;
    }


</script>
</html>
