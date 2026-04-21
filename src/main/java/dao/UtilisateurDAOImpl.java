package dao;

import entities.Utilisateur;
import org.hibernate.Session;
import java.util.List;

public class UtilisateurDAOImpl implements UtilisateurDAO {

    @Override
    public Utilisateur findByLoginAndPassword(String login, String password) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            List<Utilisateur> result = session
                .createQuery(
                    "FROM Utilisateur u WHERE u.login = :login AND u.password = :password",
                    Utilisateur.class)
                .setParameter("login", login)
                .setParameter("password", password)
                .list();
            return result.isEmpty() ? null : result.get(0);
        }
    }
}