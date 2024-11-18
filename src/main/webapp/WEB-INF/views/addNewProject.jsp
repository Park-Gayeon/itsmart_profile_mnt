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
    <title>직원 프로젝트 기술</title>
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
                        <input type="text" id="project_nm" name="project_nm"><br><br>

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
                        <input type="text" id="project_client" name="project_client"><br><br>

                        <label for="assigned_task_lar">담당업무(대분류):</label>
                        <select class="form-select" style="width: auto; justify-self: center;" id="assigned_task_lar" name="assigned_task_lar">
                            <option value="">선택해주세요</option>
                            <option value="001">IT컨설팅</option>
                            <option value="002">IT프로젝트관리</option>
                            <option value="003">IT아키텍처</option>
                            <option value="004">SW개발</option>
                            <option value="005">시스템 구축 및 운영</option>
                            <option value="006">IT마케팅</option>
                            <option value="007">IT품질관리</option>
                            <option value="008">정보보호</option>
                            <option value="009">IT기술교육</option>
                        </select><br><br>

                        <label for="assigned_task_mid">담당업무(소분류):</label>
                        <select class="form-select" style="width: auto; justify-self: center;" id="assigned_task_mid" name="assigned_task_mid">
                            <option value="">선택해주세요</option>
                            <option value="010">정보기술기획</option>
                            <option value="011">정보기술컨설팅</option>
                            <option value="012">정보보호컨설팅</option>
                            <option value="013">데이터분석</option>
                            <option value="014">업무분석</option>
                            <option value="015">빅데이터기획</option>
                            <option value="016">UI/UX기획</option>
                            <option value="017">인공지능서비스기획</option>
                            <option value="018">IT프로젝트관리</option>
                            <option value="019">IT프로젝트사업관리</option>
                            <option value="020">SW아키텍처</option>
                            <option value="021">infrastructure아키텍처</option>
                            <option value="022">데이터아키텍처</option>
                            <option value="023">빅데이터아키텍처</option>
                            <option value="024">인공지능아키텍처</option>
                            <option value="025">UI/UX개발</option>
                            <option value="026">UI/UX디자인</option>
                            <option value="027">응용SW개발</option>
                            <option value="028">빅데이터개발</option>
                            <option value="029">시스템SW개발</option>
                            <option value="030">임베디드SW개발</option>
                            <option value="031">인공지능SW개발</option>
                            <option value="032">데이터베이스관리</option>
                            <option value="033">NW엔지니어링</option>
                            <option value="034">IT시스템관리</option>
                            <option value="035">IT시스템기술지원</option>
                            <option value="036">빅데이터엔지니어링</option>
                            <option value="037">인공지능서비스관리</option>
                            <option value="038">SW제품기획</option>
                            <option value="039">IT기술영업</option>
                            <option value="040">IT서비스기획</option>
                            <option value="041">IT품질관리</option>
                            <option value="042">IT테스트</option>
                            <option value="043">IT감리</option>
                            <option value="044">IT감사</option>
                            <option value="045">정보보호관리</option>
                            <option value="046">보안사고대응</option>
                            <option value="047">IT기술교육</option>
                        </select><br><br>
                        <button type="button" onclick="sendDataToParent()">입력</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
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

</script>
</html>
