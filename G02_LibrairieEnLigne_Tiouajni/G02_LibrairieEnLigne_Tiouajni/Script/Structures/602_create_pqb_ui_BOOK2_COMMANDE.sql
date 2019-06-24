--------------------------------------------------------
--  DDL for Package Body UI_COMMANDE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "G02_BOOK"."UI_COMMANDE" AS 
procedure COMMANDE_ARTICLES(numcommande IN CONTENIR.CMD_NUM%TYPE) IS
cli CLIENT%ROWTYPE;
art ARTICLE%ROWTYPE;
c owa_cookie.cookie :=owa_cookie.get('CLI_ID');
numCli NUMBER := c.vals(1);
CURSOR c1 IS 
    SELECT 
        * 
    from 
         CONTENIR
    WHERE CMD_NUM = numcommande;

BEGIN
HTP.htmlopen;
HTP.headopen;
HTP.title('Détail commande ');
HTP.print('<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" 
                crossorigin="anonymous">');
HTP.print('<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">');
HTP.print('<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>');
HTP.print(' <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>');
HTP.print('<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>');
HTP.headclose;
--htp.print('<div class="col-md-2">');
htp.print('<br>');
--htp.print('<div class="col-md-4">');
cli := DB_CLIENT.getBYID(numCli);
DB_COMMANDE.UPDATECOMMANDE(numCli);
htp.print('<div class="container">');
htp.print('<div class="jumbotron">');
htp.print('<h2> détails commande numéro '|| numcommande || '</h2>');

htp.print('<table class="table table-hover" style="text-align: center">
  <thead>
    <tr>
      <th scope="col">Name</th>
      <th scope="col">Language</th>
      <th scope="col">Unit Price</th>
       <th scope="col">Quantity</th>
        <th scope="col">Price</th>
    </tr>
  </thead>
  <tbody>');
FOR  cont IN c1
	LOOP
        art := DB_ARTICLE.GETBYID(cont.ART_NUM);
        htp.print('    <tr>
      <td scope="row">'|| art.ART_NOM ||'</td>
      <td scope="row">'|| art.ART_LANGUE||'</td>
      <td scope="row">'|| art.ART_PRIX_HT ||'</td>
      <td scope="row">'|| cont.CONT_QTECOM ||'</td>
      <td scope="row">'|| cont.CONT_QTECOM * art.ART_PRIX_HT ||'</td>

    </tr>');

	END LOOP;

htp.print('<hr>');

htp.print('<tr><td colspan=4></td><td ><h2>Total : '||DB_COMMANDE.GETBYID(numcommande).CMD_PRIX_TTC ||' €<h2></td></tr>');
htp.print('<td colspan=4></td><td><a href="DB_COMMANDE.pay?num='||numcommande||'"><button  type="submit" class="btn btn-outline-primary" >Paye</button></td>');

htp.print('</tbody>
</div>
            </div>');
htp.print('</div>');


END COMMANDE_ARTICLES;






procedure DETAIL_COMMANDE IS
is_val VARCHAR2(100);
cli CLIENT%ROWTYPE;
c owa_cookie.cookie :=owa_cookie.get('CLI_ID');
numCli NUMBER := c.vals(1);
CURSOR c1 IS 
    SELECT 
        * 
    from 
         COMMANDE 
    WHERE CLI_ID = numCli
    AND
        CMD_REGLE = 1;


BEGIN
DB_COMMANDE.UPDATECOMMANDE(numCli);
cli := DB_CLIENT.getBYID(numCli);

HTP.htmlopen;
HTP.headopen;
HTP.title('Détail commande ');
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
htp.print('<h2> Vos commandes '|| cli.CLI_PRENOM|| '</h2>');
htp.print('<hr>');
htp.print('<table class="table table-hover">
  <thead>
    <tr>
      <th scope="col">Date</th>
      <th scope="col">Payment mode</th>
      <th scope="col">Payment total TTC (€)</th>
       <th scope="col">Validation</th>
        <th scope="col"></th>
    </tr>
  </thead>
  <tbody>');
FOR  commande_rec IN c1
	LOOP
        IF commande_rec.CMD_REGLE = 1 THEN
          is_val := 'Payé';
        ELSE
          is_val := 'Non Payé';  
           END IF;
        htp.print('    <tr>
      <th scope="row">'|| commande_rec.CMD_DATE  ||'</th>
      <td>'||commande_rec.PAY_MODE||'</td>
      <td>'||commande_rec.CMD_PRIX_TTC||'</td>
      <td>'||is_val||'</td>
      <td><a  class="btn btn-outline-primary" href="UI_COMMANDE.COMMANDE_ARTICLES?numcommande='||commande_rec.CMD_NUM ||'" >Details</a></td>
    </tr>');

	END LOOP;

htp.print('<hr>');
htp.print('</div>');
htp.print('</div>');

htp.print('</div>');


END DETAIL_COMMANDE;

END UI_COMMANDE;

/
