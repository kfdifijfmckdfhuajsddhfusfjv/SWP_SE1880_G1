package Controller.ForAccount;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import DAO.CourseDAO;
import Module.Enrollment;
import DAO.CustomerDAO;
import DAO.EnrollmentDAO;
import DAO.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Module.User;
import Module.Course;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "profileServlet", urlPatterns = {"/profile"})
public class profileServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet profileServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet profileServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO ud= new UserDAO();
        CustomerDAO cd= new CustomerDAO();
        CourseDAO cod= new CourseDAO();
        EnrollmentDAO ed = new EnrollmentDAO();
        String id_raw = request.getParameter("id");

        int id;
        if (id_raw == null) {
            id_raw = (String) request.getSession().getAttribute("id");
        }

        if (id_raw == null) {
            request.setAttribute("error", "User ID not found!");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }
        try {
            id = Integer.parseInt(id_raw);
            request.getSession().setAttribute("id", id);
            User user = ud.getUserByID(id);
            request.setAttribute("user", user);
            int cuID=cd.GetIDCustomerByID(id);
            List<Enrollment> enrollList= ed.getAllEnrollmentsByCustomerID(cuID);
            request.setAttribute("enrollList",enrollList );
            List<Integer> courseIds = ed.getAllCourseIDsByCustomerID(cuID);
            List<Course> courses = cod.getCoursesByCourseIds(courseIds);
            request.setAttribute("courses",courses );
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } catch (ServletException | IOException | NumberFormatException e) {
            System.out.println("ngu");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO ud = new UserDAO();

        String id_raw = request.getParameter("id");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String userName = request.getParameter("userName");
        String gender = request.getParameter("gender");
        String avatar =request.getParameter("avatar");
        int id;
        request.getSession().removeAttribute("message");
        request.getSession().removeAttribute("error");
        try {
            id = Integer.parseInt(id_raw);
            System.out.println("Received ID: " + id_raw);
            if (phoneNumber.length() >= 9 && phoneNumber.length() <= 12) {
                User user = new User(userName, firstName, lastName, email, phoneNumber, gender,avatar, id);
                boolean updated = ud.updateUser(user);

                if (updated) {
                    request.getSession().setAttribute("message", "Profile updated successfully!");
                } else {
                    request.getSession().setAttribute("error", "Update failed!");
                }
                request.getSession().setAttribute("user", user);
            } else {
                request.getSession().setAttribute("error", "Phone number must be 9 to 12 characters long.");
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "Invalid data!");
        }

        response.sendRedirect("profile?id=" + id_raw);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
