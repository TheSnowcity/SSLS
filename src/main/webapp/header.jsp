<%--
  Created by IntelliJ IDEA.
  User: Snow_city
  Date: 2025/5/17
  Time: 15:20
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>图书馆管理系统</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <!-- 自定义样式 -->
    <style>
        body {
            padding-top: 78px; /* 顶部导航栏高度 */
        }

        .navbar {
            background-color: #1dfd0d;
        }

        .navbar-brand {
            font-weight: bold;
            color: cyan;
        }

        .navbar-nav .nav-link {
            color: blue;
        }

        .navbar-nav .nav-link:hover {
            color: blueviolet;
        }

        .sidebar {
            border-right: 2px solid #238bf3;
            padding: 25px 0;
        }

        .sidebar-title {
            font-weight: bold;
            margin-bottom: 18px;
            padding-left: 18px;
        }

        .category-list {
            list-style: none;
            padding: 0;
        }

        .category-list li {
            padding: 10px 18px;
        }

        .category-list li a {
            color: #333;
            text-decoration: none;
            display: block;
        }

        .category-list li.active {
            background-color: #48dede;
            font-weight: bold;
        }

        .category-list li:hover {
            background-color: #3684d3;
        }

        .search-bar {
            margin: 40px 0;
        }

        .book-item {
            border: 1px solid #8de3ef;
            border-radius: 5px;
            padding: 20px;
            margin-bottom: 20px;
            transition: transform 0.3s;
            display: flex;
            flex-wrap: wrap;
        }

        .book-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .book-cover {
            width: 100px;
            margin-right: 20px;
        }

        .book-cover img {
            width: 100%;
            height: 140px;
            object-fit: cover;
            border-radius: 3px;
        }

        .book-content {
            flex: 1;
            min-width: 200px;
        }

        .book-title {
            font-weight: bold;
            font-size: 1.1rem;
            margin-bottom: 5px;
        }

        .book-details {
            margin-bottom: 10px;
        }

        .book-details p {
            margin-bottom: 3px;
            font-size: 0.9rem;
        }

        .book-actions {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: flex-end;
            margin-left: 15px;
        }

        .book-status {
            margin-bottom: 10px;
        }

        .pagination {
            margin-top: 30px;
        }

        /* 响应式调整 */
        @media (max-width: 768px) {
            .sidebar {
                border-right: none;
                border-bottom: 1px solid #dee2e6;
                padding-bottom: 10px;
            }

            .book-item {
                flex-direction: column;
            }

            .book-cover {
                width: 100%;
                margin-right: 0;
                margin-bottom: 15px;
            }

            .book-cover img {
                height: 200px;
            }

            .book-content {
                width: 100%;
                margin-bottom: 15px;
            }

            .book-actions {
                flex-direction: row;
                justify-content: space-between;
                align-items: center;
                margin-left: 0;
            }

            .book-status {
                margin-bottom: 0;
            }
        }

        .custom-search-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            background-color: #0d6efd;
            color: white;
            border: 1px solid rgba(255, 255, 255, 0.3);
            border-radius: 0.25rem;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
            white-space: nowrap;
            font-family: system-ui, -apple-system, sans-serif;
            font-size: 1rem;
            font-weight: 500;
            transition: all 0.2s ease;
            cursor: pointer;
        }

        .custom-search-btn:hover {
            background-color: #0b5ed7;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .custom-search-btn:focus {
            outline: none;
            box-shadow: 0 0 0 3px rgba(13, 110, 253, 0.5);
        }
    </style>
</head>
<body>
<!-- 顶部导航栏 -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="#">
            <i class="fa fa-book me-2"></i>图书馆管理系统
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="${ctx}/IndexServlet">首页</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${ctx}/shelf.jsp">管理我的书架</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">查看借阅</a>
                </li>
            </ul>
            <ul class="navbar-nav">
                <li class="nav-item">
                    <%--                    <a class="nav-link" href="#" id="loginLink"><i class="fa fa-sign-in me-1"></i> 登录</a>--%>
                    <c:if test="${empty reader}">
                        <a class="nav-link" href="${ctx}/login.jsp">请登录</a>
                    </c:if>
                    <c:if test="${!empty reader}">
                        <a class="nav-link" href="${ctx}/ReaderServlet">
                            欢迎：<b>${reader.username}</b>
                        </a>

                    </c:if>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" id="registerLink"><i class="fa fa-user-plus me-1"></i> 注册</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
