<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>

<style>
    .ai-container {
        max-width: 700px;
        margin: 30px auto;
        background: #ffffff;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        padding: 25px 30px;
        font-family: "Segoe UI", sans-serif;
    }

    .ai-container h3 {
        text-align: center;
        color: #2c3e50;
        margin-bottom: 20px;
    }

    #prompt {
        width: 100%;
        border: 1px solid #d1d1d1;
        border-radius: 8px;
        padding: 10px 12px;
        font-size: 15px;
        resize: vertical;
        transition: border-color 0.2s;
    }

    #prompt:focus {
        outline: none;
        border-color: #3498db;
        box-shadow: 0 0 0 3px rgba(52,152,219,0.15);
    }

    .ai-btn {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        background: linear-gradient(135deg, #4a90e2, #357ABD);
        color: white;
        border: none;
        border-radius: 8px;
        padding: 10px 18px;
        margin-top: 12px;
        cursor: pointer;
        font-size: 15px;
        transition: background 0.25s ease;
    }

    .ai-btn:hover {
        background: linear-gradient(135deg, #357ABD, #2C5F9E);
    }

    #result {
        margin-top: 20px;
        border: 1px solid #e1e1e1;
        border-radius: 8px;
        padding: 15px;
        background: #f8f9fa;
        min-height: 80px;
        white-space: pre-wrap;
        font-size: 15px;
        color: #333;
    }

    .ai-loading {
        color: #888;
        font-style: italic;
    }
</style>

<div class="ai-container">
    <h3>🤖 Trợ lý AI - Quản lý sản phẩm</h3>

    <textarea id="prompt" rows="4" placeholder="Nhập yêu cầu cho AI"></textarea>
    <br>
    <button class="ai-btn" onclick="askAI()">
        🚀 Gửi yêu cầu
    </button>

    <div id="result"></div>
</div>

<script>
    function askAI() {
        const prompt = document.getElementById("prompt").value.trim();
        const resultBox = document.getElementById("result");

        if (!prompt) {
            resultBox.innerText = "⚠️ Vui lòng nhập yêu cầu cho AI trước khi gửi.";
            return;
        }

        resultBox.innerHTML = "<span class='ai-loading'>⏳ Đang xử lý yêu cầu...</span>";

        fetch("${pageContext.request.contextPath}/admin-ai/suggest", {
            method: "POST",
            headers: {"Content-Type": "application/x-www-form-urlencoded"},
            body: "prompt=" + encodeURIComponent(prompt)
        })
            .then(r => r.text())
            .then(data => {
                resultBox.innerText = data || "Không nhận được phản hồi từ AI.";
            })
            .catch(e => {
                resultBox.innerHTML = "<span style='color:red'>❌ Lỗi khi gửi yêu cầu đến AI!</span>";
                console.error(e);
            });
    }
</script>
