import day01
import day02
import day03
import day04
import day05
import day06
import day07
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
    RunStep("day01", day01.day01),
    RunStep("day02", day02.day02),
    RunStep("day03", day03.day03),
    RunStep("day04", day04.day04),
    RunStep("day05", day05.day05),
    RunStep("day06", day06.day06),
    RunStep("day07", day07.day07),
  ]

  run_steps |> list.each(run)
}
