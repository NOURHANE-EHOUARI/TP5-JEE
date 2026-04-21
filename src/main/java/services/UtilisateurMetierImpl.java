package services;

import dao.UtilisateurDAO;
import dao.UtilisateurDAOImpl;
import entities.Utilisateur;

public class UtilisateurMetierImpl implements UtilisateurMetier {

    private final UtilisateurDAO dao = new UtilisateurDAOImpl();

    private static final UtilisateurMetierImpl instance = new UtilisateurMetierImpl();
    public static UtilisateurMetierImpl getInstance() { return instance; }
    private UtilisateurMetierImpl() {}

    @Override
    public Utilisateur authentifier(String login, String password) {
        return dao.findByLoginAndPassword(login, password);
    }
}