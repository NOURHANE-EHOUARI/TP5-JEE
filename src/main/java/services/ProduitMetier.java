package services;

import entities.Produit;
import java.util.List;

public interface ProduitMetier {
    void addProduit(Produit p);
    void deleteProduit(Long id);
    void updateProduit(Produit p);
    Produit getProduitById(Long id);
    List<Produit> getAllProduits();
}