<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<html>
<head>
    <title>Admin</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="<c:url value='/template/admin/plugins/fontawesome-free/css/all.min.css' />"/>
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <!-- Tempusdominus Bootstrap 4 -->
    <link rel="stylesheet" href="<c:url value='/template/admin/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css'/>"/>
    <!-- iCheck -->
    <link rel="stylesheet" href="<c:url value='/template/admin/plugins/icheck-bootstrap/icheck-bootstrap.min.css'/>"/>
    <!-- JQVMap -->
    <link rel="stylesheet" href="<c:url value='/template/admin/plugins/jqvmap/jqvmap.min.css'/>"/>
    <!-- Theme style -->
    <link rel="stylesheet" href="<c:url value='/template/admin/dist/css/adminlte.min.css'/>"/>

    <link rel="stylesheet" href="<c:url value='/template/admin/css/admin-forms.css'/>"/>

    <!-- overlayScrollbars -->
    <link rel="stylesheet" href="<c:url value='/template/admin/plugins/overlayScrollbars/css/OverlayScrollbars.min.css'/>"/>
    <!-- Daterange picker -->
    <link rel="stylesheet" href="<c:url value='/template/admin/plugins/daterangepicker/daterangepicker.css'/>"/>
    <!-- summernote -->
    <link rel="stylesheet" href="<c:url value='/template/admin/plugins/summernote/summernote-bs4.min.css'/>"/>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

    <!-- Preloader -->
    <div class="preloader flex-column justify-content-center align-items-center">
        <img class="animation__shake" src="<c:url value='/template/admin/dist/img/AdminLTELogo.png'/>" alt="AdminLTELogo" height="60" width="60">
    </div>

    <!-- Navbar -->
    <%@ include file="/common/admin/header.jsp"%>
    <!-- /.navbar -->

    <!-- Main Sidebar Container -->
    <%@include file="/common/admin/menu.jsp"%>
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <dec:body/>
    </div>
    <!-- /.content-wrapper -->
    <%@include file="/common/admin/footer.jsp"%>

    <!-- Control Sidebar -->
    <aside class="control-sidebar control-sidebar-dark">
        <!-- Control sidebar content goes here -->
    </aside>
    <!-- /.control-sidebar -->
    <script src="<c:url value='/template/admin/plugins/jquery/jquery.min.js'/>"></script>
    <!-- jQuery UI 1.11.4 -->
    <script src="<c:url value='/template/admin/plugins/jquery-ui/jquery-ui.min.js'/>"></script>
    <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
    <script>
        $.widget.bridge('uibutton', $.ui.button)
    </script>
    <!-- Bootstrap 4 -->
    <script src="<c:url value='/template/admin/plugins/bootstrap/js/bootstrap.bundle.min.js'/>"></script>
    <!-- ChartJS -->
    <script src="<c:url value='/template/admin/plugins/chart.js/Chart.min.js'/>"></script>
    <!-- Sparkline -->
    <script src="<c:url value='/template/admin/plugins/sparklines/sparkline.js'/>"></script>
    <!-- JQVMap -->
    <script src="<c:url value='/template/admin/plugins/jqvmap/jquery.vmap.min.js'/>"></script>
    <script src="<c:url value='/template/admin/plugins/jqvmap/maps/jquery.vmap.usa.js'/>"></script>
    <!-- jQuery Knob Chart -->
    <script src="<c:url value='/template/admin/plugins/jquery-knob/jquery.knob.min.js'/>"></script>
    <!-- daterangepicker -->
    <script src="<c:url value='/template/admin/plugins/moment/moment.min.js'/>"></script>
    <script src="<c:url value='/template/admin/plugins/daterangepicker/daterangepicker.js'/>"></script>
    <!-- Tempusdominus Bootstrap 4 -->
    <script src="<c:url value='/template/admin/plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js'/>"></script>
    <!-- Summernote -->
    <script src="<c:url value='/template/admin/plugins/summernote/summernote-bs4.min.js'/>"></script>
    <!-- overlayScrollbars -->
    <script src="<c:url value='/template/admin/plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js'/>"></script>
    <!-- AdminLTE App -->
    <script src="<c:url value='/template/admin/dist/js/adminlte.js'/>"></script>
    <!-- AdminLTE for demo purposes -->
    <script src="<c:url value='/template/admin/dist/js/demo.js'/>"></script>
    <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
    <script src="<c:url value='/template/admin/dist/js/pages/dashboard.js'/>"></script>

</div>
</body>
</html>
