package filtres;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebFilter("/app/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  req         = (HttpServletRequest) request;
        HttpServletResponse resp        = (HttpServletResponse) response;
        String              pathInfo    = req.getPathInfo();
        String              contextPath = req.getContextPath();

        boolean isPublic = pathInfo == null
                        || pathInfo.equals("/login")
                        || pathInfo.equals("/logout")
                        || pathInfo.endsWith(".css")
                        || pathInfo.endsWith(".js");

        if (isPublic) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session    = req.getSession(false);
        boolean     isConnecte = session != null && session.getAttribute("utilisateur") != null;

        if (isConnecte) {
            chain.doFilter(request, response);
        } else {
            resp.sendRedirect(contextPath + "/app/login");
        }
    }
}