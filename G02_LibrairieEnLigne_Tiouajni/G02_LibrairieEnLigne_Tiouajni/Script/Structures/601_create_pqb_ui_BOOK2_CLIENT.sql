--------------------------------------------------------
--  DDL for Package Body UI_CLIENT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "G02_BOOK"."UI_CLIENT" AS


PROCEDURE LOGIN AS

BEGIN
HTP.htmlopen;
HTP.headopen;
HTP.title('LOGIN');
HTP.print('<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" 
                crossorigin="anonymous">');
HTP.print('<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">');
  HTP.print('<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>');
 HTP.print(' <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>');
  HTP.print('<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>');
 HTP.headclose;
 HTP.print('<br>');
HTP.print('<div class="container" >');
 htp.print('<div class="jumbotron" style="">');
  htp.print('<div class="container">');

   htp.print('<ul class="nav">');
     htp.print('<li class="nav-item">');
     htp.print('</li>');
     htp.print('</ul>');
     htp.print('</div>');

  HTP.print('<h2>Book Login</h2>');
  HTP.print('<form method="post" action="UI_CLIENT.REDIRECT" class="was-validated" id="formlogin"> ');
    HTP.print('<div class="form-group">');
      HTP.print('<label for="uname">Email:</label>');
      HTP.print('<input type="text" class="form-control" id="email" placeholder="Enter email" name="email" required>');
      HTP.print('<div class="valid-feedback">Valid.</div>');
      HTP.print('<div class="invalid-feedback">Please fill out this field.</div>');
    HTP.print('</div>');
    HTP.print('<div class="form-group">');
      HTP.print('<label for="pwd">Password:</label>');
      HTP.print('<input type="password" class="form-control" id="pwd" placeholder="Enter password" name="pwd" required>');
      HTP.print('<div class="valid-feedback">Valid.</div>');
      HTP.print('<div class="invalid-feedback">Please fill out this field.</div>');
    HTP.print('</div>');
    HTP.print('<div class="form-group form-check">');
      HTP.print('<label class="form-check-label">');
      HTP.print('</label>');
    HTP.print('</div>');
    HTP.print('<button type="submit" class="btn btn-primary">Submit</button>');
  HTP.print('</form>');
HTP.print('</div>');
HTP.print('</div>');

END LOGIN;

Procedure REDIRECT(email IN varchar2,pwd IN varchar2) IS
idCl Number;
BEGIN
    idCl := DB_CLIENT.VERIFY_USER(email, pwd);
    IF idCl = 0 then
        owa_util.redirect_url('UI_CLIENT.LOGIN');
        ELSE
        owa_cookie.send('CLI_ID',idCL);
        owa_util.redirect_url('UI_ARTICLE.CATALOGUE');

        END IF;
    EXCEPTION
        WHEN others THEN
                    owa_util.redirect_url('UI_CLIENT.LOGIN');

end REDIRECT;


Procedure DCONNECT AS
c owa_cookie.cookie :=owa_cookie.get('CLI_ID');
numCli NUMBER := c.vals(1);
BEGIN
    owa_cookie.remove('CLI_ID',numCli,NULL);
    owa_util.redirect_url('UI_CLIENT.LOGIN');

END DCONNECT;
END UI_CLIENT;

/
