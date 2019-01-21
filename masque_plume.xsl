<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:output
        method="html"
        doctype-system="about:legacy-compat"
        encoding="UTF-8"
        indent="yes" />
    
    <xsl:template match="/">
        <html>
            <head>
                <meta charset="utf-8"/>
                <title>TP XSLT par Grégory Grévin et Benjamin Nicoud</title>
                <!-- Nous pouvons associer un fichier CSS -->
                <link type="text/css" rel="stylesheet" href="style.css"/>
            </head>
            <body>
                <h1 class="MainTitle"><span>TP XSLT réalisé par Grégory Grévin et Benjamin Nicoud</span></h1>
                <!-- On boucle sur toutes les émissions -->
                <xsl:for-each select="masque_plume/emissions/emission">
                    <div class="dvEmission">
                        <h2 class="hEmission">Emission</h2>
                        <li>
                            <!-- On aurait pu faire des templates comme nous l'avons fait après mais pour voir les deux versions, nous avons jugé utile de laisser ainsi -->
                            <ul>Date de l'émission : <xsl:value-of select="@date"/></ul>
                            <ul>Type de l'émission : <xsl:value-of select="@type"/></ul>
                            <ul>Titre de l'émission : <xsl:value-of select="titre"/></ul>
                            <ul>Sous-titre de l'émission :<xsl:value-of select="sous-titre"/></ul>  
                            <ul>Animateur de l'émission : <xsl:call-template name="afficherAnimateur"></xsl:call-template></ul> 
                            <ul>Critiques de l'émission : <xsl:call-template name="afficherCritique"/> Organes de presse respectifs : <xsl:call-template name="afficherOrganeDePresse"/>
                            </ul>
                        </li>
                    </div>
                    
                    <div>
                    <!-- On va récupérer le nom du 3ème élément de "emissions" ainsi on récupère livres et films -->
                    <h2><xsl:value-of select="name(*[3])"/></h2>
                        
                    <!-- On choisit l'intégralité du contenu de "livres" -->
                    <xsl:for-each select="livres/*">
                        <ul>
                            <li>
                                <!-- Dans le code HTML nous ne faisons qu'appeler les templates définis après -->
                                <h3> Titre du livre : <xsl:call-template name="afficherTitre"/></h3>
                                
                                <!-- On teste s'il existe un sous-titre -->
                                <xsl:if test="sous-titre != ''">
                                    <h4>
                                        Sous-titre du livre: <xsl:call-template name="afficherSousTitre"/>
                                    </h4>
                                </xsl:if>
                            </li>
                            <ul>
                                <!-- Paramètre ici non nécessaire car nous sommes dans livres et nous n'aurons pas de recoupement avec les autres types d'artistes (réalisateurs, scénaristes) -->
                                Auteur : <xsl:call-template name="afficherArtiste"/>
                            </ul>
                            <ul>
                                <!-- Biographie non fonctionnelle mais devrait ressembler à un appel de la sorte -->
                                Biographie : <xsl:call-template name="afficherBiographie">
                                    <xsl:with-param name="biographie"></xsl:with-param>
                                </xsl:call-template>
                            </ul>
                            <ul>
                                Editeur : <xsl:call-template name="afficherEditeur"/>
                            </ul>
                            <ul>
                                Date de parution : <xsl:call-template name="afficherDate"/>
                            </ul>
                            <ul>
                                Nombre de pages : <xsl:call-template name="afficherNbpages"/>
                            </ul>
                            <ul>
                                Numéro ISBN : <xsl:call-template name="afficherISBN"/>
                            </ul>
                            <ul>
                                Prix éditeur : <xsl:call-template name="afficherPrix"/>
                            </ul>
                            <p>
                                Résumé du livre : <xsl:call-template name="afficherResume"/>
                            </p>
                            <ul>
                                Personnages principaux : <xsl:call-template name="afficherPersonnage"/>
                            </ul>
                        </ul>
                    </xsl:for-each>
                    </div>
                    
                    <div class="dvFilms">
                        <xsl:for-each select="films/*">
                            <ul>
                                <li>
                                    <h3 class="hFilms">Titre du film : <xsl:call-template name="afficherTitre"/></h3>
                                    
                                    <xsl:if test="sous-titre != ''">
                                        <h4>
                                            Sous-titre du livre: <xsl:call-template name="afficherSousTitre"/>
                                        </h4>
                                    </xsl:if>
                                </li>
                                <ul>
                                    <!-- Il faut spécifier quel paramètre il faut prendre vu que afficherArtiste comprends les auteurs, réalisateurs et scénaristes -->
                                    Réalisateur : <xsl:call-template name="afficherArtiste">
                                        <xsl:with-param name="scenariste"/>
                                    </xsl:call-template>
                                </ul>
                                <ul>
                                    Scénaristes : <xsl:call-template name="afficherArtiste">
                                        <xsl:with-param name="realisateur"/>
                                    </xsl:call-template>
                                </ul>
                                <ul>
                                    Année de production : <xsl:call-template name="afficherAnneeProd"/>
                                </ul>
                                <ul>
                                    Nationalitées : <xsl:call-template name="afficherNationnalite"/>
                                </ul>
                                <ul>
                                    Durée totale : <xsl:call-template name="afficherDuree"/>
                                </ul>
                                <ul>
                                    Date de sortie : <xsl:call-template name="afficherDateSortie"/>
                                </ul>
                                <p>
                                    Synopsis : <xsl:call-template name="afficherSynopsis"/>
                                </p>
                                <ul>
                                    Casting : <xsl:call-template name="afficherCasting"/>
                                </ul>
                                <hr></hr>
                            </ul>
                        </xsl:for-each>
                    </div>
                </xsl:for-each>
                
                <div>
                    <hr></hr>
                    <h2>Annexe</h2>
                    <ul>
                        <xsl:for-each select="masque_plume/artistes/*">
                            <xsl:variable name="paysArtiste" select="@pays"/>
                                  <xsl:if test="biographie != ''">
                                      <xsl:value-of select="prenom"/>&#160;<xsl:value-of select="nom"/>
                                      <ul>
                                          Sexe : <xsl:value-of select="@sexe"/>
                                          Nationnalités : <xsl:value-of select="/masque_plume/nationalites/pays[@code=$paysArtiste]"/>
                                          <!-- Pour compenser la biographie qui ne marche pas :( -->
                                          <p>Biographie : <xsl:value-of select="biographie"/></p>
                                      </ul>
                                  </xsl:if>
                        </xsl:for-each>
                    </ul>
                </div>
                
            </body>
        </html>    
    </xsl:template>
    
    
    
    <xsl:template name="afficherAnimateur">
        <xsl:value-of select="//animateur/nom" />&#160;
        <xsl:value-of select="//animateur/prenom" />         
    </xsl:template>
    
    <xsl:template name="afficherCritique">
        <xsl:for-each select="id(@critiques)">
           <ul>
               <xsl:variable name="crit" select="@id"></xsl:variable>
                <xsl:value-of select="/masque_plume/critiques/critique[@id=$crit]/prenom"/>&#160;
                <xsl:value-of select="/masque_plume/critiques/critique[@id=$crit]/nom"/>
           </ul>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="afficherOrganeDePresse">
        <xsl:for-each select="id(@critiques)">
            <ul>
                <!-- On définit une variable pour récupérer l'attribut id -->
                <xsl:variable name="crit" select="@id"></xsl:variable>
                <xsl:variable name="org_presse" select="/masque_plume/critiques/critique[@id=$crit]/@organe_de_presse"/>
                <xsl:value-of select="/masque_plume/organes_de_presse/organe_de_presse[@id=$org_presse]/nom"/>
            </ul>
        </xsl:for-each>
    </xsl:template>
    
    <!-- Template pour le titre des livres et films -->
    <xsl:template name="afficherTitre">
        <xsl:value-of select="titre"/> 
    </xsl:template>
    
    <!-- Template pour les sous-titres des livres et films -->
    <xsl:template name="afficherSousTitre">
        <xsl:value-of select="sous-titre"/> 
    </xsl:template>
    
    <!-- Template pour afficher les artistes, on évite la redondance en appelant le template plusieurs fois -->
    <xsl:template name="afficherArtiste">
        <xsl:param name="auteur" select="@auteur"/>
        <xsl:param name="realisateur" select="casting/@realisateurs"/>
        <xsl:param name="scenariste" select="casting/@scenaristes"/>
            <xsl:value-of select="/masque_plume/artistes/artiste[@id=$auteur]/prenom"/>&#160;
            <xsl:value-of select="/masque_plume/artistes/artiste[@id=$auteur]/nom"/>
            
            <xsl:for-each select="id($realisateur)">
                <xsl:value-of select="prenom"/>&#160;
                <xsl:value-of select="nom"/>
            </xsl:for-each>
            
            <xsl:for-each select="id($scenariste)">
                <xsl:value-of select="prenom"/>&#160;
                <xsl:value-of select="nom"/>&#160;
            </xsl:for-each>
        <xsl:call-template name="afficherBiographie">
            <xsl:with-param name="biographie"/>
        </xsl:call-template>
        
    </xsl:template>
    
    <!-- Fonction de biographie, qui ne fonctionne pas mais nous n'avons pas compris pourquoi -->
    <xsl:template name="afficherBiographie">
        <!-- On établit en paramètre toutes les biographies grâces aux ID -->
        <xsl:param name="biographie" select="/masque_plume/artistes/artiste[@id]/biographie"/>
        <xsl:choose>
            <!-- On teste si l'artiste possède une biographie -->
            <xsl:when test="$biographie != ''">
                <!-- Si l'artiste possède une biographie alors on doit afficher au survol, son sexe et ses nationnalité -->
                <a href="#{$biographie}" title="Sexe : {/masque_plume/artistes/artiste[@id]/@sexe}, Nationalité : {/masque_plume/artistes/artiste[@id]/@pays}"/>
            </xsl:when>
            <!-- Sinon on l'affiche dans un li sans pop-up -->
            <xsl:otherwise>
                <li title="Sexe : {/masque_plume/artistes/artiste[@id]/@sexe}, Nationalité : {/masque_plume/artistes/artiste[@id]/@pays}"></li>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="afficherEditeur">
        <xsl:param name="edit" select="@editeur"/>
        <xsl:value-of select="/masque_plume/editeurs/editeur[@id=$edit]/nom"/>
        &#160;
        <xsl:variable name="siteweb" select="/masque_plume/editeurs/editeur[@id=$edit]/@site_web"/>
        <a href="{$siteweb}"><xsl:value-of select="$siteweb"/> </a>
    </xsl:template>
    
    <xsl:template name="afficherDate">
        <xsl:value-of select="@date_parution"/>
    </xsl:template>
    
    <xsl:template name="afficherNbpages">
        <xsl:value-of select="@nb_pages"/>
    </xsl:template>
    
    <xsl:template name="afficherISBN">
        <xsl:value-of select="@ISBN"/>
    </xsl:template>
    
    <xsl:template name="afficherPrix">
        <xsl:value-of select="@prix"/>
    </xsl:template>
    
    <xsl:template name="afficherResume">
        <xsl:value-of select="resume"/>
    </xsl:template>
    
    <xsl:template name="afficherPersonnage">
        <xsl:for-each select="personnages/personnage">
            <xsl:value-of select="text()"/>&#160;,
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="afficherAnneeProd">
        <xsl:value-of select="@annee_production"/>
    </xsl:template>
    
    <xsl:template name="afficherNationnalite">
        <xsl:variable name="paysfilm" select="@pays"/>
        <xsl:value-of select="/masque_plume/nationalites/pays[@code=$paysfilm]"/>
    </xsl:template>
    
    <xsl:template name="afficherDuree">
        <xsl:value-of select="@duree"/>
    </xsl:template>
    
    <xsl:template name="afficherDateSortie">
        <xsl:value-of select="@date_sortie"/>
    </xsl:template>
    
    <xsl:template name="afficherSynopsis">
        <xsl:value-of select="synopsis"/>
    </xsl:template>
    
    <xsl:template name="afficherCasting">
        <xsl:for-each select="personnages/*">
            <li>
            <xsl:variable name="acteur" select="@incarne_par"/>
            <xsl:value-of select="/masque_plume/artistes/artiste[@id=$acteur]/prenom"/>&#160;
            <xsl:value-of select="/masque_plume/artistes/artiste[@id=$acteur]/nom"/>&#160;incarne
            <!-- On affiche le contenu text de l'élément "personnage" -->
            <xsl:value-of select="text()"/>
            </li>
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>