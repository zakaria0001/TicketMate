<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <link rel="stylesheet" href="style/login.css">
    <title>Login -  TicketMate</title>
</head>
<body>
<section class='BackgroundImage'  >
    <img src="assets/Logo/logo-no-background.png"  class='FullLogo'/>
    <h1 class='subTitle'>Turning travel passions <br/> into travel plans ! </h1>
    <div class='Socials'>
        <h1>Follow Us :</h1>

    </div>
</section>

<section class="LoginForm">
    <h1 class="title">Start Planing your next adventure by </h1>
    <h2 class="subt"><b>Login to TICKETMATE</b></h2>

    <img src="assets/Logo/logo-no-background.png"  class='FullLogoImg'/>
    <h1 class='subTitleImg'>Turning travel passions <br/> into travel plans ! </h1>

    <div class="box">
        <h1 class="permanentTitle">Login</h1>
        <form method="POST" action="/Login">
            <input class="Input"  type="email" name="Email" placeholder='Enter Your Email ...'/>
            <br/>
            <input class="InputP" type="password" name="Password" placeholder='Enter Your Password ...'/>
            <br/>
            <tr>
                <td >
                    <input class="Checkb" type="checkbox"/> <label >Remember Me</label>

                    <a class="RecoverPassword" href="">Forgot Your Password ? </a>
                </td>
            </tr>
            <tr>
                <div class="Buttons" >
                    <button type="submit" class="ButtonSignIn ">SIGN IN</button>
                    <button type="button" class="SignInWGoogle">SIGN IN With Google</button>
                </div>
            </tr>
            <tr>
                <td><h2 class="RegMessage">Don't Have an account ? <a href="/Register" class="Link">Register Here !</a></h2></td>
            </tr>
        </form>

    </div>
</section>
</body>
</html>