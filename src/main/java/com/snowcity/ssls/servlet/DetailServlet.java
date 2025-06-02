package com.snowcity.ssls.servlet;

import com.snowcity.ssls.dao.BookDao;
import com.snowcity.ssls.domain.Book;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "DetailServlet", value = "/DetailServlet")
public class DetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id= Integer.parseInt(request.getParameter("id"));
        BookDao bookDao = new BookDao();
        Book book=bookDao.getById(id);
        request.getSession().setAttribute("book", book);
        response.sendRedirect(request.getContextPath()+"/detail.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
