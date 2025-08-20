<%-- 
    Document   : index
    Created on : 19 ago 2025, 3:35:15
    Author     : gutie
--%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sistema Básico de Diagnóstico</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <!-- Incluir el menú de navegación -->
    <%@ include file="navbar.jsp" %>
    
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
        }
        
        .welcome-section {
            padding: 4rem 0;
        }
        
        .welcome-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            padding: 3rem;
            text-align: center;
        }
        
        .features-grid {
            margin-top: 3rem;
        }
        
        .feature-card {
            background: #f8f9ff;
            border: 1px solid #e1e8ff;
            border-radius: 12px;
            padding: 2rem;
            height: 100%;
            transition: all 0.3s ease;
            text-decoration: none;
            color: #2d3748;
            display: block;
        }
        
        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(79, 172, 254, 0.2);
            text-decoration: none;
            color: #4facfe;
            border-color: #4facfe;
        }
        
        .feature-icon {
            font-size: 3rem;
            color: #4facfe;
            margin-bottom: 1rem;
        }
        
        .feature-title {
            font-size: 1.3rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }
        
        .feature-desc {
            color: #718096;
            font-size: 1rem;
        }
    </style>
    
    <div class="welcome-section">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <div class="welcome-card">
                        <i class="fas fa-user-md fa-4x text-primary mb-4"></i>
                        <h1 class="display-4 mb-3">Sistema Básico de Diagnóstico</h1>
                        <p class="lead text-muted mb-4">
                            Plataforma integral para el registro y análisis médico que te ayuda a gestionar 
                            síntomas, enfermedades y realizar diagnósticos de manera eficiente.
                        </p>
                        
                        <div class="features-grid">
                            <div class="row">
                                <div class="col-md-6 col-lg-3 mb-4">
                                    <a href="registrarSintoma.jsp" class="feature-card">
                                        <i class="fas fa-thermometer-half feature-icon"></i>
                                        <div class="feature-title">Síntomas</div>
                                        <p class="feature-desc">Registra y gestiona síntomas médicos</p>
                                    </a>
                                </div>
                                
                                <div class="col-md-6 col-lg-3 mb-4">
                                    <a href="registrarEnfermedad.jsp" class="feature-card">
                                        <i class="fas fa-virus feature-icon"></i>
                                        <div class="feature-title">Enfermedades</div>
                                        <p class="feature-desc">Catálogo completo de enfermedades</p>
                                    </a>
                                </div> 
                                <div class="col-md-6 col-lg-3 mb-4">
                                    <a href="registrarPaciente.jsp" class="feature-card">
                                        <i class="fas fa-users feature-icon"></i>
                                        <div class="feature-title">Pacientes</div>
                                        <p class="feature-desc">Gestión integral de pacientes</p>
                                    </a>
                                </div>
                                <div class="col-md-6 col-lg-3 mb-4">
                                    <a href="historialPacientes.jsp" class="feature-card">
                                        <i class="fas fa-users feature-icon"></i>
                                        <div class="feature-title">Historial de paciente</div>
                                        <p class="feature-desc">Gestión del hisotiral de pacientes</p>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>