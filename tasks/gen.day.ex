defmodule Mix.Tasks.Gen.Day do
  use Mix.Task

  def run([num]) do
    num = String.to_integer(num)
    padded_num = String.pad_leading(to_string(num), 2, "0")

    code = """
    defmodule AOC.Day#{padded_num} do
      def part1(input) do

      end

      def part2(_input) do
      end
    end
    """

    File.write!("lib/day#{padded_num}.ex", code)

    test = """
    defmodule AOC.Day#{padded_num}Test do
      use AOCCase

      import AOC.Day#{padded_num}

      @moduletag day: "day#{padded_num}"

      test "example1" do
        input = ""

        assert part1(input) == :fixme
      end


      test "example2" do
        input = ""

        assert part2(input) == :fixme
      end


      @tag part: "1"
      test "part1", %{input: input} do
        assert part1(input) == :fixme
      end

      @tag part: "1"
      test "part2", %{input: input} do
        assert part2(input) == :fixme
      end
    end
    """

    File.write!("test/day#{padded_num}_test.exs", test)
  end
end
