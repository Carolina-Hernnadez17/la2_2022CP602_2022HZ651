<%-- 
    Document   : navbar
    Created on : 19 ago 2025, 3:33:51
    Author     : gutie
--%>

<%-- navbar.jsp --%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

<style>
    .navbar-custom {
        background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        padding: 1rem 0;
    }
    
    .navbar-brand {
        font-weight: 700;
        font-size: 1.3rem;
        color: white !important;
    }
    
    .nav-link {
        color: rgba(255, 255, 255, 0.9) !important;
        font-weight: 500;
        padding: 0.5rem 1rem !important;
        border-radius: 8px;
        transition: all 0.3s ease;
        margin: 0 0.2rem;
    }
    
    .nav-link:hover {
        background: rgba(255, 255, 255, 0.2);
        color: white !important;
        transform: translateY(-2px);
    }
    
    .nav-link.active {
        background: rgba(255, 255, 255, 0.25);
        color: white !important;
    }
    
    .navbar-toggler {
        border: none;
        padding: 0.25rem 0.5rem;
    }
    
    .navbar-toggler:focus {
        box-shadow: none;
    }
    
    .navbar-toggler-icon {
        background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba%28255, 255, 255, 0.8%29' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
    }
    
    @media (max-width: 991px) {
        .navbar-nav {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            padding: 1rem;
            margin-top: 1rem;
        }
    }
</style>

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
                    <a class="nav-link" href="sintomas.jsp">
                        <i class="fas fa-thermometer-half me-1"></i>
                        Síntomas
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="enfermedades.jsp">
                        <i class="fas fa-virus me-1"></i>
                        Enfermedades
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="diagnostico.jsp">
                        <i class="fas fa-stethoscope me-1"></i>
                        Diagnóstico
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="registrarPaciente.jsp">
                        <i class="fas fa-users me-1"></i>
                        Pacientes
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="hisotrialPacientes.jsp">
                        <i class="fas fa-users me-1"></i>
                        Historial
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Marcar como activo el enlace de la página actual
    document.addEventListener('DOMContentLoaded', function() {
        const currentPage = window.location.pathname.split('/').pop();
        const navLinks = document.querySelectorAll('.nav-link');
        
        navLinks.forEach(link => {
            const href = link.getAttribute('href');
            if (href === currentPage || (currentPage === '' && href === 'index.jsp')) {
                link.classList.add('active');
            }
        });
    });
</script>