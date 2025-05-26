package com.snowcity.ssls.servlet;

import com.snowcity.ssls.dao.FineDao;
import com.snowcity.ssls.domain.Fine;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "PayFineServlet", value = "/PayFineServlet")
public class PayFineServlet extends HttpServlet {
    private FineDao fineDao = new FineDao();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int fineId = Integer.parseInt(request.getParameter("fineId"));
        Fine fine = fineDao.getFineById(fineId);

        if (fine != null && "未处理".equals(fine.getPayment_status())) {
            fine.setPayment_status("已缴纳"); // 修改为数据库对应的字段名
            fineDao.updateFineStatus(fine);
        }

        response.sendRedirect(request.getContextPath() + "/BorrowManageServlet");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
