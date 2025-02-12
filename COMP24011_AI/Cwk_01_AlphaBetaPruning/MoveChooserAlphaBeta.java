/**
 * Solution code for Comp24011 Reversi lab
 *
 * @author s61110ab
 */

import java.util.ArrayList;

public class MoveChooserAlphaBeta extends MoveChooser {

    /**
     * MoveCooser implementation MoveChooserAlphaBeta(int)
     *
     * @param   searchDepth The requested depth for minimax search
     */
    public MoveChooserAlphaBeta(int searchDepth) {
        // Add object initialisation code...
        super("CajamAgent",searchDepth);
    }

    public int max(int a, int b) {
        if (a > b) {return a;}
        else {return b;}
    }

    public int min(int a, int b) {
        if (a < b) {return a;}
        else {return b;}
    }

    /**
    * Recursive function in finding minimax value for te next future move
    * 
    * @param boardState The current board state to be searched
    * @param depth Depth of search, for recursion
    * @param alpha Alpha value to be passed to daughter/mother
    * @param beta Beta value to be passed to daughter/mother
    * @param player Player to be searched, 1 for white and -1 for black
    * 
    * @return Minimax value
    */
    public int MoveAlphaBeta(BoardState boardState, int depth, int alpha, int beta, int player) {

        int func_alpha = alpha;
        int func_beta = beta;
        
        ArrayList<Move> daughterBoard = new ArrayList<Move>(boardState.getLegalMoves());
        
        // stop the recursion or check if there is no more possible moves
        if ((depth == 0) || (daughterBoard.isEmpty())) {
            return boardEval(boardState);
        }

        if (player == 1) {

            int maxValue = Integer.MIN_VALUE;

            // create daughter states
            for (Move daughterMove : daughterBoard) {
                // solve the dereferencing issue
                BoardState tempState = boardState.deepCopy();
                tempState.makeLegalMove(daughterMove);
                
                int value = MoveAlphaBeta(tempState, depth - 1, func_alpha, func_beta, -1);

                maxValue = max(value, maxValue);
                func_alpha = max(value, func_alpha);

                // pruning
                if (func_beta <= func_alpha) {
                    break;
                }
            }
            // final return value 
            return maxValue;

        } else {

            int minValue = Integer.MAX_VALUE;

            // create daughter states
            for (Move daughterMove : daughterBoard) {
                // solve the dereferencing issue
                BoardState tempState = boardState.deepCopy();
                tempState.makeLegalMove(daughterMove);

                int value = MoveAlphaBeta(tempState, depth - 1, func_alpha, func_beta, 1);

                minValue = min(value, minValue);
                func_beta = min(value, func_beta);

                // pruning
                if (func_beta <= func_alpha) {
                    break;
                }
            }

            // final return value
            return minValue;
        }

    }

    /**
     * Need to implement chooseMove(BoardState,Move)
     *
     * @param   boardState  The current state of the game board
     *
     * @param   hint        Skip move or board location clicked on the UI
     *                      This parameter should be ignored!
     *
     * @return  The move chosen by alpha-beta pruning as discussed in the course
     */
    public Move chooseMove(BoardState boardState, Move hint) {
        // Add alpha-beta pruning code...        
        ArrayList<Move> level_1_moves = new ArrayList<Move>(boardState.getRegularMoves());
        System.out.println(level_1_moves);

        Move maxMove = new Move();
        int max = Integer.MIN_VALUE;

        // calculate the alphaBeta
        for (Move daughterMove : level_1_moves) {
            BoardState tempState = boardState.deepCopy();
            tempState.makeLegalMove(daughterMove);
 
            int boardAlphaBeta = MoveAlphaBeta(tempState, this.searchDepth - 1, Integer.MIN_VALUE, Integer.MAX_VALUE, -1);

            System.out.println(boardAlphaBeta);

            if (boardAlphaBeta > max) {
                maxMove = daughterMove;
                max = boardAlphaBeta;
            }
        }

        return maxMove;
    }

    /**
     * Need to implement boardEval(BoardState)
     *
     * @param   boardState  The current state of the game board
     *
     * @return  The value of the board using Norvig's weighting of squares
     */
    public int boardEval(BoardState boardState) {
        // Add board evaluation code...

        int sum = 0;

        int[][] norvigSquare = {
        {120, -20, 20,  5,  5, 20, -20, 120},
        {-20, -40, -5, -5, -5, -5, -40, -20},
        { 20,  -5, 15,  3,  3, 15,  -5,  20},
        {  5,  -5,  3,  3,  3,  3,  -5,   5},
        {  5,  -5,  3,  3,  3,  3,  -5,   5},
        { 20,  -5, 15,  3,  3, 15,  -5,  20},
        {-20, -40, -5, -5, -5, -5, -40, -20},
        {120, -20, 20,  5,  5, 20, -20, 120}
        };

        for (int i = 0; i < 8 ; i++) {
            for (int j = 0; j < 8 ; j++) {
                sum = sum + (norvigSquare[i][j] * (boardState.getContents(i, j)));
            }
        }

        return sum;
    }

    public static void main(String[] args) {
        MoveChooserAlphaBeta testing = new MoveChooserAlphaBeta(4);
        // // BoardState testBoard = new BoardState("{w......b|........|........|........|........|........|........|........}");
        
        BoardState testBoard = new BoardState("{.wwwwwww|bbwwbbww|wwwwwwbw|wwwwwbww|wbwbwbbw|wwwbwwbw|wbbbbbbw|wwbwwbbw}");
        // BoardState testBoard = new BoardState("");
        System.out.println(testing.chooseMove(testBoard, new Move(0,0)));
    }
}

/* vim:set et ts=4 sw=4: */
