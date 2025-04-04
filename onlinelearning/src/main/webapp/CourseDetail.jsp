
<!DOCTYPE html>
<html lang="en">
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page isELIgnored="false" %>
    <head>

        <!-- META ============================================= -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="keywords" content="" />
        <meta name="author" content="" />
        <meta name="robots" content="" />

        <!-- DESCRIPTION -->
        <meta name="description" content="EduChamp : Education HTML Template" />

        <!-- OG -->
        <meta property="og:title" content="EduChamp : Education HTML Template" />
        <meta property="og:description" content="EduChamp : Education HTML Template" />
        <meta property="og:image" content="" />
        <meta name="format-detection" content="telephone=no">

        <!-- FAVICONS ICON ============================================= -->
        <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon.png" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>EduChamp : Education HTML Template </title>

        <!-- MOBILE SPECIFIC ============================================= -->
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!--[if lt IE 9]>
        <script src="assets/js/html5shiv.min.js"></script>
        <script src="assets/js/respond.min.js"></script>
        <![endif]-->

        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css">

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css">

        <!-- SHORTCODES ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
        <style>
            .cours-info-list ul {
                list-style: none;
                margin: 0;
                padding: 0;
                display: flex; /* Chuyển từ block sang flex để sắp xếp theo chiều ngang */
                justify-content: space-between; /* Tạo khoảng cách đều giữa các mục */
            }

            .cours-info-list ul li {
                display: inline-block; /* Thay đổi từ block thành inline-block nếu muốn điều chỉnh các mục một cách linh hoạt */
            }

            .cours-info-list ul li a {
                padding: 8px 20px;
                font-size: 15px;
                color: #808080;
                transition:all 0.5s;
                -moz-transition:all 0.5s;
                -webkit-transition:all 0.5s;
                -ms-transition:all 0.5s;
                -o-transition:all 0.5s;
                text-decoration: none; /* Loại bỏ gạch chân nếu có */
            }

            .cours-info-list ul li a.active,
            .cours-info-list ul li a:hover{
                color:#fff;
                background: var(--primary);
            }
            .cours-info-list {
                padding-top:20px;
                margin:0 -20px;         /* Giữ phần tử cố định khi cuộn */
            }

            .cours-detail-bx{
                border:1px solid rgba(0,0,0,0.1);
                padding : 10px ;
                top: 60px;
                z-index: 10;
                position: sticky;         /* Giữ phần tử cố định khi cuộn */
                background-color: white;  /* Thiết lập nền cho phần tử */
            }
            .reply-box {
                border: 1px solid #ccc;
                padding: 10px;
                background: #f9f9f9;
                border-radius: 5px;
            }

            .reply-box textarea {
                width: 100%;
                padding: 5px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }

            .reply-box .submit-reply {
                background: red;
                color: white;
                padding: 5px 10px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
            .course-star {
                list-style: none;
                padding: 0;
                margin: 0;
                display: flex;
            }

            .course-star li {
                font-size: 25px;
                margin-right: 5px;
                position: relative;
                color: #ddd; /* Màu ngôi sao chưa tô */
            }

            .course-star li.full {
                color: #ff9900; /* Màu vàng cho ngôi sao đầy */
            }

            .course-star li.half::before {
                content: '\f005'; /* Unicode của ngôi sao */
                font-family: "Font Awesome 5 Free";
                position: absolute;
                left: 0;
                top: 0;
                color: #ff9900; /* Màu vàng cho nửa sao */
                width: 50%; /* Chỉ hiển thị nửa sao */
                overflow: hidden;
            }

            /* Điều chỉnh sao chưa đầy theo định dạng ẩn */
            .course-star li.empty::before {
                content: '\f005'; /* Unicode của ngôi sao */
                font-family: "Font Awesome 5 Free";
                position: absolute;
                left: 0;
                top: 0;
                color: #ddd; /* Màu xám cho sao trống */
                width: 100%; /* Chiều rộng đầy đủ cho ngôi sao rỗng */
            }
            .price-package-item .form-check {
                margin: 0;
            }

            .price-package-item .form-check-input {
                margin-top: 1.5rem;
            }

            .price-package-item .package-details {
                margin-left: 1.5rem;
                transition: all 0.3s ease;
            }

            .price-package-item .form-check-input:checked + .form-check-label .package-details {
                border-color: var(--primary) !important;
                background-color: rgba(var(--primary-rgb), 0.05);
            }

            .price-info {
                margin-top: 0.5rem;
            }

            .original-price {
                text-decoration: line-through;
                color: #999;
                margin-right: 1rem;
            }

            .sale-price {
                color: var(--primary);
                font-weight: bold;
            }
        </style>
    </head>
    <body id="bg">
        <div class="page-wraper">
            <div id="loading-icon-bx"></div>
            <!-- Header Top ==== -->
            <header class="header rs-nav">
                <%@include file="header.jsp" %>
            </header>
            <!-- header END ==== -->
            <!-- Content -->
            <c:set value="${requestScope.course}" var="course"/>
            <div class="page-content bg-white">
                <!-- inner page banner -->
                <div class="page-banner ovbl-dark" style="background-image:url(assets/images/banner/banner2.jpg);">
                    <div class="container">
                        <div class="page-banner-entry">
                            <h1 class="text-white">Courses Details</h1>
                        </div>
                    </div>
                </div>
                <!-- Breadcrumb row -->
                <div class="breadcrumb-row">
                    <div class="container">
                        <ul class="list-inline">
                            <li><a href="#">Home</a></li>
                            <li>Courses Details</li>
                        </ul>
                    </div>
                </div>
                <!-- Breadcrumb row END -->
                <!-- inner page banner END -->
                <div class="content-block">
                    <!-- About Us -->
                    <div class="section-area section-sp1">
                        <div class="container">
                            <div class="row d-flex flex-row-reverse">
                                <div class="col-lg-3 col-md-4 col-sm-12 m-b30">
                                    <div class="menu-side">
                                        <form action="listCourse">
                                            <div class="widget courses-search-bx ">
                                                <div class="form-group">
                                                    <h4> Search course  </h4>
                                                    <div class="input-group">
                                                        <input name="search" type="text" required
                                                               class="form-control">
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                        <div class="widget widget_archive">
                                            <h5 class="widget-title style-1">Category Course</h5>
                                            <ul>
                                                <c:forEach items="${requestScope.listCourseType}" var="courseType">
                                                    <li class="active">
                                                        <a
                                                            href="listCourse?cate=${courseType.courseTypeId}">${courseType.courseTypeName}</a>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                        <div class="widget recent-posts-entry widget-courses">
                                            <h5 class="widget-title style-1">Recent Courses</h5>
                                            <div class="widget-post-bx">
                                                <c:forEach items="${requestScope.listRecent}" var="recent">
                                                    <div class="widget-post clearfix">
                                                        <div class="ttr-post-media"> <img
                                                                src="assets/images/blog/recent-blog/pic1.jpg"
                                                                width="200" height="143" alt=""> </div>
                                                        <div class="ttr-post-info">
                                                            <div class="ttr-post-header">
                                                                <h6 class="post-title"><a href="courseDetail?courseId=${recent.course.courseId}">${recent.course.courseName}</a></h6>
                                                            </div>
                                                            <div class="ttr-post-meta">
                                                                <ul>
                                                                    <li class="price">
                                                                        <del>${recent.originalPrice}</del><br>
                                                                        <h5>${recent.lowestSalePrice}</h5>
                                                                    </li>
                                                                    <li class="review">${recent.rating}</li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-9 col-md-8 col-sm-12">
                                    <div class="courses-post">
                                        <div class="ttr-post-media media-effect">
                                            <a href="#"><img src="assets/images/blog/default/thum1.jpg" alt=""></a>
                                        </div>
                                        <div class="ttr-post-info">
                                            <div class="ttr-post-title ">
                                                <h2 class="post-title">${course.course.courseName}</h2>
                                            </div>
                                            <div class="ttr-post-text">
                                                <p> ${course.course.title}</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="course-price">
                                            <del>$${course.originalPrice}</del>
                                            <h4 class="price">$${course.lowestSalePrice}</h4>
                                        </div>
                                        <div class="course-buy-now text-center" style="margin-bottom: 70px;">
                                            <a href="#" class="btn radius-xl text-uppercase" data-toggle="modal" data-target="#pricePackageModal">Buy Now This Courses</a>
                                        </div>
                                        <div class="modal fade" id="pricePackageModal" tabindex="-1" role="dialog" aria-labelledby="pricePackageModalLabel" aria-hidden="true">
                                            <div class="modal-dialog modal-lg" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="pricePackageModalLabel">Select Price Package</h5>
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <div class="course-info mb-4">
                                                            <h3>${course.course.courseName}</h3>
                                                            <p>${course.course.description}</p>
                                                        </div>

                                                        <form id="pricePackageForm" action="payment-process" method="GET">
                                                            <input type="hidden" name="courseId" value="${course.course.courseId}">

                                                            <div class="price-packages">
                                                                <c:forEach items="${requestScope.pricePackage}" var="price">
                                                                    <div class="price-package-item mb-3">
                                                                        <div class="form-check">
                                                                            <input class="form-check-input" type="radio"
                                                                                   name="pricePackageId"
                                                                                   id="package${price.priceId}"
                                                                                   value="${price.priceId}"
                                                                                   required>
                                                                              <label class="form-check-label" for="package${price.priceId}">
                                                                                <div class="package-details p-3 border rounded">
                                                                                    <h5>${price.priceCourseName}</h5>
                                                                                    <p>${price.description}</p>
                                                                                    <div class="price-info">
                                                                                        <span class="original-price">$${price.price}</span>
                                                                                        <span class="sale-price">$${price.salePrice}</span>
                                                                                    </div>
                                                                                </div>
                                                                            </label>
                                                                        </div>
                                                                    </div>
                                                                </c:forEach>
                                                            </div>
                                                        </form>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                        <button type="submit" form="pricePackageForm" class="btn btn-primary">Continue to Order</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="cours-more-info">
                                            <div class="review">
                                                <span>${course.rating} rating</span>
                                                <ul class="course-star">
                                                    <!-- Use a <li> for each star, and adjust the width in the JavaScript -->
                                                    <li class="star" data-star="1"></li>
                                                    <li class="star" data-star="2"></li>
                                                    <li class="star" data-star="3"></li>
                                                    <li class="star" data-star="4"></li>
                                                    <li class="star" data-star="5"></li>
                                                </ul>
                                            </div>
                                            <script>
                                                function setStarRating(rating) {
                                                    console.log("Rating value: ", rating); // Log giá trị rating

                                                    const stars = document.querySelectorAll('.course-star .star'); // Chọn tất cả các ngôi sao
                                                    const fullStars = Math.floor(rating); // Số ngôi sao đầy đủ
                                                    const decimalPart = rating % 1; // Phần thập phân để xác định nửa sao

                                                    stars.forEach((star, index) => {
                                                        star.innerHTML = '<i class="fas fa-star"></i>'; // Thêm biểu tượng ngôi sao từ FontAwesome
                                                        star.classList.remove('full', 'half'); // Xóa các class cũ

                                                        if (index < fullStars) {
                                                            // Ngôi sao đầy đủ
                                                            star.classList.add('full');
                                                        } else if (index === fullStars && decimalPart >= 0.3) {
                                                            // Nửa sao (tùy chỉnh ngưỡng, ví dụ >= 0.3)
                                                            star.classList.add('half');
                                                        } else {
                                                            // Ngôi sao rỗng (không cần thêm class vì màu mặc định là #ddd)
                                                            star.classList.add('empty');
                                                        }
                                                    });
                                                }

                                                // Khi DOM được tải, lấy rating và áp dụng
                                                document.addEventListener("DOMContentLoaded", function () {
                                                    const rating = parseFloat("${course.rating}"); // Lấy rating từ JSP
                                                    console.log("Received rating: ", rating); // Log rating nhận được
                                                    setStarRating(rating); // Gọi hàm để hiển thị ngôi sao
                                                });

                                            </script>
                                            <div class="price categories">
                                                <span>Categories</span>
                                                <h5 class="text-primary">${course.course.courseType.courseTypeName}</h5>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="cours-detail-bx">
                                        <div class="cours-info-list row scroll-page">
                                            <ul class="navbar">
                                                <li><a class="nav-link" href="#overview"><i class="ti-zip"></i> Overview</a></li>
                                                <li><a class="nav-link" href="#curriculum"><i class="ti-bookmark-alt"></i> Curriculum</a></li>
                                                <li><a class="nav-link" href="#instructor"><i class="ti-user"></i>Price Package</a></li>
                                                <li><a class="nav-link" href="#reviews"><i class="ti-comments"></i> Reviews</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="m-b30" style="margin-top: 70px;" id="overview">
                                        <h4>Overview</h4>
                                        <div class="row">
                                            <div class="col-md-12 col-lg-4" >
                                                <ul class="course-features" >
                                                    <li><i class="ti-book"></i> <span class="label">Lectures</span> <span class="value">${requestScope.cntSubject}</span></li>
                                                    <li><i class="ti-help-alt"></i> <span class="label">Quizzes</span> <span class="value">${requestScope.cntSubject}</span></li>
                                                    <li><i class="ti-stats-up"></i> <span class="label">Skill level</span> <span class="value">${course.course.level}</span></li>
                                                    <li><i class="ti-user"></i> <span class="label">Enrollments</span> <span class="value">${course.totalEnrollment}</span></li>
                                                    <li><i class="ti-check-box"></i> <span class="label">Assessments</span> <span class="value">Yes</span></li>
                                                </ul>
                                            </div>
                                            <div class="col-md-12 col-lg-8">
                                                <h5 class="m-b5">Course Description</h5>
                                                <p> ${course.course.description} </p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="m-b30" id="curriculum">
                                        <h4>Curriculum</h4>
                                        <ul class="curriculum-list">
                                            <c:forEach items="${requestScope.listSubject}" var="subject">
                                                <li>
                                                    <h5>${subject.subjectName}</h5>
                                                    <ul>
                                                        <c:forEach items="${requestScope.subjectLessonsMap[subject.subjectId]}" var="lesson" >
                                                            <li>
                                                                <div class="curriculum-list-box">
                                                                    <span>Lesson ${lesson.orderNo}.</span> ${lesson.lessonName}
                                                                </div>
                                                                <span>${lesson.duration} minutes</span>
                                                            </li>
                                                        </c:forEach>
                                                    </ul>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                    <div class="" id="instructor">
                                        <h4>Price Package</h4>
                                        <c:forEach items="${requestScope.pricePackage}" var="price">
                                            <div class="instructor-bx">
                                                <div class="instructor-info">
                                                    <h6>${price.salePrice}</h6>
                                                    <del>${price.price}</del>
                                                    <p class="m-b0">${price.description}</p>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                    <div class="" id="reviews">
                                        <h4>Reviews</h4>
                                        <ol class="comment-list">
                                            <c:forEach items= "${requestScope.listComment}"  var ="parent">
                                                <li class="comment">
                                                    <div class="comment-body">
                                                        <div class="comment-author vcard"> <img  class="avatar photo" src="assets/images/testimonials/pic1.jpg" alt=""> <cite class="fn">John Doe</cite> <span class="says">says:</span> </div>
                                                        <div class="comment-meta"> <a href="#">${parent.createDate}</a> </div>
                                                        <p>${parent.content} </p>
                                                        <div class="reply">
                                                            <a href="#" class="comment-reply-link" onclick="toggleReplyBox(event, this)">Reply</a>
                                                        </div>
                                                        <form action="addCommentCourse">
                                                            <div class="reply-box" style="display: none; margin-top: 10px; margin-bottom : 10px">
                                                                <input type="hidden" name="parentId" value="${parent.commentCourseId}">
                                                                <input type="hidden" name="courseId" value="${parent.course.courseId}">
                                                                <textarea placeholder="Nhập nội dung bình luận" rows="3" name="content"></textarea>
                                                                <button type="submit" class="submit-reply">Gửi</button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                    <ol class="children">
                                                        <c:if test="${not empty parent.children}">
                                                            <c:set var="childComments" value="${parent.children}" scope="request"/>
                                                            <jsp:include page="comment-recursive-course.jsp"/>
                                                        </c:if>
                                                        <!-- list END -->
                                                    </ol>
                                                </li>
                                            </c:forEach>
                                        </ol>
                                        <script>
                                            function toggleReplyBox(event, element) {
                                                event.preventDefault(); // Chặn hành vi mặc định của thẻ <a>

                                                // Tìm phần tử cha gần nhất có class .comment
                                                let commentContainer = element.closest('.comment');

                                                // Tìm phần tử .reply-box bên trong comment đó
                                                let replyBox = commentContainer.querySelector('.reply-box');

                                                // Hiển thị hoặc ẩn phần nhập comment
                                                if (replyBox.style.display === "none") {
                                                    replyBox.style.display = "block";
                                                } else {
                                                    replyBox.style.display = "none";
                                                }
                                            }
                                        </script>
                                    </div>

                                </div>

                            </div>
                        </div>
                    </div>
                </div>
                <!-- contact area END -->

            </div>
            <!-- Content END-->
            <!-- Footer ==== -->
            <footer>
                <%@include file="footer.jsp" %>
            </footer>
            <!-- Footer END ==== -->


            <button class="back-to-top fa fa-chevron-up" ></button>
        </div>

        <!-- External JavaScripts -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/vendors/bootstrap/js/popper.min.js"></script>
        <script src="assets/vendors/bootstrap/js/bootstrap.min.js"></script>
        <script src="assets/vendors/bootstrap-select/bootstrap-select.min.js"></script>
        <script src="assets/vendors/bootstrap-touchspin/jquery.bootstrap-touchspin.js"></script>
        <script src="assets/vendors/magnific-popup/magnific-popup.js"></script>
        <script src="assets/vendors/counter/waypoints-min.js"></script>
        <script src="assets/vendors/counter/counterup.min.js"></script>
        <script src="assets/vendors/imagesloaded/imagesloaded.js"></script>
        <script src="assets/vendors/masonry/masonry.js"></script>
        <script src="assets/vendors/masonry/filter.js"></script>
        <script src="assets/vendors/owl-carousel/owl.carousel.js"></script>
        <script src="assets/js/jquery.scroller.js"></script>
        <script src="assets/js/functions.js"></script>
        <script src="assets/js/contact.js"></script>
        <script src="assets/vendors/switcher/switcher.js"></script>
    </body>

</html>
