<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="icon" type="image/x-icon" href="../assets/Logo/SmallLogo.png">
    <link rel="stylesheet" href="../style/loginAdmin.css">
    <title>Login Admin -  TicketMate</title>
</head>
<body>


<section class="LoginForm" align="center">
    <h1 class="title">Admin </h1>

    <img src="../assets/Logo/logo-no-background.png" class='FullLogoImg'/>
    <h1 class='subTitleImg'>Turning travel passions <br/> into travel plans ! </h1>

    <div class="box">
        <h1 class="permanentTitle">Login</h1>
        <form method="POST" action="/LoginAdmin">
            <input class="Input"   name="email_client" placeholder='Enter Your Email ...'/>
            <br/>
            <input class="InputP" type="Password" name="Password" placeholder='Enter Your Password ...'/>
            <br/>
            <tr>
                <td >
                    <input class="Checkb" type="checkbox"/> <label >Remember Me</label>

                </td>
            </tr>
            <tr>
                <div class="Buttons" >
                    <button type="submit" class="ButtonSignIn ">SIGN IN</button>
                </div>
            </tr>
<%--            <tr>--%>
<%--                <td><h2 class="RegMessage">Don't Have an account ? <a href="/Register" class="Link">Register Here !</a></h2></td>--%>
                <td><h4>${output==null?"":output}</h4></td>
<%--            </tr>--%>
        </form>

    </div>
</section>
</body>
</html>
<script>
    window.history.pushState(null, null, window.location.href);
    window.onpopstate = function () {
        window.history.go(1);
    };
</script>