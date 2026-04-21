package filtres;

import entities.Utilisateur;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebFilter("/app/*")
public class RoleFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  req         = (HttpServletRequest) request;
        HttpServletResponse resp        = (HttpServletResponse) response;
        String              pathInfo    = req.getPathInfo();
        String              contextPath = req.getContextPath();

        boolean isAdminOnly = pathInfo != null && (
                pathInfo.equals("/addProduit")    ||
                pathInfo.equals("/deleteProduit") ||
                pathInfo.equals("/editProduit")   ||
                pathInfo.equals("/updateProduit")
        );

        if (!isAdminOnly) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false);
        Utilisateur user    = session != null
                              ? (Utilisateur) session.getAttribute("utilisateur")
                              : null;

        if (user == null) {
            resp.sendRedirect(contextPath + "/app/login");
        } else if ("ADMIN".equals(user.getRole())) {
            chain.doFilter(request, response);
        } else {
            resp.sendRedirect(contextPath + "/access-denied.jsp");
        }
    }
}