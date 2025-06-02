<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>图书管理系统 - 登录</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css" rel="stylesheet">

    <link rel="stylesheet" href="${ctx}/css/navbar.css">
    <link rel="stylesheet" href="${ctx}/css/login.css">
</head>
<body>
<%@ include file="header2.jsp"%>
<div class="login-container">
    <h2 class="login-title">图书管理系统登录</h2>

    <!-- 注册成功消息显示 -->
    <c:if test="${registerSuccess != null && registerSuccess == true}">
        <div class="success-message">注册成功，请输入密码登录</div>
    </c:if>

    <!-- 错误消息显示 -->
    <c:if test="${!empty msg}">
        <div class="error-message">${msg}</div>
    </c:if>

    <form action="${ctx}/LoginServlet" method="post">
        <div class="form-group">
            <label for="email">用户邮箱:</label>
            <input type="email" id="email" name="email"
                   value="${registerEmail}" required>
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

<script>
    // 登录成功后清除session中的注册信息
    document.addEventListener('DOMContentLoaded', function() {
        // 清除注册相关的session数据
        <c:if test="${registerEmail != null}">
        // 使用AJAX清除服务器端的session数据
        fetch('${ctx}/ClearRegisterSessionServlet', {
            method: 'POST'
        });
        </c:if>
    });
</script>
</body>
</html>