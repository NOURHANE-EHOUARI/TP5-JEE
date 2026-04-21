package dao;

import entities.Produit;
import java.util.List;

public interface ProduitDAO {
    void add(Produit p);
    void delete(Long id);
    void update(Produit p);
    Produit getById(Long id);
    List<Produit> getAll();
}