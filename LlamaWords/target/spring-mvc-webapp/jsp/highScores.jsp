<%-- 
    Document   : highScores
    Created on : Jun 15, 2018, 10:43:21 AM
    Author     : Keller Martin
--%>

<%@page contentType="text/html" pageEncoding="windows-1252"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet"> 
        <link href="${pageContext.request.contextPath}/css/llamawords.css" rel="stylesheet"> 
        <link href="https://fonts.googleapis.com/css?family=PT+Serif" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
        <title>High Scores</title>
    </head>
    <body>
        <div class="container">
            <h1 class="text-center">Llama Words</h1>
            <hr/>
            <div class="navbar navbar-default" style="text-align: center;">
                <ul class="nav navbar-nav" style="display: inline-block; float: none; vertical-align: top;">
                    <li ><a href="${pageContext.request.contextPath}/">Home</a></li>
                    <li style="margin-top: 4%">|</li>
                    <li ><a href="${pageContext.request.contextPath}/gameboard">Current Board</a></li>
                    <li style="margin-top: 4%">|</li>
                    <li class="active"><a href="${pageContext.request.contextPath}/highscores">High Scores</a></li>
                    <li style="margin-top: 4%">|</li>
                    <li style="margin-top: 4%; margin-left: 13px">Pts: ${board.currentScore.points}</li>
                </ul>    
            </div>
            <hr/>
            <div class="col-xs-6 col-xs-offset-3">
                <h3>Current Top Scores</h3>
                <row class="row">
                    <i class="fas fa-trophy fa-3x first"></i> ${first.name} ${first.points}
                </row>
                <row class="row">
                    <i class="fas fa-trophy fa-3x second"></i> ${second.name} ${second.points}
                </row>
                <row class="row">
                    <i class="fas fa-trophy fa-3x third"></i> ${third.name} ${third.points}
                </row>
            </div>
        </div>
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="${pageContext.request.contextPath}/js/jquery-3.1.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>

    </body>
</html>
