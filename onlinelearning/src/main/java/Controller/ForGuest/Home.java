package Controller.ForGuest;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

import DAO.CourseDAO;
import DAO.PostDAO;
import DAO.ReviewPostDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Module.Course ;
import Module.Post ;
@WebServlet(name="home", urlPatterns={"/home"})
public class Home extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet home</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet home at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        CourseDAO cDAO = new CourseDAO();
        ArrayList<Course> listCourse= cDAO.getAll();
        System.out.println(listCourse.size());
        request.setAttribute("listCourse",listCourse);
        System.out.println("listCourse attribute set: " + request.getAttribute("listCourse"));
        PostDAO pDAO  = new PostDAO();
        ReviewPostDAO rpDAO = new ReviewPostDAO();
        ArrayList<Post> listPost = pDAO.getAll() ;
        HashMap<Post,Float> mapRatingPost = rpDAO.mapRating();
        System.out.println(listPost.size()) ;
        request.setAttribute("listPost",listPost);
        request.setAttribute("mapRatingPost",mapRatingPost);
        request.getRequestDispatcher("index.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
