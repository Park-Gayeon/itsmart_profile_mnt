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
    <title>수행이력 작성</title>
</head>
<body class="mngFile">
<div class="content" tabindex="-1">
    <div class="container-md">
        <div class="container-info row-box row mb-0 g-0">
            <h2 class="header">KOSA 파일 업로드
                <div class="description">
                    <button class="btn btn-success" onclick="upload()"><span>업로드</span></button>
                </div>
            </h2>
            <div class="py-3">
                <form id="kosaExcelFile" enctype="multipart/form-data">
                    <div>
                        <input type="hidden" name="user_id" value="${user_id}"/>
                        <label for="excelFile">
                            <input type="file" id="excelFile" name="excelFile"
                                   accept=".xls, .xlsx"/>
                        </label>
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

    })

    async function upload() {
        const user_id = $("input[name=user_id]").val();
        const formData = new FormData();
        const uploadFile = document.getElementById("excelFile");

        if (confirm("작성된 모든 데이터는 업로드된 엑셀파일로 UPDATE 됩니다.\n진행하시겠습니까?")) {
            formData.append("excel", uploadFile.files[0]);
            if (!uploadFile.files[0]) {
                alert("등록된 파일이 없습니다.");
                return;
            }
            try {
                const response = await fetch("/excel/" + user_id + "/upload", {
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
