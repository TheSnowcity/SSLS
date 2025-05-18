<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="header.jsp"%>
<html>
<head>
    <title>我的暂存架</title>
    <style>
        /* 基础样式设置 */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
            color: #333;
        }

        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 0 15px;
        }

        .empty-shelf {
            text-align: center;
            padding: 80px 0;
        }

        .empty-shelf i {
            font-size: 60px;
            color: #ccc;
            margin-bottom: 20px;
        }

        .empty-shelf p {
            font-size: 18px;
            color: #666;
            margin-bottom: 30px;
        }

        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #37f641;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            font-size: 14px;
            transition: background-color 0.3s;
        }

        .btn:hover {
            background-color: #408309;
        }

        .btn-outline {
            background-color: transparent;
            border: 1px solid #37f641;
            color: #95ea7e;
        }

        .btn-outline:hover {
            background-color: #f0f7ff;
        }

        .shelf-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .shelf-header h2 {
            margin: 0;
            font-size: 24px;
            color: #333;
        }

        .shelf-items {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }

        .shelf-item {
            display: flex;
            align-items: center;
            padding: 20px;
            border-bottom: 1px solid #eee;
            transition: background-color 0.3s;
        }

        .shelf-item:hover {
            background-color: #f9f9f9;
        }

        .shelf-item:last-child {
            border-bottom: none;
        }

        .item-image {
            width: 80px;
            height: 120px;
            margin-right: 20px;
            overflow: hidden;
            border-radius: 4px;
        }

        .item-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s;
        }

        .item-image img:hover {
            transform: scale(1.05);
        }

        .item-info {
            flex: 1;
            min-width: 0;
        }

        .item-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 5px;
            color: #333;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .item-details {
            font-size: 14px;
            color: #666;
            margin-bottom: 5px;
        }

        .item-actions {
            display: flex;
            align-items: center;
        }

        .remove-btn {
            color: #dc3545;
            background: none;
            border: none;
            cursor: pointer;
            font-size: 14px;
            transition: color 0.3s;
        }

        .remove-btn:hover {
            color: #c82333;
        }

        .shelf-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .shelf-total {
            font-size: 18px;
            font-weight: 600;
            color: brown;
        }

        /* 响应式布局 */
        @media (max-width: 768px) {
            .shelf-item {
                flex-direction: column;
                align-items: flex-start;
            }

            .item-image {
                margin-bottom: 15px;
            }

            .item-actions {
                margin-top: 15px;
            }

            .shelf-footer {
                flex-direction: column;
                align-items: stretch;
            }

            .shelf-total {
                margin-bottom: 15px;
                text-align: center;
            }

            .shelf-actions {
                display: flex;
                justify-content: center;
            }

            .btn {
                margin: 0 5px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="shelf-header">
        <h2>我的暂存架</h2>
        <a href="${ctx}/IndexServlet" class="btn btn-outline">朕还要选妃</a>
    </div>

    <c:if test="${empty shelf.shelfItemList}">
        <div class="empty-shelf">
            <i class="fa fa-bookmark-o"></i>
            <p>啥都没有</p>
            <a href="${ctx}/IndexServlet" class="btn">开始物色书</a>
        </div>
    </c:if>

    <c:if test="${not empty shelf.shelfItemList}">
        <div class="shelf-items">
            <c:forEach items="${shelf.shelfItemList}" var="item">
                <div class="shelf-item">
                    <div class="item-image">
                        <img src="${ctx}${item.imageUrl}" alt="${item.name}">
                    </div>
                    <div class="item-info">
                        <div class="item-title">${item.name}</div>
                        <div class="item-details">作者：${item.authors}</div>
                        <div class="item-details">出版社：${item.press}</div>
                    </div>
                    <div class="item-actions">
                        <form action="${ctx}/RemoveFromShelfServlet" method="post">
                            <input type="hidden" name="id" value="${item.id}">
                            <button type="submit" class="remove-btn">
                                <i class="fa fa-trash-o"></i> 移除
                            </button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div class="shelf-footer">
            <div class="shelf-total">
                共 <span style="color: #3792f6;">${shelf.shelfItemList.size()}</span> 本图书
            </div>
            <div class="shelf-actions">
                <a href="${ctx}/IndexServlet" class="btn btn-outline">朕还要选妃</a>
                <a href="${ctx}/CheckoutServlet" class="btn">就决定是你了！</a>
            </div>
        </div>
    </c:if>
</div>
</body>
</html>