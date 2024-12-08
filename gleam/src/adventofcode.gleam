import day1
import day2
import day3
import day4
import day6

// import day4
import day5
import gleam/int
import gleam/io
import gleam/list
import gleam/result
import simplifile

type RunStep {
  RunStep(day: String, run: fn(String) -> List(Int))
}

fn underlined_string(str: String) -> String {
  "\n\u{001b}[4m" <> str <> "\u{001b}[0m:"
}

fn run(step: RunStep) {
  step.day
  |> underlined_string
  |> io.println

  let solved_parts =
    simplifile.read("../misc/inputs/" <> step.day <> "/input.txt")
    |> result.unwrap("")
    |> step.run

  list.index_fold(solved_parts, Nil, fn(_, part, i) {
    part
    |> int.to_string
    |> fn(s) { "  part" <> int.to_string(i + 1) <> ": " <> s }
    |> io.println
  })
}

pub fn main() {
  io.println("Advent Of Code 2024")

  let run_steps = [
    RunStep("day1", day1.day1),
    RunStep("day2", day2.day2),
    RunStep("day3", day3.day3),
    // RunStep("day4", day4.day4),
    RunStep("day5", day5.day5),
    RunStep("day6", day6.day6),
  ]

  run_steps |> list.each(run)
}
