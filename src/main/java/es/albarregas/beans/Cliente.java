package es.albarregas.beans;
import java.io.Serializable;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author gloriajean
 */
public class Cliente implements Serializable {
    public enum TipoIdentificacion {
        NIF,
        NIE,
        PASAPORTE
    }
    
    private Integer id;
    private String nombre;
    private Date fecha;
    private TipoIdentificacion tipoIdentificacion;
    private String identificacion;
    private ArrayList<String> preferencias;
    
    public Integer getId() {
        return id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    public String getNombre() {
        return nombre;
    }
    
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    public Date getFecha() {
        return fecha;
    }
    
    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }
    
    public TipoIdentificacion getTipoIdentificacion() {
        return tipoIdentificacion;
    }
    
    public void setTipoIdentificacion(TipoIdentificacion tipoIdentificacion) {
        this.tipoIdentificacion = tipoIdentificacion;
    }
    
    public ArrayList<String> getPreferencias() {
        return preferencias;
    }
    
    public void setPreferencias(ArrayList<String> preferencias) {
        this.preferencias = preferencias;
    }
    
    public String getIdentificacion() {
        return identificacion;
    }
    
    public void setIdentificacion(String identificacion) {
        this.identificacion = identificacion;
    }
    
     // Devuelve el enum como String
    public static String tipoIdentToString(TipoIdentificacion tipo) {
        return tipo != null ? tipo.name() : "";
    }

    public static Date converStringToDate(String fechaStr) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date fecha = sdf.parse(fechaStr);
        return fecha;
    }
    
    public static String converDateToString(Date fechaDate) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String fecha = sdf.format(fechaDate);
        return fecha;
    }
    
}
