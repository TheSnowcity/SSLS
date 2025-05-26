<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
    <title>图书详情</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css" rel="stylesheet">

    <link rel="stylesheet" href="${ctx}/css/navbar.css">
    <link rel="stylesheet" href="${ctx}/css/detail.css">
</head>
<body>
<%@ include file="header2.jsp"%>
<div class="book-container">
    <div class="book-cover">
        <img src="${ctx}${book.imageUrl}" alt="图书封面">
    </div>
    <div class="book-info">
        <div class="book-title">${book.name}</div>
        <div class="book-author">作者：${book.authors}</div>
        <div class="book-publisher">出版社：${book.press}</div>
        <div class="book-pubdate">出版日期：${book.publishDate}</div>
        <div class="book-desc">
            <p>图书介绍：${book.description}</p>
        </div>
        <div class="action-buttons">
            <form action="${ctx}/AddToShelfServlet">
                <input type="hidden" name="id" value="${book.id}">
<%--                <button type="submit">加入暂存架</button>--%>
                <button type="submit" <c:if test="${book.status == '借出'}">disabled="disabled"</c:if>>
                    <c:choose>
                        <c:when test="${book.status == '在库'}">加入暂存架</c:when>
                        <c:otherwise>已借出</c:otherwise>
                    </c:choose>
                </button>
            </form>

        </div>
    </div>
</div>
</body>
</html>
