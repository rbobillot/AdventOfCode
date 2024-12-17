import day04
import gleeunit/should

const input = "
  MMMSXXMASM
  MSAMXMSMSA
  AMXSXMAAMM
  MSAMASMSMX
  XMASAMXAMM
  XXAMMXXAMA
  SMSMSASXSS
  SAXAMASAAA
  MAMMMXMMMM
  MXMXAXMASX
  "

pub fn day04_test() {
  let part1 = 18
  let part2 = 9

  input
  |> day04.day04
  |> should.equal([part1, part2])
}
