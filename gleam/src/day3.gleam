import gleam/int
import gleam/io
import gleam/list
import gleam/option.{Some}
import gleam/regexp.{type Match, Match}
import gleam/string
import utils

fn get_product_from_mul(mul: Match) {
  case mul {
    Match(_, [Some(a), Some(b)]) ->
      [a, b] |> list.filter_map(int.parse) |> int.product |> Ok
    _ -> Error(Nil)
  }
}

fn sum_every_mul(input: String) -> Int {
  let assert Ok(re) = regexp.from_string("mul[(](\\d+),(\\d+)[)]")

  regexp.scan(re, input)
  |> list.filter_map(get_product_from_mul)
  |> int.sum
}

pub fn part2(input: String) {
  string.split("do()" <> input, "don't()")
  |> list.filter(string.contains(_, "do()"))
  |> list.map(fn(s) { string.crop(s, "do()") |> sum_every_mul })
  |> int.sum
}

pub fn part1(input: String) {
  sum_every_mul(input)
}

pub fn day3(input: String) {
  [part1(input), part2(input)]
}

pub fn main() {
  utils.get_input(day: 3)
  |> day3
  |> list.each(io.debug)
}
