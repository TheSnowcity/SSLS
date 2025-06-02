package com.snowcity.ssls.servlet;

import com.snowcity.ssls.dao.FineDao;
import com.snowcity.ssls.dao.ReaderDao;
import com.snowcity.ssls.domain.Reader;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "ReaderServlet", value = "/ReaderServlet")
public class ReaderServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 验证用户登录状态
        HttpSession session = request.getSession();
        Reader reader = (Reader) session.getAttribute("reader");
        if (reader == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 获取读者信息（实际项目中可能需要从数据库查询）
        ReaderDao readerDao = new ReaderDao();
        Reader updatedReader = readerDao.getReaderById(reader.getId());

        // 计算未缴纳罚款数量
        FineDao fineDao = new FineDao();
        int unpaidFineCount = fineDao.getUnpaidFinesByReaderId(reader.getId()).size();

        // 存储数据到request
        request.setAttribute("reader", updatedReader);
        request.setAttribute("unpaidFineCount", unpaidFineCount);

        // 转发到读者中心页面
        request.getRequestDispatcher("readerIndex.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
