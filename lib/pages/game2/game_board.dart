import './values/colors.dart';
import'package:flutter/material.dart';
import './components/square.dart';
import './helper/helper_methods.dart';
import './components/piece.dart';
import '../home_page.dart';
import 'components/dead_piece.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {

  late List<List<ChessPiece?>> board;
  ChessPiece? selectedPiece;
  int selectedRow = -1;
  int selectedCol = -1;

  List<List<int>> validMoves =[];

  List<ChessPiece> whitePiecesTaken = [];

  List<ChessPiece>blackPiecesTaken = [];
  bool isWhiteTurn = true;

  List<int> whiteKingPosition = [7,4];
  List<int> blackKingPosition = [0,4];
  bool checkStatus = false;

  

  @override
  void initState(){
    super.initState();
    _initializeBoard();
  }

  void _initializeBoard(){

    List<List<ChessPiece?>> newBoard = List.generate(8, (index) => List.generate(8,(index)=> null));
    // newBoard[3][3]=ChessPiece(
    //     type: ChessPieceType.queen,
    //     isWhite: false,
    //     imagePath: 'assets/sub_assets/queenb.png'
    // );
     pieceSelected(int row,int col){
      setState(() {
        if(board[row][col]!=null){
          selectedPiece = board[row][col];
        }
      });
    }


    //Place pawns
    for(int i =0; i< 8; i++){
      newBoard[1][i]=ChessPiece(
          type: ChessPieceType.pawn,
          isWhite: false,
          imagePath:'assests/chess/pawn1.png'
      );
      newBoard[6][i]=ChessPiece(
          type: ChessPieceType.pawn,
          isWhite: true,
          imagePath:'assests/chess/pawn1.png'
      );
    }



      //Place rooks
    newBoard[0][0] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: false,
        imagePath:'assests/chess/rookb.png'
    );
    newBoard[0][7] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: false,
        imagePath:'assests/chess/rookb.png'
    );
    newBoard[7][0] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: true,
        imagePath:'assests/chess/rookb.png'
    );
    newBoard[7][7] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: true,
        imagePath:'assests/chess/rookb.png'
    );
    // Place Knights
    newBoard[0][1] = ChessPiece(
        type: ChessPieceType.knight,
        isWhite: false,
        imagePath:'assests/chess/knightw.png'
    );
    newBoard[0][6] = ChessPiece(
        type: ChessPieceType.knight,
        isWhite: false,
        imagePath:'assests/chess/knightw.png'
    );
    newBoard[7][1] = ChessPiece(
        type: ChessPieceType.knight,
        isWhite: true,
        imagePath:'assests/chess/knightw.png'
    );
    newBoard[7][6] = ChessPiece(
        type: ChessPieceType.knight,
        isWhite: true,
        imagePath: 'assests/chess/knightw.png'
    );


    //Place bishops
   newBoard[0][2]=ChessPiece(
        type: ChessPieceType.bishop,
        isWhite: false,
        imagePath:'assests/chess/bishopwhite.png'
    );

    newBoard[0][5]=ChessPiece(
        type: ChessPieceType.bishop,
        isWhite: false,
        imagePath:'assests/chess/bishopwhite.png'
    );

    newBoard[7][2]=ChessPiece(
        type: ChessPieceType.bishop,
        isWhite: true,
        imagePath:'assests/chess/bishopwhite.png'
    );
    newBoard[7][5]=ChessPiece(
        type: ChessPieceType.bishop,
        isWhite: true,
        imagePath:'assests/chess/bishopwhite.png'
    );

    //Place queens
   newBoard[0][3]=ChessPiece(
        type: ChessPieceType.queen,
        isWhite: false,
        imagePath:'assests/chess/queenb.png'
    );
    newBoard[7][3]=ChessPiece(
        type: ChessPieceType.queen,
        isWhite: true,
        imagePath:'assests/chess/queenb.png'
    );

    //Place Kings
    newBoard[0][4]=ChessPiece(type: ChessPieceType.king,
        isWhite: false,
        imagePath:'assests/chess/kingwhite.png'
    );
    newBoard[7][4]=ChessPiece(type: ChessPieceType.king,
        isWhite: true,
        imagePath:'assests/chess/kingwhite.png'
    );
    board = newBoard;
  }


  //ChessPiece myPawn = ChessPiece(type: ChessPieceType.pawn,
    //  isWhite: true,
     // imagePath: 'assets/sub_assets/pawn.jpg');


  //ChessPiece myPawn = ChessPiece(type: ChessPieceType.pawn,isWhite: true, imagePath: 'lib/images/pawn.jpg');
  void pieceSelected(int row,int col) {
    setState(() {
      if(selectedPiece == null && board[row][col]!=null){
        if(board[row][col]!.isWhite == isWhiteTurn){
          selectedPiece = board[row][col];
          selectedRow = row;
          selectedCol = col;
        }
      }
     /* if (board[row][col] != null) {
        selectedPiece = board[row][col];
        selectedRow = row;
        selectedCol = col;
      }

    */
      else if(board[row][col] != null &&
          board[row][col]!.isWhite == selectedPiece!.isWhite){
        selectedPiece = board[row][col];
        selectedRow = row;
        selectedCol = col;
      }
      else if (selectedPiece!=null &&
          validMoves.any((element)=>element[0] == row && element[1]==col)){
          movePiece(row,col);
      }

      validMoves =
          calculateRealValidMoves(selectedRow, selectedCol, selectedPiece, true);

      /*else{
        selectedPiece = null;
        selectedRow = -1;
        selectedCol = -1;
        validMoves = [];

      }*/
    });
  }
  List<List<int>> calculateRawValidMoves
      (int row, int col, ChessPiece? piece){
   List<List<int>> candidateMoves = [];
   if(piece == null){
     return[];
   }


   int direction = piece!.isWhite ? -1 : 1;

   switch(piece.type){
     case ChessPieceType.pawn:
       if(isInBoard(row + direction, col)&&
           board[row+direction][col]==null){
         candidateMoves.add([row+direction,col]);
       }

       if((row == 1 && !piece.isWhite)||(row == 6 && piece.isWhite)) {
         if (isInBoard(row + 2 * direction, col) &&
             board[row + 2 * direction][col] == null &&
             board[row + direction][col] == null) {
           candidateMoves.add([row + 2 * direction, col]);
         }
       }
       if(isInBoard(row + direction,col -1)&&
           board[row + direction][col-1]!=null &&
           board[row + direction][col-1]!.isWhite != piece.isWhite) {
         candidateMoves.add([row + direction, col -1]);
   }
       if(isInBoard(row + direction,col+ 1)&&
           board[row + direction][col + 1]!=null &&
           board[row + direction][col + 1]!.isWhite != piece.isWhite) {
         candidateMoves.add([row + direction, col + 1]);
       }


       break;
     case ChessPieceType.rook:
       var directions = [
         [-1,0],
         [1,0],
         [0,-1],
         [0,1]
       ];
       for(var direction in directions){
         var i = 1;
         while(true){
           var newRow = row + i * direction[0];
           var newCol = col + i * direction[1];
           if(!isInBoard(newRow, newCol)){
             break;
           }
           if(board[newRow][newCol]!= null){
             if (board[newRow][newCol]!.isWhite != piece.isWhite){
               candidateMoves.add([newRow, newCol]);
             }
             break;
           }
           candidateMoves.add([newRow, newCol]);
           i++;
         }

       }


       break;
     case ChessPieceType.knight:
       var knightMoves = [
         [-2,-1],
         [-2,1],
         [-1,-2],
         [-1,2],
         [1,-2],
         [1,2],
         [2,-1],
         [2,1],

       ];
       for(var move in knightMoves){
         var newRow = row + move[0];
         var newCol = col + move[1];
         if(!isInBoard(newRow, newCol)){
           continue;
         }
         if(board[newRow][newCol]!= null){
           if(board[newRow][newCol]!.isWhite !=piece.isWhite){
             candidateMoves.add([newRow, newCol]);
           }
           continue;
         }
         candidateMoves.add([newRow, newCol]);
       }
       break;
     case ChessPieceType.bishop:
       var directions= [
         [-1,-1],
         [-1,1],
         [1,-1],
         [1,1],
       ];

       for(var direction in directions){
         var i =1;
         while(true){
           var newRow = row + i * direction[0];
            var newCol = col + i * direction[1];
            if(!isInBoard(newRow, newCol)){
              break;
            }
            if(board[newRow][newCol]!=null){
              if(board[newRow][newCol]!.isWhite != piece.isWhite){
                candidateMoves.add([newRow,newCol]);
              }
              break;
            }
            candidateMoves.add([newRow,newCol]);
            i++;
         }
       }

       break;
     case ChessPieceType.queen:
       var directions = [
         [-1,0],
         [1,0],
         [0,-1],
         [0,1],
         [-1,-1],
         [-1,1],
         [1,-1],
         [1,1],
       ];
       for(var direction in directions){
         var i = 1;
         while(true){
           var newRow = row + i * direction[0];
           var newCol = col + i * direction[1];
           if(!isInBoard(newRow, newCol)){
             break;
           }
           if(board[newRow][newCol] != null){
             if(board[newRow][newCol]!.isWhite!=piece.isWhite){
               candidateMoves.add([newRow,newCol]);
             }
             break;

           }
           candidateMoves.add([newRow, newCol]);
           i++;
         }

       }
       break;
     case ChessPieceType.king:
       var directions = [
         [-1,0],
         [1,0],
         [0,-1],
         [0,1],
         [-1,-1],
         [-1,1],
         [1,-1],
         [1,1],
       ];
       for(var direction in directions){
         var newRow = row + direction[0];
         var newCol = col + direction[1];
         if(!isInBoard(newRow, newCol)){
           continue;
         }
         if(board[newRow][newCol]!=null){
           if(board[newRow][newCol]!.isWhite != piece.isWhite){
             candidateMoves.add([newRow, newCol]);
           }
           continue;
         }
         candidateMoves.add([newRow, newCol]);
       }
       break;
     default:
   }
   return candidateMoves;

  }
  List<List<int>> calculateRealValidMoves(
      int row, int col, ChessPiece? piece, bool checkSimulation){
    List<List<int>> realValidMoves =[];
    List<List<int>> candidateMoves = calculateRawValidMoves(row, col, piece);

    if(checkSimulation){
      for(var move in candidateMoves){
        int endRow = move[0];
        int endCol = move[1];

        if(simulatedMoveIsSafe(piece!,row, col, endRow, endCol )){
          realValidMoves.add(move);

        }
      }
    } else{
      realValidMoves = candidateMoves;
    }
    return realValidMoves;
  }
  //move piece
  void movePiece(int newRow, int newCol){
    if(board[newRow][newCol] != null){
      var capturedPiece = board[newRow][newCol];
      if(capturedPiece!.isWhite){
        whitePiecesTaken.add(capturedPiece);
      }else{
        blackPiecesTaken.add(capturedPiece);
      }
    }
    if(selectedPiece!. type == ChessPieceType.king){
      if(selectedPiece!.isWhite){
        whiteKingPosition = [newRow, newCol];
      }else{
        blackKingPosition = [newRow, newCol];
      }

    }
    board[newRow][newCol] = selectedPiece;
    board[selectedRow][selectedCol]=null;

    if(isKingInCheck(!isWhiteTurn)){
      checkStatus = true;
    }else{
      checkStatus = false;
    }
    setState((){
      selectedPiece = null;
      selectedRow = -1;
      selectedCol = -1;
      validMoves = [];
    });

    if (isCheckMate(!isWhiteTurn)){
      showDialog(
        context:context,
        builder: (context) => AlertDialog(
        title: const Text("CHECK MATE"),
        actions: [
          TextButton(
          onPressed: resetGame,
          child: const Text("Play Again"),
          ),
        ],
       ),
      );
    }
    isWhiteTurn = !isWhiteTurn;
  }

  bool isKingInCheck(bool isWhiteKing){
    List<int>kingPosition =
        isWhiteKing ? whiteKingPosition : blackKingPosition;
    for(int i = 0; i < 8; i++){
      for(int j = 0; j < 8; j++){
        if(board[i][j] == null || board[i][j]!.isWhite == isWhiteKing){
          continue;
        }
        List<List<int>> pieceValidMoves =
        calculateRealValidMoves(i, j, board[i][j],false);
        if(pieceValidMoves.any((move) =>
        move[0] == kingPosition[0] && move[1] == kingPosition[1])){
          return true;
        }

      }
    }
    return false;
  }

  bool simulatedMoveIsSafe(
      ChessPiece piece,int startRow , int startCol,int endRow, int endCol){
    ChessPiece? originalDestinationPiece = board[endRow][endCol];
    List<int>? originalKingPosition;
    if(piece.type == ChessPieceType.king){
      originalKingPosition =
          piece.isWhite ? whiteKingPosition : blackKingPosition;
      if(piece.isWhite){
        whiteKingPosition = [endRow, endCol];
      } else {
        blackKingPosition = [endRow, endCol];
      }
    }
    board[endRow][endCol] = piece;
    board[startRow][startCol] = null;
    bool kingInCheck = isKingInCheck(piece.isWhite);

    board[startRow][startCol] = piece;
    board[endRow][endCol] = originalDestinationPiece;

    if(piece.type == ChessPieceType.king){
      if(piece.isWhite){
        whiteKingPosition = originalKingPosition!;
      }else{
        blackKingPosition = originalKingPosition!;
      }
    }
    return !kingInCheck;
  }

  //checkmate
  bool isCheckMate(bool isWhiteKing){
    if(!isKingInCheck(isWhiteKing)){
      return false;
    }
    for(int i =0;i<8;i++){
      for(int j =0 ; j<8 ;j++){
        if (board[i][j] == null || board[i][j]!.isWhite != isWhiteKing){
          continue;
        }
        List<List<int>> pieceValidMoves = calculateRealValidMoves(i, j, board[i][j], true);
        if(pieceValidMoves.isNotEmpty){
          return false;
        }
      }
    }
    return true;
  }
  void resetGame(){
    Navigator.pop(context);
    _initializeBoard();
    checkStatus = false;
    whitePiecesTaken.clear();
    blackPiecesTaken.clear();
    whiteKingPosition = [7,4];
    blackKingPosition = [0,4];
    isWhiteTurn = true;
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text('Tetris'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => game3Page(appUrl: 'game3.dart'),
              ),
            );
          },
      ),
    ),
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: whitePiecesTaken.length,
                physics:const NeverScrollableScrollPhysics(),
                gridDelegate:
                   const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
            itemBuilder: (context,index)=>DeadPiece(
              imagePath: whitePiecesTaken[index].imagePath,
              isWhite: true,
            )
            ),
          ),

          Text(checkStatus ? "CHECK!" : " "),
          Expanded(
            flex:3,
            child: GridView.builder(
               itemCount: 8*8,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
              itemBuilder: (context, index) {
                 int row = index ~/8;
                 int col = index % 8;
                bool isSelected = selectedRow == row && selectedCol == col;

                bool isValidMove = false;
                for(var position in validMoves){
                  if(position[0]== row && position[1] == col){
                    isValidMove=true;
                  }
                }
                return Square(
                  isWhite: isWhite(index),
                  piece: board[row][col],isSelected:isSelected,isValidMove: isValidMove, onTap: () => pieceSelected( row, col),

                );
                 },

            ),
          ),
          Expanded(
            child: GridView.builder(
                itemCount: blackPiecesTaken.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
                itemBuilder: (context,index)=>DeadPiece(
                  imagePath: blackPiecesTaken[index].imagePath,
                  isWhite: false,
                )
            ),
          ),
        ],
      ),
    );
  }


}
class game3Page extends StatelessWidget {
  final String appUrl;

  game3Page({required this.appUrl}); // Constructor to accept the parameter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chess'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
          child: Text(
            "Home Page",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
         // Use the parameter in your widget
      ),
    );
  }
}


