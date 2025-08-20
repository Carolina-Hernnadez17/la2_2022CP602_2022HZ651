/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clases;

import java.util.List;
import java.util.Map;

/**
 *
 * @author gutie
 */
public class Paciente {
      private String id;
    private String nombre;
    private int edad;
    private String diagnostico; // enfermedad exacta o "no concluyente"
    private Map<String, Double> probabilidades; // solo si es no concluyente

    public Paciente(String id, String nombre, int edad) {
        this.id = id;
        this.nombre = nombre;
        this.edad = edad;
    }

    public String getId() { return id; }
    public String getNombre() { return nombre; }
    public int getEdad() { return edad; }
    public String getDiagnostico() { return diagnostico; }
    public void setDiagnostico(String diagnostico) { this.diagnostico = diagnostico; }
    public Map<String, Double> getProbabilidades() { return probabilidades; }
    public void setProbabilidades(Map<String, Double> probabilidades) { this.probabilidades = probabilidades; }
}
