package com.snowcity.ssls.servlet;


import com.snowcity.ssls.domain.Book;
import com.snowcity.ssls.dao.BookDao;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "IndexServlet", value = "/IndexServlet")
public class IndexServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("utf-8");
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        BookDao bookDao = new BookDao();
        List<Book> bookList = null;

        try {
            String categoryIdParam = request.getParameter("categoryId");
            String status = request.getParameter("status");
            // category参数值存在且有效
            if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
                int categoryId = Integer.parseInt(categoryIdParam);
                // 根据分类ID查询
                if (status != null && !status.isEmpty()) {
                    // 同时有分类和状态参数
                    bookList = bookDao.getByCategoryAndStatus(categoryId, status);
                } else {
                    // 只有分类参数
                    bookList = bookDao.getByCategory(categoryId);
                }
            } else if (status != null && !status.isEmpty()) {
                // 只有状态参数
                bookList = bookDao.getByStatus(status);
            } else {
                // 没有参数，获取最新列表（默认操作）
                bookList = bookDao.getNewList();
            }
        } catch (NumberFormatException e) {
            // 处理分类ID转换异常
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "分类ID参数格式错误");
            return;
        } catch (Exception e) {
            // 处理其他异常
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "服务器内部错误");
            return;
        }

        // 将结果存入session
        request.getSession().setAttribute("bookList", bookList);
        response.sendRedirect(request.getContextPath()+"/index.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doGet(request, response);
    }
}

