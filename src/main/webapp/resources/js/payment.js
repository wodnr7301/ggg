// 구매자 정보
const user_email = "tndus0561@naver.com";
const username = "김수연";

// 결제창 함수 넣어주기
const buyButton = document.getElementById('kakaoPay');
const buyButton2 = document.getElementById('toss');
const buyButton3 = document.getElementById('payco');
const buyButton4 = document.getElementById('uplus');
buyButton.addEventListener('click', () => kakaoPay(user_email, username));
buyButton2.addEventListener('click', () => toss(user_email, username));
buyButton3.addEventListener('click', () => payco(user_email, username));
buyButton4.addEventListener('click', () => uplus(user_email, username));

var IMP = window.IMP;

var today = new Date();
var hours = today.getHours(); // 시
var minutes = today.getMinutes();  // 분
var seconds = today.getSeconds();  // 초
var milliseconds = today.getMilliseconds();
var makeMerchantUid = `${hours}${minutes}${seconds}${milliseconds}`;

function kakaoPay(useremail, username) {
    IMP.init("imp03332385"); // 가맹점 식별코드
    IMP.request_pay({
        pg: 'kakaopay', // PG사 코드표에서 선택
        pay_method: 'card', // 결제 방식
        merchant_uid: "IMP" + makeMerchantUid, // 결제 고유 번호
        name: '상품명', // 제품명
        amount: 100, // 가격
        //구매자 정보 ↓
        buyer_email: `${useremail}`,
        buyer_name: `${username}`
        // buyer_tel : '010-1234-5678',
        // buyer_addr : '서울특별시 강남구 삼성동',
        // buyer_postcode : '123-456'
    }, function (rsp) { // callback
        if (rsp.success) { //결제 성공시
            console.log(rsp);
            //결제 성공시 프로젝트 DB저장 요청
            // 아래의 코드가 올바른지 확인하세요.
            // 아래의 코드가 올바른지 확인하세요.
            if (rsp.status == 200) {
                alert('결제 완료!')
                window.location.reload();
            }
        } else { // 결제 실패시
            alert(rsp.error_msg)
        }
    });
}

function toss(useremail, username) {
    IMP.init("imp03332385"); // 가맹점 식별코드
    IMP.request_pay({
        pg: 'tosspay', // PG사 코드표에서 선택
        pay_method: 'card', // 결제 방식
        merchant_uid: "IMP" + makeMerchantUid, // 결제 고유 번호
        name: '상품명', // 제품명
        amount: 100, // 가격
        //구매자 정보 ↓
        buyer_email: `${useremail}`,
        buyer_name: `${username}`
        // buyer_tel : '010-1234-5678',
        // buyer_addr : '서울특별시 강남구 삼성동',
        // buyer_postcode : '123-456'
    }, function (rsp) { // callback
        if (rsp.success) { //결제 성공시
            console.log(rsp);
            //결제 성공시 프로젝트 DB저장 요청
            if (rsp.status == 200) {
                alert('결제 완료!')
                window.location.reload();
            }
        } else { // 결제 실패시
            alert(rsp.error_msg)
        }
    });
}

function payco(useremail, username) {
    // const emoticonName = document.getElementById('title').innerText

    IMP.init("imp03332385"); // 가맹점 식별코드
    IMP.request_pay({
        pg: 'payco', // PG사 코드표에서 선택
        pay_method: 'card', // 결제 방식
        merchant_uid: "IMP" + makeMerchantUid, // 결제 고유 번호
        name: '상품명', // 제품명
        amount: 100, // 가격
        //구매자 정보 ↓
        buyer_email: `${useremail}`,
        buyer_name: `${username}`
        // buyer_tel : '010-1234-5678',
        // buyer_addr : '서울특별시 강남구 삼성동',
        // buyer_postcode : '123-456'
    }, function (rsp) { // callback
        if (rsp.success) { //결제 성공시
            console.log(rsp);
            //결제 성공시 프로젝트 DB저장 요청
            if (rsp.status == 200) {
                alert('결제 완료!')
                window.location.reload();
            }
        } else { // 결제 실패시
            alert(rsp.error_msg)
        }
    });
}

function uplus(useremail, username) {
    IMP.init("imp03332385"); // 가맹점 식별코드
    IMP.request_pay({
        pg: 'uplus', // PG사 코드표에서 선택
        pay_method: 'card', // 결제 방식
        merchant_uid: "IMP" + makeMerchantUid, // 결제 고유 번호
        name: '상품명', // 제품명
        amount: 100, // 가격
        //구매자 정보 ↓
        buyer_email: `${useremail}`,
        buyer_name: `${username}`
        // buyer_tel : '010-1234-5678',
        // buyer_addr : '서울특별시 강남구 삼성동',
        // buyer_postcode : '123-456'
    }, function (rsp) { // callback
        if (rsp.success) { //결제 성공시
            console.log(rsp);
            //결제 성공시 프로젝트 DB저장 요청
            if (rsp.status == 200) {
                alert('결제 완료!')
                window.location.reload();
            }
        } else { // 결제 실패시
            alert(rsp.error_msg)
        }
    });
}
