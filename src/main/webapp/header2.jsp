<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 顶部导航栏 -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="${ctx}/IndexServlet">
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
                <!-- 书架管理链接（添加登录校验） -->
                <li class="nav-item">
                    <c:if test="${empty reader}">
                        <a class="nav-link" href="${ctx}/login.jsp?redirect=${ctx}/shelf.jsp">我的书架</a>
                    </c:if>
                    <c:if test="${not empty reader}">
                        <a class="nav-link" href="${ctx}/shelf.jsp">我的书架</a>
                    </c:if>
                </li>
                <!-- 借阅管理链接（添加登录校验） -->
                <li class="nav-item">
                    <c:if test="${empty reader}">
                        <a class="nav-link" href="${ctx}/login.jsp?redirect=${ctx}/borrowManage.jsp">我的借阅</a>
                    </c:if>
                    <c:if test="${not empty reader}">
                        <a class="nav-link" href="${ctx}/BorrowManageServlet">我的借阅</a>
                    </c:if>
                </li>

                <!-- 罚款管理链接（添加登录校验和罚款数量显示） -->
                <li class="nav-item">
                    <c:if test="${empty reader}">
                        <a class="nav-link" href="${ctx}/login.jsp?redirect=${ctx}/fineManage.jsp">我的罚款</a>
                    </c:if>
                    <c:if test="${not empty reader}">
                        <a class="nav-link" href="${ctx}/FineManageServlet">
                            我的罚款(<c:out value="${sessionScope.unpaidFineCount}"/>)
                        </a>
                    </c:if>
                </li>
            </ul>
            <ul class="navbar-nav">
                <c:if test="${empty reader}">
                    <li class="nav-item">
                        <a class="nav-link" href="${ctx}/login.jsp">请登录</a>
                    </li>
                </c:if>
                <c:if test="${!empty reader}">
                    <li class="nav-item">
                        <a class="nav-link" href="${ctx}/readerIndex.jsp">
<%--                            欢迎：<b>${reader.username}</b>--%>
                            <i class="fa fa-user-circle me-1"></i> <b>${reader.username}</b>
                        </a>
                    </li>
                    <span style="color: white; padding: 8px 2px;">|</span>
                    <li class="nav-item">
                        <a class="nav-link" href="${ctx}/LogoutServlet">注销</a>
                    </li>
                </c:if>


                &nbsp;&nbsp;
                <li class="nav-item">
                    <a class="nav-link" href="${ctx}/register.jsp" id="registerLink"><i class="fa fa-user-plus me-1"></i> 注册</a>
                </li>
            </ul>
        </div>
    </div>
</nav>