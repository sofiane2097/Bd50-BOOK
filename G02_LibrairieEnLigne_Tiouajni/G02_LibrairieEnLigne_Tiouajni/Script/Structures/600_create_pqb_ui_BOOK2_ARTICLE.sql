--------------------------------------------------------
--  DDL for Package Body UI_ARTICLE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "G02_BOOK"."UI_ARTICLE" AS 
procedure CATALOGUE  IS
CURSOR c1 IS 
    SELECT 
        * 
    from 
         ARTICLE 
    ORDER BY ART_NUM;
commande_id NUMBER; 

c owa_cookie.cookie :=owa_cookie.get('CLI_ID');
TVA NUMBER := 1.196;
numCli NUMBER := c.vals(1);
commandeExiste NUMBER := 0;
BEGIN
-- Ajout commande si client n'a pas de commande ouverte
if (DB_COMMANDE.IS_EXISTING(numCli) =0) then 
DB_COMMANDE.insertion (numCli,to_date(sysdate,'DD/MM/RR'),0,'cb',0,0);
end if;
commande_id := DB_COMMANDE.IS_EXISTING(numCli);

HTP.htmlopen;
HTP.headopen;
HTP.title('ADD ARTICLE');
HTP.print('<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" 
                crossorigin="anonymous">');
HTP.print('<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">');
  HTP.print('<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>');
 HTP.print(' <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>');
  HTP.print('<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>');
 HTP.headclose;
--htp.print('<div class="col-md-2">');
htp.print('<br>');

htp.print('<div class="container">');
--htp.print('<div class="col-md-4">');
htp.print('<div class="jumbotron">');

HTP.print('<nav class="navbar navbar-expand-sm bg-light justify-content-center">');
  HTP.print('<ul class="navbar-nav">');
    HTP.print('<li class="nav-item">');
      HTP.print('<a class="nav-link" href="UI_COMMANDE.DETAIL_COMMANDE">Commandes</a>');
    HTP.print('</li>');
    HTP.print('<li class="nav-item">');
      HTP.print('<a class="nav-link" href="UI_COMMANDE.COMMANDE_ARTICLES?numcommande='||commande_id||'">Panier</a>');
    HTP.print('</li>');
    HTP.print('<li class="nav-item">');
      HTP.print('<a class="nav-link"href="UI_CLIENT.DCONNECT">Disconnect</a>');
    HTP.print('</li>');
  HTP.print('</ul>');
HTP.print('</nav>');

htp.print('<div class="container">');


htp.print('<h2>Catalogue</h2>');
htp.print('<hr>');
htp.print('<table class="table table-hover">
  <thead>
    <tr>
      <th scope="col">Nom</th>
      <th scope="col">Année publication</th>
      <th scope="col">Langue</th>
      <th scope="col">Prix (€)</th>
      <th scope="col">Quantity</th>
      <th scope="col">Ajouter</th>

    </tr>
  </thead>
  <tbody>');
FOR  article_rec IN c1
	LOOP

		--htp.print('<h3>Livre</h3>');
      --  htp.print('<h4>'||article_rec.ART_NOM ||' <i class="fas fa-plane"></i> '|| article_rec.ART_ANNEE  ||'<i class="far fa-calendar-alt pull-right"> '||article_rec.ART_langue ||'</i></h4>');
        --DBMS_OUTPUT.PUT_LINE (article_rec.ART_NOM);
        htp.print('<tr>
      <td>'||article_rec.ART_NOM ||'</td>
      <td>'|| article_rec.ART_ANNEE  ||'</td>
      <td>'||article_rec.ART_langue||'</td>
       <td>'||article_rec.ART_PRIX_HT||'€</td>
       <td><input class="form-control" type="number" onchange="updateHref_'||article_rec.ART_NUM ||'()" id="qte_'||article_rec.ART_NUM ||'" name="QTE_COMM" min="1" value="1"></td>
       <td><a id="href_'||article_rec.ART_NUM ||'" href="#"><button  type="submit" class="btn btn-outline-primary" >Ajouter</button></td>
   
    </tr>');
   
--<form method="post" action="DB_CONTENIR.insertion('||article_rec.ART_NUM||', '||commande_id||',1,'||article_rec.ART_PRIX_HT*1.196||',0)" class="was-validated" id="formlogin"></form> 
 htp.print('
             <script type="text/javascript">
             function updateHref_'||article_rec.ART_NUM ||'() {
                var qte= document.getElementById("qte_'||article_rec.ART_NUM ||'").value;
                document.getElementById("href_'||article_rec.ART_NUM ||'").href = "DB_CONTENIR.insertion?ARTNUM='||article_rec.ART_NUM ||'&CMDNUM='||commande_id||'&PRIX_IMM='||article_rec.ART_PRIX_HT*TVA||'&QTE_COMM="+qte+"&PROMO=0"
            }
            updateHref();                
        </script>
    ');
   
	END LOOP;

htp.print('<hr>');
htp.print('</div>');
htp.print('</div>');

htp.print('</div>');


end CATALOGUE;

END UI_ARTICLE;

/
