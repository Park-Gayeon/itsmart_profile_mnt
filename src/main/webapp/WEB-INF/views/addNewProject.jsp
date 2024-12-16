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
    <title>수행이력 작성</title>
</head>
<body>
<div class="content" tabindex="-1">
    <div class="container pb-0">
        <div class="container-info row-box row mb-0 g-0">
            <h2 class="header">수행이력 작성
                <div class="description" >
                    <button class="btn btn-success" onclick="sendDataToParent()"><span>SAVE</span></button>
                </div>
            </h2>
            <div class="py-3">
                <form>
                    <div class="col-md-auto g-0">
                        <div class="row mb-2 g-0">
                            <input type="hidden" id="project_seq" name="project_seq" value="${maxSeq}"/>
                            <div class="col-sm-4 common-box common-box input-box pt-4 me-2">
                                <span>사업명</span>
                                <input type="text" id="project_nm" name="project_nm" maxlength="18">
                            </div>
                            <div class="col-sm-3 common-box common-box input-box pt-4 me-2">
                                <span>발주처</span>
                                <input type="text" id="project_client" name="project_client" maxlength="18">
                            </div>
                            <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                <span>투입시작일</span>
                                <input type="text" class="dateFmt" id="project_start_date" name="project_start_date" maxlength="10">
                            </div>
                            <div class="col-sm-2 common-box common-box input-box pt-4">
                                <span>투입종료일</span>
                                <input type="text" class="dateFmt" id="project_end_date" name="project_end_date" maxlength="10">
                            </div>
                        </div>
                    </div>
                    <div class="row mb-2 g-0">
                        <div class="row mb-2 g-0">
                            <div class="col-sm-4 common-box common-box input-box pt-4 me-2">
                                <span>담당업무(대분류)</span>
                                <select class="form-select noneBorder" id="assigned_task_lar" name="assigned_task_lar"
                                        onchange="selectTaskLar(this)">
                                    <option value="" selected>-</option>
                                    <c:forEach var="taskLarList" items="${taskLarList}">
                                        <option value="${taskLarList.code_id}">${taskLarList.code_value}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-sm-3 common-box common-box input-box pt-4 me-2">
                                <span>담당업무(중분류)</span>
                                <select class="form-select noneBorder"  id="assigned_task_mid" name="assigned_task_mid">
                                    <option value="" selected>-</option>
                                    <c:forEach var="taskMidList" items="${taskMidList}">
                                        <option value="${taskMidList.code_id}">${taskMidList.code_value}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-sm-2 common-box common-box input-box pt-4">
                                <span>역할</span>
                                <select class="form-select noneBorder" id="project_role" name="project_role">
                                    <option value="">-</option>
                                    <option value="001">PM</option>
                                    <option value="002">PMO</option>
                                    <option value="003">PL</option>
                                    <option value="004">PE</option>
                                    <option value="005">PA</option>
                                    <option value="006">QA</option>
                                </select>
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
    $(document).ready(function (){
        $(".container").on("keyup", ".dateFmt", function () {
            formatInput($(this));
        });
    })
    // 부모 창으로 데이터를 전달 하고 팝업창을 닫는다
    function sendDataToParent() {
        const project_seq = document.getElementById("project_seq").value;
        const project_nm = document.getElementById("project_nm").value.trim();
        const project_start_date = document.getElementById("project_start_date").value;
        const project_end_date = document.getElementById("project_end_date").value;
        const project_role = document.getElementById("project_role").value;
        const role = document.getElementById("project_role");
        const project_role_nm = role.options[role.selectedIndex].innerText;
        const project_client = document.getElementById("project_client").value.trim();
        const assigned_task_lar = document.getElementById("assigned_task_lar").value;
        const lar = document.getElementById("assigned_task_lar");
        const assigned_task_lar_nm = lar.options[lar.selectedIndex].innerText;
        const assigned_task_mid = document.getElementById("assigned_task_mid").value;
        const mid = document.getElementById("assigned_task_mid");
        const assigned_task_mid_nm = mid.options[mid.selectedIndex].innerText;

        if(!chkData()){
            return;
        }
        if(!validateDates()){
            return;
        }

        const data = {
            project_seq: project_seq,
            project_nm: project_nm,
            project_start_date: project_start_date,
            project_end_date: project_end_date,
            project_role: project_role,
            project_role_nm: project_role_nm,
            project_client: project_client,
            assigned_task_lar: assigned_task_lar,
            assigned_task_lar_nm: assigned_task_lar_nm,
            assigned_task_mid: assigned_task_mid,
            assigned_task_mid_nm: assigned_task_mid_nm,
            flag: "new",
            addCnt: 1
        };

        window.opener.addProjectRow(data);
        window.close();
    }

    function chkData(){
        let inputEls = Array.from(document.getElementsByTagName("input"));
        let selectEls = Array.from(document.getElementsByTagName("select"))
        let els = [...inputEls, ...selectEls];
        let chk = true;
        for(let i = 0; i < els.length; i++){
            let elVal = els[i].value;
            if(els[i].name == 'project_seq'){
                continue;
            }
            let elNm = els[i].previousElementSibling.innerText;
            if(elVal == ''){
                chk = false;
                alert(elNm +" 확인해주세요");
                break;
            }
        }
        return chk;
    }

    function validateDates() {
        let isValidDates = true;
        $("form").find(".dateFmt").each(function () {
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
        if (fmtStartDt > fmtEndDt){
            alert("종료일자가 시작일자보다 빠릅니다.");
            isValidDates = false;
        }
        return isValidDates;
    }

    // 업무분류 BOX 서버 데이터 조회
    function selectTaskLar(ob) {
        const parentId = $(ob).val();
        const url = "/profile/project/select/task";
        const $subCategory = $("select[name=assigned_task_mid]");

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

</script>
</html>
