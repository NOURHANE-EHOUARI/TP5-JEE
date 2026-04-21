package web;

import entities.Produit;
import entities.Utilisateur;
import services.ProduitMetier;
import services.ProduitMetierImpl;
import services.UtilisateurMetier;
import services.UtilisateurMetierImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/app/*")
public class FrontControllerServlet extends HttpServlet {

    private ProduitMetier     produitMetier;
    private UtilisateurMetier utilisateurMetier;

    @Override
    public void init() {
        produitMetier     = ProduitMetierImpl.getInstance();
        utilisateurMetier = UtilisateurMetierImpl.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        dispatch(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        dispatch(req, resp);
    }

    private void dispatch(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String pathInfo = req.getPathInfo();
        String action   = (pathInfo != null && pathInfo.length() > 1)
                          ? pathInfo.substring(1)
                          : "listProduits";

        switch (action) {
            case "login"          -> handleLogin(req, resp);
            case "logout"         -> handleLogout(req, resp);
            case "listProduits"   -> handleList(req, resp);
            case "addProduit"     -> handleAdd(req, resp);
            case "editProduit"    -> handleEdit(req, resp);
            case "updateProduit"  -> handleUpdate(req, resp);
            case "deleteProduit"  -> handleDelete(req, resp);
            default               -> resp.sendError(404, "Action inconnue : " + action);
        }
    }

    private void handleLogin(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        if ("POST".equalsIgnoreCase(req.getMethod())) {
            String login    = req.getParameter("login");
            String password = req.getParameter("password");
            Utilisateur user = utilisateurMetier.authentifier(login, password);

            if (user != null) {
                req.getSession().setAttribute("utilisateur", user);
                resp.sendRedirect(req.getContextPath() + "/app/listProduits");
            } else {
                req.setAttribute("erreur", "Login ou mot de passe incorrect !");
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
            }
        } else {
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }

    private void handleLogout(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        HttpSession session = req.getSession(false);
        if (session != null) session.invalidate();
        resp.sendRedirect(req.getContextPath() + "/app/login");
    }

    private void handleList(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String idParam = req.getParameter("idProduit");
        List<Produit> liste;

        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                Produit p = produitMetier.getProduitById(Long.parseLong(idParam.trim()));
                liste = new ArrayList<>();
                if (p != null) liste.add(p);
            } catch (NumberFormatException e) {
                liste = produitMetier.getAllProduits();
            }
        } else {
            liste = produitMetier.getAllProduits();
        }

        req.setAttribute("listeProduits", liste);
        req.getRequestDispatcher("/WEB-INF/views/index.jsp").forward(req, resp);
    }

    private void handleAdd(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        String nom         = req.getParameter("nom");
        String description = req.getParameter("description");
        Double prix        = Double.parseDouble(req.getParameter("prix"));
        produitMetier.addProduit(new Produit(nom, description, prix));
        resp.sendRedirect(req.getContextPath() + "/app/listProduits");
    }

    private void handleEdit(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Long id    = Long.parseLong(req.getParameter("id"));
        Produit p  = produitMetier.getProduitById(id);
        req.setAttribute("produitEdit",   p);
        req.setAttribute("listeProduits", produitMetier.getAllProduits());
        req.getRequestDispatcher("/WEB-INF/views/index.jsp").forward(req, resp);
    }

    private void handleUpdate(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        Produit p = new Produit();
        p.setIdProduit(Long.parseLong(req.getParameter("idProduit")));
        p.setNom(req.getParameter("nom"));
        p.setDescription(req.getParameter("description"));
        p.setPrix(Double.parseDouble(req.getParameter("prix")));
        produitMetier.updateProduit(p);
        resp.sendRedirect(req.getContextPath() + "/app/listProduits");
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        Long id = Long.parseLong(req.getParameter("id"));
        produitMetier.deleteProduit(id);
        resp.sendRedirect(req.getContextPath() + "/app/listProduits");
    }
}