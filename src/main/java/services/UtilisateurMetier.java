package services;

import entities.Utilisateur;

public interface UtilisateurMetier {
    Utilisateur authentifier(String login, String password);
}