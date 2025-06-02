package com.snowcity.ssls.servlet;

import com.snowcity.ssls.dao.FineDao;
import com.snowcity.ssls.dao.ReaderDao;
import com.snowcity.ssls.domain.Fine;
import com.snowcity.ssls.domain.Reader;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email=request.getParameter("email");
        String pwd=request.getParameter("password");
        ReaderDao readerDao=new ReaderDao();
        Reader reader=readerDao.getByEmailAndPwd(email,pwd);
        if(reader!=null){
            // 登录成功后
            HttpSession session= request.getSession();
            session.setAttribute("reader",reader);


            // 计算并存储未处理罚款数量
            FineDao fineDao = new FineDao();
            List<Fine> unpaidFineList = fineDao.getUnpaidFinesByReaderId(reader.getId());
            session.setAttribute("unpaidFineCount", unpaidFineList.size());

            response.sendRedirect(request.getContextPath()+"/IndexServlet");
        }else{
            request.setAttribute("msg","邮箱或密码错误!");
            request.getRequestDispatcher("/login.jsp").forward(request,response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
