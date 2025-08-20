<%-- 
    Document   : registrarEnfermedad
    Created on : 19 ago 2025, 3:39:41
    Author     : gutie
--%>

<%-- 
    Document   : registrarEnfermedad
    Created on : 19 ago 2025, 3:39:41
    Author     : gutie
--%>
<%@page import="clases.Sintoma"%>
<%@page import="clases.Enfermedad"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar Enfermedades - Sistema de Diagnóstico</title>
    
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
            --danger-color: #ef4444;
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
            padding: 2.5rem;
        }

        .form-section {
            background: var(--light-bg);
            padding: 2rem;
            border-radius: 15px;
            margin-bottom: 2rem;
            border: 1px solid rgba(239, 68, 68, 0.1);
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
            border-color: var(--danger-color);
            box-shadow: 0 0 0 0.2rem rgba(239, 68, 68, 0.25);
            background: white;
        }

        .sintomas-section {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            margin: 1.5rem 0;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            border: 1px solid rgba(239, 68, 68, 0.1);
        }

        .sintomas-section h4 {
            color: var(--danger-color);
            font-weight: 600;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .checkbox-group {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 15px;
            max-height: 400px;
            overflow-y: auto;
            padding: 1rem;
            background: #f8fafc;
            border-radius: 12px;
        }

        .form-check {
            background: white;
            padding: 12px 16px;
            border-radius: 10px;
            border: 2px solid #e2e8f0;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .form-check:hover {
            border-color: var(--danger-color);
            transform: translateY(-1px);
            box-shadow: 0 4px 8px rgba(239, 68, 68, 0.1);
        }

        .form-check-input:checked {
            background-color: var(--danger-color);
            border-color: var(--danger-color);
        }

        .form-check-input:focus {
            border-color: var(--danger-color);
            box-shadow: 0 0 0 0.25rem rgba(239, 68, 68, 0.25);
        }

        .form-check-label {
            font-weight: 500;
            color: var(--primary-color);
            margin-left: 8px;
            cursor: pointer;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--danger-color), #dc2626);
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
            box-shadow: 0 8px 25px -5px rgba(239, 68, 68, 0.4);
            background: linear-gradient(135deg, #dc2626, #b91c1c);
        }

        .enfermedades-list {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }

        .enfermedades-list h3 {
            color: var(--danger-color);
            font-weight: 600;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .enfermedad-item {
            background: linear-gradient(135deg, #fef2f2, #fee2e2);
            margin: 0.5rem 0;
            padding: 1rem 1.5rem;
            border-radius: 12px;
            border-left: 4px solid var(--danger-color);
            transition: all 0.3s ease;
            list-style: none;
        }

        .enfermedad-item:hover {
            transform: translateX(5px);
            box-shadow: var(--shadow);
            background: linear-gradient(135deg, #fee2e2, #fecaca);
        }

        .enfermedad-item::before {
            content: "🦠";
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

        .no-sintomas-alert {
            background: linear-gradient(135deg, #fef3c7, #fde68a);
            border: 1px solid #f59e0b;
            color: #92400e;
            padding: 1.5rem;
            border-radius: 12px;
            margin: 1rem 0;
            text-align: center;
        }

        @media (max-width: 768px) {
            .card-body {
                padding: 1.5rem;
            }
            
            .form-section, .sintomas-section {
                padding: 1.5rem;
            }
            
            .card-header h2 {
                font-size: 1.5rem;
            }
            
            .checkbox-group {
                grid-template-columns: 1fr;
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
                        <a class="nav-link" href="registrarSintoma.jsp">
                            <i class="fas fa-thermometer-half me-1"></i>
                            Síntomas
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="registrarEnfermedad.jsp">
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
            <div class="col-lg-10 col-xl-9">
                <div class="card">
                    <div class="card-header">
                        <i class="fas fa-virus icon-header"></i>
                        <h2>Registrar Enfermedad</h2>
                        <p class="mb-0 mt-2 opacity-90">Añade nuevas enfermedades y asocia sus síntomas</p>
                    </div>
                    
                    <div class="card-body">
                        <!-- Formulario de registro -->
                        <div class="form-section">
                            <form method="post" action="EnfermedadServlet">
                                <div class="mb-4">
                                    <label for="nombreEnfermedad" class="form-label">
                                        <i class="fas fa-edit me-2"></i>
                                        Nombre de la enfermedad
                                    </label>
                                    <input type="text" 
                                           id="nombreEnfermedad"
                                           name="nombreEnfermedad" 
                                           class="form-control"
                                           placeholder="Ej: Gripe, COVID-19, Migraña..."
                                           required>
                                </div>

                                <!-- Sección de síntomas -->
                                <div class="sintomas-section">
                                    <h4>
                                        <i class="fas fa-list-check"></i>
                                        Seleccione los síntomas presentes
                                    </h4>
                                    
                                    <% 
                                    List<Sintoma> sintomas = (List<Sintoma>) session.getAttribute("sintomas");
                                    if(sintomas != null && !sintomas.isEmpty()) {
                                    %>
                                        <div class="checkbox-group">
                                            <% for(Sintoma s : sintomas) { %>
                                                <div class="form-check">
                                                    <input class="form-check-input" 
                                                           type="checkbox" 
                                                           name="sintoma_<%= s.getNombre_sintoma() %>"
                                                           id="sintoma_<%= s.getNombre_sintoma().replaceAll(" ", "_") %>">
                                                    <label class="form-check-label" 
                                                           for="sintoma_<%= s.getNombre_sintoma().replaceAll(" ", "_") %>">
                                                        <%= s.getNombre_sintoma() %>
                                                    </label>
                                                </div>
                                            <% } %>
                                        </div>
                                    <% } else { %>
                                        <div class="no-sintomas-alert">
                                            <i class="fas fa-exclamation-triangle me-2"></i>
                                            <strong>No hay síntomas registrados</strong><br>
                                            Necesitas registrar síntomas primero antes de crear una enfermedad.
                                            <br><br>
                                            <a href="sintomas.jsp" class="btn btn-warning btn-sm">
                                                <i class="fas fa-plus me-1"></i>
                                                Ir a registrar síntomas
                                            </a>
                                        </div>
                                    <% } %>
                                </div>
                                
                                <div class="text-center">
                                    <button type="submit" class="btn btn-primary" 
                                            <%= (sintomas == null || sintomas.isEmpty()) ? "disabled" : "" %>>
                                        <i class="fas fa-plus me-2"></i>
                                        Agregar Enfermedad
                                    </button>
                                </div>
                            </form>
                        </div>

                        <!-- Lista de enfermedades registradas -->
                        <div class="enfermedades-list">
                            <h3>
                                <i class="fas fa-list-ul"></i>
                                Enfermedades Registradas
                            </h3>
                            
                            <% 
                            List<Enfermedad> enfermedades = (List<Enfermedad>) session.getAttribute("enfermedades");
                            if(enfermedades != null && !enfermedades.isEmpty()) {
                            %>
                                <ul class="list-unstyled">
                                    <% for(Enfermedad e : enfermedades) { %>
                                        <li class="enfermedad-item">
                                            <%= e.getNombre() %>
                                        </li>
                                    <% } %>
                                </ul>
                            <% } else { %>
                                <div class="empty-state">
                                    <i class="fas fa-virus"></i>
                                    <h5>No hay enfermedades registradas</h5>
                                    <p class="text-muted">Comienza agregando la primera enfermedad usando el formulario anterior</p>
                                </div>
                            <% } %>
                        </div>

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