<%-- 
    Document   : registrarSintoma
    Created on : 19 ago 2025, 3:39:02
    Author     : gutie
--%>
<%@page import="java.util.List"%>
<%@page import="clases.Sintoma"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar Síntomas - Sistema de Diagnóstico</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <style>
        :root {
            --primary-color: #2c5aa0;
            --secondary-color: #1e3a8a;
            --accent-color: #3b82f6;
            --success-color: #10b981;
            --light-bg: #f8fafc;
            --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }

        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .navbar-custom {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            box-shadow: var(--shadow);
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
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
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .card-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
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
            padding: 2.5rem;
        }

        .form-section {
            background: var(--light-bg);
            padding: 2rem;
            border-radius: 15px;
            margin-bottom: 2rem;
            border: 1px solid rgba(59, 130, 246, 0.1);
        }

        .form-label {
            color: var(--primary-color);
            font-weight: 600;
            margin-bottom: 0.8rem;
            font-size: 1.1rem;
        }

        .form-control {
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            padding: 12px 16px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: white;
        }

        .form-control:focus {
            border-color: var(--accent-color);
            box-shadow: 0 0 0 0.2rem rgba(59, 130, 246, 0.25);
            background: white;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--accent-color), var(--primary-color));
            border: none;
            border-radius: 12px;
            padding: 12px 30px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            box-shadow: var(--shadow);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px -5px rgba(59, 130, 246, 0.4);
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
        }

        .sintomas-list {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }

        .sintomas-list h3 {
            color: var(--primary-color);
            font-weight: 600;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .sintoma-item {
            background: linear-gradient(135deg, #f1f5f9, #e2e8f0);
            margin: 0.5rem 0;
            padding: 1rem 1.5rem;
            border-radius: 12px;
            border-left: 4px solid var(--accent-color);
            transition: all 0.3s ease;
            list-style: none;
        }

        .sintoma-item:hover {
            transform: translateX(5px);
            box-shadow: var(--shadow);
            background: linear-gradient(135deg, #e2e8f0, #cbd5e1);
        }

        .sintoma-item::before {
            content: "🔸";
            margin-right: 10px;
        }

        .empty-state {
            text-align: center;
            padding: 3rem;
            color: #64748b;
        }

        .empty-state i {
            font-size: 4rem;
            margin-bottom: 1rem;
            color: #cbd5e1;
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

        .icon-header {
            font-size: 3rem;
            margin-bottom: 1rem;
            opacity: 0.9;
        }

        @media (max-width: 768px) {
            .card-body {
                padding: 1.5rem;
            }
            
            .form-section {
                padding: 1.5rem;
            }
            
            .card-header h2 {
                font-size: 1.5rem;
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
                    <a class="nav-link" href="index.jsp">
                        <i class="fas fa-home me-1"></i>
                        Inicio
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="registrarSintoma.jsp">
                        <i class="fas fa-thermometer-half me-1"></i>
                        Síntomas
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="registrarEnfermedad.jsp">
                        <i class="fas fa-virus me-1"></i>
                        Enfermedades
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="registrarPaciente.jsp">
                        <i class="fas fa-users me-1"></i>
                        Pacientes
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="historialPacientes.jsp">
                        <i class="fas fa-users me-1"></i>
                        Historial
                    </a>
                </li>
            </ul>
        </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container container-main">
        <div class="row justify-content-center">
            <div class="col-lg-10 col-xl-8">
                <div class="card">
                    <div class="card-header">
                        <i class="fas fa-thermometer-half icon-header"></i>
                        <h2>Registrar Síntomas</h2>
                        <p class="mb-0 mt-2 opacity-90">Añade nuevos síntomas al sistema de diagnóstico</p>
                    </div>
                    
                    <div class="card-body">

                        <!-- Mensajes -->
                        <%
                            String mensaje = (String) request.getAttribute("mensaje");
                            String tipoMensaje = (String) request.getAttribute("tipoMensaje");
                            if (mensaje != null) {
                        %>
                            <div class="alert alert-<%= "success".equals(tipoMensaje) ? "success" : "danger" %> alert-dismissible fade show" role="alert">
                                <%= mensaje %>
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        <% } %>

                        <!-- Formulario de registro -->
                        <div class="form-section">
                            <form method="post" action="SintomaServlet">
                                <input type="hidden" name="accion" value="agregar">

                                <div class="mb-4">
                                    <label for="nombreSintoma" class="form-label">
                                        <i class="fas fa-edit me-2"></i>
                                        Nombre del síntoma
                                    </label>
                                    <input type="text" 
                                           id="nombreSintoma"
                                           name="nombreSintoma" 
                                           class="form-control"
                                           placeholder="Ej: Dolor de cabeza, Fiebre, Tos..."
                                           required>
                                </div>
                                
                                <div class="text-center">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-plus me-2"></i>
                                        Agregar Síntoma
                                    </button>
                                </div>
                            </form>
                        </div>

                        <!-- Formulario de búsqueda -->
                        <div class="form-section mt-4">
                            <form method="post" action="SintomaServlet">
                                <input type="hidden" name="accion" value="buscar">
                                <div class="mb-3">
                                    <label for="buscar" class="form-label">
                                        <i class="fas fa-search me-2"></i> Buscar síntoma
                                    </label>
                                    <input type="text" id="buscar" name="buscar" class="form-control" placeholder="Nombre o ID del síntoma">
                                </div>
                                <div class="text-center">
                                    <button type="submit" class="btn btn-secondary">
                                        <i class="fas fa-search me-2"></i> Buscar
                                    </button>
                                </div>
                            </form>
                        </div>

                        <!-- Lista de síntomas registrados -->
                        <div class="sintomas-list">
                            <h3>
                                <i class="fas fa-list-ul"></i>
                                Síntomas Registrados
                            </h3>
                            
                            <% 
                            List<Sintoma> sintomas = (List<Sintoma>) session.getAttribute("sintomas");
                            if(sintomas != null && !sintomas.isEmpty()) {
                            %>
                                <ul class="list-unstyled">
                                    <% for(int i=0; i<sintomas.size(); i++) { %>
                                        <li class="sintoma-item">
                                            <strong><%= (i+1) %>.</strong> <%= sintomas.get(i).getNombre_sintoma() %>
                                        </li>
                                    <% } %>
                                </ul>
                            <% } else { %>
                                <div class="empty-state">
                                    <i class="fas fa-clipboard-list"></i>
                                    <h5>No hay síntomas registrados</h5>
                                    <p class="text-muted">Comienza agregando el primer síntoma usando el formulario anterior</p>
                                </div>
                            <% } %>
                        </div>

                        <!-- Resultados de búsqueda -->
                        <%
                            List<Sintoma> resultados = (List<Sintoma>) request.getAttribute("resultados");
                            if (resultados != null) {
                        %>
                        <div class="sintomas-list mt-4">
                            <h3><i class="fas fa-search"></i> Resultados de búsqueda</h3>
                            <% if (!resultados.isEmpty()) { %>
                                <ul class="list-unstyled">
                                    <% for (Sintoma s : resultados) { %>
                                        <li class="sintoma-item"><%= s.getNombre_sintoma() %></li>
                                    <% } %>
                                </ul>
                            <% } else { %>
                                <div class="empty-state">
                                    <i class="fas fa-search-minus"></i>
                                    <h5>No se encontraron resultados</h5>
                                </div>
                            <% } %>
                        </div>
                        <% } %>

                        <!-- Link de regreso -->
                        <div class="text-center">
                            <a href="index.jsp" class="back-link">
                                <i class="fas fa-arrow-left"></i>
                                Volver al Menú Principal
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>
