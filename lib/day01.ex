defmodule AOC.Day01 do
  require Logger
  @digits Enum.map(?0..?9, fn x -> x |> List.wrap() |> List.to_string() end)
  @words [
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine"
  ]

  def part1(input) do
    input = String.split(input, "\n", trim: true)

    Enum.reduce(input, 0, fn line, count ->
      chars = String.graphemes(line)

      first = Enum.find(chars, fn c -> c in @digits end)
      last = Enum.find(Enum.reverse(chars), fn c -> c in @digits end)

      count + String.to_integer(first <> last)
    end)
  end

  def part2(input) do
    input = String.split(input, "\n", trim: true)

    Enum.reduce(input, 0, fn line, count ->
      digits = find_digits(line)

      count + digits
    end)
  end

  defp find_digits(line), do: find_digits(line, {nil, nil})

  defp find_digits("", {first, last}), do: 10 * first + last
  defp find_digits(line, {first, last}) do
    case next_digit(line) do
      nil -> find_digits("", {first, last})
      {digit, line} ->
        find_digits(line, {first || digit, digit})
    end
  end

  for {w, index} <- Enum.with_index(@words, 1) do
    defp next_digit(unquote(w) <> rest) do
      {unquote(index), drop_first(unquote(w)) <> rest}
    end
  end

  for d <- 0..9 do
    defp next_digit(unquote(to_string(d)) <> rest) do
      {unquote(d), rest}
    end
  end

  defp next_digit(""), do: nil
  defp next_digit(line), do: line |> drop_first() |> next_digit()

  defp drop_first(<<_first::size(8), rest::binary>>), do: rest
end
