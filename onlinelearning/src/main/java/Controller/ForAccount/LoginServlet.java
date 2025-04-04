package Controller.ForAccount;

import java.io.IOException;
import java.io.PrintWriter;

import DAO.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import Module.User;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet  extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet </title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet  at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String u=request.getParameter("user");
        String p=request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");
        UserDAO d = new UserDAO();
        User a =d.checkAuthen(u, p);
        if (a!=null) {
            if (a.getUserName().equalsIgnoreCase("admin")) {
                HttpSession session = request.getSession();
                session.setAttribute("account", a);
                response.sendRedirect("manage-account");
            }
            if(a.getStatus()==true) {//a.getStatus()==1
                HttpSession session = request.getSession();
                session.setAttribute("account", a);
                String redirectUrl = (String) session.getAttribute("redirectUrl");
                if (redirectUrl != null) {
                    response.sendRedirect(redirectUrl); // Chuyển hướng về trang trước đó
                    session.removeAttribute("redirectUrl");
                    // Xóa URL sau khi chuyển hướng
                } else {
                    response.sendRedirect("home"); // Chuyển hướng về trang chính hoặc mặc định
                }
                if ("on".equals(rememberMe)) {
                    Cookie cookie = new Cookie("rememberUser", u);
                    cookie.setMaxAge(60 * 60 * 24 * 7);
                    response.addCookie(cookie);
                } else {
                    Cookie cookie = new Cookie("rememberUser", "");
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                }
            }else{
                request.setAttribute("error", "You need to verify your email before logging in.");
                request.getRequestDispatcher("login.jsp").forward(request, response);

            }
        }
        else  {
            request.setAttribute("error", "Username/Email  or Password incorrect!!!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

//    User user = ud.getUserByEmailAndPassword(email, password);
//if (user != null) {
//        if (user.getVerified() == 1) {
//            session.setAttribute("user", user);
//            response.sendRedirect("home.jsp");
//        } else {
//            request.setAttribute("error", "Bạn cần xác thực email trước khi đăng nhập.");
//            request.getRequestDispatcher("login.jsp").forward(request, response);
//        }
//    } else {
//        request.setAttribute("error", "Sai email hoặc mật khẩu.");
//        request.getRequestDispatcher("login.jsp").forward(request, response);
//    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}

