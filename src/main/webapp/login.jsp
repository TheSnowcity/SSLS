<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp"%>
<html>
<head>
    <title>图书管理系统 - 登录</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .login-container {
            max-width: 400px;
            margin: 100px auto;
            padding: 20px;
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .login-title {
            text-align: center;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 3px;
        }
        .btn-login {
            width: 100%;
            padding: 10px;
            background-color: #4fcfec;
            color: white;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }
        .btn-login:hover {
            background-color: #42c2e8;
        }
        .error-message {
            color: red;
            margin-bottom: 10px;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="login-container">
    <h2 class="login-title">图书管理系统登录</h2>

    <!-- 错误消息显示 -->
    <c:if test="${!empty msg}">
        <div class="error-message">${msg}</div>
    </c:if>

    <form action="${ctx}/LoginServlet" method="post">
        <div class="form-group">
            <label for="email">用户邮箱:</label>
            <input type="email" id="email" name="email" required>
        </div>

        <div class="form-group">
            <label for="password">用户密码:</label>
            <input type="password" id="password" name="password" required>
        </div>

        <button type="submit" class="btn-login">登录</button>
    </form>

    <p style="text-align: center; margin-top: 15px;">
        <a href="${ctx}/forgotPassword.jsp">忘记密码?</a>
    </p>
</div>
</body>
</html>