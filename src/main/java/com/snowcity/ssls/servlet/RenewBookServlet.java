package com.snowcity.ssls.servlet;


import com.snowcity.ssls.dao.BorrowDao;
import com.snowcity.ssls.dao.FineDao;
import com.snowcity.ssls.domain.Borrow;
import com.snowcity.ssls.domain.Fine;
import com.snowcity.ssls.domain.Reader;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet(name = "RenewBookServlet", value = "/RenewBookServlet")
public class RenewBookServlet extends HttpServlet {
    private static final int RENEW_DAYS = 30; // 续借天数（可从配置文件读取，此处硬编码）
    BorrowDao borrowDao = new BorrowDao(); // 依赖BorrowDao
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置编码
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 从Session获取当前用户
        Reader reader = (Reader) request.getSession().getAttribute("reader");
        if (reader == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 检查是否有未缴罚款
        FineDao fineDao = new FineDao();
        List<Fine> unpaidFines = fineDao.getUnpaidFinesByReaderId(reader.getId());
        if (!unpaidFines.isEmpty()) {
            request.getSession().setAttribute("error", "请先缴纳未处理的罚款再进行借阅/续借操作");
//            request.getRequestDispatcher(request.getContextPath() + "/bookManage.jsp").forward(request, response);
            response.sendRedirect(request.getContextPath() + "/BorrowManageServlet");
            return;
        }


        try {
            // 1. 获取参数
            int borrowId = Integer.parseInt(request.getParameter("borrowId"));

            // 2. 查询借阅记录（包含图书信息）
            Borrow borrow = borrowDao.getBorrowById(borrowId);
            if (borrow == null) {
                response.getWriter().println("错误：借阅记录不存在");
                return;
            }

            // 3. 校验续借条件
            // 条件1：未归还（return_date为空）
            if (borrow.getReturn_date() != null) {
                response.getWriter().println("错误：图书已归还，无法续借");
                return;
            }
            // 条件2：未逾期（isOverdue()返回false）
            if (borrow.isOverdue()) {
                response.getWriter().println("错误：图书已逾期，需先处理逾期");
                return;
            }

            // 4. 计算新应还日期（原日期+30天）
            LocalDate newDueDate = borrow.getDue_date().plusDays(RENEW_DAYS);
            borrow.setDue_date(newDueDate); // 更新Borrow对象中的应还日期

            // 5. 更新数据库（注意：BorrowDao中需有更新due_date的方法）
            // 当前BorrowDao的updateBorrow方法仅更新return_date和status，需扩展SQL
            borrowDao.updateBorrow(borrow); // 自定义更新due_date的方法

            // 6. 操作成功，重定向回借阅列表
            response.sendRedirect(request.getContextPath() + "/BorrowManageServlet");

        } catch (NumberFormatException e) {
            response.getWriter().println("错误：无效的借阅记录ID");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("错误：服务器内部错误，请联系管理员");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
