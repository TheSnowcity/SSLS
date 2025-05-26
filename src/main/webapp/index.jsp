<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
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

    <link rel="stylesheet" href="${ctx}/css/navbar.css">
    <link rel="stylesheet" href="${ctx}/css/index.css">
</head>
<body>
<%@ include file="header2.jsp"%>
<!-- 主内容区域 -->
<main class="container mt-4">
    <div class="row">
        <!-- 左侧分类栏 -->
        <div class="col-md-3">
            <div class="sidebar">
                <div class="sidebar-title">图书分类</div>
                <ul class="category-list">
                    <li class="active"><a href="${ctx}/IndexServlet">全部</a></li>
                    <li><a href="${ctx}/IndexServlet?categoryId=1">文学</a></li>
                    <li><a href="${ctx}/IndexServlet?categoryId=2">科技</a></li>
                    <li><a href="${ctx}/IndexServlet?categoryId=3">历史</a></li>
                    <li><a href="${ctx}/IndexServlet?categoryId=4">经济</a></li>
                    <li><a href="${ctx}/IndexServlet?categoryId=5">哲学</a></li>
                    <li><a href="${ctx}/IndexServlet?categoryId=6">艺术</a></li>
                </ul>

                <div class="sidebar-title mt-4">借阅状态</div>
                <ul class="category-list">
                    <li class="active"><a href="${ctx}/IndexServlet">全部</a></li>
                    <li><a href="${ctx}/IndexServlet?status=在库">可借阅</a></li>
                    <li><a href="${ctx}/IndexServlet?status=已借出">已借出</a></li>
                </ul>
            </div>
        </div>

        <!-- 右侧图书列表 -->
        <div class="col-md-9">
            <!-- 搜索栏 -->
            <div class="search-bar">
                <form class="d-flex">
                    <input class="form-control me-2" type="search" placeholder="搜索图书、作者、出版社" aria-label="Search">
                    <button class="custom-search-btn" type="submit">
                        <i class="fa fa-search"></i>
                        <span>搜索</span>
                    </button>
                </form>
            </div>

            <!-- 页面标题 -->
            <div class="mb-4">
                <h2>图书馆藏书</h2>
                <p class="text-muted">共收录 <span class="fw-bold">${bookList.size()}</span> 本图书</p>
            </div>

            <!-- 图书列表 -->
            <div class="book-list">
                <c:forEach items="${bookList}" var="book">
                    <div class="book-item">
                        <div class="book-cover">
                            <img src="${ctx}${book.imageUrl}" alt="${book.name}">
                        </div>
                        <div class="book-content">
                            <div class="book-title">${book.name}</div>
                            <div class="book-details">
                                <p><i class="fa fa-user me-1"></i> ${book.authors}</p>
                                <p><i class="fa fa-calendar me-1"></i> ${book.publishDate}</p>
                                <p><i class="fa fa-building me-1"></i> ${book.press}</p>
                            </div>
                        </div>
                        <div class="book-actions">
                            <div class="book-status">
                                <!-- 根据状态动态切换徽章颜色 -->
                                <c:choose>
                                    <c:when test="${book.status == '在库'}">
                                        <span class="badge bg-success">${book.status}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge status-borrowed">${book.status}</span> <!-- 已借出状态 -->
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="book-buttons">
                                <a href="${ctx}/DetailServlet?id=${book.id}" style="text-decoration: none">
                                    <button class="btn btn-sm btn-outline-primary me-1">
                                        <i class="fa fa-eye"></i> 详情
                                    </button>
                                </a>

                                <!-- 根据状态禁用借阅按钮 -->
                                <c:choose>
                                    <c:when test="${book.status == '在库'}">
                                        <a href="${ctx}/AddToShelfServlet?id=${book.id}">
                                            <button class="btn btn-sm btn-primary">
                                                <i class="fa fa-book"></i> 借阅
                                            </button>
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="btn btn-sm btn-primary btn-disabled">
                                            <i class="fa fa-book"></i> 已借出
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- 分页 -->
            <div class="mt-5">
                <nav aria-label="Page navigation">
                    <ul class="pagination justify-content-center">
                        <li class="page-item disabled">
                            <a class="page-link" href="#" tabindex="-1" aria-disabled="true">上一页</a>
                        </li>
                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                        <li class="page-item">
                            <a class="page-link" href="#">下一页</a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</main>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- 自定义脚本 -->
<script>

    document.getElementById('registerLink').addEventListener('click', function(e) {
        e.preventDefault();
        alert('注册功能将在后续版本中实现');
    });

    // 分类点击事件
    document.querySelectorAll('.category-list li a').forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            // 移除当前活动状态
            this.parentElement.parentElement.querySelectorAll('li.active').forEach(li => {
                li.classList.remove('active');
            });
            // 设置当前项为活动状态
            this.parentElement.classList.add('active');
        });
    });
</script>
</body>
</html>