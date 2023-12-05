defmodule AOC.Day03Test do
  use AOCCase

  import AOC.Day03

  @moduletag day: "day03"

  test "example1" do
    input = """
    467..114..
    ...*......
    ..35..633.
    ......#...
    617*......
    .....+.58.
    ..592.....
    ......755.
    ...$.*....
    .664.598..
    """

    assert part1(input) == 4361
  end

  test "distance" do
    row = 0
    col = 2
    sr = 0
    sc = 3
    assert :math.sqrt((sr - row) ** 2 + (sc - col) ** 2) == 1
  end

  test "example2" do
    input = """
    467..114..
    ...*......
    ..35..633.
    ......#...
    617*......
    .....+.58.
    ..592.....
    ......755.
    ...$.*....
    .664.598..
    """

    assert part2(input) == 467_835
  end

  @tag part: "1"
  test "part1", %{input: input} do
    assert part1(input) == 556_057
  end

  test "broken parser" do
    input = """
    ........897.*.3...839...........651.399.............236...............................343...986...........308...............................
    ............12*
    """

    assert part1(input) == 15
  end

  @tag part: "1"
  test "part2", %{input: input} do
    assert part2(input) == 82_824_352
  end
end
