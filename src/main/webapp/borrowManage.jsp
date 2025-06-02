<%@ page import="java.time.LocalDate" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%@ page import="com.wyx.dao.FineDao" %>
<%@ page import="com.wyx.domain.Fine" %>
<%@ page import="com.wyx.domain.Reader" %>

<%-- 检查用户是否有未缴纳的罚款 --%>
<%
    Reader reader = (Reader) session.getAttribute("reader");
    boolean hasUnpaidFines = false;

    if (reader != null) {
        FineDao fineDao = new FineDao();
        int unpaidFineCount = fineDao.getUnpaidFinesByReaderId(reader.getId()).size();
        hasUnpaidFines = unpaidFineCount > 0;
        request.setAttribute("hasUnpaidFines", hasUnpaidFines);
        request.setAttribute("unpaidFineCount", unpaidFineCount);
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>我的借阅</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css" rel="stylesheet">

    <link rel="stylesheet" href="${ctx}/css/navbar.css">
    <link rel="stylesheet" href="${ctx}/css/shelf.css">
    <link rel="stylesheet" href="${ctx}/css/borrowManage.css">
</head>
<body>
<%@ include file="header2.jsp"%>
<div class="borrow-container">

    <!-- 未缴纳罚款提示 -->
    <c:if test="${hasUnpaidFines}">
        <div class="alert-fine">
            <i class="fa fa-exclamation-circle"></i>
            您有 <strong style="color: red">${unpaidFineCount}</strong> 笔未缴纳的罚款，请先<a href="${ctx}/FineManageServlet">缴纳罚款</a>再进行借阅或续借操作。
        </div>
    </c:if>

    <h2>我的借阅记录</h2>

    <!-- 顶部导航栏 -->
    <nav class="navbar navbar-light bg-light mb-4">
        <div class="container">
            <ul class="nav nav-tabs">
                <li class="nav-item">
                    <a class="nav-link" href="${ctx}/BorrowManageServlet">所有借阅</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${ctx}/BorrowHistoryServlet">借阅历史</a>
                </li>
            </ul>
        </div>
    </nav>

    <c:if test="${empty borrowList}">
        <p>您当前没有借阅的图书</p>
    </c:if>

    <c:if test="${not empty borrowList}">
        <table class="borrow-table">
            <thead>
            <tr>
                <th>图书封面</th>
                <th>图书名称</th>
                <th>借阅日期</th>
                <th>应还日期</th>
                <th>归还日期</th>
                <th>当前状态</th>
                <th>罚款信息</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${borrowList}" var="borrow">
                <tr>
                    <!-- 其他列保持不变 -->
                    <td><img src="${ctx}${borrow.imageUrl}" width="60" alt="${borrow.name}"></td>
                    <td>${borrow.name}</td>
                    <td>${borrow.borrow_date}</td>
                    <td>${borrow.due_date}</td>
                    <td>${borrow.return_date}</td>
                    <td>
                        <c:if test="${borrow.return_date != null}">
                            <span class="is-returned">已归还</span>
                        </c:if>
                        <c:if test="${borrow.return_date == null}">
                            <c:if test="${borrow.overdue}">
                                <span class="overdue">已逾期 ${borrow.overdueDays} 天</span>
                            </c:if>
                            <c:if test="${not borrow.overdue}">
                                <span class="not-overdue">正常</span>
                            </c:if>
                        </c:if>
                    </td>
                    <td>
                        <!-- 罚款信息列 -->
                        <c:if test="${borrow.return_date != null and borrow.overdue}">
                            <c:set var="fineDao" value="<%= new FineDao() %>" />
                            <c:set var="fine" value="${fineDao.getFineByBorrowId(borrow.id)}" />
                            <c:if test="${fine != null}">
                                <span class="fine-info">
                                    罚款：<span style="font-weight: bold">${fine.penalty_amount} 元</span> &nbsp;&nbsp;
                                    状态：
                                    <span style="font-weight: bold">${fine.payment_status eq '未处理' ? '未缴纳' : '已缴纳'}</span>
                                </span>
                            </c:if>
                        </c:if>
                    </td>

                    <td>
                        <!-- 操作列：新增续借按钮（跳转确认页面） -->
                        <c:if test="${borrow.return_date == null}">
                            <!-- 归还按钮 -->
                            <a href="${ctx}/ReturnBookServlet?borrowId=${borrow.id}" class="return-btn">归还</a>

                            <!-- 续借按钮：仅未超期时显示，跳转至确认页面 -->
<%--                            <c:if test="${not borrow.overdue}">--%>
<%--                                <a href="${ctx}/RenewBookServlet?borrowId=${borrow.id}" class="renew-btn">续借</a>--%>
<%--                            </c:if>--%>
                            <!-- 续借按钮 -->
                            <c:choose>
                                <c:when test="${not borrow.overdue and not hasUnpaidFines}">
                                    <a href="${ctx}/RenewBookServlet?borrowId=${borrow.id}" class="renew-btn">续借</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${ctx}/RenewBookServlet?borrowId=${borrow.id}" class="renew-btn-disabled">续借</a>
                                </c:otherwise>
                            </c:choose>

                        </c:if>

                        <!-- 罚款缴纳按钮 -->
                        <c:if test="${borrow.return_date != null and borrow.overdue}">
                            <c:set var="fineDao" value="<%= new FineDao() %>" />
                            <c:set var="fine" value="${fineDao.getFineByBorrowId(borrow.id)}" />
                            <c:if test="${fine != null and fine.payment_status eq '未处理'}">
<%--                                <a href="${ctx}/PayFineServlet?fineId=${fine.id}" class="pay-btn">缴纳</a>--%>
                                <a href="${ctx}/payFine.jsp?fineId=${fine.id}" class="pay-btn">缴纳</a>
                            </c:if>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>
</div>
</body>
</html>