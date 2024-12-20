// apply-modal.js

function applyDetailModal() {
    applyBizPostDetailModal();
    applyUserResumeList();
}

function applyBizPostDetailModal() {
    var bizIdx = $("#bizIdx").val();
    var postIdx = $("#postIdx").val();
    var loginIdx = $("#loginIdx").val();
    var param = {
        bizIdx: bizIdx,
        postIdx: postIdx,
        loginIdx: loginIdx
    };
    
    var callback = function(res) {
        var detail = res.bizPostDetail;
        $("#bizName3").text(detail.bizName);
        $("#bizPostTitle").text(detail.postTitle);
        
        gfModalPop("#applyModal");
    };
    
    callAjax("/jobs/applyBizPostDetail.do", "post", "json", false, param, callback);
}

function applyUserResumeList() {
    var loginIdx = $("#loginIdx").val();
    var param = {
        loginIdx: loginIdx
    };

    var callback = function(res) {
        var userResumeList = res.userResumeList;
        console.log(userResumeList);
        var tbody = $("#resumeTable tbody");
        tbody.empty();  // 기존 내용 제거

        // 이력서 리스트를 테이블에 추가
        userResumeList.forEach(function(item) {
            var row = "<tr class='spaceBetweenRB'>"
                + "<td style='flex: 8;'>"
                + "<input type='hidden' id='userIdx' name='userIdx' value='" + item.userIdx + "' />"
                + "<div class='resumeTitle'><strong>" + item.resumeTitle + "</strong> "
                + "<a style='color: gray;' href='/apply/resume-detail.do?resumeNum=" + item.resumeIdx + "'><span>수정</span></a>"
                + "</div>"
                + "<div style='clear: both;'></div>"
                + "<div style='margin:30px 5px 10px;'>이메일 주소: " + item.userEmail + "</div>"
                + "<div style='margin:10px 5px 10px;'>핸드폰: " + item.userPhone + "</div>"
                + "</td>"
                + "<td style='flex: 2; text-align: right;'>"
                + "<input type='radio' name='resumeSelect' value='" + item.resumeIdx + "'>"
                + "</td>"
                + "</tr>";
            tbody.append(row);
        });
        gfModalPopTop("#applyModal");
    };

    callAjax("/jobs/applyUserResumeDetail.do", "post", "json", false, param, callback);
}

// jQuery가 로드된 경우 applyDetailModal 호출
if (window.jQuery) {
    $(document).ready(function() {
        applyDetailModal();
    });
} else {
    // jQuery가 로드되지 않았다면 DOMContentLoaded로 실행
    document.addEventListener("DOMContentLoaded", function() {
        applyDetailModal();
    });
}
