package Controller.ForAdmin;

import DAO.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import Module.Subject;

import java.util.Collection;
import java.util.List;

import Module.QuestionAnswer;
import Module.Question;
import Module.QuestionImage;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.File;

import Module.CourseType;
import Module.QuestionType;

@MultipartConfig
@WebServlet(name = "ManageQuestion", urlPatterns = {"/manage-question"})
public class ManageQuestionController extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null || action.equals("list")) {
            searchByFilter(request, response);
        } else {
            switch (action) {
                case "edit":
                    ShowEditForm(request, response);
                    break;
            }
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null || action.equals("list")) {
            searchByFilter(request, response);
        } else if (action.equals("update")) {
            updateQuestion(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }


    private void searchByFilter(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String search = request.getParameter("search");
        String subject = request.getParameter("subject");
        String level = request.getParameter("level");
        String status = request.getParameter("status");
        String pageSizeStr = request.getParameter("pageSize");
        String[] optionChoice = request.getParameterValues("optionChoice");

        int page = 1;
        int pageSize = 5;

        if (pageSizeStr != null && !pageSizeStr.isEmpty()) {
            try {
                pageSize = Integer.parseInt(pageSizeStr);
            } catch (NumberFormatException e) {
                System.out.println(e.getMessage() + " is not a number");
            }
        }
        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
                if (page < 1)
                    page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        SubjectDAO subjectDAO = new SubjectDAO();
        List<Subject> subjectList = subjectDAO.findAll();


        QuestionTypeDAO questionTypeDAO = new QuestionTypeDAO();
        List<QuestionType> questionTypes = questionTypeDAO.findAll();

        QuestionDAO questionDAO = new QuestionDAO();
        List<Question> questionList = questionDAO.getQuestionByFilter(search, subject, level, status, page, pageSize);
        int totalQuestion = questionDAO.getTotalQuestionByFilter(search, subject, level, status);
        int totalPage = (int) Math.ceil((double) totalQuestion / pageSize);

        List<Object> listColum = new java.util.ArrayList<>();
        if (optionChoice != null) {
            for (int i = 0; i < optionChoice.length; i++) {
                switch (optionChoice[i]) {
                    case "idChoice":
                        listColum.add("idChoice");
                        break;
                    case "subjectChoice":
                        listColum.add("subjectChoice");
                        break;
                    case "levelChoice":
                        listColum.add("levelChoice");
                        break;
                    case "statusChoice":
                        listColum.add("statusChoice");
                        break;
                    case "contentChoice":
                        listColum.add("contentChoice");
                        break;
                    case "typeChoice":
                        listColum.add("typeChoice");
                        break;
                    case "actionChoice":
                        listColum.add("actionChoice");
                        break;
                }
            }
        } else {
            listColum.add("idChoice");
            listColum.add("contentChoice");
            listColum.add("subjectChoice");
            listColum.add("levelChoice");
            listColum.add("typeChoice");
            listColum.add("statusChoice");
            listColum.add("actionChoice");
        }
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("currentPage", page);
        request.setAttribute("questionList", questionList);
        request.setAttribute("subjectList", subjectList);
        request.setAttribute("questionTypes", questionTypes);

        request.setAttribute("subject", subject);
        request.setAttribute("level", level);
        request.setAttribute("status", status);
        request.setAttribute("search", search);
        request.setAttribute("listColum", listColum);
        request.setAttribute("pageSize", pageSize);
        request.getRequestDispatcher("/admin/manage-question.jsp").forward(request, response);
    }


    private void ShowEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Nhận tham số
        String questionIdStr = request.getParameter("questionId");
        int questionId = 0;
        try {
            questionId = Integer.parseInt(questionIdStr);
        } catch (NumberFormatException e) {
            System.out.println(e.getMessage());
        }

        // Lấy ra question cần edit
        QuestionDAO questionDAO = new QuestionDAO();
        Question question = questionDAO.GetQuestionById(questionId);

        // Lấy ra hình ảnh của question
        QuestionImageDAO questionImageDAO = new QuestionImageDAO();
        List<QuestionImage> questionImages = questionImageDAO.getImageByQuestionId(questionId);

        // Lấy ra questionType
        QuestionTypeDAO questionTypeDAO = new QuestionTypeDAO();
        List<QuestionType> questionTypes = questionTypeDAO.findAll();

        // Lấy ra subject
        SubjectDAO subjectDAO = new SubjectDAO();
        List<Subject> subjectList = subjectDAO.findAll();

        // Lấy ra Answer của question
        QuestionAnswerDAO questionAnswerDAO = new QuestionAnswerDAO();
        List<QuestionAnswer> questionAnswers = questionAnswerDAO.getAnswerByQuestionId(questionId);

        // Set Attribute
        request.setAttribute("question", question);
        request.setAttribute("questionImages", questionImages);
        request.setAttribute("questionTypes", questionTypes);
        request.setAttribute("subjectList", subjectList);
        request.setAttribute("questionAnswers", questionAnswers);

        // Gửi về JSP
        request.getRequestDispatcher("/admin/edit-question.jsp").forward(request, response);
    }

    private void updateQuestion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String questionIdStr = request.getParameter("questionId");
        int questionId = Integer.parseInt(questionIdStr);
        String content = request.getParameter("content");
        int level = Integer.parseInt(request.getParameter("level"));
        int subjectId = Integer.parseInt(request.getParameter("subject"));
        int mark = Integer.parseInt(request.getParameter("mark"));
        int questionTypeId = Integer.parseInt(request.getParameter("questionType"));
        boolean isActive = Boolean.parseBoolean(request.getParameter("status"));

        // Get the current question
        QuestionDAO questionDAO = new QuestionDAO();
        Question question = questionDAO.GetQuestionById(questionId);

        // Update question properties
        question.setContent(content);
        question.setLevel(level);

        // Set subject
        SubjectDAO subjectDAO = new SubjectDAO();
        Subject subject = subjectDAO.getSubjectById(subjectId);
        question.setSubject(subject);
        question.setMark(mark);
        // Set question type
        QuestionTypeDAO questionTypeDAO = new QuestionTypeDAO();
        QuestionType questionType = questionTypeDAO.getQuestionTypeById(questionTypeId);
        question.setQuestionType(questionType);
        question.setStatus(isActive);
        // Handle MP3 file if uploaded
        Part audioPart = request.getPart("audioFile");
        String deleteAudio = request.getParameter("deleteAudio");

        if (deleteAudio != null && deleteAudio.equals("true")) {
            // Delete the existing audio file
            question.setMp3(null);
        } else if (audioPart != null && audioPart.getSize() > 0) {
            // Save the new audio file
            String fileName = getSubmittedFileName(audioPart);
            String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
            String uploadPath = request.getServletContext().getRealPath("/uploads/audio/");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            audioPart.write(uploadPath + File.separator + uniqueFileName);
            question.setMp3(uniqueFileName);
        }

        // Handle existing images
        QuestionImageDAO imageDAO = new QuestionImageDAO();
        String[] imageIds = request.getParameterValues("imageId");
        String[] deleteFlags = request.getParameterValues("deleteImage");

        if (imageIds != null && deleteFlags != null) {
            for (int i = 0; i < imageIds.length; i++) {
                int imageId = Integer.parseInt(imageIds[i]);
                boolean deleteFlag = Boolean.parseBoolean(deleteFlags[i]);

                if (deleteFlag) {
                    // Delete the image
                    QuestionImage image = new QuestionImage();
                    image.setImageId(imageId);
                    imageDAO.delete(image);
                }
            }
        }

        // Handle new images
        Collection<Part> imageParts = request.getParts();
        for (Part part : imageParts) {
            if (part.getName().startsWith("newImageFile[") && part.getSize() > 0) {
                // Extract index from name
                String name = part.getName();
                int startIndex = name.indexOf('[') + 1;
                int endIndex = name.indexOf(']');
                int index = Integer.parseInt(name.substring(startIndex, endIndex));

                // Get corresponding title
                String titleParam = "newImageTitle[" + index + "]";
                String imageTitle = request.getParameter(titleParam);

                // Save the image file
                String fileName = getSubmittedFileName(part);
                String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                String uploadPath = request.getServletContext().getRealPath("/uploads/images/");

                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                part.write(uploadPath + File.separator + uniqueFileName);

                // Create and save new QuestionImage
                QuestionImage newImage = new QuestionImage();
                newImage.setImageTitle(imageTitle);
                // Lưu đường dẫn tương đối đến file ảnh
                String relativePath = "/uploads/images/" + uniqueFileName;
                newImage.setImageURL(relativePath);
                newImage.setQuestionImangeId(questionId);
                imageDAO.insert(newImage);
            }
        }

        // Update the question in the database
        boolean updated = questionDAO.update(question);

        // Handle question answers
        if (updated) {
            // First delete existing answers
            QuestionAnswerDAO answerDAO = new QuestionAnswerDAO();
            answerDAO.deleteAnswersByQuestionId(questionId);

            // Then add new answers
            int optionCount = 0;
            String[] optionValue;

            optionValue = request.getParameterValues("option");
            for (int i = 0; i < optionValue.length; i++) {
                if (optionValue[i] == null || optionValue[i].trim().isEmpty()) break;
                QuestionAnswer answer = new QuestionAnswer();
                answer.setContent(optionValue[i]);
                answer.setQuestionId(questionId);
                answer.setSortOrder(i);

                String isCorrectParam = request.getParameter("isCorrect" + (i + 1));
                boolean isCorrect = isCorrectParam != null &&
                        (isCorrectParam.equals("on") || isCorrectParam.equals("true"));
                answer.setCorrect(isCorrect);

                answerDAO.insert(answer);
                // optionCount++;
                System.out.println("Added option: " + optionValue + ", isCorrect: " + isCorrect);
            }
        }

        // Redirect back to the question list
        response.sendRedirect(request.getContextPath() + "/manage-question");
    }

    // Helper method to get the submitted file name
    private String getSubmittedFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                return cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}