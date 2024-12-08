import gleam/dict
import gleam/function
import gleam/int
import gleam/io
import gleam/list
import gleam/string
import utils

fn words_from_graphemes(gs: List(String), window: Int) {
  list.map(list.window(gs, window), string.join(_, ""))
}

/// ```gleam
/// fn(List(a), Int) -> List(a)
/// ```
///
/// Performs a circular shift on a list:
/// - a negative number of rotations shifts the list to the left
/// - a positive number shifts it to the right
///
/// ```gleam
/// rotate([1,2,3,4,5], -3)
/// // -> [4,5,1,2,3]
///
/// rotate([1,2,3,4,5], 3)
/// // -> [3,4,5,1,2]
/// ```
///
fn rotate(list: List(String), rotations n: Int) -> List(String) {
  let len = list.length(list)
  let idx = case n < 0 {
    False -> len - n
    True -> n
  }

  let #(h, t) = list.split(list, int.absolute_value(idx) % len)

  list.append(t, h)
}

fn tr_rotate_input(
  input: List(List(String)),
  direction: String,
  n: Int,
  res: List(List(String)),
) {
  // io.debug(list.first(res) |> result.unwrap([]))
  case input, direction {
    [h, ..t], "right" ->
      tr_rotate_input(t, direction, n + 1, [rotate(h, n), ..res])
    [h, ..t], "left" ->
      tr_rotate_input(t, direction, n - 1, [rotate(h, n), ..res])
    [_, ..], _ -> input
    _, _ -> list.reverse(res)
  }
}

fn get_diagonal_input(input: List(List(String)), direction: String) {
  tr_rotate_input(input, direction, 0, [])
}

pub fn part2(_input: List(List(String))) {
  -1
}

pub fn part1(input: List(List(String))) {
  let vertical_input = input |> list.transpose
  let diagonal_left_input = list.transpose(get_diagonal_input(input, "left"))
  // |> list.map(io.debug)
  // io.println("")
  let diagonal_right_input = list.transpose(get_diagonal_input(input, "right"))
  //|> list.map(io.debug)

  let map =
    [input, vertical_input, diagonal_left_input, diagonal_right_input]
    // [diagonal_right_input]
    |> list.flat_map(list.flat_map(_, words_from_graphemes(_, 4)))
    |> list.group(function.identity)
    |> dict.map_values(fn(_, v) { list.length(v) })

  ["XMAS", "SAMX"] |> list.filter_map(dict.get(map, _)) |> int.sum

  -1
}

pub fn day4(input: String) -> List(Int) {
  let input =
    input
    |> utils.clean_input_lines
    |> list.map(string.to_graphemes)

  [part1(input), part2(input)]
}

pub fn main() {
  utils.get_input(day: 4)
  |> day4
  |> list.each(io.debug)
}
