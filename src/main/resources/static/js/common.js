$(document).ready(function (){
    const currentUrl = window.location.pathname;
    const referrer = document.referrer;
    let flag = false;
    $('.nav-link').each(function(){
        if(flag) return;
        $('.nav-link').removeClass('active');
        if(currentUrl === ($(this).attr("href"))){
            $(this).addClass('active');
            flag = true;
        } else if(currentUrl.startsWith("/profile/") && referrer.includes("/list")){
            if($(this).attr("href").startsWith("/profile/")){
                $(this).addClass('active');
                flag = true;
            }
        }
    })
});

function formatDate(date){
    return date
        .replace(/[^0-9]/g, "")
        .replace(/(\d{4})(\d{2})(\d{2})/g, "$1-$2-$3")
        .replace(/(\-{1,2})$/g, "");
}

function formatTel(phone){
    return phone
        .replace(/[^0-9]/g, "")
        .replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, "$1-$2-$3")
        .replace(/(\-{1,2})$/g, "");
}

function onlyCharKo(str){
    return str
        .replace(/[^가-힣]/g, "");
}

function onlyCharEn(str){
    return str
        .replace(/[^a-zA-Z]/g, "");
}

// 숫자 + dot
function onlyDot(el){
    const input = $(el).val();
    let chkData = input;
    chkData = chkData.replace(/[^0-9.]/g, "");
    $(el).val(chkData);
}

// 숫자
function onlyNum(input){
    const regex = /^[0-9]*$/;
    const chkInput = input.trim();
    if(input != ''){
        if(regex.test(chkInput)){
            return true;
        }else{
            return false;
        }
    } else {
        return false;
    }
}

// 학점 유효성 검사
function chkGrade(grade){
    const regEx = /^[0-4]\.[0-9]$/;
    let rtn = false;
    if(!regEx.test(grade)){
        return rtn;
    }
    if(parseFloat(grade) > 4.5){
        return rtn;
    }
    return true;
}

// 날짜 검증(정규식 체크)
function chkDate(date){
    const regEx = /^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/;
    let rtn = false;
    if(!regEx.test(date)){
        return rtn;
    }
    // 윤년 및 말일 검증
    if(!chkDate2(date)){
        return rtn;
    }
    return true;
}

// 윤년 및 말일 검증
function chkDate2(date){
    const month_day = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    let parts = date.split("-");
    let year = parts[0];
    let month = parts[1];
    let day = parts[2];

    let rtn = false;

    // 윤년 여부
    let leaf = false;
    if(year % 4 == 0){
        leaf = true;
        if(year % 100 == 0){
            leaf = false;
        }
        if(year % 400 == 0){
            leaf = true;
        }
    }
    // 윤년 및 말일 검증
    if(leaf){
        if(month == 2){
            if(day <= month_day[month-1] + 1){
                rtn = true;
            }
        } else {
            if(day <= month_day[month-1]){
                rtn = true;
            }
        }
    } else {
        if(day <= month_day[month-1]){
            rtn = true;
        }
    }
    return rtn;
}
// 비밀번호 검증(정규식 체크)
function chkPassword(password){
    let rtn = false;
    // 8자 - 20자, 문자 + 숫자 + 특수문자 정규식
    const regex_pwd = /^(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&#.~_-])[A-Za-z\d@$!%*?&#.~_-]{8,20}$/

    if(!regex_pwd.test(password)){
        return rtn;
    }
    return true;
}

// 휴대폰번호 검증(정규식 체크)
function chkTel(phoneNum){
    const regEx = /(01[0|1|6|9|7])[-](\d{3}|\d{4})[-](\d{4}$)/g;
    let rtn = false;
    if(!regEx.test(phoneNum)){
        return rtn;
    }
    return true;
}

/*
* dateFmt, telFmt DOM을 읽어올때 & 실시간 포맷
* 포맷팅 하여 표기
* */
function formatInput(input){
    const value = input.val();
    let formattedValue = value;

    if(input.hasClass("dateFmt")){
        formattedValue = formatDate(value);
    } else if (input.hasClass("telFmt")){
        formattedValue = formatTel(value);
    }

    input.val(formattedValue);
}

function convertToString(totalMonth){
    const year = Math.floor(totalMonth / 12);
    const months = totalMonth % 12;

    let result = "";
    if(year > 0){
        result += year + '년 ';
    }
    if(months > 0){
        result += months + '개월';
    }
    return result;
}

/*
* html 내의 모든 input/select 요소에 대해
* empty 값을 검증한다
* */
function chkEmptyData(nullable){
    let inputEls = Array.from(document.getElementsByTagName("input"));
    let selectEls = Array.from(document.getElementsByTagName("select"))
    let els = [...inputEls, ...selectEls];
    let chk = true;
    for(let i = 0; i < els.length; i++){
        let elVal = els[i].value;
        let elNm = els[i].name;
        let elNmKor = els[i].previousElementSibling.innerText;
        if(!nullable.includes(elNm) && elVal === ''){
            chk = false;
            alert(elNmKor + "항목을 확인해주세요");
            $(this).focus();
            return false;
        }
    }
    return chk;
}

function logout() {
    $.ajax({
        url: '/auth/logout',
        type: 'POST',
        success: function () {
            window.location.href = '/auth/login/main';
        }
    });
}

function changePw(user_id) {
    let url = "/auth/change/password/" + user_id;
    let properties = "width=600, height=220";
    window.open(url, "changePassword", properties);
}