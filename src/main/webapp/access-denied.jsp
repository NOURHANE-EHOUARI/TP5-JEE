<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Accès refusé</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', sans-serif; background: #f5f5f0; min-height: 100vh; display: flex; align-items: center; justify-content: center; }
        .card { background: #fff; border-radius: 12px; padding: 50px 40px; text-align: center; max-width: 400px; width: 90%; border: 1px solid #ebebeb; border-top: 4px solid #e94560; }
        h1 { font-size: 20px; font-weight: 700; color: #1a1a1a; margin-bottom: 14px; }
        p { font-size: 13px; color: #aaa; line-height: 1.7; margin-bottom: 4px; }
        a { display: inline-block; margin-top: 28px; padding: 10px 24px; background: #1a1a1a; border-radius: 8px; color: #fff; text-decoration: none; font-size: 13px; font-weight: 600; }
        a:hover { background: #e94560; }
    </style>
</head>
<body>
    <div class="card">
        <h1>Accès refusé</h1>
        <p>Vous n'avez pas les droits nécessaires.</p>
        <p>Seul un <strong style="color:#1a1a1a;">Administrateur</strong> peut effectuer cette action.</p>
        <a href="${pageContext.request.contextPath}/app/listProduits">Retour à la liste</a>
    </div>
</body>
</html>