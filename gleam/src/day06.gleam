import gleam/dict.{type Dict}
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import utils

type Cell {
  Cell(x: Int, y: Int, c: String)
}

pub type Coord {
  Coord(x: Int, y: Int)
}

fn tr_line_to_row(line: List(String), x: Int, y: Int, res: List(Cell)) {
  case line {
    [h, ..t] -> tr_line_to_row(t, x + 1, y, [Cell(x, y, h), ..res])
    [] -> res |> list.reverse
  }
}

fn tr_input_to_cells(
  input: List(List(String)),
  y: Int,
  res: List(List(Cell)),
) -> List(List(Cell)) {
  case input {
    [] -> res |> list.reverse
    [line, ..lines] ->
      tr_input_to_cells(lines, y + 1, [tr_line_to_row(line, 0, y, []), ..res])
  }
}

fn input_to_cells(input: List(List(String))) -> Dict(Coord, String) {
  tr_input_to_cells(input, 0, [])
  |> list.flatten
  |> list.group(fn(cell) { Coord(cell.x, cell.y) })
  |> dict.map_values(fn(_, v) {
    { list.first(v) |> result.unwrap(Cell(0, 0, "")) }.c
  })
}

fn get_start(input: List(List(String))) -> Result(Coord, Nil) {
  tr_input_to_cells(input, 0, [])
  |> list.flatten
  |> list.find(fn(cell) { cell.c == "^" })
  |> result.map(fn(cell) { Coord(cell.x, cell.y) })
}

fn update_position(pos: Coord, orientation: Int) -> Coord {
  case orientation {
    0 -> Coord(..pos, y: pos.y - 1)
    1 -> Coord(..pos, x: pos.x + 1)
    2 -> Coord(..pos, y: pos.y + 1)
    _ -> Coord(..pos, x: pos.x - 1)
  }
}

fn traverse_cells(
  pos: Coord,
  orientation: Int,
  cells: Dict(Coord, String),
  traversed: List(Coord),
) {
  let next_pos = update_position(pos, orientation)

  case dict.get(cells, next_pos) {
    Ok("#") -> traverse_cells(pos, { orientation + 1 } % 4, cells, traversed)
    Ok(_) -> traverse_cells(next_pos, orientation, cells, [pos, ..traversed])
    _ -> [pos, ..traversed] |> list.unique |> list.length
  }
}

// part2:
//
// for each "." cell, create a new single obstacle, re-traverse the map
//
// -> count traversed cells occurences: use a Dict(Cell, Int)
//
// new traverse_cells function, or updated version ?
// -> each time a cell is traversed, increment occurence in Dict
// -> when facing "O":
//   - if pos has more than 10 occurences: return next_pos ("O" coord)
//   - else: traverse
//
pub fn part2(_cells: Dict(Coord, String), _start: Coord) {
  -1
}

pub fn part1(cells: Dict(Coord, String), start: Coord) {
  traverse_cells(start, 0, cells, [])
}

pub fn day06(input: String) -> List(Int) {
  let input =
    input
    |> utils.clean_input_lines
    |> list.map(string.to_graphemes)

  let cells: Dict(Coord, String) = input_to_cells(input)
  let assert Ok(start) = get_start(input)

  [part1(cells, start), part2(cells, start)]
}

pub fn main() {
  utils.get_input(day: 6)
  |> day06
  |> list.each(io.debug)
}
