/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/J2EE/EJB30/StatelessEjbClass.java to edit this template
 */
package es.albarregas.beans;
import java.io.Serializable;
import java.util.Date;
import javax.ejb.Stateless;

/**
 *
 * @author gloriajean
 */
@Stateless
public class Usuario implements Serializable {

    private String nombre;
    private Date fechaNacimiento;
    private Integer numHijos;
    private Double salario;
    
    //Constructor por defecto
    public Usuario() {
    }
    
    //Constructor explícito
    public Usuario(String nombre, Date fechaNacimiento, Integer numHijos, Double salario) {
        this.nombre = nombre;
        this.fechaNacimiento = fechaNacimiento;
        this.numHijos = numHijos;
        this.salario = salario;
    }
    
    //Getters y setters
    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Date getFechaNacimiento() {
        return fechaNacimiento;
    }

    public void setFechaNacimiento(Date fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }

    public Integer getNumHijos() {
        return numHijos;
    }

    public void setNumHijos(Integer numHijos) {
        this.numHijos = numHijos;
    }

    public Double getSalario() {
        return salario;
    }

    public void setSalario(Double salario) {
        this.salario = salario;
    }

    @Override
    public String toString() {
        return "Usuario{" +
                "nombre='" + nombre + '\'' +
                ", fechaNacimiento=" + fechaNacimiento +
                ", numHijos=" + numHijos +
                ", salario=" + salario +
                '}';
    }
}
    

