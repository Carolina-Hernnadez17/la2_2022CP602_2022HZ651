<%@page import="clases.Sintoma"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro de Paciente</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding-top: 80px;
        }
        
        /* Navbar Styles */
        .navbar-custom {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .navbar-custom .navbar-brand {
            font-weight: 700;
            font-size: 1.5rem;
            color: #2c3e50;
            text-decoration: none;
        }
        
        .navbar-custom .navbar-brand:hover {
            color: #667eea;
        }
        
        .navbar-custom .nav-link {
            color: #555;
            font-weight: 500;
            transition: all 0.3s ease;
            margin: 0 5px;
            border-radius: 8px;
            padding: 8px 16px;
        }
        
        .navbar-custom .nav-link:hover {
            color: #667eea;
            background: rgba(102, 126, 234, 0.1);
            transform: translateY(-2px);
        }
        
        .navbar-custom .navbar-toggler {
            border: none;
            padding: 4px 8px;
        }
        
        .navbar-custom .nav-link.active {
            color: #667eea;
            background: rgba(102, 126, 234, 0.15);
            font-weight: 600;
        }
        
        /* Main Content */
        .main-content {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: calc(100vh - 80px);
            padding: 20px;
        }
        
        .form-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        h2 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 30px;
            font-size: 28px;
            font-weight: 600;
            position: relative;
        }
        
        h2:after {
            content: '';
            display: block;
            width: 60px;
            height: 3px;
            background: linear-gradient(45deg, #667eea, #764ba2);
            margin: 10px auto 0;
            border-radius: 2px;
        }
        
        .input-group {
            margin-bottom: 25px;
            position: relative;
        }
        
        .input-group label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 500;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .input-group input[type="text"],
        .input-group input[type="number"] {
            width: 100%;
            padding: 15px 20px;
            border: 2px solid #e1e8ed;
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.9);
        }
        
        .input-group input:focus {
            border-color: #667eea;
            outline: none;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            transform: translateY(-2px);
        }
        
        .symptoms-section {
            margin: 30px 0;
            padding: 25px;
            background: rgba(102, 126, 234, 0.05);
            border-radius: 15px;
            border-left: 4px solid #667eea;
        }
        
        .symptoms-section h3 {
            color: #2c3e50;
            margin-bottom: 20px;
            font-size: 18px;
            font-weight: 600;
        }
        
        .symptom-checkbox {
            display: flex;
            align-items: center;
            margin: 12px 0;
            padding: 10px 15px;
            border-radius: 8px;
            transition: all 0.2s ease;
            cursor: pointer;
            position: relative;
        }
        
        .symptom-checkbox:hover {
            background: rgba(102, 126, 234, 0.1);
            transform: translateX(5px);
        }
        
        .symptom-checkbox input[type="checkbox"] {
            margin-right: 12px;
            width: 18px;
            height: 18px;
            accent-color: #667eea;
            cursor: pointer;
        }
        
        .symptom-checkbox label {
            cursor: pointer;
            color: #555;
            font-weight: 400;
            margin: 0;
            font-size: 15px;
            text-transform: none;
            letter-spacing: normal;
        }
        
        .submit-btn {
            width: 100%;
            padding: 16px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-top: 10px;
        }
        
        .submit-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
        }
        
        .submit-btn:active {
            transform: translateY(-1px);
        }
        
        /* Animación de entrada */
        .form-container {
            animation: slideUp 0.6s ease-out;
        }
        
        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        /* Responsive */
        @media (max-width: 600px) {
            .form-container {
                padding: 30px 20px;
                margin: 10px;
            }
            
            h2 {
                font-size: 24px;
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
                        <a class="nav-link active" href="registrarPaciente.jsp">
                            <i class="fas fa-users me-1"></i>
                            Pacientes
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="historialPacientes.jsp">
                            <i class="fas fa-history me-1"></i>
                            Historial
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    
    <div class="main-content">
        <div class="form-container">
        <h2>Diagnostico y registro de Paciente</h2>
        <form action="PacienteServlet" method="post">
            <div class="input-group">
                <label for="nombre">Nombre</label>
                <input type="text" id="nombre" name="nombre" required placeholder="Ingrese el nombre completo">
            </div>
            
            <div class="input-group">
                <label for="edad">Edad</label>
                <input type="number" id="edad" name="edad" required min="0" max="120" placeholder="Ingrese la edad">
            </div>
            
            <div class="symptoms-section">
                <h3>Seleccione síntomas del paciente</h3>
                <%
                    List<Sintoma> sintomas = (List<Sintoma>) session.getAttribute("sintomas");
                    if (sintomas != null && !sintomas.isEmpty()) {
                        for (Sintoma s : sintomas) {
                %>
                    <div class="symptom-checkbox">
                        <input type="checkbox" id="<%= s.getNombre_sintoma() %>" 
                               name="sintoma_<%= s.getNombre_sintoma() %>">
                        <label for="<%= s.getNombre_sintoma() %>"><%= s.getNombre_sintoma() %></label>
                    </div>
                <%
                        }
                    } else {
                %>
                    <p style="color:#888; font-style:italic;">No hay síntomas registrados en el sistema.</p>
                <%
                    }
                %>
            </div>
            
            <button type="submit" class="submit-btn">Registrar Paciente</button>
        </form>
    </div>
    </div>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>