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

// 날짜 유효성 검사
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

// 휴대전화 유효성 검사
function chkTel(phoneNum){
    const regEx = /(01[0|1|6|9|7])[-](\d{3}|\d{4})[-](\d{4}$)/g;
    let rtn = false;
    if(!regEx.test(phoneNum)){
        return rtn;
    }
    return true;
}
