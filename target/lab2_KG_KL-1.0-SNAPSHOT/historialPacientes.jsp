<%@page import="java.util.List"%>
<%@page import="clases.Paciente"%>
<%@page import="java.util.Map"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Historial de Pacientes</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --success-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --warning-gradient: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
            --danger-gradient: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            --card-shadow: 0 20px 40px rgba(0,0,0,0.1);
            --card-hover-shadow: 0 25px 50px rgba(0,0,0,0.15);
            --text-primary: #2c3e50;
            --text-secondary: #7f8c8d;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding-top: 100px;
        }

        /* Navbar personalizada */
        .navbar-custom {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 1.5rem;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .navbar-nav .nav-link {
            color: var(--text-primary) !important;
            font-weight: 500;
            padding: 0.8rem 1.2rem !important;
            border-radius: 25px;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .navbar-nav .nav-link::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: var(--primary-gradient);
            transition: left 0.3s ease;
            z-index: -1;
            border-radius: 25px;
        }

        .navbar-nav .nav-link:hover::before,
        .navbar-nav .nav-link.active::before {
            left: 0;
        }

        .navbar-nav .nav-link:hover,
        .navbar-nav .nav-link.active {
            color: white !important;
            transform: translateY(-2px);
        }

        /* Contenedor principal */
        .main-content {
            padding: 2rem 0;
            min-height: calc(100vh - 100px);
        }

        .content-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 2rem;
        }

        h2 {
            color: white;
            font-weight: 700;
            font-size: 2.5rem;
            margin-bottom: 2rem;
            text-align: center;
            text-shadow: 0 5px 15px rgba(0,0,0,0.2);
            position: relative;
        }

        h2::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 4px;
            background: var(--warning-gradient);
            border-radius: 2px;
        }

        /* Contenedor de tabla mejorado */
        .table-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: var(--card-shadow);
            border: 1px solid rgba(255, 255, 255, 0.2);
            overflow: hidden;
            position: relative;
        }

        .table-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: var(--primary-gradient);
        }

        /* Tabla moderna */
        .table-modern {
            margin-bottom: 0;
            border-collapse: separate;
            border-spacing: 0 10px;
        }

        .table-modern thead th {
            background: var(--primary-gradient);
            color: white;
            font-weight: 600;
            font-size: 1.1rem;
            padding: 1.2rem 1.5rem;
            border: none;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
            position: relative;
        }

        .table-modern thead th:first-child {
            border-radius: 15px 0 0 15px;
        }

        .table-modern thead th:last-child {
            border-radius: 0 15px 15px 0;
        }

        .table-modern tbody tr {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            transform: translateY(0);
        }

        .table-modern tbody tr:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.15);
        }

        .table-modern tbody td {
            padding: 1.5rem;
            border: none;
            vertical-align: middle;
            position: relative;
        }

        .table-modern tbody tr td:first-child {
            border-radius: 15px 0 0 15px;
        }

        .table-modern tbody tr td:last-child {
            border-radius: 0 15px 15px 0;
        }

        /* Estilos para elementos específicos */
        .patient-id {
            display: inline-block;
            background: var(--success-gradient);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.9rem;
            box-shadow: 0 5px 15px rgba(79, 172, 254, 0.3);
        }

        .patient-name {
            font-weight: 600;
            color: var(--text-primary);
            font-size: 1.1rem;
            position: relative;
        }

        .patient-name::before {
            content: '\f007';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            margin-right: 0.5rem;
            color: var(--text-secondary);
        }

        .patient-age {
            display: inline-block;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 0.4rem 0.8rem;
            border-radius: 15px;
            font-weight: 500;
            font-size: 0.9rem;
        }

        .diagnosis-main {
            display: inline-block;
            background: var(--warning-gradient);
            color: white;
            padding: 0.6rem 1.2rem;
            border-radius: 20px;
            font-weight: 600;
            margin-bottom: 0.5rem;
            font-size: 1rem;
            box-shadow: 0 5px 15px rgba(67, 233, 123, 0.3);
        }

        .no-conclusive {
            display: inline-block;
            background: var(--danger-gradient);
            color: white;
            padding: 0.6rem 1.2rem;
            border-radius: 20px;
            font-weight: 600;
            margin-bottom: 0.8rem;
            font-size: 1rem;
            box-shadow: 0 5px 15px rgba(250, 112, 154, 0.3);
        }

        .diagnosis-probability {
            display: inline-block;
            background: rgba(102, 126, 234, 0.1);
            color: var(--text-primary);
            padding: 0.3rem 0.8rem;
            border-radius: 15px;
            font-size: 0.85rem;
            margin: 0.2rem 0.3rem 0.2rem 0;
            border: 1px solid rgba(102, 126, 234, 0.2);
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .diagnosis-probability:hover {
            background: rgba(102, 126, 234, 0.2);
            transform: scale(1.05);
        }

        /* Estado vacío mejorado */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            box-shadow: var(--card-shadow);
            border: 1px solid rgba(255, 255, 255, 0.2);
            position: relative;
            overflow: hidden;
        }

        .empty-state::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: var(--secondary-gradient);
        }

        .empty-state i {
            font-size: 4rem;
            background: var(--secondary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 1.5rem;
            display: block;
            animation: pulse 2s ease-in-out infinite;
        }

        .empty-state h4 {
            color: var(--text-primary);
            font-weight: 700;
            font-size: 1.8rem;
            margin-bottom: 1rem;
        }

        .empty-state p {
            color: var(--text-secondary);
            font-size: 1.1rem;
            line-height: 1.6;
            max-width: 500px;
            margin: 0 auto;
        }


        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .table-modern tbody tr {
            animation: fadeInUp 0.6s ease forwards;
        }

        .table-modern tbody tr:nth-child(even) {
            animation-delay: 0.1s;
        }

        .table-modern tbody tr:nth-child(odd) {
            animation-delay: 0.2s;
        }

        /* Responsive */
        @media (max-width: 768px) {
            body { padding-top: 80px; }
            
            .content-container {
                padding: 0 1rem;
            }

            h2 {
                font-size: 2rem;
            }

            .table-container {
                padding: 1rem;
                border-radius: 15px;
            }

            .table-modern thead th,
            .table-modern tbody td {
                padding: 1rem 0.8rem;
                font-size: 0.9rem;
            }

            .navbar-nav .nav-link {
                padding: 0.5rem 1rem !important;
            }
        }

        @media (max-width: 576px) {
            .table-container {
                overflow-x: auto;
            }

            .table-modern {
                min-width: 600px;
            }

            h2 {
                font-size: 1.8rem;
            }
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-custom fixed-top">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">
                <i class="fas fa-user-md me-2"></i>
                Sistema de Diagnóstico
            </a>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="index.jsp"><i class="fas fa-home me-1"></i>Inicio</a></li>
                    <li class="nav-item"><a class="nav-link" href="registrarSintoma.jsp"><i class="fas fa-thermometer-half me-1"></i>Síntomas</a></li>
                    <li class="nav-item"><a class="nav-link" href="registrarEnfermdad.jsp"><i class="fas fa-virus me-1"></i>Enfermedades</a></li>
                    <li class="nav-item"><a class="nav-link" href="registrarPaciente.jsp"><i class="fas fa-users me-1"></i>Pacientes</a></li>
                    <li class="nav-item"><a class="nav-link active" href="historialPacientes.jsp"><i class="fas fa-history me-1"></i>Historial</a></li>
                </ul>
            </div>
        </div>
    </nav>
    
    <div class="main-content">
        <div class="content-container">
            <h2><i class="fas fa-history me-2"></i>Historial de Pacientes</h2>

            <%
                List<Paciente> pacientes = (List<Paciente>) session.getAttribute("pacientes");
                if (pacientes != null && !pacientes.isEmpty()) {
            %>
            <div class="table-container">
                <table class="table table-modern">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Edad</th>
                            <th>Diagnóstico</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (Paciente p : pacientes) {
                        %>
                        <tr>
                            <td><span class="patient-id"><%= p.getId() %></span></td>
                            <td><span class="patient-name"><%= p.getNombre() %></span></td>
                            <td><span class="patient-age"><%= p.getEdad() %> años</span></td>
                            <td>
                                <%
                                    if (!"No concluyente".equals(p.getDiagnostico())) {
                                %>
                                    <div class="diagnosis-main"><%= p.getDiagnostico() %></div>
                                <%
                                    } else {
                                %>
                                    <div class="no-conclusive">No concluyente</div>
                                    <%
                                        for (Map.Entry<String, Double> e : p.getProbabilidades().entrySet()) {
                                    %>
                                    <span class="diagnosis-probability"><%= e.getKey() %> (<%= String.format("%.2f", e.getValue()) %>%)</span>
                                    <%
                                        }
                                    %>
                                <%
                                    }
                                %>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
            <%
                } else {
            %>
            <div class="empty-state">
                <i class="fas fa-users-slash"></i>
                <h4>No hay pacientes registrados</h4>
                <p>Cuando registres pacientes, aparecerán aquí con su historial completo.</p>
            </div>
            <%
                }
            %>
        </div>
    </div>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>