package Controller.ForAccount;

import java.io.IOException;
import java.io.PrintWriter;

import DAO.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Module.User;
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
        String id_raw = request.getParameter("id");
        //System.out.println(id_raw+ "hehehe");
        int id;
        try {
            id = Integer.parseInt(id_raw);
            User user = ud.getUserByID(id);
            request.setAttribute("user", user);
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } catch (ServletException | IOException | NumberFormatException e) {
            System.out.println(e);
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
        String age_raw = request.getParameter("age");
        String gender = request.getParameter("gender");

        int id, age;

        try {
            id = Integer.parseInt(id_raw);
            age = Integer.parseInt(age_raw);

            User user = new User( firstName, lastName, email, phoneNumber,gender, age, id);
            boolean updated = ud.updateUser(user);

            if (updated) {
                request.setAttribute("message", "Cập nhật hồ sơ thành công!");
            } else {
                request.setAttribute("error", "Cập nhật thất bại!");
            }
            request.setAttribute("user", user);
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Dữ liệu không hợp lệ!");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        }
    }
    private boolean isValidEmail(String email) {
        return email != null && !email.isEmpty() ;
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
