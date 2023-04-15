<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport"
              content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <link rel="stylesheet" href="style/home.css">

        <title>Home</title>
    </head>
<body>

${FullName==null?"d":FullName}
<h3>${Bio}</h3>
<%--<h3>${FullName}</h3>--%>
</body>
</html>
