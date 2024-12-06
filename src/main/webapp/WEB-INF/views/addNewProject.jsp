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
        <div class="common-box row-box row mb-0 g-0">
            <div class="modal-header">
                <h5 class="modal-title">정보 입력</h5>
            </div>
            <div class="modal-body py-3">
                <div class="container text-center">
                    <form>
                        <input type="hidden" id="project_seq" name="project_seq" value="${maxSeq}"/>
                        <label for="project_nm">사업명:</label>
                        <input type="text" id="project_nm" name="project_nm" maxlength="18"><br><br>

                        <label for="project_start_date">투입시작일:</label>
                        <input type="date" id="project_start_date" name="project_start_date"><br><br>

                        <label for="project_end_date">투입종료일:</label>
                        <input type="date" id="project_end_date" name="project_end_date"><br><br>

                        <label for="project_role">역할:</label>
                        <select class="form-select" style="width: auto; justify-self: center;" id="project_role" name="project_role">
                            <option value="">선택해주세요</option>
                            <option value="001">PM</option>
                            <option value="002">PMO</option>
                            <option value="003">PL</option>
                            <option value="004">PE</option>
                            <option value="005">PA</option>
                            <option value="006">QA</option>
                        </select><br><br>

                        <label for="project_client">발주처:</label>
                        <input type="text" id="project_client" name="project_client" maxlength="18"><br><br>

                        <label for="assigned_task_lar">담당업무(대분류):</label>
                        <select class="form-select" style="width: auto; justify-self: center;" id="assigned_task_lar" name="assigned_task_lar"
                                onchange="selectTaskLar(this)">
                            <option value="" selected>선택해주세요</option>
                            <c:forEach var="taskLarList" items="${taskLarList}">
                                <option value="${taskLarList.code_id}">${taskLarList.code_value}</option>
                            </c:forEach>
                        </select><br><br>

                        <label for="assigned_task_mid">담당업무(소분류):</label>
                        <select class="form-select" style="width: auto; justify-self: center;" id="assigned_task_mid" name="assigned_task_mid">
                            <option value="" selected>선택해주세요</option>
                            <c:forEach var="taskMidList" items="${taskMidList}">
                                <option value="${taskMidList.code_id}">${taskMidList.code_value}</option>
                            </c:forEach>
                        </select><br><br>
                        <button type="button" onclick="sendDataToParent()">입력</button>
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
