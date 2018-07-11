package com.tsguild.wordguesser;

import com.tsguild.wordguesser.model.CurrentBoard;
import com.tsguild.wordguesser.model.Score;
import com.tsguild.wordguesser.model.Word;
import com.tsguild.wordguesser.ops.LlamaWordsService;
import java.util.ArrayList;
import java.util.List;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MainController {

    private final LlamaWordsService service;

    @Inject
    public MainController(LlamaWordsService serviceLayer) {
        this.service = serviceLayer;
    }

    @RequestMapping(value = "/gameboard", method = RequestMethod.GET)
    public String displayGameBoard(Model data) {

        CurrentBoard currentBoard = service.getGameState();
        boolean wordIsComplete = false;
        boolean gameIsOver = false;
        boolean isInTopThree = false;
        boolean newGame = false;

        if (service.getGameState() == null) {
            service.startNewGame();
            newGame = true;
        } else if (service.isGameOver()) {
            gameIsOver = true;
            List<Score> topThree = service.getTopThreeScores();
            if (service.isInTopThree(currentBoard.getCurrentScore())) {
                isInTopThree = true;
                Score score = currentBoard.getCurrentScore();
                int i = 0;
                for (Score currentScore : topThree) {
                    if (score.getPoints() > currentScore.getPoints()) {
                        data.addAttribute("place", i);
                        break;
                    } else {
                        i++;
                    }
                }
            } else {
                data.addAttribute("third", topThree.get(2));
            }

        } else {

            Word currentWord = currentBoard.getChosenWord();

            if (currentWord.getIsComplete()) {
                wordIsComplete = true;

            }

        }
        data.addAttribute("board", service.getGameState());
        
        data.addAttribute("newGame", newGame);

        data.addAttribute("gameIsOver", gameIsOver);

        data.addAttribute("wordIsComplete", wordIsComplete);

        data.addAttribute("isInTopThree", isInTopThree);

        return "gameBoard";
    }

    @RequestMapping(value = "/highscores", method = RequestMethod.GET)
    public String displayHighScores(Model data) {
        List<Score> topThree = service.getTopThreeScores();
        CurrentBoard currentBoard = service.getGameState();

        data.addAttribute("first", topThree.get(0));
        data.addAttribute("second", topThree.get(1));
        data.addAttribute("third", topThree.get(2));
        data.addAttribute("board", currentBoard);

        return "highScores";
    }

    @RequestMapping(value = "/letterPicked/{letter}", method = RequestMethod.GET)
    public String checkForCorrectLetter(HttpServletRequest req,
            @PathVariable char letter) {
        boolean correctGuess = false;
        CurrentBoard currentBoard = service.getGameState();
        Word currentWord = currentBoard.getChosenWord();
        currentBoard.getChosenLetters().add(letter);

        correctGuess = currentWord.guessLetter(letter);
        if (!correctGuess) {
            int lives = currentBoard.getLivesLeft();
            currentBoard.setLivesLeft(lives - 1);
        }

        return "redirect:/gameboard";
    }

    @RequestMapping(value = "/getNewWord", method = RequestMethod.GET)
    public String chooseNewWord() {
        CurrentBoard currentBoard = service.getGameState();
        Word currentWord = currentBoard.getChosenWord();
        Score currentScore = currentBoard.getCurrentScore();
        currentScore.addToScore(currentWord);
        currentBoard.setChosenWord(service.chooseNewWord());
        List<Character> newList = new ArrayList<>();
        currentBoard.setChosenLetters(newList);
        return "redirect:/gameboard";
    }

    @RequestMapping(value = "/highscores/{score}", method = RequestMethod.GET)
    public String checkForNewHighScore(HttpServletRequest req,
            @PathVariable int score) {
        Score potentialScore = new Score("???", score);
        boolean isInTopThree = service.isInTopThree(potentialScore);
        if (isInTopThree) {
            service.submitNewScore(potentialScore);
        }

        return "redirect:/highscores";
    }

    @RequestMapping(value = "/addNewHighScore", method = RequestMethod.POST)
    public String addNewHighScore(HttpServletRequest req) {
        String name = req.getParameter("name");
        CurrentBoard currentBoard = service.getGameState();
        Score score = currentBoard.getCurrentScore();
        Score newScore = new Score(name, score.getPoints());
        service.submitNewScore(newScore);
        service.startNewGame();
        return "redirect:/highscores";
    }

    @RequestMapping(value = "/tryAgain", method = RequestMethod.GET)
    public String tryAgain() {
        service.startNewGame();
        return "redirect:/gameboard";
    }

}
