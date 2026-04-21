package dao;

import entities.Utilisateur;

public interface UtilisateurDAO {
    Utilisateur findByLoginAndPassword(String login, String password);
}