package entities;

import jakarta.persistence.*;

@Entity
@Table(name = "utilisateurs")
public class Utilisateur {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "login", nullable = false, unique = true)
    private String login;

    @Column(name = "password", nullable = false)
    private String password;

    @Column(name = "role", nullable = false)
    private String role; // "ADMIN" ou "USER"

    public Utilisateur() {}

    public Long getId()                   { return id; }
    public void setId(Long id)            { this.id = id; }
    public String getLogin()              { return login; }
    public void setLogin(String login)    { this.login = login; }
    public String getPassword()           { return password; }
    public void setPassword(String p)     { this.password = p; }
    public String getRole()               { return role; }
    public void setRole(String role)      { this.role = role; }
}