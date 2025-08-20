<%-- 
    Document   : diagnostico
    Created on : 19 ago 2025, 3:28:19
    Author     : gutie
--%>
<%@page import="java.util.Map"%>
<%@page import="clases.Sintoma"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Diagnóstico del Paciente - Sistema de Diagnóstico</title>
    
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
            --warning-color: #f59e0b;
            --danger-color: #ef4444;
            --diagnostic-color: #8b5cf6;
            --diagnostic-secondary: #7c3aed;
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
            background: linear-gradient(135deg, var(--diagnostic-color), var(--diagnostic-secondary));
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
            border: 1px solid rgba(139, 92, 246, 0.1);
        }

        .sintomas-section {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            margin: 1.5rem 0;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            border: 1px solid rgba(139, 92, 246, 0.1);
        }

        .sintomas-section h4 {
            color: var(--diagnostic-color);
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
            border-color: var(--diagnostic-color);
            transform: translateY(-1px);
            box-shadow: 0 4px 8px rgba(139, 92, 246, 0.1);
        }

        .form-check-input:checked {
            background-color: var(--diagnostic-color);
            border-color: var(--diagnostic-color);
        }

        .form-check-input:focus {
            border-color: var(--diagnostic-color);
            box-shadow: 0 0 0 0.25rem rgba(139, 92, 246, 0.25);
        }

        .form-check-label {
            font-weight: 500;
            color: var(--primary-color);
            margin-left: 8px;
            cursor: pointer;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--diagnostic-color), var(--diagnostic-secondary));
            border: none;
            border-radius: 12px;
            padding: 15px 40px;
            font-weight: 600;
            font-size: 1.2rem;
            transition: all 0.3s ease;
            box-shadow: var(--shadow);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px -5px rgba(139, 92, 246, 0.4);
            background: linear-gradient(135deg, var(--diagnostic-secondary), #6d28d9);
        }

        .results-section {
            margin-top: 2rem;
        }

        .result-exacto {
            background: linear-gradient(135deg, #dcfdf7, #a7f3d0);
            border: 2px solid var(--success-color);
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
        }

        .result-exacto h3 {
            color: #065f46;
            font-weight: 700;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .result-exacto .enfermedad-exacta {
            background: white;
            padding: 1rem 1.5rem;
            border-radius: 10px;
            margin: 0.5rem 0;
            border-left: 4px solid var(--success-color);
            list-style: none;
            font-weight: 600;
            color: #065f46;
        }

        .result-exacto .enfermedad-exacta::before {
            content: "✅";
            margin-right: 10px;
        }

        .result-parcial {
            background: linear-gradient(135deg, #fef3c7, #fde68a);
            border: 2px solid var(--warning-color);
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
        }

        .result-parcial h3 {
            color: #92400e;
            font-weight: 700;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .enfermedad-probable {
            background: white;
            padding: 1rem 1.5rem;
            border-radius: 10px;
            margin: 0.5rem 0;
            border-left: 4px solid var(--warning-color);
            list-style: none;
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: all 0.3s ease;
        }

        .enfermedad-probable:hover {
            transform: translateX(5px);
            box-shadow: var(--shadow);
        }

        .enfermedad-nombre {
            font-weight: 600;
            color: #92400e;
        }

        .confianza-badge {
            background: var(--warning-color);
            color: white;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
        }

        .confianza-high {
            background: var(--success-color);
        }

        .confianza-medium {
            background: var(--warning-color);
        }

        .confianza-low {
            background: var(--danger-color);
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

        .diagnostic-instructions {
            background: linear-gradient(135deg, #e0e7ff, #c7d2fe);
            border: 1px solid var(--accent-color);
            color: var(--primary-color);
            padding: 1.5rem;
            border-radius: 12px;
            margin-bottom: 1.5rem;
        }

        .diagnostic-instructions i {
            color: var(--diagnostic-color);
            margin-right: 10px;
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
            
            .enfermedad-probable {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
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
                        <a class="nav-link" href="registrarEnfermedad.jsp">
                            <i class="fas fa-virus me-1"></i>
                            Enfermedades
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="diagnostico.jsp">
                            <i class="fas fa-stethoscope me-1"></i>
                            Diagnóstico
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="pacientes.jsp">
                            <i class="fas fa-users me-1"></i>
                            Pacientes
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
                        <i class="fas fa-stethoscope icon-header"></i>
                        <h2>Diagnóstico del Paciente</h2>
                        <p class="mb-0 mt-2 opacity-90">Selecciona los síntomas presentes para obtener un diagnóstico</p>
                    </div>
                    
                    <div class="card-body">
                        <!-- Instrucciones -->
                        <div class="diagnostic-instructions">
                            <i class="fas fa-info-circle"></i>
                            <strong>Instrucciones:</strong> Selecciona todos los síntomas que presenta el paciente. El sistema analizará la información y proporcionará un diagnóstico basado en las enfermedades registradas.
                        </div>

                        <!-- Formulario de diagnóstico -->
                        <div class="form-section">
                            <form method="post" action="DiagnosticoServlet">
                                <!-- Sección de síntomas -->
                                <div class="sintomas-section">
                                    <h4>
                                        <i class="fas fa-list-check"></i>
                                        Síntomas del Paciente
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
                                                           name="paciente_<%= s.getNombre_sintoma() %>"
                                                           id="paciente_<%= s.getNombre_sintoma().replaceAll(" ", "_") %>">
                                                    <label class="form-check-label" 
                                                           for="paciente_<%= s.getNombre_sintoma().replaceAll(" ", "_") %>">
                                                        <%= s.getNombre_sintoma() %>
                                                    </label>
                                                </div>
                                            <% } %>
                                        </div>
                                    <% } else { %>
                                        <div class="no-sintomas-alert">
                                            <i class="fas fa-exclamation-triangle me-2"></i>
                                            <strong>No hay síntomas registrados</strong><br>
                                            Necesitas registrar síntomas primero antes de realizar un diagnóstico.
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
                                        <i class="fas fa-search me-2"></i>
                                        Diagnosticar
                                    </button>
                                </div>
                            </form>
                        </div>

                        <!-- Resultados del diagnóstico -->
                        <div class="results-section">
                            <% 
                            List<String> resultadoExacto = (List<String>) request.getAttribute("resultadoExacto");
                            List<Map.Entry<String, Double>> resultadoParcial = (List<Map.Entry<String, Double>>) request.getAttribute("resultadoParcial");
                            
                            if(resultadoExacto != null && !resultadoExacto.isEmpty()) { %>
                                <div class="result-exacto">
                                    <h3>
                                        <i class="fas fa-check-circle"></i>
                                        Diagnóstico Confirmado
                                    </h3>
                                    <ul class="list-unstyled">
                                        <% for(String e : resultadoExacto) { %>
                                            <li class="enfermedad-exacta">
                                                <%= e %>
                                            </li>
                                        <% } %>
                                    </ul>
                                    <p class="mt-3 mb-0 text-success fw-bold">
                                        <i class="fas fa-info-circle me-1"></i>
                                        Los síntomas coinciden exactamente con esta enfermedad.
                                    </p>
                                </div>
                            <% } else if(resultadoParcial != null && !resultadoParcial.isEmpty()) { %>
                                <div class="result-parcial">
                                    <h3>
                                        <i class="fas fa-chart-line"></i>
                                        Diagnósticos Probables
                                    </h3>
                                    <ul class="list-unstyled">
                                        <% for(Map.Entry<String, Double> e : resultadoParcial) { 
                                           double confianza = e.getValue();
                                           String badgeClass = "confianza-low";
                                           if(confianza >= 70) badgeClass = "confianza-high";
                                           else if(confianza >= 50) badgeClass = "confianza-medium";
                                        %>
                                            <li class="enfermedad-probable">
                                                <span class="enfermedad-nombre">
                                                    <%= e.getKey() %>
                                                </span>
                                                <span class="confianza-badge <%= badgeClass %>">
                                                    <%= String.format("%.1f", confianza) %>% confianza
                                                </span>
                                            </li>
                                        <% } %>
                                    </ul>
                                    <p class="mt-3 mb-0 text-warning fw-bold">
                                        <i class="fas fa-exclamation-triangle me-1"></i>
                                        Los síntomas coinciden parcialmente. Se recomienda evaluación médica adicional.
                                    </p>
                                </div>
                            <% } else if(request.getMethod().equals("POST")) { %>
                                <div class="empty-state">
                                    <i class="fas fa-search"></i>
                                    <h5>No se encontraron coincidencias</h5>
                                    <p class="text-muted">Los síntomas seleccionados no coinciden con ninguna enfermedad registrada en el sistema.</p>
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