<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion des Produits</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', sans-serif; background: #f5f5f0; min-height: 100vh; color: #1a1a1a; }
        nav { background: #1a1a1a; padding: 0 40px; height: 60px; display: flex; align-items: center; justify-content: space-between; }
        .brand { font-size: 15px; font-weight: 700; color: #fff; }
        .brand span { color: #e94560; }
        .nav-right { display: flex; align-items: center; gap: 14px; }
        .nav-user { font-size: 13px; color: rgba(255,255,255,0.45); }
        .nav-user strong { color: #fff; }
        .badge { padding: 3px 10px; border-radius: 4px; font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.8px; }
        .badge-admin { background: rgba(233,69,96,0.15); color: #e94560; }
        .badge-user  { background: rgba(255,255,255,0.08); color: rgba(255,255,255,0.4); }
        .btn-logout { padding: 7px 16px; background: transparent; border: 1px solid rgba(255,255,255,0.15); border-radius: 6px; color: rgba(255,255,255,0.5); text-decoration: none; font-size: 12px; font-weight: 600; }
        .btn-logout:hover { border-color: #e94560; color: #e94560; }
        .container { max-width: 1000px; margin: 0 auto; padding: 40px 20px; }
        .page-header { margin-bottom: 28px; padding-bottom: 20px; border-bottom: 1px solid #e0e0db; }
        .page-header h1 { font-size: 22px; font-weight: 700; }
        .page-header p { font-size: 13px; color: #555; margin-top: 4px; }
        .card { background: #fff; border-radius: 12px; padding: 28px; margin-bottom: 20px; border: 1px solid #ebebeb; }
        .card-title { font-size: 11px; font-weight: 800; text-transform: uppercase; letter-spacing: 1.2px; color: #414141; margin-bottom: 18px; }
        .form-row { display: flex; gap: 12px; align-items: flex-end; flex-wrap: wrap; }
        .form-row input { flex: 1; min-width: 130px; padding: 10px 14px; border: 1.5px solid #ebebeb; border-radius: 8px; font-size: 13px; outline: none; background: #fafafa; }
        .form-row input:focus { border-color: #1a1a1a; }
        .btn-primary { padding: 10px 22px; background: #1a1a1a; border: none; border-radius: 8px; color: #fff; font-size: 13px; font-weight: 700; cursor: pointer; white-space: nowrap; }
        .btn-primary:hover { background: #e94560; }
        .btn-secondary { padding: 10px 22px; background: transparent; border: 1.5px solid #ebebeb; border-radius: 8px; color: #666; font-size: 13px; font-weight: 600; cursor: pointer; white-space: nowrap; }
        .btn-secondary:hover { border-color: #1a1a1a; color: #1a1a1a; }
        table { width: 100%; border-collapse: collapse; }
        th { text-align: left; padding: 10px 16px; font-size: 11px; font-weight: 800; text-transform: uppercase; letter-spacing: 1px; color: #292929; border-bottom: 1px solid #f0f0eb; }
        td { padding: 14px 16px; font-size: 13px; color: #494949; border-bottom: 1px solid #f5f5f0; }
        tr:last-child td { border-bottom: none; }
        tbody tr:hover td { background: #fafaf8; }
        .id-cell { color: #ccc; font-size: 12px; font-weight: 600; }
        .prix-cell { font-weight: 700; color: #1a1a1a; }
        .btn-edit { padding: 5px 12px; background: transparent; border: 1px solid #ebebeb; border-radius: 5px; color: #666; text-decoration: none; font-size: 12px; font-weight: 600; margin-right: 6px; }
        .btn-edit:hover { border-color: #f59e0b; color: #f59e0b; }
        .btn-delete { padding: 5px 12px; background: transparent; border: 1px solid #ebebeb; border-radius: 5px; color: #666; text-decoration: none; font-size: 12px; font-weight: 600; }
        .btn-delete:hover { border-color: #e94560; color: #e94560; }
        .readonly { font-size: 11px; color: #ccc; font-style: italic; }
    </style>
</head>
<body>

<nav>
    <div class="brand">Gestion<span>Produits</span></div>
    <div class="nav-right">
        <span class="nav-user">Connecté : <strong>${utilisateur.login}</strong></span>
        <c:choose>
            <c:when test="${utilisateur.role == 'ADMIN'}">
                <span class="badge badge-admin">Admin</span>
            </c:when>
            <c:otherwise>
                <span class="badge badge-user">User</span>
            </c:otherwise>
        </c:choose>
        <a href="${pageContext.request.contextPath}/app/logout" class="btn-logout">Déconnexion</a>
    </div>
</nav>

<div class="container">

    <div class="page-header">
        <h1>Produits</h1>
        <p>Gestion du catalogue des produits</p>
    </div>

    <c:if test="${utilisateur.role == 'ADMIN'}">
        <div class="card">
            <div class="card-title">
                <c:choose>
                    <c:when test="${produitEdit != null}">Modifier le produit</c:when>
                    <c:otherwise>Ajouter un produit</c:otherwise>
                </c:choose>
            </div>
            <form action="${pageContext.request.contextPath}/app/${produitEdit != null ? 'updateProduit' : 'addProduit'}" method="post">
                <input type="hidden" name="idProduit" value="${produitEdit.idProduit}" />
                <div class="form-row">
                    <input type="text"   name="nom"         placeholder="Nom"         value="${produitEdit.nom}"         required />
                    <input type="text"   name="description" placeholder="Description" value="${produitEdit.description}" required />
                    <input type="number" name="prix"        placeholder="Prix (DH)"   value="${produitEdit.prix}"        step="0.01" required />
                    <button type="submit" class="btn-primary">
                        <c:choose>
                            <c:when test="${produitEdit != null}">Modifier</c:when>
                            <c:otherwise>Ajouter</c:otherwise>
                        </c:choose>
                    </button>
                </div>
            </form>
        </div>
    </c:if>

    <div class="card">
        <div class="card-title">Recherche</div>
        <form action="${pageContext.request.contextPath}/app/listProduits" method="get">
            <div class="form-row">
                <input type="text" name="idProduit" placeholder="Rechercher par ID..." />
                <button type="submit" class="btn-secondary">Rechercher</button>
                <button type="button" class="btn-secondary"
                        onclick="window.location='${pageContext.request.contextPath}/app/listProduits'">
                    Tout afficher
                </button>
            </div>
        </form>
    </div>

    <div class="card">
        <div class="card-title">Liste des produits</div>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nom</th>
                    <th>Description</th>
                    <th>Prix</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="p" items="${listeProduits}">
                    <tr>
                        <td class="id-cell">${p.idProduit}</td>
                        <td>${p.nom}</td>
                        <td>${p.description}</td>
                        <td class="prix-cell">${p.prix} DH</td>
                        <td>
                            <c:choose>
                                <c:when test="${utilisateur.role == 'ADMIN'}">
                                    <a href="${pageContext.request.contextPath}/app/editProduit?id=${p.idProduit}" class="btn-edit">Modifier</a>
                                    <a href="${pageContext.request.contextPath}/app/deleteProduit?id=${p.idProduit}" class="btn-delete"
                                       onclick="return confirm('Supprimer ce produit ?');">Supprimer</a>
                                </c:when>
                                <c:otherwise>
                                    <span class="readonly">Lecture seule</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

</div>
</body>
</html>