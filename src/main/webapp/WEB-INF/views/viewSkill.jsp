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
    <style>
        .over:hover {
            background: darkred;
            cursor: pointer;
        }
    </style>
</head>
<body>


<div class="content" tabindex="-1">
    <div class="container pb-0">
        <div class="common-box row-box row mb-0 g-0">
            <div class="modal-header">
                <h5 class="modal-title">직원 기술</h5>
            </div>
            <form id="frm">
                <div class="modal-body py-3">
                    <div class="container text-center">
                        <div class="col-md-auto g-0 add" style="margin-bottom: 10px;">
                            <input type="hidden" name="project_seq" value="${projectSeq}"/>
                            <c:forEach var="skill" items="${skill.skillList}">
                                <c:choose>
                                    <c:when test="${flag ne 1}">
                                        <div class="col-sm-3 common-box common-box input-box" style="margin-bottom: 5px;">

                                            <input type="text" style="text-align: center" name="skill_nm" value="${skill.skill_nm}" readonly/>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="col-sm-3 common-box common-box input-box" style="margin-bottom: 5px;" onclick="removeEl(this, 'old')">
                                            <input class="over" type="text" style="text-align: center" name="skill_nm" value="${skill.skill_nm}" readonly/>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </div>
                        <c:if test="${flag eq 1}">
                            <div>
                                <input type="text" style="width: auto" name="newSkill" maxlength="10"/>
                                <input type="button" class="add_field" value="ADD"/>
                            </div>
                        </c:if>
                    </div>
                </div>
            </form>
            <div class="modal-footer">
                <c:if test="${flag eq 1}">
                    <button type="button" class="btn btn-primary" onclick="saveSkill()">Save</button>
                </c:if>
                <button type="button" class="btn btn-secondary" onclick="window.close()">Close</button>
            </div>
        </div>
    </div>
</div>

<script src="//code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/js/bootstrap.bundle.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
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
           <div class="col-sm-3 common-box common-box input-box" style="margin-bottom: 5px;" onclick="removeEl(this, 'new')">
               <input class="over" type="text" style="text-align: center;" name="skill_nm" value="` +newSkill+ `" readonly/>
           <div>
           `
            tarDiv.append(newElement);
            $('input[name=newSkill]').val('');
            $('input[name=newSkill]').focus();
        });
    })

    function saveSkill(){
        if(confirm("저장하시겠습니까 ?")){
            alert("저장되었습니다. - 로직구현이전");
            window.close();
        }
    }

    function removeEl(div, str){
        if(str == 'new'){
            $(div).remove();
        }else {
            alert("db update 를 할거다");
        }
    }


</script>
</body>
</html>
