/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clases;


import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
/**
 *
 * @author gutie
 */
public class Enfermedad {
    
   private String nombre;
    private Map<String, Boolean> sintomas;

    public Enfermedad(String nombre) {
        this.nombre = nombre;
        this.sintomas = new LinkedHashMap<>();
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Map<String, Boolean> getSintomas() {
        return sintomas;
    }

    public void addSintoma(String nombreSintoma, boolean presente) {
        this.sintomas.put(nombreSintoma, presente);
    }
    
    
}
