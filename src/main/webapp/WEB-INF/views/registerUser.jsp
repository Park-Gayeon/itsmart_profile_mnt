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
        <div class="container-info row-box row mb-0 g-0">
            <h2 class="header">직원 등록
                <div class="description" >
                    <button type="button" class="btn btn-success" onclick="save()">저장</button>
                </div>
            </h2>

            <div class="modal-body py-3">
                <div class="container text-center">
                    <form id="frm">
                        <!-- 사진 -->
                        <div class="d-sm-flex justify-content-sm-center">
                            <img id="profileImg" src="/images/image.png" class="img-profile">
                                <label for="imgFile" class="align-self-end">
                                    <div class="img-profile-btn do-hyeon-regular">+</div>
                                </label>
                                <input type="file" id="imgFile" name="imgFile" class="d-none" accept=".jpg, .png, .jpeg"/>
                        </div>
                        <!-- 개인정보 -->
                        <div class="col-sm-auto g-0">
                            <!-- 첫번째 row -->
                            <div class="row mb-2 g-0">
                                <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                    <span>이름</span>
                                    <input type="text" name="user_nm" maxlength="5"/>
                                </div>
                                <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                    <span>생년월일</span>
                                    <input type="text" class="dateFmt" name="user_birth" maxlength="10"/>
                                </div>
                                <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                    <span>휴대전화</span>
                                    <input type="text" class ="telFmt" name="user_phone" maxlength="13"/>
                                </div>
                                <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                    <span>직원ID</span>
                                    <input type="text" name="user_id" maxlength="8"/>
                                </div>
                                <div class="col-sm common-box common-box input-box pt-4 me-2">
                                    <span>이메일</span>
                                    <input type="text" name="user_email"/>
                                </div>
                            </div>
                            <!-- 두번째 row -->
                            <div class="row mb-2 g-0">
                                <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                    <span>소속</span>
                                    <select class="form-select noneBorder" name="user_department">
                                        <option value="">-</option>
                                        <c:forEach var="orgList" items="${orgList}">
                                            <option value="${orgList.code_id}">${orgList.code_value}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                    <span>직위/직급</span>
                                    <select class="form-select noneBorder" name="user_position">
                                        <option value="">-</option>
                                        <c:forEach var="psitList" items="${psitList}">
                                            <option value="${psitList.code_id}">${psitList.code_value}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                    <span>입사일자</span>
                                    <input type="text" class="dateFmt" name="hire_date" maxlength="10"/>
                                </div>
                                <div class="col-sm common-box common-box input-box pt-4 me-2">
                                    <span>주소</span>
                                    <input type="text" name="user_address" maxlength="40"/>
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
    let chgImg = false;
    $(document).ready(function(){
        $(".container").on("keyup", ".dateFmt, .telFmt", function(){
            formatInput($(this));
        });

        $("input[name=user_nm]").on("keyup", function(){
            const name = onlyCharKo($(this).val());
            $(this).val(name);
        });

        $("input[name=user_id]").on("keyup", function(){
            const user_id = onlyCharEn($(this).val());
            $(this).val(user_id);
            const domain = "itsmart.co.kr";

            if(user_id.trim() === ""){
                $("input[name=user_email]").val("");
            } else {
                let email = user_id + "@" + domain;
                $("input[name=user_email]").val(email);
            }
        });

        $("#imgFile").change(function(e){
            /*최대 파일크기 2MB(2097152) */
            const fileInfo = e.target.files[0];
            const maxSize = 1024*1024*2; // 최대 크기 2MB
            const basicImg = "/images/image.png"; // 기본 이미지 경로
            chgImg = true;

            // 파일 선택 취소
            if(!fileInfo){
                $("#profileImg").attr("src", basicImg);
                chgImg = false;
                return;
            }
            // 파일 이름 검증(20자)
            const oriFileNm = fileInfo.name;
            if(oriFileNm.length > 20 || oriFileNm.includes(" ")){
                alert("파일명은 공백을 제외한 20자 이내로 작성해주세요");
                return;
            }

            // 파일 크기 검증
            if(fileInfo.size > maxSize){
                alert("이미지 사진의 용량이 2MB를 초과합니다.");
                return;
            }
            // 파일 형식 검증
            const allowedExtensions = ['image/jpeg', 'image/png', 'image/jpg'];
            if(!allowedExtensions.includes(fileInfo.type)){
                alert("이미지 파일만 업로드 가능합니다.");
                return;
            }
            // 파일 미리보기
            const reader = new FileReader();
            reader.onload = function(e){
                const url = e.target.result;
                $("#profileImg").attr("src", url);
            };
            reader.readAsDataURL(fileInfo);
        });
    });

    function save(){
        let flag = true;
        let data;
        let nullable = ['imgFile'];
        // 빈값 검증
        if(!chkEmptyData(nullable)) return false;

        // 휴대전화 정규식
        if(!validatePhone()) return false;

        // 날짜 정규식
        if(!validateDates()) return false;

        // 문자열 치환
        $("#frm").find(".dateFmt, .telFmt").each(function (){
            const replStr = $(this).val().replaceAll("-", "");
            $(this).val(replStr);
        })

        if(chgImg){
            // 프로필 사진이 변경된 경우
            flag = false; // FormData 사용
            data = new FormData($("#frm")[0]);
        } else {
            // 프로필 사진이 변경되지 않은 경우
            $("#imgFile").attr("disabled", true);
            data = $("#frm").serialize();
        }

        if(confirm("저장하시겠습니까?")){
            const url = "/profile/info/register";

            $.ajax({
                url: url,
                type: "POST",
                data: data,
                processData: flag,
                contentType: flag ? "application/x-www-form-urlencoded; charset=UTF-8" : false,
                success: function(){
                    alert("저장되었습니다.");
                    if (window.opener && !window.opener.closed) {
                        window.opener.location.reload(); // 부모 창 리로드
                    }
                    window.close(); // 자식 창 닫기
                },
                error: function (response){
                    alert(response.responseText);
                    $("input[name=user_id]").val('');
                    $("input[name=user_email]").val('');
                    return;
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
