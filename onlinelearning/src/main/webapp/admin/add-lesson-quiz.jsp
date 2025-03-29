<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 3/29/2025
  Time: 11:02 AM
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- META ============================================= -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="keywords" content=""/>
    <meta name="author" content=""/>
    <meta name="robots" content=""/>
    <!-- DESCRIPTION -->
    <meta name="description" content="EduChamp : Education HTML Template"/>
    <!-- OG -->
    <meta property="og:title" content="EduChamp : Education HTML Template"/>
    <meta property="og:description" content="EduChamp : Education HTML Template"/>
    <meta property="og:image" content=""/>
    <meta name="format-detection" content="telephone=no">
    <!-- PAGE TITLE HERE ============================================= -->
    <title>Admin - Add Lesson Quiz</title>

    <!-- MOBILE SPECIFIC ============================================= -->
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- All PLUGINS CSS ============================================= -->
    <jsp:include page="../common/common_admin_css.jsp"></jsp:include>

    <style>
        /* Toast notification styles */
        .toast-container {
            position: fixed;
            top: 80px;
            right: 20px;
            z-index: 9999;
        }

        .toast {
            min-width: 250px;
            margin-bottom: 10px;
            background-color: #fff;
            border-radius: 4px;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);
            opacity: 0;
            transition: opacity 0.3s ease-in-out;
        }

        .toast.show {
            opacity: 1;
        }

        .toast-header {
            display: flex;
            align-items: center;
            padding: 0.5rem 0.75rem;
            background-color: rgba(0,0,0,0.03);
            border-bottom: 1px solid rgba(0,0,0,0.1);
        }

        .toast-body {
            padding: 0.75rem;
        }

        .toast-success .toast-header {
            background-color: #d4edda;
            color: #155724;
        }

        .toast-error .toast-header {
            background-color: #f8d7da;
            color: #721c24;
        }
    </style>
</head>

<body class="ttr-opened-sidebar ttr-pinned-sidebar">

<!-- Toast notifications container -->
<div class="toast-container">
    <c:if test="${not empty sessionScope.toastMessage}">
        <div class="toast toast-${sessionScope.toastType} show" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-header">
                <strong class="mr-auto">
                    <c:choose>
                        <c:when test="${sessionScope.toastType eq 'success'}">Success</c:when>
                        <c:otherwise>Error</c:otherwise>
                    </c:choose>
                </strong>
                <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="toast-body">
                    ${sessionScope.toastMessage}
            </div>
        </div>
        <c:remove var="toastMessage" scope="session" />
        <c:remove var="toastType" scope="session" />
    </c:if>
</div>

<!-- header start -->
<jsp:include page="../common/common_admin_header.jsp"></jsp:include>
<!-- header end -->

<!-- Left sidebar menu start -->
<jsp:include page="../common/common_admin_sidebar_menu.jsp"></jsp:include>
<!-- Left sidebar menu end -->

<!--Main container start -->
<main class="ttr-wrapper">
    <div class="container-fluid">
        <div class="db-breadcrumb">
            <h4 class="breadcrumb-title">Add New Lesson Quiz</h4>
            <ul class="db-breadcrumb-list">
                <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                <li><a href="${pageContext.request.contextPath}/admin-manage-lesson-quiz">Manage Lesson Quizzes</a></li>
                <li>Add New Quiz</li>
            </ul>
        </div>

        <div class="row">
            <!-- Your Profile Views Chart -->
            <div class="col-lg-12 m-b30">
                <div class="widget-box">
                    <div class="wc-title">
                        <h4>Add New Lesson Quiz</h4>
                    </div>
                    <div class="widget-body">
                        <div class="widget-inner">
                            <form action="admin-manage-lesson-quiz?action=add" method="POST" enctype="multipart/form-data">
                                <div class="form-group row">
                                    <label for="courseId" class="col-sm-2 col-form-label">Course</label>
                                    <div class="col-sm-10">
                                        <select class="form-control" id="courseId" name="courseId" required>
                                            <option value="" selected disabled>Select a course</option>
                                            <c:forEach items="${courses}" var="course">
                                                <option value="<c:out value="${course.courseId}"/>">
                                                    <c:out value="${course.courseName}"/>
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="subjectId" class="col-sm-2 col-form-label">Subject</label>
                                    <div class="col-sm-10">
                                        <select class="form-control" id="subjectId" name="subjectId" required disabled>
                                            <option value="" selected disabled>Select a course first</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="lessonName" class="col-sm-2 col-form-label">Lesson Name</label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="lessonName" name="lessonName" required>
                                        <small class="form-text text-muted">Enter a name for the new quiz lesson.</small>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="duration" class="col-sm-2 col-form-label">Duration (minutes)</label>
                                    <div class="col-sm-10">
                                        <input type="number" class="form-control" id="duration" name="duration"
                                               min="1" value="30" required>
                                        <small class="form-text text-muted">Estimated time for the student to complete this lesson including the quiz.</small>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="passPercentage" class="col-sm-2 col-form-label">Pass Percentage</label>
                                    <div class="col-sm-10">
                                        <input type="number" class="form-control" id="passPercentage" name="passPercentage"
                                               min="1" max="100" value="70" required>
                                        <small class="form-text text-muted">Minimum percentage required to pass the quiz (1-100).</small>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="timeLimit" class="col-sm-2 col-form-label">Time Limit (minutes)</label>
                                    <div class="col-sm-10">
                                        <input type="number" class="form-control" id="timeLimit" name="timeLimit"
                                               min="1" value="30" required>
                                        <small class="form-text text-muted">Maximum time allowed to complete the quiz in minutes.</small>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="attemptAllowed" class="col-sm-2 col-form-label">Attempts Allowed</label>
                                    <div class="col-sm-10">
                                        <input type="number" class="form-control" id="attemptAllowed" name="attemptAllowed"
                                               min="1" value="3" required>
                                        <small class="form-text text-muted">Number of times a user can attempt the quiz.</small>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <div class="col-sm-2">Status</div>
                                    <div class="col-sm-10">
                                        <div class="custom-control custom-switch">
                                            <input type="checkbox" class="custom-control-input" id="status" name="status" checked>
                                            <label class="custom-control-label" for="status">Active</label>
                                        </div>
                                        <small class="form-text text-muted">Enable or disable this quiz.</small>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="imageFile" class="col-sm-2 col-form-label">Image (Optional)</label>
                                    <div class="col-sm-10">
                                        <div class="custom-file">
                                            <input type="file" class="custom-file-input" id="imageFile" name="imageFile" accept="image/*">
                                            <label class="custom-file-label" for="imageFile">Choose file</label>
                                        </div>
                                        <small class="form-text text-muted">Optional image to display with the quiz.</small>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="mp3File" class="col-sm-2 col-form-label">Audio (Optional)</label>
                                    <div class="col-sm-10">
                                        <div class="custom-file">
                                            <input type="file" class="custom-file-input" id="mp3File" name="mp3File" accept="audio/mpeg">
                                            <label class="custom-file-label" for="mp3File">Choose file</label>
                                        </div>
                                        <small class="form-text text-muted">Optional MP3 audio to include with the quiz.</small>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <div class="col-sm-10 offset-sm-2">
                                        <button type="submit" class="btn btn-primary">Save Quiz</button>
                                        <a href="admin-manage-lesson-quiz" class="btn btn-secondary">Cancel</a>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Your Profile Views Chart END-->
        </div>
    </div>
</main>

<div class="ttr-overlay"></div>

<footer>
    <jsp:include page="../footer.jsp"></jsp:include>
</footer>

<!-- External JavaScripts -->
<jsp:include page="../common/common_admin_js.jsp"></jsp:include>

<!-- BS-Custom-file-input -->
<script src="https://cdn.jsdelivr.net/npm/bs-custom-file-input/dist/bs-custom-file-input.min.js"></script>
<script>
    $(document).ready(function () {
        bsCustomFileInput.init();

        // Toast notification auto-hide
        setTimeout(function() {
            $('.toast').fadeOut('slow');
        }, 5000);

        // Close toast when close button is clicked
        $('.close').on('click', function() {
            $(this).closest('.toast').fadeOut('slow');
        });

        // When course is selected, load subjects for that course
        $('#courseId').change(function() {
            let courseId = $(this).val();
            if (courseId) {
                // Enable subject dropdown and show loading option
                $('#subjectId').empty().append('<option value="" selected disabled>Loading subjects...</option>');

                // AJAX call to get subjects for the selected course
                $.ajax({
                    url: '${pageContext.request.contextPath}/admin-manage-lesson-quiz',
                    type: 'GET',
                    data: {
                        action: 'getSubjects',
                        courseId: courseId
                    },
                    dataType: 'json',
                    success: function(data) {
                        // Clear loading message
                        $('#subjectId').empty().append('<option value="" selected disabled>Select a subject</option>');

                        // Add subjects to dropdown
                        $.each(data, function(index, subject) {
                            $('#subjectId').append('<option value="' + subject.subjectId + '">' + subject.subjectName + '</option>');
                        });

                        // Enable subject dropdown
                        $('#subjectId').prop('disabled', false);
                    },
                    error: function(xhr, status, error) {
                        console.error('Error loading subjects:', error);
                        $('#subjectId').empty().append('<option value="" selected disabled>Error loading subjects</option>');
                    }
                });
            } else {
                // If no course selected, disable subject dropdown
                $('#subjectId').empty().append('<option value="" selected disabled>Select a course first</option>').prop('disabled', true);
            }
        });
    });
</script>

</body>
</html>