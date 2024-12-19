<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
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
        <div class="container-info row-box row mb-0 g-0">
            <h2 class="header">직원 기술
                <div class="description" >
                <c:if test="${flag eq 1}">
                    <button class="btn btn-success" onclick="saveSkill()"><span>저장</span></button>
                </c:if>
                    <button class="btn btn-outline-danger" onclick="window.close()"><span>X</span></button>
                </div>
            </h2>
            <form id="frm">
                    <div class="container text-center" style="height: 280px;">
                        <input type="hidden" name="user_id" value="${project.user_id}"/>
                        <input type="hidden" name="project_seq" value="${project.project_seq}"/>
                        <div class="col-sm-auto g-0 add" style="height: 80%">
                            <c:forEach var="skill" items="${skill.skillList}" varStatus="status">
                                <c:choose>
                                    <c:when test="${flag ne 1}">
                                        <div class="col-sm-3 common-box input-box mb-1">
                                            <input type="hidden" name="skillList[${status.index}]skill_id" value="${skill.skill_id}"/>
                                            <input type="text" class="text-center" name="skillList[${status.index}]skill_nm" value="${skill.skill_nm}" readonly/>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="col-sm-3 common-box input-box sort mb-1" onclick="removeEl(this)">
                                            <input type="hidden" class="idx" name="skillList[${status.index}].skill_id" value="${skill.skill_id}"/>
                                            <input class="over text-center" type="text" name="skillList[${status.index}].skill_nm" value="${skill.skill_nm}" readonly/>
                                            <img src="/images/x-circle-fill.svg" alt="remove" class="remove-btn"/>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </div>
                        <c:if test="${flag eq 1}">
                            <div class="input-group p-3 justify-content-center">
                                <input type="text" name="newSkill" class="search-input px-sm-3" maxlength="10">
                                <button type="button" class="btn btn-secondary add_field"><span class="blind">추가</span></button>
                            </div>
                        </c:if>
                    </div>
            </form>

        </div>
    </div>
</div>

<script src="//code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/js/bootstrap.bundle.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        $(document).on("keydown", function (e){
            if(e.which === 13){
                e.preventDefault();
                $(".add_field").click();
            }
        })
        $(".add_field").click(function(){
           const tarDiv = $(".add");
           let elCount = tarDiv.children().length;
           let newSkill = $('input[name=newSkill]').val().trim();
           if(newSkill === ''){
               alert("기술을 입력하여 주세요.");
               return;
           }
           if(elCount == 12){
               alert("12개 이상 작성할 수 없습니다.");
               $('input[name=newSkill]').val('');
               return;
           }
           let newElement = `
               <div class="col-sm-3 common-box input-box sort mb-1" onclick="removeEl(this)">
                   <input class="idx" type="hidden" name="skillList[0].skill_id"/>
                   <input class="over text-center" type="text" name="skillList[0].skill_nm" value="` +newSkill+ `" readonly/>
                   <img src="/images/x-circle-fill.svg" alt="remove" class="remove-btn"/>
               <div>
           `
           tarDiv.append(newElement);
           updateIndex();
           $('input[name=newSkill]').val('');
           $('input[name=newSkill]').focus();
        });
    })

    function saveSkill(){
        if(confirm("저장하시겠습니까 ?")){
            let frm = $("#frm").serialize();
            let url = "/profile/project/save/skill";
            $.ajax({
                url: url,
                type: "POST",
                data: frm,
                success: function (response){
                    if(response === "SUCCESS"){
                        alert("저장 되었습니다");
                        if (window.opener && !window.opener.closed) {
                            window.opener.location.reload(); // 부모 창 리로드
                        }
                        window.close();
                    }else {
                        alert("저장에 실패했습니다");
                    }
                },
                error: function(){
                    alert("서버 오류가 발생했습니다. 다시 시도해 주세요.");
                }
            });
        }
    }

    function removeEl(div){
        $(div).remove();
        updateIndex();
    }

    function updateIndex(){
        let listNm = 'skillList';
        $(".add").find(".sort").each(function(i){
            $(this).find("input").each(function (){
                let name = $(this).attr("name");
                if(name && name.startsWith(listNm)){
                    let newName = name.replace(/\[\d*\]/, '[' + i + ']');
                    $(this).attr("name", newName);
                }
            });
            $(this).find(".idx").attr("value", i + 1);
        });
    }


</script>
</body>
</html>
