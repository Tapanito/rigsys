open util/ordering [Move] as M

abstract sig Player {}
one sig X, O extends Player {}

abstract sig Cell {}
one sig C00, C01, C02, C10, C11, C12, C20, C21, C22 extends Cell {}

sig Board {
  grid: Cell -> lone Player
} 

sig Move {
  player: Player,
  pos: Cell,
  board, board': Board // pre and post board
} {
  // must choose an empty grid cell
  no board.grid[pos]
  // set the `pos` cell to `player`
  board'.grid[pos] = player
  // all other grid cells remain the same
  all c: Cell - pos | board'.grid[c] = board.grid[c]
}

fact {
  // empty board at the beginning
  no M/first.board.grid
  all m: Move {
    some M/next[m] => {
      // alternate players each move
      M/next[m].player != m.player
      // connect boards
      M/next[m].board = m.board'
    }
  }
}


run {} for 1 but 10 Board
