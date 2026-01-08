/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package es.albarregas.controllers;

import es.albarregas.beans.Carta;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author gloriajean
 */
@WebServlet(name = "EditarCartaController", urlPatterns = {"/EditarCartaController"})
public class EditarCartaController extends HttpServlet {

  
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        ServletContext contexto = request.getServletContext();
        
        List<Carta> cartas = (List<Carta>) contexto.getAttribute("cartas");
        
        int idCarta = Integer.parseInt(request.getParameter("id"));
        String nombreCarta = request.getParameter("nombre");
        int elixirCarta = Integer.parseInt(request.getParameter("elixir"));
        String rarezaCarta = request.getParameter("rareza");
        
        
        for (Carta c : cartas) {
            if(c.getId() == idCarta) {
                c.setNombre(nombreCarta);
                c.setElixir(elixirCarta);
                c.setRareza(rarezaCarta);
            }
        }
        
        contexto.setAttribute("cartas", cartas);
        
        request.getRequestDispatcher("jsp/cartas.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
