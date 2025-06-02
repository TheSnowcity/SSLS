<%@ page import="com.wyx.domain.Reader" %>
<%@ page import="com.wyx.dao.FineDao" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%--<%@ include file="header.jsp"%>--%>

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
    <title>我的书架</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css" rel="stylesheet">

    <link rel="stylesheet" href="${ctx}/css/navbar.css">
    <link rel="stylesheet" href="${ctx}/css/shelf.css">
</head>
<body>

<%@ include file="header2.jsp"%>

<form id="borrowForm" action="${ctx}/BorrowBooksServlet" method="post">
<div class="shelf-container">
    <!-- 未缴纳罚款提示 -->
    <c:if test="${hasUnpaidFines}">
        <div class="alert-fine">
            <i class="fa fa-exclamation-circle"></i>
            您有 <strong style="color: red">${unpaidFineCount}</strong> 笔未缴纳的罚款，请先<a href="${ctx}/FineManageServlet">缴纳罚款</a>再进行借阅或续借操作。
        </div>
    </c:if>

    <div class="shelf-header">
        <h2>我的暂存架</h2>
        <a href="${ctx}/IndexServlet" class="btn btn-outline">继续选书</a>
    </div>

    <c:if test="${empty shelf.shelfItemList}">
        <div class="empty-shelf">
            <i class="fa fa-bookmark-o"></i>
            <p>你的暂存架是空的</p>
            <a href="${ctx}/IndexServlet" class="btn">开始添加图书</a>
        </div>
    </c:if>

    <c:if test="${not empty shelf.shelfItemList}">
        <div class="shelf-items">
            <c:forEach items="${shelf.shelfItemList}" var="item">
                <div class="shelf-item">
                    <div class="item-select">
                        <input type="checkbox" name="selectedBooks" value="${item.id}"
                               id="book-${item.id}" class="book-checkbox">
                    </div>
                    <div class="item-image">
                        <img src="${ctx}${item.imageUrl}" alt="${item.name}">
                    </div>
                    <div class="item-info">
                        <div class="item-title">${item.name}</div>
                        <div class="item-details">作者：${item.authors}</div>
                        <div class="item-details">出版社：${item.press}</div>
                        <div class="item-details">
                                出版时间：${item.publishDate.year}-${item.publishDate.monthValue}-${item.publishDate.dayOfMonth}
                        </div>
                    </div>
                    <div class="item-actions">
<%--                        <form action="${ctx}/RemoveFromShelfServlet" method="post">--%>
<%--                            <input type="hidden" name="id" value="${item.id}">--%>
<%--                            <button type="submit" class="remove-btn">--%>
<%--                                <i class="fa fa-trash-o"></i> 移除--%>
<%--                            </button>--%>
<%--                        </form>--%>
                        <div class="item-actions">
                            <button type="button" class="remove-btn" data-id="${item.id}">
                                <i class="fa fa-trash-o"></i> 移除
                            </button>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div class="shelf-selection">
            <input type="checkbox" id="selectAll">
            <label for="selectAll">全选</label>
            <span class="selected-count ml-3">已选：<span id="selectedCount">0</span> 本</span>
        </div>

        <div class="shelf-footer">
            <div class="shelf-total">
                共 <span style="color: #3792f6;">${shelf.shelfItemList.size()}</span> 本图书
            </div>
            <div class="shelf-actions">
                <a href="${ctx}/IndexServlet" class="btn btn-outline">继续选书</a>
<%--                <button type="submit" id="confirmBorrowBtn" class="btn btn-primary">--%>
<%--                    确认借阅已选图书--%>
<%--                </button>--%>
                <c:choose>
                    <c:when test="${not hasUnpaidFines}">
                        <button type="submit" id="confirmBorrowBtn" class="btn btn-primary">
                            确认借阅已选图书
                        </button>
                    </c:when>
                    <c:otherwise>
                        <button type="submit" id="confirmBorrowBtn" class="btn btn-primary" style="opacity: 0.5" disabled>
                            确认借阅已选图书
                        </button>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </c:if>

</div>
</form>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const selectAllCheckbox = document.getElementById('selectAll');
        const bookCheckboxes = document.querySelectorAll('.book-checkbox');
        const selectedCountSpan = document.getElementById('selectedCount');
        const confirmBorrowBtn = document.getElementById('confirmBorrowBtn');
        const borrowForm = document.getElementById('borrowForm');

        // 更新选中图书数量
        // function updateSelectedCount() {
        //     const selectedCount = document.querySelectorAll('.book-checkbox:checked').length;
        //     selectedCountSpan.textContent = selectedCount;
        //
        //     // 禁用/启用确认借阅按钮
        //     confirmBorrowBtn.disabled = selectedCount === 0;
        // }
        // 更新选中图书数量
        function updateSelectedCount() {
            const selectedCount = document.querySelectorAll('.book-checkbox:checked').length;
            selectedCountSpan.textContent = selectedCount;

            // 同时检查选中数量和罚款状态
            if (hasUnpaidFines) {
                confirmBorrowBtn.disabled = true;
                confirmBorrowBtn.title = '请先缴纳未处理的罚款';
            } else {
                confirmBorrowBtn.disabled = selectedCount === 0;
                confirmBorrowBtn.title = '';
            }
        }

        // 全选/取消全选功能
        selectAllCheckbox.addEventListener('change', function() {
            bookCheckboxes.forEach(checkbox => {
                checkbox.checked = this.checked;
            });
            updateSelectedCount();
        });

        // 单个图书复选框事件
        bookCheckboxes.forEach(checkbox => {
            checkbox.addEventListener('change', function() {
                // 检查是否所有图书都被选中
                const allChecked = document.querySelectorAll('.book-checkbox:checked').length ===
                    bookCheckboxes.length;
                selectAllCheckbox.checked = allChecked;

                updateSelectedCount();
            });
        });

        const removeButtons = document.querySelectorAll('.remove-btn');
        removeButtons.forEach(button => {
            button.addEventListener('click', function() {
                const id = this.dataset.id;
                // if (confirm('确定要移除这本书吗？')) {
                    fetch('${ctx}/RemoveFromShelfServlet', {
                        method: 'POST',
                        body: new URLSearchParams({ id: id })
                    })
                        .then(response => {
                            if (response.ok) {
                                // 删除成功后，刷新当前页面
                                window.location.reload();
                            } else {
                                alert('删除失败，请重试');
                            }
                        })
                        .catch(error => {
                            console.error('删除失败:', error);
                            alert('网络错误，删除失败');
                        });
                // }
            });
        });
        // 初始化
        updateSelectedCount();
    });
</script>

</body>
</html>