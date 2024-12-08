import day1
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

  list.each(solved_parts, fn(part) {
    part
    |> int.to_string
    |> fn(s) { "  " <> s }
    |> io.println
  })
}

pub fn main() {
  io.println("Advent Of Code 2024")

  let run_steps = [RunStep("day1", day1.day1)]

  run_steps |> list.each(run)
}
