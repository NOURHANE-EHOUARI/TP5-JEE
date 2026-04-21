package services;

import dao.ProduitDAO;
import dao.ProduitDAOImpl;
import entities.Produit;
import java.util.List;

public class ProduitMetierImpl implements ProduitMetier {

    private final ProduitDAO dao = new ProduitDAOImpl();

    private static final ProduitMetierImpl instance = new ProduitMetierImpl();
    public static ProduitMetierImpl getInstance() { return instance; }
    private ProduitMetierImpl() {}

    @Override public void addProduit(Produit p)      { dao.add(p); }
    @Override public void deleteProduit(Long id)     { dao.delete(id); }
    @Override public void updateProduit(Produit p)   { dao.update(p); }
    @Override public Produit getProduitById(Long id) { return dao.getById(id); }
    @Override public List<Produit> getAllProduits()   { return dao.getAll(); }
}