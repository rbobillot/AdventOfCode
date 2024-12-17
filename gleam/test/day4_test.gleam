import day4
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

pub fn day4_test() {
  let part1 = 18
  let part2 = 9

  input
  |> day4.day4
  |> should.equal([part1, part2])
}
