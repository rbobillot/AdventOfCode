import gleam/int
import gleam/list
import gleam/result
import gleam/string
import simplifile

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
