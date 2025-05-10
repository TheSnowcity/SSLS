<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>校园自助图书管理系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 自定义样式 -->
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<!-- 顶部 LOGO 和标题 -->
<nav class="navbar navbar-light bg-light mb-3">
    <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center" href="#">
            <img src="LOGO/LOGO.png" alt="Logo" class="logo">
            <span class="fs-4">校园自助图书管理系统</span>
        </a>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <!-- 左侧图书类别 -->
        <div class="col-md-2 sidebar">
            <h5>图书类别</h5>
            <ul class="list-group">
                <li class="list-group-item">文学</li>
                <li class="list-group-item">历史</li>
                <li class="list-group-item">计算机</li>
                <li class="list-group-item">经济</li>
                <li class="list-group-item">艺术</li>
            </ul>
        </div>

        <!-- 右侧内容 -->
        <div class="col-md-10">
            <!-- 搜索栏 -->
            <div class="search-bar">
                <form class="d-flex" role="search">
                    <input class="form-control me-2" type="search" placeholder="搜索图书..." aria-label="Search">
                    <button class="btn btn-primary" type="submit">搜索</button>
                </form>
            </div>

            <!-- 检索结果 -->
            <div class="row">
                <!-- 示例图书卡片 -->
                <div class="col-md-4">
                    <div class="card book-card">
                        <div class="card-body">
                            <h5 class="card-title">母猪的产后护理</h5>
                            <p class="card-text">作者：赵本山<br>分类：计算机<br>馆藏：3本</p>
                            <a href="#" class="btn btn-outline-primary btn-sm">查看详情</a>
                        </div>
                    </div>
                </div>
                <!-- 更多图书卡片 -->
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS (可选) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>