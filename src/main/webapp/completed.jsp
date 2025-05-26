<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%--<%@ include file="header.jsp"%>--%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>借阅完成</title>
<%--    <style>--%>
<%--        body {--%>
<%--            font-family: Arial, sans-serif;--%>
<%--            margin: 0;--%>
<%--            padding: 20px;--%>
<%--            background-color: #f5f5f5;--%>
<%--        }--%>
<%--        .container {--%>
<%--            max-width: 800px;--%>
<%--            margin: 0 auto;--%>
<%--            background-color: white;--%>
<%--            padding: 20px;--%>
<%--            border-radius: 8px;--%>
<%--            box-shadow: 0 2px 4px rgba(0,0,0,0.1);--%>
<%--        }--%>
<%--        h2 {--%>
<%--            color: #333;--%>
<%--            margin-top: 0;--%>
<%--        }--%>
<%--        .success-message {--%>
<%--            color: #4CAF50;--%>
<%--            font-size: 18px;--%>
<%--            margin-bottom: 20px;--%>
<%--        }--%>
<%--        .book-table {--%>
<%--            width: 100%;--%>
<%--            border-collapse: collapse;--%>
<%--            margin-bottom: 20px;--%>
<%--        }--%>
<%--        .book-table th, .book-table td {--%>
<%--            padding: 10px;--%>
<%--            border: 1px solid #ddd;--%>
<%--            text-align: left;--%>
<%--        }--%>
<%--        .book-table th {--%>
<%--            background-color: #f2f2f2;--%>
<%--        }--%>
<%--        .due-date {--%>
<%--            color: #f44336;--%>
<%--            font-weight: bold;--%>
<%--        }--%>
<%--        .action-buttons {--%>
<%--            text-align: center;--%>
<%--            margin-top: 20px;--%>
<%--        }--%>
<%--        .action-buttons button {--%>
<%--            padding: 10px 20px;--%>
<%--            background-color: #4CAF50;--%>
<%--            color: white;--%>
<%--            border: none;--%>
<%--            border-radius: 4px;--%>
<%--            cursor: pointer;--%>
<%--            margin: 0 10px;--%>
<%--        }--%>
<%--        .action-buttons button:hover {--%>
<%--            background-color: #45a049;--%>
<%--        }--%>
<%--    </style>--%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css" rel="stylesheet">

    <link rel="stylesheet" href="${ctx}/css/navbar.css">
    <link rel="stylesheet" href="${ctx}/css/completed.css">
</head>
<body>

<%@ include file="header2.jsp"%>

<div class="completed-container">
    <h2>借阅成功</h2>

    <div class="success-message">
        您已成功借阅以下图书，请按时归还。
    </div>

    <table class="book-table">
        <thead>
        <tr>
            <th>图书ID</th>
            <th>图书名称</th>
            <th>借阅日期</th>
            <th>应归还日期</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${sessionScope.booksToBorrow}" var="book">
            <tr>
                <td>${book.id}</td>
                <td>${book.name}</td>
                <td>${currentDate}</td>
                <td class="due-date">${dueDate}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="action-buttons">
        <button onclick="window.location.href='${pageContext.request.contextPath}/shelf.jsp'">继续借阅</button>
        <button onclick="window.location.href='${pageContext.request.contextPath}/BorrowManageServlet'">查看我的借阅</button>
    </div>
</div>

<script>
    // 页面加载完成后，从session中获取当前日期
    document.addEventListener('DOMContentLoaded', function() {
        // 如果需要JavaScript处理日期，可以在这里添加
    });
</script>
</body>
</html>