package com.snowcity.ssls.servlet;

import com.snowcity.ssls.domain.Shelf;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "AddToShelfServlet", value = "/AddToShelfServlet")
public class AddToShelfServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
//        int quantity = Integer.parseInt(request.getParameter("quantity"));
        Shelf shelf;
        if (request.getSession().getAttribute("shelf") != null) {
            shelf = (Shelf) request.getSession().getAttribute("shelf");
        }
        else {
            shelf = new Shelf();
        }

        shelf.add(id);
        request.getSession().setAttribute("shelf", shelf);
        response.sendRedirect(request.getContextPath() + "/shelf.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
