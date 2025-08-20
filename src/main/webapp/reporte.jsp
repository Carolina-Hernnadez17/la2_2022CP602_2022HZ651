<%-- 
    Document   : reporte
    Created on : 20 ago 2025
    Author     : rebec
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="clases.Diagnostico, clases.Paciente, clases.Enfermedad, clases.Sintoma, java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reporte de Diagnósticos - Sistema de Diagnóstico</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <style>
        :root {
            --primary-color: #2c5aa0;
            --accent-color: #3b82f6;
            --success-color: #10b981;
            --danger-color: #ef4444;
            --light-bg: #f8fafc;
            --shadow: 0 4px 6px -1px rgba(0,0,0,0.1);
        }

        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 2rem 0;
        }

        .navbar-custom {
            background: rgba(255,255,255,0.95);
            backdrop-filter: blur(10px);
            box-shadow: var(--shadow);
            border-bottom: 1px solid rgba(255,255,255,0.2);
        }

        .navbar-brand {
            font-weight: 700;
            color: var(--primary-color) !important;
            font-size: 1.5rem;
        }

        .nav-link {
            color: var(--primary-color) !important;
            font-weight: 500;
            transition: all 0.3s ease;
            border-radius: 8px;
            margin: 0 5px;
            padding: 8px 15px !important;
        }

        .nav-link:hover {
            background: var(--accent-color);
            color: white !important;
            transform: translateY(-1px);
        }

        .nav-link.active {
            background: var(--primary-color);
            color: white !important;
        }

        .container-main {
            margin-top: 2rem;
            margin-bottom: 2rem;
        }

        .card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border: none;
            border-radius: 20px;
            box-shadow: 0 20px 25px -5px rgba(0,0,0,0.1);
            overflow: hidden;
            margin-bottom: 2rem;
        }

        .card-header {
            background: linear-gradient(135deg, var(--danger-color), #dc2626);
            color: white;
            border: none;
            padding: 2rem;
            text-align: center;
        }

        .card-header h2 {
            margin: 0;
            font-weight: 600;
            font-size: 2rem;
        }

        .card-body {
            padding: 2rem;
        }

        .section-title {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 1rem;
            color: var(--primary-color);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .table thead {
            background-color: #f1f5f9;
        }

        .feature-list li {
            background: linear-gradient(135deg, #fef2f2, #fee2e2);
            padding: 0.8rem 1rem;
            margin: 0.3rem 0;
            border-radius: 10px;
            border-left: 4px solid var(--danger-color);
            list-style: none;
            transition: all 0.3s ease;
        }

        .feature-list li:hover {
            transform: translateX(5px);
            box-shadow: var(--shadow);
            background: linear-gradient(135deg, #fee2e2, #fecaca);
        }

        .icon-header {
            font-size: 2.5rem;
            margin-right: 10px;
            opacity: 0.9;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 600;
            padding: 12px 24px;
            border: 2px solid var(--primary-color);
            border-radius: 12px;
            transition: all 0.3s ease;
            margin-top: 1.5rem;
        }

        .back-link:hover {
            background: var(--primary-color);
            color: white;
            transform: translateY(-2px);
            box-shadow: var(--shadow);
        }

        @media (max-width: 768px) {
            .card-body {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-custom">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">
                <i class="fas fa-user-md me-2"></i>
                Sistema de Diagnóstico
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="index.jsp"><i class="fas fa-home me-1"></i> Inicio</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="registrarSintoma.jsp"><i class="fas fa-thermometer-half me-1"></i> Síntomas</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="registrarEnfermedad.jsp"><i class="fas fa-virus me-1"></i> Enfermedades</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="registrarPaciente.jsp"><i class="fas fa-users me-1"></i> Pacientes</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="reporte.jsp"><i class="fas fa-chart-line me-1"></i> Reporte</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container container-main">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="card">
                    <div class="card-header">
                        <i class="fas fa-chart-line icon-header"></i>
                        <h2>Reporte de Diagnósticos</h2>
                    </div>
                    <div class="card-body">

                        <!-- Estadísticas -->
                        <div class="section-title"><i class="fas fa-chart-pie"></i> Estadísticas Generales</div>
                        <ul class="feature-list">
                            <li>Total de pacientes: <strong>${fn:length(sessionScope.pacientes)}</strong></li>
                            <li>Total de enfermedades: <strong>${fn:length(sessionScope.enfermedades)}</strong></li>
                            <li>Total de diagnósticos: <strong>${fn:length(sessionScope.historial)}</strong></li>
                            <li>Total de síntomas: <strong>${fn:length(sessionScope.sintomas)}</strong></li>

                            <li>Exactos / Parciales: 
                                <strong>
                                    <c:set var="exactos" value="0"/>
                                    <c:set var="parciales" value="0"/>
                                    <c:forEach var="d" items="${sessionScope.historial}">
                                        <c:if test="${d.exacto}">
                                            <c:set var="exactos" value="${exactos + 1}"/>
                                        </c:if>
                                        <c:if test="${not d.exacto}">
                                            <c:set var="parciales" value="${parciales + 1}"/>
                                        </c:if>
                                    </c:forEach>
                                    ${exactos} / ${parciales}
                                </strong>
                            </li>

                            <li>Promedio confianza parciales: 
                                <strong>
                                    <c:set var="sumaConf" value="0"/>
                                    <c:set var="parcCount" value="0"/>
                                    <c:forEach var="d" items="${sessionScope.historial}">
                                        <c:if test="${not d.exacto}">
                                            <c:set var="sumaConf" value="${sumaConf + d.confianza}"/>
                                            <c:set var="parcCount" value="${parcCount + 1}"/>
                                        </c:if>
                                    </c:forEach>
                                    <c:choose>
                                        <c:when test="${parcCount > 0}">
                                            <c:set var="promConfParciales" value="${sumaConf / parcCount}"/>
                                            ${promConfParciales}%
                                        </c:when>
                                        <c:otherwise>0%</c:otherwise>
                                    </c:choose>
                                </strong>
                            </li>
                        </ul>

                        <!-- Pacientes Registrados con filtro -->
                        <div class="section-title mt-4"><i class="fas fa-users"></i> Pacientes Registrados</div>
                        <input type="text" id="filterPacientes" class="form-control mb-2" placeholder="Buscar paciente..." onkeyup="filterList('filterPacientes', 'listaPacientes')">
                        <ul class="feature-list" id="listaPacientes">
                            <c:choose>
                                <c:when test="${not empty sessionScope.pacientes}">
                                    <c:forEach var="p" items="${sessionScope.pacientes}">
                                        <li>${p.nombre}</li>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <li>No hay pacientes registrados.</li>
                                </c:otherwise>
                            </c:choose>
                        </ul>

                        <!-- Enfermedades Registradas con filtro -->
                        <div class="section-title mt-4"><i class="fas fa-virus"></i> Enfermedades Registradas</div>
                        <input type="text" id="filterEnfermedades" class="form-control mb-2" placeholder="Buscar enfermedad..." onkeyup="filterList('filterEnfermedades', 'listaEnfermedades')">
                        <ul class="feature-list" id="listaEnfermedades">
                            <c:choose>
                                <c:when test="${not empty sessionScope.enfermedades}">
                                    <c:forEach var="e" items="${sessionScope.enfermedades}">
                                        <li>${e.nombre}</li>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <li>No hay enfermedades registradas.</li>
                                </c:otherwise>
                            </c:choose>
                        </ul>

                        <!-- Síntomas Registrados con filtro -->
                        <div class="section-title mt-4"><i class="fas fa-stethoscope"></i> Síntomas Registrados</div>
                        <input type="text" id="filterSintomas" class="form-control mb-2" placeholder="Buscar síntoma..." onkeyup="filterList('filterSintomas', 'listaSintomas')">
                        <ul class="feature-list" id="listaSintomas">
                            <c:choose>
                                <c:when test="${not empty sessionScope.sintomas}">
                                    <c:forEach var="s" items="${sessionScope.sintomas}">
                                        <li>${s.nombre_sintoma}</li>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <li>No hay síntomas registrados.</li>
                                </c:otherwise>
                            </c:choose>
                        </ul>

                        <!-- Back link -->
                        <div class="text-center mt-4">
                            <a href="index.jsp" class="back-link"><i class="fas fa-arrow-left"></i> Volver al Menú Principal</a>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script>
    function filterList(inputId, listId) {
        const input = document.getElementById(inputId);
        const filter = input.value.toLowerCase();
        const ul = document.getElementById(listId);
        const li = ul.getElementsByTagName('li');

        for (let i = 0; i < li.length; i++) {
            const txtValue = li[i].textContent || li[i].innerText;
            li[i].style.display = txtValue.toLowerCase().includes(filter) ? "" : "none";
        }
    }
    </script>
</body>
</html>
