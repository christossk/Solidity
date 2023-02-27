pragma solidity ^0.8.0;

contract RockPaperScissors {
    
    event GameCreated(address indexed creator, uint indexed gameNumber, uint betSize);
    event GameStarted(address[2] players, uint indexed gameNumber);
    event GameComplete(address indexed winner, uint indexed gameNumber);

    struct Game {
        address creator;
        address participant;
        uint betSize;
        uint8[2] moves;
        address winner;
    }
    
    uint public gameCount;
    mapping(uint => Game) public games;

    function createGame(address _participant) public payable {
        require(msg.value > 0, "Bet size must be greater than zero.");
        require(_participant != address(0), "Participant address cannot be the zero address.");
        
        uint gameNumber = gameCount++;
        games[gameNumber] = Game(msg.sender, _participant, msg.value, [0, 0], address(0));
        
        emit GameCreated(msg.sender, gameNumber, msg.value);
    }
    
    function joinGame(uint _gameNumber) public payable {
        Game storage game = games[_gameNumber];
        require(game.creator != address(0), "Game does not exist.");
        require(game.participant == address(0), "Game is already full.");
        require(msg.value == game.betSize, "Must send exact bet size.");
        
        game.participant = msg.sender;
        
        emit GameStarted([game.creator, game.participant], _gameNumber);
    }
    
    function makeMove(uint _gameNumber, uint8 _move) public {
        Game storage game = games[_gameNumber];
        require(game.creator != address(0), "Game does not exist.");
        require(game.participant != address(0), "Game is not full yet.");
        require(msg.sender == game.creator || msg.sender == game.participant, "You are not a participant in this game.");
        require(_move >= 1 && _move <= 3, "Invalid move.");
        
        uint8 playerIndex = msg.sender == game.creator ? 0 : 1;
        game.moves[playerIndex] = _move;
        
        if (game.moves[0] != 0 && game.moves[1] != 0) {
            uint8 winnerIndex = determineWinner(game.moves[0], game.moves[1]);
            if (winnerIndex == 0) {
                game.winner = game.creator;
                payable(game.creator).transfer(game.betSize * 2);
            } else if (winnerIndex == 1) {
                game.winner = game.participant;
                payable(game.participant).transfer(game.betSize * 2);
            } else {
                game.winner = address(0);
                payable(game.creator).transfer(game.betSize);
                payable(game.participant).transfer(game.betSize);
            }
            emit GameComplete(game.winner, _gameNumber);
        }
    }
    
    function determineWinner(uint8 _move1, uint8 _move2) private pure returns (uint8) {
        if (_move1 == _move2) {
            return 2;
        } else if ((_move1 == 1 && _move2 == 3) || (_move1 == 2 && _move2 == 1) || (_move1 == 3 && _move2 == 2)) {
            return 0;
        } else {
            return 1;
        }
    }
}
