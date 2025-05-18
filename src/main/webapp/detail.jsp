<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="header.jsp"%>
<html>
<head>
    <title>图书详情</title>
    <style>
        .book-container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            display: flex;
            flex-wrap: wrap;
            align-items: flex-start;

            /* 增加边框感 */
            border: 1px solid #ccc;
            border-radius: 8px;
            background-color: #fdfdfd;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .book-cover {
            flex: 0 0 300px;
            margin-right: 30px;
        }

        .book-cover img {
            width: 100%;
            height: auto;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 4px;
        }

        .book-info {
            flex: 1;
            display: flex;
            flex-direction: column;
            min-height: 450px; /* 设置最小高度与图片一致 */
            justify-content: space-between;

            /* 可选：分区更清晰 */
            padding: 10px;
            border-left: 1px solid #eee;
        }

        .book-title {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .book-author, .book-publisher, .book-pubdate, .book-isbn, .book-price {
            font-size: 16px;
            margin-bottom: 8px;
        }

        .book-desc {
            margin-top: 20px;
            line-height: 1.6;
        }

        .action-buttons {
            margin-top: 20px;
        }

        .action-buttons button {
            padding: 10px 20px;
            margin-right: 10px;
            background-color: #14d017;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .action-buttons button:hover {
            background-color: #a5f5b5;
        }
    </style>
</head>
<body>
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
<%--                <a href="${ctx}/IndexServlet"><button>返回首页</button></a>--%>
            </form>

        </div>
    </div>
</div>

<%--<div class="book-container book-reviews">--%>
<%--    <h3>读者评论</h3>--%>

<%--    <div class="review-item">--%>
<%--        <div class="review-header">--%>
<%--            <div class="review-author">张三</div>--%>
<%--            <div class="review-date">2025-04-15</div>--%>
<%--        </div>--%>
<%--        <div class="review-content">--%>
<%--            非常好的Java学习书籍，内容全面，讲解详细，适合系统学习Java编程。--%>
<%--        </div>--%>
<%--    </div>--%>

<%--    <div class="review-item">--%>
<%--        <div class="review-header">--%>
<%--            <div class="review-author">李四</div>--%>
<%--            <div class="review-date">2025-03-20</div>--%>
<%--        </div>--%>
<%--        <div class="review-content">--%>
<%--            作为Java开发的参考书籍很不错，案例丰富，实用性强。--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>
</body>
</html>
