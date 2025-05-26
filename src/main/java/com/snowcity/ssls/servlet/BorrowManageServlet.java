package com.snowcity.ssls.servlet;

import com.snowcity.ssls.dao.BorrowDao;
import com.snowcity.ssls.domain.Borrow;
import com.snowcity.ssls.domain.Reader;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "BorrowManageServlet", value = "/BorrowManageServlet")
public class BorrowManageServlet extends HttpServlet {
    BorrowDao borrowDao = new BorrowDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 从Session获取当前用户
        HttpSession session = request.getSession();
        Reader reader = (Reader) session.getAttribute("reader");
        if (reader == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 查询当前用户的借阅记录（状态为"已借出"和"已归还"）
        List<Borrow> borrowList = borrowDao.getBorrowingByReaderId(reader.getId());

        // 将数据存入请求域
        request.setAttribute("borrowList", borrowList);
        request.getRequestDispatcher("/borrowManage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
