<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <link rel="stylesheet" href="style/register.css">
    <title>Register - TicketMate</title>
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
    <h2 class="subt"><b>Registering on TICKETMATE</b></h2>

    <img src="assets/Logo/logo-no-background.png"  class='FullLogoImg'/>
    <h1 class='subTitleImg'>Turning travel passions <br/> into travel plans ! </h1>

    <div class="box">
        <h1 class="permanentTitle">Register</h1>
        <form action="/users/save" method="POST" enctype="multipart/form-data">
            <input class="Input"  type="text" name="NomClient" placeholder='Enter Your Full Name ...' required/>
            <input class="Input"  type="email" name="EmailClient" placeholder='Enter Your Email ...' required/>
            <input class="Input" type="password" name="Password" placeholder='Enter Your Password ...' required/>
            <input class="Input" type="text" name="Bio" placeholder='Bio' required/>
            <select class="Input" name="City" required>
                <option value="" disabled selected>Select Your City</option>
                <option>Casablanca</option>
            </select>
            <br/>
            <div style="display: flex;margin-bottom: 5%;">
                <label class="" for="fileb" style="color: #828282">Profile Picture : </label>
                <div class="browse">
                   <input required type="file" id="fileb" class="browse-file" name="image" accept="image/png, image/jpeg" />
                    <div class="browse-file-img">
                        <img src="assets/images/AddImage.png" alt="" />
                    </div>
                </div>
            </div>

            <tr>
                <div class="Buttons" >
                    <button type="submit" class="ButtonSignIn ">SIGN UP</button>
                    <button type="button" class="SignInWGoogle">SIGN IN With Google</button>
                </div>
            </tr>
            <tr>
                <td><h2 class="RegMessage">Already A Member ? <a href="/" class="Link">Login Here !</a></h2></td>
            </tr>
        </form>

    </div>
</section>
</body>
</html>