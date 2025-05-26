package com.snowcity.ssls.servlet;

import com.snowcity.ssls.dao.BookDao;
import com.snowcity.ssls.dao.BorrowDao;
import com.snowcity.ssls.domain.Book;
import com.snowcity.ssls.domain.Borrow;
import com.snowcity.ssls.domain.Reader;
import com.snowcity.ssls.domain.Shelf;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/BorrowBooksServlet")
public class BorrowBooksServlet extends HttpServlet {
    BookDao bookDao = new BookDao();
    BorrowDao borrowDao = new BorrowDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 从Session获取当前用户
        Reader reader = (Reader) request.getSession().getAttribute("reader");
        if (reader == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 获取选中的图书ID列表
        String[] bookIds = request.getParameterValues("selectedBooks");
        if (bookIds == null || bookIds.length == 0) {
            System.out.println("未选择任何图书");
            request.setAttribute("errorMsg", "请选择要借阅的图书");
            request.getRequestDispatcher("/shelf.jsp").forward(request, response);
            return;
        }

        try {
            // 1. 验证每本图书是否可借阅
            List<Book> booksToBorrow = new ArrayList<>();
            for (String bookId : bookIds) {
                Book book = bookDao.getById(Integer.parseInt(bookId));
                if (book == null || !"在库".equals(book.getStatus())) {
                    request.setAttribute("errorMsg", "图书 [" + book.getName() + "] 不可借阅");
                    request.getRequestDispatcher("/shelf.jsp").forward(request, response);
                    return;
                }
                booksToBorrow.add(book);
            }

            // 2. 检查用户借阅限制（示例：最多借5本）
            // 这里需要在BorrowDao中添加获取当前读者借阅数量的方法
            int currentBorrowCount = borrowDao.getBorrowingCount(reader.getId());
            if (currentBorrowCount + booksToBorrow.size() > 5) {
                request.setAttribute("errorMsg", "您已超出最大借阅数量限制");
                request.getRequestDispatcher("/shelf.jsp").forward(request, response);
                return;
            }

            // 3. 创建借阅记录
            for (Book book : booksToBorrow) {
                Borrow borrow = new Borrow();
                borrow.setBook_id(book.getId());
                borrow.setReader_id(reader.getId());
                borrow.setBorrow_date(LocalDate.now());
                borrow.setDue_date(LocalDate.now().plusDays(30));
                borrow.setReturn_date(null);
                borrow.setStatus("已借出");

                // 4. 保存借阅记录到数据库
                borrowDao.createBorrow(borrow);
            }

            // 5. 更新图书状态为"已借出"
            for (Book book : booksToBorrow) {
                book.setStatus("已借出");
                bookDao.updateBook(book);
                // 这里需要在BookDao中添加更新图书状态的方法
            }

            // 6. 从暂存架中移除已借阅的图书
            HttpSession session = request.getSession();
            Shelf shelf = (Shelf) session.getAttribute("shelf"); // 获取暂存架对象

            if (shelf != null && bookIds != null && bookIds.length > 0) {
                for (String bookIdStr : bookIds) {
                    int bookId = Integer.parseInt(bookIdStr);
                    shelf.remove(bookId); // 调用 Shelf 的 remove 方法删除图书
                }
            }

            // 获取当前日期
            LocalDate currentDate = LocalDate.now();

            // 存储借阅成功的书籍和日期信息到 Session
            String formattedCurrentDate = currentDate.toString(); // 格式为 yyyy-MM-dd
            String formattedDueDate = currentDate.plusDays(30).toString();
            session.setAttribute("currentDate", formattedCurrentDate);
            session.setAttribute("dueDate", formattedDueDate);
            session.setAttribute("booksToBorrow", booksToBorrow);
//            session.setAttribute("currentDate", currentDate); // 借阅日期
//            session.setAttribute("dueDate", currentDate.plusDays(30)); // 应还日期

            // 7. 跳转到借阅完成页面
//            response.sendRedirect(request.getContextPath() + "/CompletedServlet?borrowIds=" + String.join(",", bookIds));
            response.sendRedirect(request.getContextPath()+"/completed.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("借阅失败：" + e.getMessage());
            request.setAttribute("errorMsg", "借阅失败：" + e.getMessage());
            request.getRequestDispatcher("/shelf.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}