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

fn day4_test() {
  let part1 = -1
  let part2 = -1

  input
  |> day4.day4
  |> should.equal([part1, part2])
}
