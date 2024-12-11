import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import simplifile

@external(erlang, "os", "system_time")
fn now() -> Int

pub fn timed(f: fn(a) -> b, x: a) -> b {
  let start = now()
  let res = f(x)
  let elapsed = now() - start

  let _ = io.println("Elapsed: " <> int.to_string(elapsed / 1_000_000) <> "ms")

  res
}

pub fn clean_input_lines(input: String) -> List(String) {
  input
  |> string.trim
  |> string.split("\n")
  |> list.map(string.trim)
}

pub fn get_input(day n: Int) -> String {
  let day = "day" <> int.to_string(n)

  simplifile.read("../misc/inputs/" <> day <> "/input.txt")
  |> result.unwrap("")
  |> string.trim
}
