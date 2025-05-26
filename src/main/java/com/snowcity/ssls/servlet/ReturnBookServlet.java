package com.snowcity.ssls.servlet;

import com.snowcity.ssls.dao.BorrowDao;
import com.snowcity.ssls.dao.BookDao;
import com.snowcity.ssls.dao.FineDao;
import com.snowcity.ssls.domain.Borrow;
import com.snowcity.ssls.domain.Book;
import com.snowcity.ssls.domain.Fine;
import com.snowcity.ssls.util.JDBCUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/ReturnBookServlet")
public class ReturnBookServlet extends HttpServlet {
    private BorrowDao borrowDao = new BorrowDao();
    private BookDao bookDao = new BookDao();
    private FineDao fineDao = new FineDao();

    // 处理 GET 请求，显示归还页面
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. 从请求中获取 borrowId（借阅记录ID）
        int borrowId = Integer.parseInt(request.getParameter("borrowId"));

        // 2. 通过 borrowId 查询 Borrow 对象（包含关联的图书信息）
        Borrow borrow = borrowDao.getBorrowById(borrowId);

        // 3. 检查 Borrow 对象是否存在
        if (borrow == null) {
            request.setAttribute("errorMsg", "借阅记录不存在");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        // 4. 将 Borrow 对象存入 request 作用域
        request.setAttribute("borrow", borrow);

        // 5. 转发到 returnBook.jsp 页面
        request.getRequestDispatcher("/returnBook.jsp").forward(request, response);
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int borrowId = Integer.parseInt(request.getParameter("borrowId"));

        try {
            // 1. 更新借阅记录为已归还
            Borrow borrow = borrowDao.getBorrowById(borrowId);
            borrow.setReturn_date(LocalDate.now());
            borrow.setStatus("已归还");
            borrowDao.updateBorrow(borrow);

            // 2. 将图书状态还原为"在库"
            Book book = bookDao.getById(borrow.getBook_id());
            book.setStatus("在库");
            bookDao.updateBook(book);

            // 3. 处理逾期罚款
            if (borrow.isOverdue()) {
                double penalty = borrow.getOverdueDays() * 0.5; // 罚款计算逻辑
                Fine fine = new Fine();
                fine.setBorrow_id(borrowId);
                fine.setPenalty_amount(penalty);
                fineDao.createFine(fine); // 生成罚款记录
            }

            // 重定向到"我的借阅"页面（直接跳转JSP或通过Servlet）
//            response.sendRedirect(request.getContextPath() + "/borrowManage.jsp?action=returnSuccess");
             response.sendRedirect(request.getContextPath() + "/BorrowManageServlet"); // 通过Servlet查询最新数据
        } catch (Exception e) {
            e.printStackTrace();
            // 携带错误信息到错误页面
            response.sendRedirect(request.getContextPath() + "/borrowManage.jsp?error=归还失败，请联系管理员");
        }
    }
}