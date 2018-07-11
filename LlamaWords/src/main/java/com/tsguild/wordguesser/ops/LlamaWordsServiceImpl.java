/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsguild.wordguesser.ops;

import com.tsguild.wordguesser.dao.HighScoreDao;
import com.tsguild.wordguesser.dao.WordDao;
import com.tsguild.wordguesser.model.CurrentBoard;
import com.tsguild.wordguesser.model.Score;
import com.tsguild.wordguesser.model.Word;
import java.util.List;
import java.util.Random;
import javax.inject.Inject;

/**
 *
 * @author ahill
 */
public class LlamaWordsServiceImpl implements LlamaWordsService {

    private WordDao words;
    private HighScoreDao scores;
    private CurrentBoard currentBoard;

    @Inject
    public LlamaWordsServiceImpl(WordDao words, HighScoreDao scores) {
        this.words = words;
        this.scores = scores;
    }

    @Override
    public CurrentBoard startNewGame() {
        currentBoard = new CurrentBoard(this.chooseNewWord(), 5);
        currentBoard.setCurrentScore(new Score());
        
        return currentBoard;
    }

    @Override
    public Word chooseNewWord() {
        if(currentBoard != null){
            currentBoard.getChosenWord().resetGuesses();
        }
        List<Word> allWords = words.getAllWords();
        int length = allWords.size();
        Random rd = new Random();
        int wordNum = rd.nextInt(length);
        Word chosenWord = allWords.get(wordNum);
        return chosenWord;
    }

    @Override
    public CurrentBoard getGameState() {
        return currentBoard;
    }

    @Override
    public List<Score> getAllScores() {
        return scores.getAllScores();
    }

    @Override
    public List<Score> getTopThreeScores() {
        return scores.getTopThree();
    }

    @Override
    public boolean isInTopThree(Score potentialScore) {
        List<Score> topThree = this.getTopThreeScores();
        boolean isInTopThree = false;
        for (Score currentScore : topThree) {
            if (potentialScore.getPoints() > currentScore.getPoints()) {
                isInTopThree = true;
                break;
            }
        }
        return isInTopThree;
    }

    @Override
    public void submitNewScore(Score score) {
        boolean isInTopThree = this.isInTopThree(score);
        if (isInTopThree) {
            scores.addScore(score);
        }
    }

    @Override
    public List<Word> getAllWords() {
        return words.getAllWords();
    }
    
    @Override
    public boolean isGameOver(){
        return currentBoard.isGameOver();
    }

}
