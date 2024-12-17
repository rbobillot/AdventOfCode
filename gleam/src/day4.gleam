import gleam/dict.{type Dict}
import gleam/io
import gleam/list
import gleam/string
import utils

pub type Coord {
  Coord(x: Int, y: Int)
}

pub fn part2(_input: Dict(Coord, String)) {
  -1
}

fn find_words_in_neighbours(
  ws: List(String),
  input: Dict(Coord, String),
  x: Int,
  y: Int,
) {
  let h =
    list.range(0, 3)
    |> list.filter_map(fn(n) { dict.get(input, Coord(x + n, y)) })
  let v =
    list.range(0, 3)
    |> list.filter_map(fn(n) { dict.get(input, Coord(x, y + n)) })
  let dr =
    list.range(0, 3)
    |> list.filter_map(fn(n) { dict.get(input, Coord(x + n, y + n)) })
  let dl =
    list.range(0, 3)
    |> list.filter_map(fn(n) { dict.get(input, Coord(x - n, y + n)) })

  [h, v, dr, dl]
  |> list.count(fn(w) { list.contains(ws, string.join(w, "")) })
}

fn tr_solve_part1(input: Dict(Coord, String), x: Int, y: Int, res: Int) {
  case dict.get(input, Coord(x, y)) {
    Error(_) ->
      case dict.get(input, Coord(0, y + 1)) {
        Error(_) -> res
        Ok(_) -> tr_solve_part1(input, 0, y + 1, res)
      }
    Ok(_) ->
      tr_solve_part1(
        input,
        x + 1,
        y,
        res + find_words_in_neighbours(["XMAS", "SAMX"], input, x, y),
      )
  }
}

pub fn part1(input: Dict(Coord, String)) {
  tr_solve_part1(input, 0, 0, 0)
}

fn to_cells(input: List(List(String)), x: Int, y: Int, res: Dict(Coord, String)) {
  case input {
    [] -> res
    [row, ..rows] ->
      case row {
        [] -> to_cells(rows, 0, y + 1, res)
        [h, ..r] ->
          to_cells([r, ..rows], x + 1, y, dict.insert(res, Coord(x, y), h))
      }
  }
}

pub fn day4(input: String) -> List(Int) {
  let input =
    input
    |> utils.clean_input_lines
    |> list.map(string.to_graphemes)
    |> to_cells(0, 0, dict.new())

  [part1(input), part2(input)]
}

pub fn main() {
  utils.get_input(day: 4)
  |> day4
  |> list.each(io.debug)
}
