<%-- 
    Document   : gameBoard
    Created on : Jun 15, 2018, 10:43:08 AM
    Author     : Keller Martin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page contentType="text/html" pageEncoding="windows-1252"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">  
        <link href="${pageContext.request.contextPath}/css/llamawords.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=PT+Serif" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
        <title>Game Board</title>
    </head>
    <body>
        <div class="container">
            <h1 class="text-center">Llama Words</h1>
            <hr/>
            <div class="navbar" style="text-align: center;">
                <ul class="nav navbar-nav" style="display: inline-block; float: none; vertical-align: top;">
                    <li ><a href="${pageContext.request.contextPath}/">Home</a></li>
                    <li style="margin-top: 4%">|</li>
                    <li class="active"><a href="${pageContext.request.contextPath}/gameboard">Current Board</a></li>
                    <li style="margin-top: 4%">|</li>
                    <li ><a href="${pageContext.request.contextPath}/highscores">High Scores</a></li>
                    <li style="margin-top: 4%">|</li>
                    <li style="margin-top: 4%; margin-left: 13px">Pts: ${board.currentScore.points}</li>
                </ul>    
            </div>
            <hr/>
            <div class="col-xs-6 col-xs-offset-3">

                <!--${board.chosenWord.word}-->
                <div id="wordToGuess">
                    <c:if test="${gameIsOver}">
                        <c:forEach var="letter" items="${board.chosenWord.letters}">
                            <c:out value="${letter}"/>
                        </c:forEach> 
                    </c:if>
                    <c:if test="${!gameIsOver}">
                        <c:forEach var="guess" items="${board.chosenWord.guesses}">
                            <c:out value="${guess}"/>
                        </c:forEach> 
                    </c:if>
                </div>
            </div>

            <!--Smiley and Frowny Faces Go Here!-->

            <hr class="col-xs-5 col-xs-offset-4" />
            <div class="col-xs-6 col-xs-offset-3">
                <c:set var = "lives" value="${board.livesLeft}"/>
                <c:if test="${lives == 5}">
                    <i class="far fa-smile fa-3x" style="color: #2fad0a"></i>
                    <i class="far fa-smile fa-3x" style="color: #2fad0a"></i>
                    <i class="far fa-smile fa-3x" style="color: #2fad0a"></i>
                    <i class="far fa-smile fa-3x" style="color: #2fad0a"></i>
                    <i class="far fa-smile fa-3x" style="color: #2fad0a"></i>
                </c:if>
                <c:if test="${lives == 4}">
                    <i class="far fa-frown fa-3x" style="color: #cc1804"></i>
                    <i class="far fa-smile fa-3x" style="color: #2fad0a"></i>
                    <i class="far fa-smile fa-3x" style="color: #2fad0a"></i>
                    <i class="far fa-smile fa-3x" style="color: #2fad0a"></i>
                    <i class="far fa-smile fa-3x" style="color: #2fad0a"></i>
                </c:if>
                <c:if test="${lives == 3}">
                    <i class="far fa-frown fa-3x" style="color: #cc1804"></i>
                    <i class="far fa-frown fa-3x" style="color: #cc1804"></i>
                    <i class="far fa-smile fa-3x" style="color: #2fad0a"></i>
                    <i class="far fa-smile fa-3x" style="color: #2fad0a"></i>
                    <i class="far fa-smile fa-3x" style="color: #2fad0a"></i>
                </c:if>
                <c:if test="${lives == 2}">
                    <i class="far fa-frown fa-3x" style="color: #cc1804"></i>
                    <i class="far fa-frown fa-3x" style="color: #cc1804"></i>
                    <i class="far fa-frown fa-3x" style="color: #cc1804"></i>
                    <i class="far fa-smile fa-3x" style="color: #2fad0a"></i>
                    <i class="far fa-smile fa-3x" style="color: #2fad0a"></i>
                </c:if>
                <c:if test="${lives == 1}">
                    <i class="far fa-frown fa-3x" style="color: #cc1804"></i>
                    <i class="far fa-frown fa-3x" style="color: #cc1804"></i>
                    <i class="far fa-frown fa-3x" style="color: #cc1804"></i>
                    <i class="far fa-frown fa-3x" style="color: #cc1804"></i>
                    <i class="far fa-smile fa-3x" style="color: #2fad0a"></i>
                </c:if>
                <c:if test="${lives <= 0}">
                    <i class="far fa-frown fa-3x" style="color: #cc1804"></i>
                    <i class="far fa-frown fa-3x" style="color: #cc1804"></i>
                    <i class="far fa-frown fa-3x" style="color: #cc1804"></i>
                    <i class="far fa-frown fa-3x" style="color: #cc1804"></i>
                    <i class="far fa-frown fa-3x" style="color: #cc1804"></i>
                </c:if>

            </div>

            <!--Multiple if statements deciding what goes in the bottom section-->

            <hr class="col-xs-5 col-xs-offset-4" />
            <div class="col-xs-6 col-xs-offset-3">

                <!--If game is still going, check the following conditions-->



                <c:if test="${!gameIsOver}">


                    <!--If word is complete, display victory and offer another word-->

                    <c:if test="${wordIsComplete}">
                        <p>You Win!!!</p><br/>
                        <p>+ ${board.chosenWord.points} pts</p>
                        <a href="${pageContext.request.contextPath}/getNewWord">
                            <button class="btn btn-default" id="newWordButton">Get a New Word?</button>
                        </a>
                    </c:if>

                    <!--If board is null, start new board-->

                    <c:if test="${newGame}">
                        <c:forEach var="letter" items="${board.ALL_LETTERS}">
                            <a href="${pageContext.request.contextPath}/letterPicked/${letter}">
                                <button class="btn btn-default" id="letterButton" name="letterPicked">
                                    <c:out value="${letter}"/>
                                </button>
                            </a>
                        </c:forEach>
                    </c:if>

                    <!--If board is not null, print buttons by whether or not the letters have been chosen-->

                    <%--<c:if test="${!newGame}">
                        <c:if test="${!wordIsComplete}">
                            <c:forEach var="letter" items="${board.ALL_LETTERS}">
                            <c:set var="disable" value=""></c:set>
                            <c:forEach var="pickedLetter" items="${board.chosenLetters}">
                            
                            <c:choose>
                                <c:when test=>

                                </c:when>
                            </c:choose>





                            
                                
                                    <c:if test="${letter == pickedLetter}">
                                        <button disabled class="btn btn-default" id="letterButtonDisabled" name="pickedLetter">
                                            <c:out value="${letter}"/>
                                        </button>
                                    </c:if>
                                    <c:if test="${letter != pickedLetter}">
                                        <a href="${pageContext.request.contextPath}/letterPicked/${letter}">
                                            <button class="btn btn-default" id="letterButton" name="letterPicked">
                                                <c:out value="${letter}"/>
                                            </button>
                                        </a>
                                    </c:if>
                                </c:forEach>
                            </c:forEach>
                        </c:if>
                    </c:if>--%>
                    <c:forEach var="letter" items="${board.ALL_LETTERS}">
                        <a href="${pageContext.request.contextPath}/letterPicked/${letter}">
                            <button class="btn btn-default" id="letterButton" name="letterPicked">
                                <c:out value="${letter}"/>
                            </button>
                        </a>
                    </c:forEach>
                </c:if>

                <c:if test="${gameIsOver}">
                    <c:if test="${isInTopThree}">
                        <c:set var="place" value="${place}"/>
                        <c:choose>
                            <c:when test="${place == 0}">
                                <i class="fas fa-trophy fa-3x first"></i>
                                Game Over
                                <i class="fas fa-trophy fa-3x first"></i>
                                <br/>
                                <p>Good news - you got a total of ${board.currentScore.points} and came in FIRST!</p><br/>
                            </c:when>
                            <c:when test="${place == 1}">
                                <i class="fas fa-trophy fa-3x second"></i>
                                Game Over
                                <i class="fas fa-trophy fa-3x second"></i>
                                <br/>
                                <p>Good news - you got a total of ${board.currentScore.points} and came in SECOND!</p><br/>
                            </c:when>
                            <c:when test="${place == 2}">
                                <i class="fas fa-trophy fa-3x third"></i>
                                Game Over
                                <i class="fas fa-trophy fa-3x third"></i>
                                <br/>
                                <p>Good news - you got a total of ${board.currentScore.points} and came in THIRD!</p><br/>
                            </c:when>
                        </c:choose>
                        <form action="${pageContext.request.contextPath}/addNewHighScore" method="POST">
                            <div class="form-group">
                                <label for="name">What's your name, genius?!</label>
                                <input type='text' class="form-control" name="name" placeholder="Your Name Here"/>
                            </div>
                            <button type="submit" class="btn btn-default">Submit Score and Start New Game</button>
                        </form>
                    </c:if>
                    <c:if test="${!isInTopThree}">
                        <p>Too bad.</p><br/>
                        <p>You got a total of ${board.currentScore.points} pts</p><br/>
                        <p>but you needed at least ${third.points} pts to make a top score.</p><br/>
                        <a href="${pageContext.request.contextPath}/tryAgain">
                            <button class="btn btn-default" id="tryAgain">
                                Try Again?
                            </button>
                        </a>
                    </c:if>
                </c:if>

            </div>
        </div>
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="${pageContext.request.contextPath}/js/jquery-3.1.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>

    </body>
</html>
