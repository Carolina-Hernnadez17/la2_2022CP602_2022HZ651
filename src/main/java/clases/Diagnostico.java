/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clases;

/**
 *
 * @author rebec
 */
import java.time.LocalDate;
public class Diagnostico {
    private Paciente paciente;
    private String enfermedad;
    private boolean exacto;
    private double confianza;
    private LocalDate fecha;

    public Diagnostico(Paciente paciente, String enfermedad, boolean exacto, double confianza) {
        this.paciente = paciente;
        this.enfermedad = enfermedad;
        this.exacto = exacto;
        this.confianza = confianza;
        this.fecha = LocalDate.now();
    }

    public Paciente getPaciente() { return paciente; }
    public String getEnfermedad() { return enfermedad; }
    public boolean isExacto() { return exacto; }
    public double getConfianza() { return confianza; }
    public LocalDate getFecha() { return fecha; }
    
}
