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
    <title>EXCEL 템플릿 업로드</title>
</head>
<body class="mngFile">
<div class="content" tabindex="-1">
    <div class="container-md py-sm-2">
        <div class="container-info row-box row mb-0 g-0">
            <h2 class="header">EXCEL 템플릿 업로드
                <div class="description">
                    <button class="btn btn-success" onclick="upload()"><span>업로드</span></button>
                </div>
            </h2>
            <div class="py-3">
                <form id="kosaExcelFile" enctype="multipart/form-data">
                    <div class="container-md">
                        <input type="hidden" name="user_id" value="${user_id}"/>
                        <label for="excelFile">
                            <input type="file" id="excelFile" name="excelFile"
                                   accept=".xls, .xlsx"/>
                        </label>
                    </div>
                </form>
            </div>

            <div class="d-grid gap-2">
                <hr/>
                <p>템플릿 파일 다운로드</p>

                <select class="form-select" aria-label="Default select example" id="excelTempate">
                    <option value="0" selected>template.xlsx</option>
                    <c:forEach var="attachFileList" items="${attachFileList}">
                        <option value="${attachFileList.file_seq}">${attachFileList.file_ori_nm}</option>
                    </c:forEach>
                </select>
                <button class="btn btn-primary" type="button" onclick="excelDownload();"><span>다운로드</span></button>
                <div class="desc basic-thin">
                    * 이미지 크기는 가로 2 * 세로 8 크기로 고정되면 엑셀내에 '#IMG#' 부분에 표시 됩니다.<br/>
                    * 기본 템플릿 변수 명은 그대로 넣어주셔야 해당 내용에 표기됩니다.
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script src="//code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/js/common.js"></script>
<script type="text/javascript">
    $(document).ready(function () {

    })

    function excelDownload() {

        var fileSeq = $("#excelTempate").val();

        fetch("/excel/downloadTemplate/" + fileSeq, {
            method: 'GET'
        }).then(response => {
            if (!response.ok) { // HTTP 상태 코드가 200-299 범위에 없을 경우
                return response.text().then(errorMessage => {
                    throw new Error(errorMessage); // 서버에서 반환한 에러 메세지
                })
            }
            return response.blob(); // Blob 데이터 반환
        }).then(blob => {
            // Blob 데이터를 URL 객체로 변환
            const url = window.URL.createObjectURL(blob);
            // 다운로드 링크 생성 및 클릭 이벤트 실행
            const a = document.createElement('a');
            a.style.display = 'none';
            a.href = url;
            a.download = $("#excelTempate option:selected").text(); // 다운로드할 파일 이름 설정
            document.body.appendChild(a);
            a.click();
            window.URL.revokeObjectURL(url);// URL 객체 해제
        }).catch(error => {
            // 오류 발생
            alert(error);
        })
    }

    async function upload() {
        const formData = new FormData();
        const uploadFile = document.getElementById("excelFile");


        if (confirm("작성된 모든 데이터는 업로드된 엑셀파일로 UPDATE 됩니다.\n진행하시겠습니까?")) {
            formData.append("excel", uploadFile.files[0]);
            if (!uploadFile.files[0]) {
                alert("등록된 파일이 없습니다.");
                return;
            }

            const fileNm = uploadFile.files[0].name;
            if (fileNm.length > 20 || fileNm.includes(" ")) {
                alert("파일명은 공백을 제외한 20자 이내로 작성해주세요");
                return;
            }

            try {
                const response = await fetch("/excel/excelTemplateUpload", {
                    method: "POST",
                    body: formData,
                });

                if (response.ok) {
                    const result = await response.text(); // 응답 본문 처리
                    console.log("success : ", result);
                    alert("엑셀 파일이 성공적으로 업로드되었습니다.");
                    if (window.opener && !window.opener.closed) {
                        window.opener.location.reload();
                    }
                    window.close();
                } else {
                    const errorMessage = await response.text(); // 에러 메시지 처리
                    console.error("Upload failed: ", errorMessage);
                    alert(`업로드에 실패했습니다: ${errorMessage}`);
                }
            } catch (error) {
                console.error("Error: ", error);
                alert("파일 업로드 중 오류가 발생했습니다.");
            }
        }
    }


</script>
</html>
