/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package es.albarregas.listeners;

import es.albarregas.beans.Carta;
import es.albarregas.dao.CartasDAO;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextAttributeEvent;
import javax.servlet.ServletContextAttributeListener;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.ServletRequestAttributeEvent;
import javax.servlet.ServletRequestAttributeListener;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionActivationListener;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionEvent;

/**
 *
 * @author gloriajean
 */
@WebListener
public class ListenerList implements ServletContextListener,
        ServletContextAttributeListener,
        HttpSessionActivationListener,
        HttpSessionAttributeListener,
        ServletRequestAttributeListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("Se ha iniciado la aplicación (contextInitialized)");
        List<Carta> cartas = new CartasDAO().getCartas();
        ServletContext contexto = sce.getServletContext();
        contexto.setAttribute("cartas", cartas);

    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("Se ha detenido la aplicación (contextDestroyed)");
    }

    @Override
    public void attributeAdded(ServletContextAttributeEvent event) {
        System.out.println("Se ha añadido el atributo " + event.getName() + "(attributeAdded)");
        ServletContext contexto = event.getServletContext();
        List<Carta> cartas = (List<Carta>) contexto.getAttribute("cartas");
        for (Carta carta : cartas) {
            System.out.println(carta.getNombre());
        }
    }

    @Override
    public void attributeRemoved(ServletContextAttributeEvent event) {
        System.out.println("Se ha eliminado el atributo" + event.getName() + "(attributeRemoved)");
    }

    @Override
    public void attributeReplaced(ServletContextAttributeEvent scae) {
        System.out.println("Se ha reemplazado el atributo" + scae.getName() + "(attributeReplaced)");
    }

    @Override
    public void sessionWillPassivate(HttpSessionEvent se) {
    }

    @Override
    public void sessionDidActivate(HttpSessionEvent se) {
    }

    @Override
    public void attributeAdded(HttpSessionBindingEvent event) {
        System.out.println("Se ha añadido el atributo " + event.getName() + "(attributeAdded - HttpSessionBindingEvent)");
    }

    @Override
    public void attributeRemoved(HttpSessionBindingEvent event) {
        System.out.println("Se ha eliminado el atributo" + event.getName() + "(attributeRemoved - HttpSessionBindingEvent)");
    }

    @Override
    public void attributeReplaced(HttpSessionBindingEvent event) {
    }

    @Override
    public void attributeAdded(ServletRequestAttributeEvent srae) {
    }

    @Override
    public void attributeRemoved(ServletRequestAttributeEvent srae) {
    }

    @Override
    public void attributeReplaced(ServletRequestAttributeEvent srae) {
    }

}
