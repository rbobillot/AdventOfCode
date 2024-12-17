import gleam/dict
import gleam/function.{identity}
import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import utils

fn str_to_ints(str: String) -> List(Int) {
  str |> string.split(" ") |> list.filter_map(int.parse)
}

fn distance(x: Int, y: Int) -> Int {
  int.absolute_value(x - y)
}

pub fn part2(xs: List(Int), ys: List(Int)) -> Int {
  let occurences = list.group(ys, identity)

  list.fold(xs, 0, fn(acc, e) {
    acc + { dict.get(occurences, e) |> result.unwrap([]) |> int.sum }
  })
}

pub fn part1(xs: List(Int), ys: List(Int)) -> Int {
  list.map2(xs, ys, distance)
  |> int.sum
}

pub fn day01(input: String) -> List(Int) {
  let assert [xs, ys] =
    input
    |> utils.clean_input_lines
    |> list.map(str_to_ints)
    |> list.transpose
    |> list.map(list.sort(_, int.compare))

  [part1(xs, ys), part2(xs, ys)]
}

pub fn main() {
  utils.get_input(day: 1)
  |> day01
  |> list.each(io.debug)
}
