package com.snowcity.ssls.servlet;

import com.snowcity.ssls.domain.Shelf;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "RemoveFromShelfServlet", value = "/RemoveFromShelfServlet")
public class RemoveFromShelfServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        if (request.getSession().getAttribute("shelf") != null) {
            Shelf shelf = (Shelf) request.getSession().getAttribute("shelf");
            shelf.remove(id);
            response.sendRedirect(request.getContextPath() + "/shelf.jsp");
        }
        else {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
