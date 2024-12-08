import day6
import gleeunit/should

const input = "
  ....#.....
  .........#
  ..........
  ..#.......
  .......#..
  ..........
  .#..^.....
  ........#.
  #.........
  ......#...
  "

pub fn day6_test() {
  let part1 = 41
  let part2 = -1

  input
  |> day6.day6
  |> should.equal([part1, part2])
}
