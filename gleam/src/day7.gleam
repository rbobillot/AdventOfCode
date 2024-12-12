import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import utils

fn concat(x: Int, y: Int) -> Int {
  { int.to_string(y) <> int.to_string(x) } |> int.parse |> result.unwrap(0)
}

fn calibration_candidates(
  xs: List(Int),
  ops: List(fn(Int, Int) -> Int),
  res: List(Int),
) {
  case xs, res {
    [h, ..t], [] -> calibration_candidates(t, ops, [h])
    [h, ..t], _ ->
      calibration_candidates(
        t,
        ops,
        list.flat_map(res, fn(n) { list.map(ops, fn(op) { op(h, n) }) }),
      )
    [], _ -> res
  }
}

fn total_calibrations(
  input: List(#(Int, List(Int))),
  ops: List(fn(Int, Int) -> Int),
) {
  use #(x, nums) <- list.filter_map(input)
  use candidate <- list.find(calibration_candidates(nums, ops, []))

  candidate == x
}

pub fn part2(input: List(#(Int, List(Int)))) {
  total_calibrations(input, [int.add, int.multiply, concat]) |> int.sum
}

pub fn part1(input: List(#(Int, List(Int)))) {
  total_calibrations(input, [int.add, int.multiply]) |> int.sum
}

pub fn day7(input: String) -> List(Int) {
  let input =
    input
    |> utils.clean_input_lines
    |> list.filter_map(string.split_once(_, ":"))
    |> list.map(fn(tup) {
      case tup {
        #(x, xs) -> {
          let x = x |> int.parse |> result.unwrap(0)
          let xs = xs |> string.split(" ") |> list.filter_map(int.parse)
          #(x, xs)
        }
      }
    })

  [part1(input), part2(input)]
}

pub fn main() {
  utils.get_input(day: 7)
  |> day7
  |> list.each(io.debug)
}
