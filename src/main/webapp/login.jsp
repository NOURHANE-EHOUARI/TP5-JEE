<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Connexion</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', sans-serif; background: #f5f5f0; min-height: 100vh; display: flex; align-items: center; justify-content: center; }
        .wrapper { display: flex; width: 800px; min-height: 480px; border-radius: 16px; overflow: hidden; box-shadow: 0 20px 60px rgba(0,0,0,0.12); }
        .left { flex: 1; background: #1a1a1a; display: flex; flex-direction: column; justify-content: center; padding: 50px 40px; }
        .left .line { width: 40px; height: 3px; background: #e94560; border-radius: 2px; margin-bottom: 24px; }
        .left h1 { font-size: 30px; font-weight: 700; color: #fff; margin-bottom: 12px; }
        .left p { color: rgba(255,255,255,0.35); font-size: 13px; }
        .right { flex: 1; background: #fff; display: flex; flex-direction: column; justify-content: center; padding: 50px 40px; }
        .right h2 { font-size: 20px; font-weight: 700; color: #1a1a1a; margin-bottom: 6px; }
        .right .sub { color: #555; font-size: 13px; margin-bottom: 32px; }
        .form-group { margin-bottom: 18px; }
        .form-group label { display: block; font-size: 11px; font-weight: 800; text-transform: uppercase; letter-spacing: 1.2px; color: #3f3f3f; margin-bottom: 8px; }
        .form-group input { width: 100%; padding: 12px 16px; border: 1.5px solid #ebebeb; border-radius: 8px; font-size: 14px; outline: none; background: #fafafa; }
        .form-group input:focus { border-color: #1a1a1a; background: #fff; }
        .error { background: #fff5f5; border-left: 3px solid #e94560; padding: 10px 14px; border-radius: 6px; color: #c0392b; font-size: 13px; margin-bottom: 20px; }
        .btn { width: 100%; padding: 13px; background: #1a1a1a; border: none; border-radius: 8px; color: #fff; font-size: 14px; font-weight: 700; cursor: pointer; }
        .btn:hover { background: #e94560; }
    </style>
</head>
<body>
    <div class="wrapper">
        <div class="left">
            <div class="line"></div>
            <h1>Gestion des<br/>Produits</h1>
        </div>
        <div class="right">
            <h2>Connexion</h2>
            <p class="sub">Entrez vos identifiants pour continuer</p>

            <c:if test="${not empty erreur}">
                <div class="error">${erreur}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/app/login" method="post" autocomplete="off">
                <div class="form-group">
                    <label>Login</label>
                    <input type="text" name="login" placeholder="Votre login" required />
                </div>
                <div class="form-group">
                    <label>Mot de passe</label>
                    <input type="password" name="password" placeholder="Votre mot de passe" required />
                </div>
                <button type="submit" class="btn">Se connecter</button>
            </form>
        </div>
    </div>
</body>
</html>