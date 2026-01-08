package es.albarregas.beans;

import java.io.Serializable;
import java.util.Objects;

/**
 *
 * @author jesus
 */
public class Carta implements Serializable {
    
    private int id;
    private String nombre;
    private int elixir;
    private int ataque;
    private int vida;
    private String rareza;
    private String imagen;

    public Carta(){

    }

    public Carta(int id, String nombre, int elixir, int ataque, int vida, String rareza, String imagen){
        this.id=id;
        this.nombre=nombre;
        this.elixir=elixir;
        this.ataque=ataque;
        this.vida=vida;
        this.rareza=rareza;
        this.imagen=imagen;
    }

    public int getId() {
        return this.id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return this.nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getElixir() {
        return this.elixir;
    }

    public void setElixir(int elixir) {
        this.elixir = elixir;
    }

    public int getAtaque() {
        return this.ataque;
    }

    public void setAtaque(int ataque) {
        this.ataque = ataque;
    }

    public int getVida() {
        return this.vida;
    }

    public void setVida(int vida) {
        this.vida = vida;
    }

    public String getRareza() {
        return this.rareza;
    }

    public void setRareza(String rareza) {
        this.rareza = rareza;
    }

    public String getImagen() {
        return this.imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 97 * hash + this.id;
        hash = 97 * hash + Objects.hashCode(this.nombre);
        hash = 97 * hash + this.elixir;
        hash = 97 * hash + this.ataque;
        hash = 97 * hash + this.vida;
        hash = 97 * hash + Objects.hashCode(this.rareza);
        hash = 97 * hash + Objects.hashCode(this.imagen);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Carta other = (Carta) obj;
        if (this.id != other.id) {
            return false;
        }
        if (this.elixir != other.elixir) {
            return false;
        }
        if (this.ataque != other.ataque) {
            return false;
        }
        if (this.vida != other.vida) {
            return false;
        }
        if (!Objects.equals(this.nombre, other.nombre)) {
            return false;
        }
        if (!Objects.equals(this.rareza, other.rareza)) {
            return false;
        }
        return Objects.equals(this.imagen, other.imagen);
    }
    
    
    
}
