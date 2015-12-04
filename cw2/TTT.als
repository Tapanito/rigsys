open util/ordering [Move] as M
open util/relation

abstract sig Player {}
// There is one of each players
one sig X, O extends Player {}

abstract sig Cell {
  player: Cell -> lone Player
}

// each cell is unique
one sig C1, C2, C3, C4, C5, C6, C7, C8, C9 extends Cell { }

abstract sig Row {
cell: seq Cell
}
// each row is unique
one sig R1, R2, R3 extends Row { }
{
  all r:Row | #(r->cell) = 3 // row has 3 cells
}

// a cell is in at most one row
fact OneCell {
  all c:Cell | one r:Row | c in r.cell.elems
}

// if cell is non empty its domain is itself
fact Domain {
 all c : Cell | not CellEmpty[c] => dom[c.player] = c
}

// a row is in at most one grid
fact OneRow {
all r:Row | one g : Grid | r in g.row.elems
}

sig Grid {
row: seq Row
} {
	all g:Grid |#(g->row) = 3 // grid has 3 rows
}
 
sig Move {
 p: Player,
 pos: Cell,
 board: Grid
} {
	// iff cell is empty it can be ocupied by a player
	CellEmpty[pos] <=> (pos.player[pos] = p)
}

pred CellEmpty[p:Cell]
{
no dom[p.player]
}

fact Movement {
  all m: Move {
    some M/next[m] => {
      	// alternate players each move
		M/next[m].p != m.p
	     // no two cells in a move are the same
		all m': Move | m.pos = m'.pos => m=m'
    }
  }
}

pred WinMove[p' : Player]
{
	lone m : Move | m.p = p' => WinBoard[m.board, p']
}

pred WinBoard[b:Grid,  p:Player] {
			// take all cells 
	WinRow[b.row[0], p] or WinRow[b.row[1], p] or	WinRow[b.row[2], p] or
	WinColumn[b.row[0], b.row[1], b.row[2], p] or WinDiag[b.row[0], b.row[1], b.row[2], p]
}
// Winning row
pred WinRow[r : Row, p:Player] {
  ran[r.cell[0].player] = p
  and ran[r.cell[1].player] = p
  and ran[r.cell[2].player] = p
}
// Winning Column
pred WinColumn[r1, r2, r3:Row, p:Player] {
	ran[r1.cell[0].player] = p
	and ran[r2.cell[0].player] = p
	and ran[r3.cell[0].player] = p
or
	  ran[r1.cell[1].player] = p
	and ran[r2.cell[1].player] = p
	and ran[r3.cell[1].player] = p
or
	ran[r1.cell[2].player] = p
	and ran[r2.cell[2].player] = p
	and ran[r3.cell[2].player] = p
}

// winning diagonal
pred WinDiag[r1, r2, r3:Row, p:Player] {
	ran[r1.cell[0].player] = p
	and ran[r2.cell[1].player] = p
	and ran[r3.cell[2].player] = p
or
	  ran[r1.cell[2].player] = p
	and ran[r2.cell[1].player] = p
	and ran[r3.cell[0].player] = p
}

// check that after 9 moves the board is full
assert BoardFull {
	no c:Cell | no c.player[c]
}
// assert that there is at most one player that can win
assert Win {
	lone p : Player | WinMove[p]
}

assert NoWin {
 no p: Player | WinMove[p]
}

//check BoardFull for 9 but 1 Grid
//check BoardFull for 6 but 1 Grid
//check Win for 9 but 1 Grid
//check NoWin for 3 but 1 Grid
run {} for 9 but 10 Grid
