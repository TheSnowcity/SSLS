<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>归还图书</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css" rel="stylesheet">

    <link rel="stylesheet" href="${ctx}/css/navbar.css">
    <link rel="stylesheet" href="${ctx}/css/returnBook.css">
</head>
<body>
<%@ include file="header2.jsp"%>
<div class="returnBook-container">
    <h2>归还图书</h2>

    <!-- 显示借阅记录详情（添加错误提示） -->
    <c:if test="${empty borrow}">
        <p style="color: red;">错误：未找到要归还的图书信息</p>
    </c:if>

    <c:if test="${not empty borrow}">
        <div class="book-info">
            <!-- 图书封面：使用 borrow.imageUrl（来自 SQL 别名） -->
            <img src="${ctx}${borrow.imageUrl}"
                 alt="${borrow.name}"
                 class="book-image">

            <div style="display: inline-block; vertical-align: middle; margin-left: 20px;">
                <p><strong>图书名称：</strong> ${borrow.name}</p>
                <p><strong>借阅日期：</strong>
                        ${borrow.borrow_date}
                </p>
                <p><strong>应还日期：</strong>
                        ${borrow.due_date}
                </p>
                <c:if test="${borrow.overdue}">
                    <p class="notice">
                        警告：已逾期 ${borrow.overdueDays} 天，将产生 <strong>${borrow.overdueDays * 0.5} 元</strong> 罚款！
                    </p>
                </c:if>
            </div>
        </div>

        <!-- 归还表单：传递 borrowId（借阅记录ID） -->
        <form action="${ctx}/ReturnBookServlet" method="post">
            <input type="hidden" name="borrowId" value="${borrow.id}">
            <button type="submit" class="action-btn">确认归还</button>
        </form>
    </c:if>
</div>
</body>
</html>